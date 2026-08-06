# Storing {{ mgl-full-name }} Docker images in {{ container-registry-full-name }}


[{{ container-registry-name }}](https://docs.gitlab.com/ee/user/packages/container_registry/) is integrated into {{ GL }}. It enables you to store Docker images on a per-project basis in {{ GL }}.

You can use [{{ container-registry-full-name }}](../../container-registry/index.yaml) instead of {{ GL }} {{ container-registry-name }}. This service allows you to store Docker images in the cloud and share them across {{ yandex-cloud }} managed services, such as [{{ managed-k8s-full-name }}](../../managed-kubernetes/index.yaml) or [{{ mgl-full-name }}](../../managed-gitlab/index.yaml).

Using {{ container-registry-full-name }} to store images from {{ GL }} projects has several advantages:

* {{ GL }} {{ container-registry-name }} stores images and tags on the [{{ GL }} instance](../../managed-gitlab/concepts/index.md#instance) disk. When the instance runs out of disk space, it returns HTTP 500 errors and becomes unavailable. You can restore the instance only by contacting support.

   {{ container-registry-full-name }} stores images and tags in [registries](../../container-registry/concepts/registry.md), each with its [own quota](../../container-registry/concepts/limits.md). Therefore, storing large numbers of Docker images and tags does not consume the instance disk space.

* Images stored in {{ container-registry-full-name }} remain available even if {{ mgl-name }} becomes unavailable.

* {{ container-registry-full-name }} supports the [Docker image vulnerability scanner](../../container-registry/concepts/vulnerability-scanner.md). Use it to detect vulnerabilities and fix them before deploying your application.

To set up storage of {{ mgl-name }} Docker images in {{ container-registry-full-name }}:

1. [Create a {{ GL }} instance](#create-gitlab).
1. [Configure {{ GL }}](#configure-gitlab).
1. [Create a test application](#app-create).
1. [Create a {{ GLR }}](#runners).
1. [Create {{ GL }} environment variables](#add-variables).
1. [Create a CI pipeline configuration file](#add-ci).
1. [Check the result](#check-result).
1. [Enable a Docker image lifecycle policy](#lifecycle-policy).
1. Optionally, [scan your Docker images for vulnerabilities](#vulnerability-scanner).

If you have already configured your {{ mgl-full-name }} instance for Continuous Integration (CI), make sure to set up your [infrastructure for storing Docker images](#deploy-infrastructure). Then, proceed with the setup by [creating environment variables](#add-variables).

If you no longer need the resources you created, [delete them](#clear-out).

{% note info %}

By default, {{ GL }} {{ container-registry-name }} is disabled when creating a {{ mgl-name }} instance.

{% endnote %}

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

Infrastructure support costs include fees for the following resources:

* Disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Dynamic public IP address assigned (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* Storage of the Docker images you created and vulnerability scanner, if [enabled](#vulnerability-scanner) (see [{{ container-registry-name }} pricing](../../container-registry/pricing.md)).
* {{ managed-k8s-name }} master (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).

### Set up your infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

   1. If you do not have a [network](../../vpc/concepts/network.md#network) yet, [create one](../../vpc/operations/network-create.md).
   1. If you do not have any [subnets](../../vpc/concepts/network.md#subnet) yet, [create them](../../vpc/operations/subnet-create.md) in the [availability zones](../../overview/concepts/geo-scope.md) the new [{{ managed-k8s-full-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and [node group](../../managed-kubernetes/concepts/index.md#node-group) will reside in.
   1. [Create a service account](../../iam/operations/sa/create.md) named `account-for-container-registry` with the following [roles](../../iam/concepts/access-control/roles.md) for the folder:

      * `{{ roles-editor }}`
      * `{{ roles-cr-pusher }}`
      * `{{ roles-cr-puller }}`

   1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) with a basic master and create a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md). When doing so, specify the service account you created earlier.
   1. Configure a security group for the [{{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/connect/security-groups.md) and [{{ mgl-name }} instance](../../managed-gitlab/operations/configure-security-group.md).

   1. [Create a registry in {{ container-registry-full-name }}](../../container-registry/operations/registry/registry-create.md).

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

   1. Download the [container-registry-and-gitlab.tf](https://github.com/yandex-cloud-examples/yc-gitlab-cr-integration/blob/main/container-registry-and-gitlab.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security group](../../vpc/concepts/security-groups.md) and rules required for the {{ mgl-name }} instance and [{{ managed-k8s-full-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).
      * {{ managed-k8s-name }} cluster with a basic master.
      * [Node group for the cluster](../../managed-kubernetes/concepts/index.md#node-group).
      * [Service account](../../iam/concepts/users/service-accounts.md) for the {{ managed-k8s-name }} cluster and node group.
      * Registry in {{ container-registry-full-name }}.

   1. In `container-registry-and-gitlab.tf`, specify the following:

      * [Cloud ID](../../resource-manager/operations/cloud/get-id.md).
      * [Folder ID](../../resource-manager/operations/folder/get-id.md).
      * [{{ k8s }} version](../../managed-kubernetes/concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.

   1. Validate your {{ TF }} configuration files using this command:

      ```bash
      terraform validate
      ```

      {{ TF }} will display any configuration errors detected in your files.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

{% include [create-gitlab](../../_includes/managed-gitlab/create-gitlab.md) %}

{% include [configure-gitlab](../../_includes/managed-gitlab/initialize.md) %}

## Create a test application {#app-create}

Create a test application that can be deployed in a {{ managed-k8s-name }} cluster. To do this, add a `Dockerfile` to your project:

   1. Log in to {{ GL }}.
   1. Open your {{ GL }} project.
   1. Click ![image](../../_assets/console-icons/plus.svg) in the repository navigation bar and select **New file** from the drop-down menu.
   1. Name the file `Dockerfile` and add the following code to it:

      ```Dockerfile
      FROM alpine:3.10
      CMD echo "Hello"
      ```

   1. Add a comment in the **Commit message** field: `Dockerfile for a test application`.
   1. Click **Commit changes**.

{% include [create glr](../../_includes/managed-gitlab/k8s-runner.md) %}

## Create {{ GL }} environment variables {#add-variables}

To allow {{ mgl-name }} to save Docker images and their tags to {{ container-registry-full-name }}, create [{{ GL }} environment variables](https://docs.gitlab.com/ee/ci/variables/index.html):

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Create an [authorized key](../../iam/concepts/authorization/key.md) for the `account-for-container-registry` service account [you created earlier](#before-you-begin):

   ```bash
   yc iam key create --service-account-name account-for-container-registry -o key.json
   ```

   The key is saved in the `key.json` file in the current working directory.

1. Open your project in {{ GL }}.

1. Go to **Settings** in the left-hand panel and select **CI/CD** from the drop-down list.

1. Expand the **Variables** section.

1. Add environment variables with the protection option disabled:

   | **Variable**        | **Value**                    |
   | --------------------- | ---------------------------------- |
   | `CI_REGISTRY`         | `{{ registry }}/<registry_ID>`. Specify the ID of the registry you created earlier in {{ container-registry-full-name }}. |
   | `CI_REGISTRY_KEY`     | `key.json` file contents       |

   To add a variable:

   1. Click **Add variable**.
   1. For the `CI_REGISTRY_KEY` variable, select the **Visible** option in the **Visibility** field.

      {% note warning %}

      The `key.json` file contains spaces and line breaks which cannot be masked in {{ GL }}. However, in the provided [CI pipeline example](#add-ci), the `CI_REGISTRY_KEY` variable is not displayed explicitly, so you do not need to mask it.

      {% endnote %}

   1. In the window that opens, specify a variable name in the **Key** field and its value in the **Value** field.
   1. Disable **Protect variable**.
   1. Click **Add variable**.

## Create a CI pipeline configuration file {#add-ci}

To build images from a Dockerfile without Docker, use [kaniko](https://github.com/GoogleContainerTools/kaniko).

To publish Docker images from your {{ GL }} project to {{ container-registry-full-name }}, create a CI pipeline configuration:

1. Open the `gitlab-test` project.
1. Click ![image](../../_assets/console-icons/plus.svg) in the repository navigation bar and select **New file** from the drop-down menu.
1. Name your file `.gitlab-ci.yml`. Add the steps for building the Docker image and pushing it to {{ container-registry-full-name }}:

   {% cut ".gitlab-ci.yml" %}

   ```yaml
   build:
      stage: build
      # Using `kaniko` to create a container inside another container for enhanced security.
      image:
         name: gcr.io/kaniko-project/executor:debug
         entrypoint: [""]
      script:
         - mkdir -p /kaniko/.docker
         # Pushing the container image to the registry. The image is tagged with the commit hash.
         - echo "{\"auths\":{\"$CI_REGISTRY\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
         - >-
            /kaniko/executor
            --context "${CI_PROJECT_DIR}"
            --dockerfile "${CI_PROJECT_DIR}/Dockerfile"
            --destination "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"
   ```

   {% endcut %}

   This file includes the following variables:

   * `CI_REGISTRY` and `CI_REGISTRY_KEY`: Added to GitLab in the [previous step](#add-variables).
   * `CI_PROJECT_DIR`, `CI_PROJECT_PATH`, and `CI_COMMIT_SHORT_SHA`: [Preset in GitLab](https://docs.gitlab.com/ee/ci/variables/predefined_variables.html).

1. Add a comment in the **Commit message** field: `Create a CI pipeline`.
1. Click **Commit changes**.

## Check the result {#check-result}

Each commit triggers a build pipeline. To verify that it completed successfully:

1. Select **Build** in the left-hand panel in the `gitlab-test` project, and then select **Pipelines** from the drop-down menu.

1. Make sure the `build` stage has the `passed` status. This means that the CI pipeline completed successfully.

1. Go to the [management console]({{ link-console-main }}/) and open your {{ container-registry-full-name }}.

   If the CI pipeline completes successfully, your registry will contain a new repository. New Docker images from the {{ GL }} project will be added to this repository at each commit.

## Enable a Docker image lifecycle policy {#lifecycle-policy}

To avoid storing outdated Docker images and their tags, configure a [Docker image lifecycle policy](../../container-registry/concepts/lifecycle-policy.md). It applies to images in your [{{ container-registry-name }} repository](../../container-registry/concepts/repository.md) and enables timely cleanup of the repository. This way, you do not pay extra for [storing outdated images](../../container-registry/pricing.md#prices-storage).

To create a policy, [follow this guide](../../container-registry/operations/lifecycle-policy/lifecycle-policy-create.md).

When using a policy:

* External {{ container-registry-name }} and Docker image lifecycle policy [affect CI pipeline performance](https://docs.gitlab.com/ee/user/packages/container_registry/reduce_container_registry_storage.html#use-with-external-container-registries).

* The policy has a [limit](../../container-registry/concepts/limits.md#container-registry-limits) on the maximum number of images that can be checked per policy run. If the number of images in your {{ container-registry-name }} repository exceeds this limit, run the policy several times. This way, all your images will be checked.

## Scan your Docker images for vulnerabilities {#vulnerability-scanner}

To detect vulnerabilities in your Docker images, you can additionally enable a [vulnerability scanner](../../container-registry/concepts/vulnerability-scanner.md) in {{ container-registry-full-name }}. The scanner checks the versions of packages installed in your images against [CVE](https://cve.mitre.org/) vulnerability databases.

To enable scanning, update the CI pipeline in your {{ GL }} project:

1. Open the `gitlab-test` project.
1. Open the `.gitlab-ci.yml` file.
1. Add the steps to scan the Docker image for vulnerabilities:

   {% cut ".gitlab-ci.yml" %}

   ```yaml
   stages:
      - build
      - test

   <build_block_previously_added_to_file>

   container_scanning_free_yc:
      stage: test
      # Using jq to search for ID and write logs.
      image: 
         name: pindar/jq
         entrypoint: [""]
      artifacts:
         when: always
         paths:
            - gl-container-scanning-report-yc.json
      variables:
         # Specify the ID of the registry you previously created.
         CI_REGISTRY_ID: "<registry_ID>"
      script:
         - export CI_COMMIT_SHORT_SHA=${CI_COMMIT_SHORT_SHA}
         # Installing the Yandex Cloud CLI.
         - curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash -s -- -a && cp /root/yandex-cloud/bin/yc /usr/bin/
         # Start of scanning.
         - echo "Scanning image ${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}..."
         - export IMAGE_ID=$(yc container image list --registry-id $CI_REGISTRY_ID --format=json | jq -r --arg CI_COMMIT_SHORT_SHA $CI_COMMIT_SHORT_SHA '.[] | select(.tags[0]==$CI_COMMIT_SHORT_SHA) | .id ')
         # Logging.
         - export SCAN_RESULT=$(yc container image scan $IMAGE_ID --format=json)
         - export CRIT_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.critical // 0')
         - export HIGH_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.high // 0')
         - export SCAN_ID=$(echo $SCAN_RESULT | jq -r '.id')
         - echo "Scan results:"
         - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")'
         - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")' > gl-container-scanning-report-yc.json
         # Checking the result.
         - (( SUM = $CRIT_VULN + $HIGH_VULN )) && (( RES = (SUM >= 1) )) && echo $RES && echo "image has $CRIT_VULN critical vulnerabilities and $HIGH_VULN high vulnerabilities" && exit 1 || echo "image has no high or critical vulnerabilities" exit 0
   ```

   {% endcut %}

1. Add a comment in the **Commit message** field: `Turn on a vulnerability scanner`.
1. Click **Commit changes**. After that, the updated pipeline will run.

To make sure the image scan completed successfully:

1. Select **Build** in the left-hand panel in the `gitlab-test` project, and then select **Pipelines** from the drop-down menu.
1. Make sure the `build` and `test` stages have the `passed` status. This means that the CI pipeline completed successfully.
1. Go to the [management console]({{ link-console-main }}/) and open your {{ container-registry-full-name }}.
1. Open the repository with Docker images from the {{ GL }} project.
1. Go to the directory named after the {{ GL }} project.
1. Make sure the **{{ ui-key.yacloud.cr.image.label_scan-status }}** column shows **{{ ui-key.yacloud.cr.registry.label_scan-status-READY }}**.
1. In the **{{ ui-key.yacloud.cr.image.label_last-scan-time }}** column, click the link with the scan time.

   This will open the scan result page. Any vulnerabilities found in the image will be displayed there.

## Delete the resources you created {#clear-out}

If you no longer need the resources you created, delete them:

1. [Delete the {{ mgl-name }} instance](../../managed-gitlab/operations/instance/instance-delete.md) or the [{{ GL }} VM](../../compute/operations/vm-control/vm-delete.md).
1. [Delete all Docker images](../../container-registry/operations/docker-image/docker-image-delete.md) from the {{ container-registry-name }} registry.

Delete the other resources depending on how you created them:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. [Delete](../../vpc/operations/address-delete.md) the public IP address of the {{ managed-k8s-name }} cluster if you reserved one.
   1. [Delete the service accounts](../../iam/operations/sa/delete.md).
   1. [Delete the {{ container-registry-name }}](../../container-registry/operations/registry/registry-delete.md).
   1. [Delete the subnets](../../vpc/operations/subnet-delete.md) and the [network](../../vpc/operations/network-delete.md).

- {{ TF }} {#tf}

   {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
