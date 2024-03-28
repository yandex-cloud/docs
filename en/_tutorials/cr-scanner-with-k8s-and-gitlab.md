# Scanning {{ container-registry-name }} for vulnerabilities during continuous deployment of {{ managed-k8s-name }} applications using {{ GL }}

You can scan [Docker images](../container-registry/concepts/docker-image.md) for [vulnerabilities](../container-registry/concepts/vulnerability-scanner.md) in [{{ container-registry-full-name }}](../container-registry/) when continuously deploying [{{ managed-k8s-full-name }}](../managed-kubernetes/) applications via {{ GL }}.

To do this, use Continuous Integration (CI) to create a special script in {{ GL }} that will run after each commit:
1. Building an application into a Docker image and pushing the image to {{ container-registry-name }}.
1. Scanning Docker images in {{ container-registry-name }} for vulnerabilities.
1. Deploying an application from a Docker image in a [{{ managed-k8s-name }} cluster](../managed-kubernetes/concepts/index.md#kubernetes-cluster) using the {{ yandex-cloud }} tools.

To set up the vulnerability scanner:
1. [Create a {{ GL }} instance](#create-gitlab).
1. [Configure {{ GL }}](#configure-gitlab).
1. [Create a test application](#app-create).
1. [Create a {{ GLR }}](#runner).
1. [Configure the CI script](#ci).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

{% include [deploy-infrastructure](../_includes/managed-gitlab/deploy-infrastructure.md) %}

{% include [prepare](../_includes/managed-gitlab/prepare.md) %}

{% include [create-gitlab](../_includes/managed-gitlab/create-gitlab.md) %}

{% include [Create a project](../_includes/managed-gitlab/initialize.md) %}

{% include [app-create](../_includes/managed-gitlab/app-create.md) %}

{% include [create glr](../_includes/managed-gitlab/k8s-runner.md) %}

## Set up {{ k8s }} authentication in {{ GL }} {#gitlab-authentication}

You can set up authentication in {{ GL }} using a {{ k8s }} service account token or the [{{ GLA }}](/marketplace/products/yc/gitlab-agent) application:

{% list tabs group=gl_auth %}

- Service account token {#token}

   {% include notitle [k8s-get-token](../_includes/managed-gitlab/k8s-get-token.md) %}

- {{ GLA }} {#gla}

   {% include notitle [create gla](../_includes/managed-gitlab/k8s-agent.md) %}

{% endlist %}

## Configure the CI script {#ci}

1. Create the [{{ GL }} environment variables](https://docs.gitlab.com/ee/ci/variables/README.html):
   1. Go to **Settings** in the left-hand {{ GL }} panel and select **CI/CD** from the drop-down list.
   1. Click **Expand** next to **Variables**.
   1. Add the following environment variables depending on the {{ managed-k8s-name }} authentication method in {{ GL }}:

      {% list tabs group=gl_auth %}

      - Service account token {#token}

        * `KUBE_URL`: [{{ managed-k8s-name }} master](../managed-kubernetes/concepts/index.md#master) address. You can retrieve it using the following command:

          ```bash
          yc managed-kubernetes cluster get <cluster_name_or_ID> --format=json \
             | jq -r .master.endpoints.external_v4_endpoint
          ```

        * `KUBE_TOKEN`: Token that will use {{ GL }} to apply the configuration. Use the token obtained earlier.

      - {{ GLA }} {#gla}

      {% endlist %}

      * `CI_REGISTRY`: Address of the previously created [registry](../container-registry/concepts/registry.md) in `{{ registry }}/<registry_ID>` format.
      * `CI_REGISTRY_KEY`: Key that {{ GL }} will use to access the registry. Copy the contents of the previously obtained `key.json` static key file to access the registry.

      To add a variable:
      * Click **Add variable**.
      * In the window that opens, enter the variable name in the **Key** field and the value in the **Value** field.
      * Click **Add variable**.
1. Create the CI script's configuration file:
   1. In the left-hand panel in {{ GL }}, go to **Repository** and click the **Files** tab.
   1. Click ![image](../_assets/console-icons/plus.svg) to the right of the project name and select **New file** from the drop-down menu.
   1. Name the file as `.gitlab-ci.yml`. Add the steps to build and push a Docker image, scan it for vulnerabilities, and update the application configuration in the {{ managed-k8s-name }} cluster. The file structure depends on the {{ k8s }} authentication method in {{ GL }}:

      {% list tabs group=gl_auth %}

      - Service account token {#token}

        {% cut ".gitlab-ci.yml" %}

         ```yaml
         stages:
           - build
           - test
           - deploy

         build_docker_image:
           stage: build
           variables:
             DOCKER_CUSTOM_SUBFOLDER: "" # Specify a custom path (if any) to your folder with docker files.
           image:
             name: gcr.io/kaniko-project/executor:debug
             entrypoint: [""]
           script:
             - mkdir -p /kaniko/.docker
             - echo "{\"auths\":{\"${CI_REGISTRY}\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
             - >-
               /kaniko/executor
               --context "${CI_PROJECT_DIR}"/"${DOCKER_CUSTOM_SUBFOLDER}"
               --dockerfile "${CI_PROJECT_DIR}/"${DOCKER_CUSTOM_SUBFOLDER}"/Dockerfile"
               --destination "${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}"

         container_scanning_free_yc:
           image:
             name: pindar/jq
             entrypoint: [""]
           stage: test
           artifacts:
             when: always
             paths:
               - gl-container-scanning-report-yc.json
           script:
             - export CI_COMMIT_SHA=${CI_COMMIT_SHA}
             # Install YC CLI.
             - curl https://{{ s3-storage-host }}{{ yc-install-path }} | bash -s -- -a && cp /root/yandex-cloud/bin/yc /usr/bin/
             # Start scanning.
             - echo "Scanning image $IMAGE_NAME ${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}..."
             - export IMAGE_ID=$(yc container image list --registry-id (${CI_REGISTRY} | cut -d/ -f2) --format=json | jq -r --arg CI_COMMIT_SHA $CI_COMMIT_SHA '.[] | select(.tags[0]==$CI_COMMIT_SHA) | .id ')
             # Make a report.
             - export SCAN_RESULT=$(yc container image scan $IMAGE_ID --format=json)
             - export CRIT_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.critical // 0')
             - export HIGH_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.high // 0')
             - export SCAN_ID=$(echo $SCAN_RESULT | jq -r '.id')
             - echo "Scan results:"
             - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")'
             - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")' > gl-container-scanning-report-yc.json
             # Check the result.
             - (( SUM = $CRIT_VULN + $HIGH_VULN )) && (( RES = (SUM >= 1) )) && echo $RES && echo "image has $CRIT_VULN critical vulns and $HIGH_VULN high vulns" && exit 1 || echo "image has no high or crit vulns" exit 0

         deploy:
           image: gcr.io/cloud-builders/kubectl:latest
           stage: deploy
           script:
             - kubectl config set-cluster k8s --server="$KUBE_URL" --insecure-skip-tls-verify=true
             - kubectl config set-credentials admin --token="$KUBE_TOKEN"
             - kubectl config set-context default --cluster=k8s --user=admin
             - kubectl config use-context default
             - sed -i "s,__VERSION__,${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}," k8s.yaml
             - kubectl apply -f k8s.yaml
         ```

        {% endcut %}

      - {{ GLA }} {#gla}

        {% cut ".gitlab-ci.yml" %}

         ```yaml
         stages:
           - build
           - test
           - deploy

         build_docker_image:
           stage: build
           variables:
             DOCKER_CUSTOM_SUBFOLDER: "" # Specify a custom path (if any) to your folder with docker files.
           image:
             name: gcr.io/kaniko-project/executor:debug
             entrypoint: [""]
           script:
             - mkdir -p /kaniko/.docker
             - echo "{\"auths\":{\"${CI_REGISTRY}\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
             - >-
               /kaniko/executor
               --context "${CI_PROJECT_DIR}"/"${DOCKER_CUSTOM_SUBFOLDER}"
               --dockerfile "${CI_PROJECT_DIR}/"${DOCKER_CUSTOM_SUBFOLDER}"/Dockerfile"
               --destination "${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}"

         container_scanning_free_yc:
           image:
             name: pindar/jq
             entrypoint: [""]
           stage: test
           artifacts:
             when: always
             paths:
               - gl-container-scanning-report-yc.json
           script:
             - export CI_COMMIT_SHA=${CI_COMMIT_SHA}
             # Install YC CLI.
             - curl https://{{ s3-storage-host }}{{ yc-install-path }} | bash -s -- -a && cp /root/yandex-cloud/bin/yc /usr/bin/
             # Start scanning.
             - echo "Scanning image $IMAGE_NAME ${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}..."
             - export IMAGE_ID=$(yc container image list --registry-id (${CI_REGISTRY} | cut -d/ -f2) --format=json | jq -r --arg CI_COMMIT_SHA $CI_COMMIT_SHA '.[] | select(.tags[0]==$CI_COMMIT_SHA) | .id ')
             # Make a report.
             - export SCAN_RESULT=$(yc container image scan $IMAGE_ID --format=json)
             - export CRIT_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.critical // 0')
             - export HIGH_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.high // 0')
             - export SCAN_ID=$(echo $SCAN_RESULT | jq -r '.id')
             - echo "Scan results:"
             - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")'
             - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")' > gl-container-scanning-report-yc.json
             # Check the result.
             - (( SUM = $CRIT_VULN + $HIGH_VULN )) && (( RES = (SUM >= 1) )) && echo $RES && echo "image has $CRIT_VULN critical vulns and $HIGH_VULN high vulns" && exit 1 || echo "image has no high or crit vulns" exit 0

         deploy:
           image: bitnami/kubectl:latest
           stage: deploy
           script:
             - kubectl config use-context ${CI_PROJECT_PATH}:<GitLab_Agent_name>
             - cat k8s.yaml | sed -e "s,__VERSION__,${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}," | kubectl apply -f -
         ```

        {% endcut %}

        Replace `<GitLab_Agent_name>` with the agent name in {{ mgl-name }}.

      {% endlist %}

   1. Add a comment to the commit in the **Commit message** field: `CI scripts`.
   1. Click **Commit changes**.

   In the `.gitlab-ci.yml` file, the following steps of the CI script are described:
   * Build a Docker image using the `Dockerfile` and push the image to {{ container-registry-name }}.
   * Scan the Docker image for vulnerabilities in {{ container-registry-name }}.
   * Set up an environment to work with {{ k8s }} and apply `k8s.yaml` configurations to {{ managed-k8s-name }} clusters. This way, the application is deployed on the previously created {{ managed-k8s-name }} cluster.

## Check the result {#check-result}

After saving the `.gitlab-ci.yml` configuration file, the build script will start. To check its results, select **CI/CD** → **Pipelines** in the drop-down menu in the left-hand panel in {{ GL }}. Vulnerability scanning is performed at the second stage (`test`).

{% include [clear-out](../_includes/managed-gitlab/clear-out.md) %}