# Scanning {{ container-registry-name }} for vulnerabilities during continuous deployment of {{ managed-k8s-name }} applications using {{ GL }}

You can scan [Docker images](../container-registry/concepts/docker-image.md) for [vulnerabilities](../container-registry/concepts/vulnerability-scanner.md) in [{{ container-registry-full-name }}](../container-registry/) when continuously deploying [{{ managed-k8s-full-name }}](../managed-kubernetes/) applications via {{ GL }}.

To do this, use Continuous Integration (CI) to create a special script in {{ GL }} to be run after each commit:
1. Building an application into a Docker image and pushing the image to {{ container-registry-name }}.
1. Scanning Docker images in {{ container-registry-name }} for vulnerabilities.
1. Deploying an application from a Docker image in a {{ managed-k8s-name }} cluster using the {{ yandex-cloud }} tools.

To set up the vulnerability scanner:
1. [Create a {{ GL }} instance](#create-gitlab).
1. [Configure {{ GL }}](#configure-gitlab).
1. [Create a test application](#app-create).
1. [Create a {{ GLR }}](#runner).
1. [Configure the CI script](#ci).
1. [Check the results](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs %}

- Manually

  1. [Create service accounts](../iam/operations/sa/create.md) and [assign](../iam/operations/sa/assign-role-for-sa.md) the following roles to them:
     * A [service account](../iam/concepts/users/service-accounts.md) for the resources with the [{{ roles-editor }}](../resource-manager/security/index.md#roles-list) role to the [folder](../resource-manager/concepts/resources-hierarchy.md#folder) where the [{{ managed-k8s-name }} cluster](../managed-kubernetes/concepts/index.md#kubernetes-cluster) is being created. The resources that the {{ managed-k8s-name }} cluster needs will be created on behalf of this account.
     * A service account for [nodes](../managed-kubernetes/concepts/index.md#node-group) with the `{{ roles-cr-puller }}` and `{{ roles-cr-pusher }}` [roles](../container-registry/security/index.md#service-roles) for the folder with the Docker image [registry](../container-registry/concepts/registry.md). Nodes will download the Docker images they require from the registry on behalf of this account.

     You can use the same service account for both operations.
  1. [Create a {{ managed-k8s-name }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) and a [node group](../managed-kubernetes/operations/node-group/node-group-create.md). When creating the cluster, specify the previously created service accounts for the resources and nodes.
  1. [Configure security groups](../managed-kubernetes/operations/connect/security-groups.md) for the {{ managed-k8s-name }} cluster to run.
  1. [Configure the default security group](../managed-gitlab/operations/connect.md) required for the [{{ mgl-full-name }} instance](../managed-gitlab/concepts/index.md#instance) to run.
  1. [Create a registry in {{ container-registry-name }}](../container-registry/operations/registry/registry-create.md).

- Using {{ TF }}

  1. If you do not have {{ TF }} yet, [install and configure it](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
  1. Download the [cr-scanner-with-k8s-and-gitlab.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/cr-scanner-with-k8s-and-gitlab.tf) configuration file to the same working directory.

     This file describes:
     * [Network](../vpc/concepts/network.md#network).
     * [Subnet](../vpc/concepts/network.md#subnet).
     * [Default security group](../vpc/concepts/security-groups.md) and rules needed to run the {{ mgl-name }} instance.
     * [Security group](../vpc/concepts/security-groups.md) and rules needed to run the {{ managed-k8s-name }} cluster:
       * Rules for service traffic.
       * Rules for accessing the {{ k8s }} API and managing the cluster with `kubectl` through ports 443 and 6443.
     * {{ managed-k8s-name }} cluster.
     * Service account required to use the {{ managed-k8s-name }} cluster and node group.
     * {{ container-registry-name }} registry.
  1. In the `cr-scanner-with-k8s-and-gitlab.tf` file, specify:
     * [Folder ID](../resource-manager/operations/folder/get-id.md).
     * [{{ k8s }} version](../managed-kubernetes/concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.
     * {{ managed-k8s-name }} cluster CIDR.
     * Name of the {{ managed-k8s-name }} cluster service account.
     * Name of the {{ container-registry-name }} registry.
  1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
  1. Make sure the {{ TF }} configuration files are correct using this command:

     ```bash
     terraform validate
     ```

     If there are any errors in the configuration files, {{ TF }} will point to them.
  1. Create the required infrastructure:

     {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Install additional dependencies {#prepare}

Install the following in the local environment:
* [{{ yandex-cloud }} command line interface (YC CLI)](../cli/operations/install-cli.md).
* [The `jq` JSON stream processor](https://stedolan.github.io/jq/).
* [The Helm package manager]({{ links.helm.install }}).
* [The {{ k8s }} command-line tool kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) and [configure it to work with the created cluster](../managed-kubernetes/operations/connect/index.md#kubectl-connect).

## Get a {{ k8s }} service account token to authenticate with {{ GL }} {#k8s-get-token}

{% include notitle [k8s-get-token](../_includes/managed-gitlab/k8s-get-token.md) %}

## Create a {{ GL }} instance {#create-gitlab}

Create a {{ mgl-name }} instance and a [virtual machine](../compute/concepts/vm.md) with a {{ GL }} [image](../compute/concepts/image.md) on the same cloud network as the {{ managed-k8s-name }} cluster.

{% list tabs %}


- {{ mgl-name }} instance

  Create a {{ mgl-name }} instance by [following the instructions](../managed-gitlab/quickstart.md#instance-create).


- VM running a {{ GL }} image

  Launch {{ GL }} on a VM with a public IP.

  {% include [create-gitlab](../_includes/managed-gitlab/create.md) %}

{% endlist %}

## Configure {{ GL }} {#configure-gitlab}

{% include [Create a project](../_includes/managed-gitlab/initialize.md) %}

## Create a test application {#app-create}

Create a test application that can be deployed in a {{ managed-k8s-name }} cluster:
1. Add `Dockerfile` to the project:
   1. Log in to {{ GL }}.
   1. On the home page, select a repository.
   1. Select the **Repository** → **Files** section.
   1. Click **+** and select **New file** from the dropdown menu.
   1. Name the file as `Dockerfile` and add the following code to it:

      ```Dockerfile
      FROM alpine:3.10
      CMD echo "Hello"
      ```

   1. Add a comment to the commit in the **Commit message** field: `Dockerfile for test application`.
   1. Click **Commit changes**.
1. Add the manifest for the {{ managed-k8s-name }} cluster resources to the project:
   1. Select the **Repository** → **Files** section.
   1. Click **+** and select **New file** from the dropdown menu.
   1. Name the file as `k8s.yaml`:

      {% cut "k8s.yaml" %}

      ```yaml
      apiVersion: v1
      kind: Namespace
      metadata:
        name: hello-world
      ---
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        name: hello-world-deployment
        namespace: hello-world
      spec:
        replicas: 1
        selector:
          matchLabels:
            app: hello
        template:
          metadata:
            namespace: hello-world
            labels:
              app: hello
          spec:
            containers:
              - name: hello-world
                image: {{ registry }}/<registry ID>/__VERSION__
                imagePullPolicy: Always
      ```

      {% endcut %}

   1. Replace the `<registry ID>` with the ID of the {{ container-registry-name }} registry that you created previously.
   1. Add a comment to the commit in the **Commit message** field: `Docker image deployment config`.
   1. Click **Commit changes**.

## Create a {{ GLR }} {#runner}

{% include notitle [create glr](../_includes/managed-gitlab/k8s-runner.md) %}

## Configure the CI script {#ci}

1. Create the [{{ GL }} environment variables](https://docs.gitlab.com/ee/ci/variables/README.html):
   1. Go to **Settings** in the left {{ GL }} panel, then select **CI/CD** from the drop-down list.
   1. Click **Expand** next to **Variables**.
   1. Add two environment variables:
      * `KUBE_URL`: The [{{ managed-k8s-name }} master address](../managed-kubernetes/concepts/index.md#master). Retrieve it using the command:

        ```bash
        yc managed-kubernetes cluster get <{{ k8s }} cluster ID or name> --format=json \
          | jq -r .master.endpoints.external_v4_endpoint
        ```

      * `KUBE_TOKEN`: The token will use {{ GL }} to apply the configuration. Use the token that you received previously.
      To add a variable:
      * Click **Add variable**.
      * In the resulting window, enter the variable name in the **Key** field and the value in the **Value** field.
      * Click **Add variable**.
1. Create the CI script's configuration file:
   1. On the left-hand panel in {{ GL }}, select **Repository** and click the **Files** tab.
   1. To the right of the project name, click **+** and select **New file** from the drop-down menu.
   1. Name the file `.gitlab-ci.yml`. Add the steps to build and push a Docker image, scan it for vulnerabilities, and update the application configuration in the {{ managed-k8s-name }} cluster:

      {% cut ".gitlab-ci.yml" %}

      ```yaml
      stages:
        - build
        - test
        - deploy

      build_docker_image:
        stage: build
        variables:
          YC_REGISTRY_ID: "<registry ID>" # Set your registry ID
          DOCKER_CUSTOM_SUBFOLDER: "" # Specify a custom path (if any) to your folder with docker files
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
          YC_REGISTRY_ID: "<registry ID>" # Set your registry ID
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

   1. Replace the `<registry ID>` with the ID of the {{ container-registry-name }} registry that you created previously.
   1. Add a comment to the commit in the **Commit message** field: `CI scripts`.
   1. Click **Commit changes**.

   In the `.gitlab-ci.yml` file, the following steps of the CI script are described:
   * Build a Docker image using the `Dockerfile` and push the image to {{ container-registry-name }}.
   * Scan the Docker image for vulnerabilities in {{ container-registry-name }}.
   * Set up an environment to work with {{ k8s }} and apply `k8s.yaml` configurations to {{ managed-k8s-name }} clusters. This way the application is deployed on the previously created cluster.

## Check the results {#check-result}

After saving the `.gitlab-ci.yml` configuration file, the build script starts. To check its results, select **CI/CD** → **Pipelines** in the drop-down menu in the left-hand panel in {{ GL }}. Vulnerability scanning is performed at the second stage (`test`).

## How to delete created resources {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:
1. [Delete the {{ mgl-name }} instance](../managed-gitlab/operations/instance/instance-delete.md) or the [created VM with the {{ GL }} image](../compute/operations/vm-control/vm-delete.md).
1. [Delete all the Docker images](../container-registry/operations/docker-image/docker-image-delete.md) from the {{ container-registry-name }} registry.

Delete the other resources, depending on the method used to create them:

{% list tabs %}

- Manually

  1. [Delete the {{ managed-k8s-name }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. If you reserved a public static IP address for the cluster, [delete it](../vpc/operations/address-delete.md).
  1. [Delete the service accounts](../iam/operations/sa/delete.md).
  1. [Delete the {{ container-registry-name }} registry](../container-registry/operations/registry/registry-delete.md).

- Using {{ TF }}

  To delete the infrastructure [created with {{ TF }}](#deploy-infrastructure):
  1. In the terminal window, switch to the directory containing the infrastructure plan.
  1. Delete the `cr-scanner-with-k8s-and-gitlab.tf` configuration file.
  1. Make sure the {{ TF }} configuration files are correct using this command:

     ```bash
     terraform validate
     ```

     If there are any errors in the configuration files, {{ TF }} will point to them.
  1. Confirm the resources have been updated.

     {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

     All the resources described in the `cr-scanner-with-k8s-and-gitlab.tf` configuration will be deleted.

{% endlist %}