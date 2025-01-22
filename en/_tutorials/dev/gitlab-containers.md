

[{{ GL }}](https://about.gitlab.com/) is a tool for Continuous integration (CI).

This tutorial describes:
* Building an application into a Docker container.
* Deploying an application from a container in a [{{ managed-k8s-full-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) via {{ GL }} using the {{ yandex-cloud }} tools.

Each commit to {{ GL }} is followed by:
* Running a script that includes steps to build the [Docker image](../../container-registry/concepts/docker-image.md).
* Applying a new {{ managed-k8s-name }} cluster configuration specifying the application to deploy.

To set up the infrastructure required to store the source code, build the Docker image, and deploy your applications, follow these steps:
1. [Prepare your cloud](#before-you-begin).

   
   1. [Review the list of paid resources available](#paid-resources).


1. [Prepare your infrastructure](#deploy-infrastructure).
1. [Create a {{ GL }} instance](#create-gitlab).
1. [Configure {{ GL }}](#configure-gitlab).
1. [Create a test application](#app-create).
1. [Create a {{ GLR }}](#runners).
1. [Set up {{ k8s }} authentication in {{ GL }}](#gitlab-authentication).
1. [Configure the CI script](#ci).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

Infrastructure support costs include fees for the following resources:
* [Disks](../../compute/concepts/disk.md) and continuously running [VMs](../../compute/concepts/vm.md) (see the [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Usage of a dynamic [public IP](../../vpc/concepts/ips.md) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Storage of created Docker images (see [{{ container-registry-name }} pricing](../../container-registry/pricing.md)).
* Usage of a [{{ managed-k8s-name }} master](../../managed-kubernetes/concepts/index.md#master) (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).


{% include [deploy-infrastructure](../../_includes/managed-gitlab/deploy-infrastructure.md) %}

{% include [prepare](../../_includes/managed-gitlab/prepare.md) %}

{% include [create-gitlab](../../_includes/managed-gitlab/create-gitlab.md) %}

{% include [Create a project](../../_includes/managed-gitlab/initialize.md) %}

{% include [app-create](../../_includes/managed-gitlab/app-create.md) %}

{% include [create glr](../../_includes/managed-gitlab/k8s-runner.md) %}

## Set up {{ k8s }} authentication in {{ GL }} {#gitlab-authentication}

You can set up authentication in {{ GL }} using a {{ k8s }} service account token or the [{{ GLA }}](/marketplace/products/yc/gitlab-agent) application:

{% list tabs group=gl_auth %}

- Service account token {#token}

   {% include notitle [k8s-get-token](../../_includes/managed-gitlab/k8s-get-token.md) %}

- {{ GLA }} {#gla}

   {% include notitle [create gla](../../_includes/managed-gitlab/k8s-agent.md) %}

{% endlist %}

## Configure the CI script {#ci}

1. Create the [{{ GL }} environment variables]({{ gl.docs }}/ee/ci/variables/):
   1. In {{ GL }}, go to **Settings** in the left-hand panel and select **CI/CD** from the drop-down list.
   1. Click **Expand** next to **Variables**.
   1. Add the following environment variables depending on the {{ k8s }} authentication method in {{ GL }}:

      {% list tabs group=gl_auth %}

      - Service account token {#token}

        * `KUBE_URL`: {{ managed-k8s-name }} master address. You can retrieve it using the following command:

          ```bash
          yc managed-kubernetes cluster get <cluster_ID_or_name> --format=json \
             | jq -r .master.endpoints.external_v4_endpoint
          ```

        * `KUBE_TOKEN`: Token that {{ GL }} will use to apply the configuration. Use the token obtained earlier.

      - {{ GLA }} {#gla}

      {% endlist %}

      * `CI_REGISTRY`: Address of the previously created registry in `{{ registry }}/<registry_ID>` format.
      * `CI_REGISTRY_KEY`: Key that {{ GL }} will use to access the registry. Copy the contents of the previously obtained `key.json` static key file to access the registry.

      To add a variable:
      * Click **Add variable**.
      * In the window that opens, enter the variable name in the **Key** field and the value in the **Value** field.
      * Click **Add variable**.
1. Create the CI script configuration file:
   1. Open the `gitlab-test` project.
   1. Click ![image](../../_assets/console-icons/plus.svg) in the repository navigation bar and select **New file** from the drop-down menu.
   1. Name your file `.gitlab-ci.yml`. Add the steps to build and push a Docker image and update the application configuration in the {{ managed-k8s-name }} cluster. The file structure depends on the {{ k8s }} authentication method in {{ GL }}:

      {% list tabs group=gl_auth %}

      - Service account token {#token}

        * To build a container via `kaniko` without using the {{ GLR }} privileged mode:

          {% cut ".gitlab-ci.yml" %}

          ```yaml
          stages:
            - build
            - deploy

          build:
            stage: build
            image:
              name: gcr.io/kaniko-project/executor:debug
              entrypoint: [""]
            script:
              - mkdir -p /kaniko/.docker
              - echo "{\"auths\":{\"${CI_REGISTRY}\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
              - >-
                /kaniko/executor
                --context "${CI_PROJECT_DIR}"
                --dockerfile "${CI_PROJECT_DIR}/Dockerfile"
                --destination "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"

          deploy:
            image: gcr.io/cloud-builders/kubectl:latest
            stage: deploy
            script:
              - kubectl config set-cluster k8s --server="$KUBE_URL" --insecure-skip-tls-verify=true
              - kubectl config set-credentials admin --token="$KUBE_TOKEN"
              - kubectl config set-context default --cluster=k8s --user=admin
              - kubectl config use-context default
              - sed -i "s,__VERSION__,${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}," k8s.yaml
              - kubectl apply -f k8s.yaml
          ```

          {% endcut %}

        * To build a container via `docker:dind` using the {{ GLR }} privileged mode:

          {% cut ".gitlab-ci.yml" %}

          ```yaml
          stages:
            - build
            - deploy

          image: docker:20.10.16

          variables:
            DOCKER_HOST: tcp://docker:2376
            DOCKER_TLS_CERTDIR: "/certs"
            DOCKER_TLS_VERIFY: 1
            DOCKER_CERT_PATH: "$DOCKER_TLS_CERTDIR/client"
            DOCKER_DRIVER: overlay2

          services:
            - docker:20.10.16-dind

          before_script:
            - for try in {1..10}; do sleep 0.5; docker info && break ; done

          build:
            stage: build
            script:
              - echo "${CI_REGISTRY_KEY}" | docker login ${CI_REGISTRY} -u json_key --password-stdin
              - >-
                docker build
                "${CI_PROJECT_DIR}"
                --file "${CI_PROJECT_DIR}/Dockerfile"
                --tag "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"
              - docker push "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"

          deploy:
            image: gcr.io/cloud-builders/kubectl:latest
            stage: deploy
            script:
              - kubectl config set-cluster k8s --server="$KUBE_URL" --insecure-skip-tls-verify=true
              - kubectl config set-credentials admin --token="$KUBE_TOKEN"
              - kubectl config set-context default --cluster=k8s --user=admin
              - kubectl config use-context default
              - sed -i "s,__VERSION__,${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}," k8s.yaml
              - kubectl apply -f k8s.yaml
          ```

          {% endcut %}

      - {{ GLA }} {#gla}

        * To build a container via `kaniko` without using the {{ GLR }} privileged mode:

          {% cut ".gitlab-ci.yml" %}

          ```yaml
          stages:
            - build
            - deploy

          build:
            stage: build
            image:
              name: gcr.io/kaniko-project/executor:debug
              entrypoint: [""]
            script:
              - mkdir -p /kaniko/.docker
              - echo "{\"auths\":{\"${CI_REGISTRY}\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
              - >-
                /kaniko/executor
                --context "${CI_PROJECT_DIR}"
                --dockerfile "${CI_PROJECT_DIR}/Dockerfile"
                --destination "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"

          deploy:
            image: bitnami/kubectl:latest
            stage: deploy
            script:
              - kubectl config use-context ${CI_PROJECT_PATH}:<GitLab_agent_name>
              - cat k8s.yaml | sed -e "s,__VERSION__,${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}," | kubectl apply -f -
          ```

          {% endcut %}

        * To build a container via `docker:dind` using the {{ GLR }} privileged mode:

          {% cut ".gitlab-ci.yml" %}

          ```yaml
          stages:
            - build
            - deploy

          image: docker:20.10.16

          variables:
            DOCKER_HOST: tcp://docker:2376
            DOCKER_TLS_CERTDIR: "/certs"
            DOCKER_TLS_VERIFY: 1
            DOCKER_CERT_PATH: "$DOCKER_TLS_CERTDIR/client"
            DOCKER_DRIVER: overlay2

          services:
            - docker:20.10.16-dind

          before_script:
            - for try in {1..10}; do sleep 0.5; docker info && break ; done

          build:
            stage: build
            script:
              - echo "${CI_REGISTRY_KEY}" | docker login ${CI_REGISTRY} -u json_key --password-stdin
              - >-
                docker build
                "${CI_PROJECT_DIR}"
                --file "${CI_PROJECT_DIR}/Dockerfile"
                --tag "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"
              - docker push "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"

          deploy:
            image: bitnami/kubectl:latest
            stage: deploy
            script:
              - kubectl config use-context ${CI_PROJECT_PATH}:<GitLab_agent_name>
              - cat k8s.yaml | sed -e "s,__VERSION__,${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}," | kubectl apply -f -
          ```

          {% endcut %}

        Replace `<GitLab_agent_name>` with the name of the agent in {{ mgl-name }}.

      {% endlist %}

   1. Add a comment to the commit in the **Commit message** field: `CI scripts`.
   1. Click **Commit changes**.

   The `.gitlab-ci.yml` file describes the following two steps of the project build process:
   * Building a Docker image using `Dockerfile` and pushing the image to {{ container-registry-name }}.
   * Setting up an environment to work with {{ k8s }} and applying the `k8s.yaml` configuration to {{ managed-k8s-name }} clusters. This way, the application is deployed on the previously created {{ managed-k8s-name }} cluster.

## Check the result {#check-result}

1. After you save the `.gitlab-ci.yml` configuration file, the build scenario will start. To check its results, select **Build** on the left-hand panel in the `gitlab-test` project, then select **Pipelines** from the drop-down menu, and wait for both build stages to complete successfully.
1. To check how the created application is running in your {{ managed-k8s-name }} cluster, view its container logs:

   ```bash
   kubectl logs deployment/hello-world-deployment -n hello-world
   ```

   Result:

   ```text
   Hello
   ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:
1. [Delete the created Docker images](../../container-registry/operations/docker-image/docker-image-delete.md).
1. Delete the {{ managed-k8s-name }} cluster and {{ container-registry-name }} registry:

   {% list tabs group=instructions %}

   - Manually {#manual}

     1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
     1. [Delete the {{ container-registry-name }} registry](../../container-registry/operations/registry/registry-delete.md).
     1. [Delete the created subnets](../../vpc/operations/subnet-delete.md) and [networks](../../vpc/operations/network-delete.md).
     1. [Delete service accounts you created](../../iam/operations/sa/delete.md).

   - {{ TF }} {#tf}

     {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

   {% endlist %}

1. [Delete the {{ GL }} VM](../../compute/operations/vm-control/vm-delete.md) or {{ mgl-name }} instance that you created.

## See also {#see-also}

* [Creating test VMs using {{ GL }} CI](../../tutorials/testing/ci-for-snapshots.md).
