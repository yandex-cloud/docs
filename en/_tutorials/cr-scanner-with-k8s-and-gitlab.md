# Scanning {{ container-registry-name }} for vulnerabilities during continuous deployment of {{ managed-k8s-name }} applications using {{ GL }}

You can [scan Docker images for vulnerabilities](../container-registry/concepts/vulnerability-scanner.md) in [{{ container-registry-full-name }}](../container-registry/) when continuously deploying [{{ managed-k8s-full-name }}](../managed-kubernetes/) applications via {{ GL }}.

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

{% include [k8s-get-token](../_includes/managed-gitlab/k8s-get-token.md) %}

{% include [create-gitlab](../_includes/managed-gitlab/create-gitlab.md) %}

{% include [Create a project](../_includes/managed-gitlab/initialize.md) %}

{% include [app-create](../_includes/managed-gitlab/app-create.md) %}

{% include [create glr](../_includes/managed-gitlab/k8s-runner.md) %}

## Configure the CI script {#ci}

1. Create the [{{ GL }} environment variables](https://docs.gitlab.com/ee/ci/variables/README.html):
   1. Go to **Settings** in the left-hand {{ GL }} panel and select **CI/CD** from the drop-down list.
   1. Click **Expand** next to **Variables**.
   1. Add two environment variables:
      * `KUBE_URL`: [{{ managed-k8s-name }} master](../managed-kubernetes/concepts/index.md#master) address. You can retrieve it using the following command:

        ```bash
        yc managed-kubernetes cluster get <{{ k8s }} cluster ID or name> --format=json \
          | jq -r .master.endpoints.external_v4_endpoint
        ```

      * `KUBE_TOKEN`: Token that will use {{ GL }} to apply the configuration. Use the token that you received previously.

      To add a variable:
      1. Click **Add variable**.
      1. In the window that opens, enter the variable name in the **Key** field and the value in the **Value** field.
      1. Click **Add variable**.
1. Create the CI script's configuration file:
   1. On the left-hand panel in {{ GL }}, select **Repository** and click the **Files** tab.
   1. Click ![image](../_assets/plus.svg) to the right of the project name and select **New file** from the drop-down menu.
   1. Name the file as `.gitlab-ci.yml`. Add the steps to build and push a Docker image, scan it for vulnerabilities, and update the application configuration in the {{ managed-k8s-name }} cluster:

      {% cut ".gitlab-ci.yml" %}

      ```yaml
      stages:
        - build
        - test
        - deploy

      build_docker_image:
        stage: build
        variables:
          YC_REGISTRY_ID: "<registry ID>" # Set your registry ID.
          DOCKER_CUSTOM_SUBFOLDER: "" # Specify a custom path (if any) to your folder with docker files.
        image:
          name: gcr.io/kaniko-project/executor:debug
          entrypoint: [""]
        script:
          - mkdir -p /kaniko/.docker
          # Install jq.
          - wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && chmod +x ./jq && cp jq /kaniko
          # Get a service account token from metadata.
          - wget --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token && cp token /kaniko
          - echo "{\"auths\":{\"{{ registry }}\":{\"auth\":\"$(printf "%s:%s" "iam" "$(cat /kaniko/token | ./jq -r '.access_token')" | base64 | tr -d '\n')\"}}}" > /kaniko/.docker/config.json
          - >-
            /kaniko/executor
            --context "${CI_PROJECT_DIR}"/"${DOCKER_CUSTOM_SUBFOLDER}"
            --dockerfile "${CI_PROJECT_DIR}/"${DOCKER_CUSTOM_SUBFOLDER}"/Dockerfile"
            --destination "{{ registry }}/${YC_REGISTRY_ID}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}"
          # Delete the metadata file.
          - rm /kaniko/token

      container_scanning_free_yc:
        image:
          name: pindar/jq
          entrypoint: [""]
        stage: test
        artifacts:
          when: always
          paths:
            - gl-container-scanning-report-yc.json
        variables:
          YC_REGISTRY_ID: "<registry ID>" # Set your registry ID.
        script:
          - export CI_COMMIT_SHA=${CI_COMMIT_SHA}
          # Install YC CLI.
          - curl https://{{ s3-storage-host }}{{ yc-install-path }} | bash -s -- -a && cp /root/yandex-cloud/bin/yc /usr/bin/
          # Start scanning.
          - echo "Scanning image $IMAGE_NAME {{ registry }}/${YC_REGISTRY_ID}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}..."
          - export IMAGE_ID=$(yc container image list --registry-id $YC_REGISTRY_ID --format=json | jq -r --arg CI_COMMIT_SHA $CI_COMMIT_SHA '.[] | select(.tags[0]==$CI_COMMIT_SHA) | .id ')
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
          - sed -i "s/__VERSION__/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}/" k8s.yaml
          - kubectl apply -f k8s.yaml
      ```

      {% endcut %}

   1. Replace the `<registry ID>` with the ID of the {{ container-registry-name }} [registry](../container-registry/concepts/registry.md) that you created previously.
   1. Add a comment to the commit in the **Commit message** field: `CI scripts`.
   1. Click **Commit changes**.

   In the `.gitlab-ci.yml` file, the following steps of the CI script are described:
   * Build a Docker image using the `Dockerfile` and push the image to {{ container-registry-name }}.
   * Scan the Docker image for vulnerabilities in {{ container-registry-name }}.
   * Set up an environment to work with {{ k8s }} and apply `k8s.yaml` configurations to {{ managed-k8s-name }} clusters. This way, the application is deployed on the previously created {{ managed-k8s-name }} cluster.

## Check the result {#check-result}

Once you save the `.gitlab-ci.yml` configuration file, the build script will start. To check its results, select **CI/CD** → **Pipelines** in the drop-down menu in the left-hand panel in {{ GL }}. Vulnerability scanning is performed at the second stage (`test`).

{% include [clear-out](../_includes/managed-gitlab/clear-out.md) %}