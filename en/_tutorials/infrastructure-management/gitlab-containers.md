[{{ GL }}](https://about.gitlab.com/) is a tool for Continuous integration (CI).

This tutorial describes:
* Building an application into a Docker container.
* Deploying an application from a container in a [{{ managed-k8s-full-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) via {{ GL }} using the {{ yandex-cloud }} tools.

Each commit to {{ GL }} is followed by:
* Running a script that includes steps to build the [Docker image](../../container-registry/concepts/docker-image.md).
* Applying a new {{ managed-k8s-name }} cluster configuration specifying the application to deploy.

To set up the infrastructure required to store the source code, build the Docker image, and deploy your applications, follow these steps:
1. [Create a {{ GL }} instance](#create-gitlab).
1. [Configure {{ GL }}](#configure-gitlab).
1. [Create a test application](#app-create).
1. [Create a {{ GLR }}](#runner).
1. [Configure the CI script](#ci).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

Infrastructure support costs include payments for the following resources:
* [Disks](../../compute/concepts/disk.md) and continuously running [VMs](../../compute/concepts/vm.md) (see the [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Usage of a dynamic [public IP](../../vpc/concepts/ips.md) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Storage of created Docker images (see [{{ container-registry-name }} pricing](../../container-registry/pricing.md)).
* Usage of a [{{ managed-k8s-name }} master](../../managed-kubernetes/concepts/index.md#master) (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).


{% include [deploy-infrastructure](../../_includes/managed-gitlab/deploy-infrastructure.md) %}

{% include [prepare](../../_includes/managed-gitlab/prepare.md) %}

{% include [k8s-get-token](../../_includes/managed-gitlab/k8s-get-token.md) %}

{% include [create-gitlab](../../_includes/managed-gitlab/create-gitlab.md) %}

{% include [Create a project](../../_includes/managed-gitlab/initialize.md) %}

{% include [app-create](../../_includes/managed-gitlab/app-create.md) %}

{% include [create glr](../../_includes/managed-gitlab/k8s-runner.md) %}

## Configure the CI script {#ci}

1. Create the [{{ GL }} environment variables](https://docs.gitlab.com/ee/ci/variables/README.html):
   1. Go to **Settings** in the left-hand {{ GL }} panel and select **CI/CD** from the drop-down list.
   1. Click **Expand** next to **Variables**.
   1. Add two environment variables:
      * `KUBE_URL`: [{{ managed-k8s-name }} master address](../../managed-kubernetes/concepts/index.md#master). You can retrieve it using the following command:

         ```bash
         yc managed-kubernetes cluster get <{{ k8s }} cluster ID or name> --format=json \
            | jq -r .master.endpoints.external_v4_endpoint
         ```

      * `KUBE_TOKEN`: Token that will use {{ GL }} to apply the configuration. Use the token that you received previously.

      To add a variable:
      * Click **Add variable**.
      * In the window that opens, enter the variable name in the **Key** field and the value in the **Value** field.
      * Click **Add variable**.
1. Create the CI script's configuration file:
   1. On the left-hand panel in {{ GL }}, select **Repository** and click the **Files** tab.
   1. Click ![image](../../_assets/plus.svg) to the right of the project name and select **New file** from the drop-down menu.
   1. Name the file `.gitlab-ci.yml`. Add the steps to build and push a [Docker image](../../container-registry/concepts/docker-image.md) and update the application configuration in the {{ managed-k8s-name }} cluster:

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
          # Install jq.
          - wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && chmod +x ./jq && cp jq /kaniko
          # Get a service account token from metadata.
          - wget --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token && cp token /kaniko
          - echo "{\"auths\":{\"cr.yandex\":{\"auth\":\"$(printf "%s:%s" "iam" "$(cat /kaniko/token | ./jq -r '.access_token')" | base64 | tr -d '\n')\"}}}" > /kaniko/.docker/config.json
          - >-
            /kaniko/executor
            --context "${CI_PROJECT_DIR}"
            --dockerfile "${CI_PROJECT_DIR}/Dockerfile"
            --destination "cr.yandex/<registry ID>/hello:gitlab-$CI_COMMIT_SHORT_SHA"
          # Delete the metadata file.
          - rm /kaniko/token

      deploy:
        image: gcr.io/cloud-builders/kubectl:latest
        stage: deploy
        script:
          - kubectl config set-cluster k8s --server="$KUBE_URL" --insecure-skip-tls-verify=true
          - kubectl config set-credentials admin --token="$KUBE_TOKEN"
          - kubectl config set-context default --cluster=k8s --user=admin
          - kubectl config use-context default
          - sed -i "s/__VERSION__/gitlab-$CI_COMMIT_SHORT_SHA/" k8s.yaml
          - kubectl apply -f k8s.yaml
      ```

      {% endcut %}

   1. Replace the `<registry ID>` with the ID of the {{ container-registry-name }} registry that you created previously.
   1. Add a comment to the commit in the **Commit message** field: `CI scripts`.
   1. Click **Commit changes**.

   In the `.gitlab-ci.yml` file, the following two steps of project build are described:
   * Build a Docker image using the `Dockerfile` and push the image to {{ container-registry-name }}.
   * Set up an environment to work with {{ k8s }} and apply `k8s.yaml` configurations to {{ managed-k8s-name }} clusters. This way the application is deployed on the previously created cluster.

## Check the result {#check-result}

1. Once you save the `.gitlab-ci.yml` configuration file, the build script will start. To check its results, select **CI/CD** → **Pipelines** in the drop-down menu in the left-hand panel in {{ GL }} and wait for the build stages to complete.
1. To check how the created application is running in a {{ managed-k8s-name }} cluster, view the container logs in the {{ k8s }} cluster:

   ```bash
   kubectl logs deployment/hello-world-deployment -n hello-world
   ```

   Result:

   ```text
   Hello
   ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:
1. [Delete the created Docker images](../../container-registry/operations/docker-image/docker-image-delete.md).
1. Delete the {{ managed-k8s-name }} cluster and {{ container-registry-name }} registry:

   {% list tabs %}

   - Manually

      1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
      1. [Delete the {{ container-registry-name }} registry](../../container-registry/operations/registry/registry-delete.md).
      1. [Delete the created subnets](../../vpc/operations/subnet-delete.md) and [networks](../../vpc/operations/network-delete.md).
      1. [Delete the created service accounts](../../iam/operations/sa/delete.md).

   - Using {{ TF }}

      1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
      1. Delete the `k8s-and-registry-for-gitlab.tf` configuration file.
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point to them.
      1. Confirm the resources have been updated:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         All resources described in the `k8s-and-registry-for-gitlab.tf` configuration file will be deleted.

   {% endlist %}

1. [Delete the {{ GL }} VM](../../compute/operations/vm-control/vm-delete.md) or {{ mgl-name }} instance that you created.

## See also {#see-also}

* [Creating test VMs using {{ GL }} CI](../../tutorials/testing/ci-for-snapshots.md).