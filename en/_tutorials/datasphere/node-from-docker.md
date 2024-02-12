# Deploying a service based on a Docker image

{{ ml-platform-name }} enables you to deploy and run services based on any Docker image.

In this tutorial, you will, using a [node built from a Docker image](../../datasphere/concepts/deploy/index.md#docker-node), deploy an object detection service based on [NVIDIA Triton Inference Server](https://github.com/triton-inference-server).

1. [Prepare your infrastructure](#infra).
1. [Prepare a Docker image for the service deployment](#docker).
1. [Deploy the service in {{ ml-platform-name }}](#deploy).
1. [Run a health check for the service you deployed](#check-node).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

What the cost of deploying a service based on a Docker image includes:

* A fee for continuously running node instances (see [{{ ml-platform-name }} pricing](../../datasphere/pricing.md)).
* A fee for running code cells for health checks of the deployed service
* The amount of storage used by {{ container-registry-full-name }} data (see [{{ container-registry-name }} pricing](../../container-registry/pricing.md)).

## Prepare the infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Create a folder {#create-folder}


Create a folder to host the infrastructure and store logs of your service.

{% note info %}

In our example, both the {{ yandex-cloud }} infrastructure and the deployed service run in the same {{ yandex-cloud }} folder; however, this is not required.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Give your folder a name, e.g., `data-folder`.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a registry in {{ container-registry-name }} {#create-registry}

{{ ml-platform-name }} can create a node from a Docker image hosted in {{ container-registry-full-name }}. To push an image, create a registry.

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the `data-folder` folder.
   1. In the list of services, select **{{ container-registry-name }}**.
   1. Click **{{ ui-key.yacloud.cr.overview.button_create }}**.
   1. Specify a name for the registry, such as `datasphere-registry`, and click **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.

{% endlist %}


### Create a service account for the {{ ml-platform-name }} project {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the `data-folder` folder.
   1. In the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab, click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter the name of the [service account](../../iam/concepts/users/service-accounts.md), e.g., `sa-for-datasphere`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the following [roles](../../iam/concepts/access-control/roles.md) to the service account:
      * `container-registry.images.puller` to allow {{ ml-platform-name }} to pull your Docker image for creating a node.
      * `vpc.user` to use the {{ ml-platform-name }} cluster network.
      * (Optional) `datasphere.user` to send requests to the node.

   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Create an authorized key for a service account {#create-key}

To allow your service account to [get authenticated in {{ container-registry-full-name }}](../../container-registry/operations/authentication.md), create an authorized key.

{% include [disclaimer](../../_includes/iam/authorized-keys-disclaimer.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the `data-folder` folder.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Choose the `sa-for-datasphere` service account and click the line with its name.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** in the top panel.
   1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
   1. Select the encryption algorithm.
   1. Enter a description of the key so that you can easily find it in the management console.
   1. Save both the public and private keys. The private key is not saved in {{ yandex-cloud }}, and you will not be able to view the public key in the management console.

      {% note tip %}

      You can save the file with the key on your computer. You will need its contents later when creating a secret to access {{ ml-platform-name }} in {{ container-registry-name }}.

      {% endnote %}

{% endlist %}

## Prepare your Docker image for the service deployment {#docker}

If you do not have Docker yet, [install](https://docs.docker.com/install/) it.

### Create a Docker image for your service {#create-docker}

1. Create a folder to store the configuration of your Docker image, e.g., `/home/docker-images`.
1. Create and save a text file named `Dockerfile` (without any extension).

   {% cut "Triton Dockerfile" %}

   ```text
   # syntax=docker/dockerfile:1
   FROM nvcr.io/nvidia/tritonserver:22.01-py3

   RUN mkdir -p /models/resnet152_640x640/1/model.savedmodel/ &&\
     curl -L "https://tfhub.dev/tensorflow/faster_rcnn/resnet152_v1_640x640/1?tf-hub-format=compressed" |\
     tar -zxvC /models/resnet152_640x640/1/model.savedmodel/ &&\
     mkdir -p /models/inception_resnet_v2_640x640/1/model.savedmodel/ &&\
     curl -L "https://tfhub.dev/tensorflow/faster_rcnn/inception_resnet_v2_640x640/1?tf-hub-format=compressed" |\
     tar -zxvC /models/inception_resnet_v2_640x640/1/model.savedmodel/

   ENTRYPOINT ["/opt/tritonserver/nvidia_entrypoint.sh",\
               "tritonserver",\
               "--model-repository=/models",\
               "--strict-model-config=false"]
   ```

   {% endcut %}

1. Run [Docker Desktop](https://docs.docker.com/desktop/).
1. In the command shell, navigate to the folder with `Dockerfile` you created.

   ```bash
   cd docker-images
   ```

1. Build a Docker image:

   ```bash
   docker build -t triton-docker --platfom linux/amd64 .
   ```

### Upload the Docker image to {{ container-registry-name }} {#push-docker}

{% include [install cli](../../_includes/cli-install.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

   1. [Set](../../cli/operations/profile/manage-properties.md) `data-folder` as your default folder:

      ```bash
      yc config set folder-name data-folder
      ```

   1. [Get authenticated in {{ container-registry-name }}](../../container-registry).

      1. Issue an [IAM token](../../iam/concepts/authorization/iam-token.md) for your service account.

      ```bash
      yc iam create-token
      ```

      The response will contain the IAM token: If you are authenticating on behalf of a federated account, the CLI will redirect you to the management console to authenticate and then send you an IAM token.

      {% note info %}

      {% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

      {% endnote %}

      1. Run the command using the value of the token obtained in the previous step as `<IAM token>`:

      ```bash
      docker login \
        --username iam \
        --password <IAM token> \
        {{ registry }}
      ```

   1. Get a list of registries in `data-folder`.

      ```bash
      yc container registry list

      ```

      You will need the registry ID at the next step. Sample command output:

      ```text
      +----------------------+---------------------+----------------------+
      |          ID          |        NAME         |      FOLDER ID       |
      +----------------------+---------------------+----------------------+
      | crp86bmgl1da******** | datasphere-registry | b1g4bh24c406******** |
      +----------------------+---------------------+----------------------+
      ```

   1. Push the Docker image to {{ container-registry-name }}. For `<registry_ID>`, use the ID of your registry (`datasphere-registry`):

      ```bash
      docker tag triton-docker {{ registry }}/<registry_ID>/triton:v1
      docker push {{ registry }}/<registry_ID>/triton:v1
      ```

{% endlist %}

## Deploy the service in {{ ml-platform-name }} {#deploy}

1. Open the {{ ml-platform-name }} [home page]({{ link-datasphere-main }}).
1. In the left-hand panel, select ![image](../../_assets/console-icons/circles-concentric.svg) **{{ ui-key.yc-ui-datasphere.common.spaces }}**.
1. Select a community with a billing account linked.
1. [Create a project](../../datasphere/operations/projects/create.md) named `Node from Docker`.
1. [In the project settings](../../datasphere/operations/projects/update.md), specify:
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.default-folder }}**: `data-folder`.
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.service-account }}**: `sa-for-datasphere`.
1. [Create a secret](../../datasphere/operations/data/secrets.md) named `iam-secret` including an IAM token of your user account.
1. Create a secret named `key-for-sa` storing the complete authorized key for the `sa-for-datasphere` service account.
1. Create a node. To do this, click **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}** in the top-right corner of the project page. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.node }}**. Specify the basic node parameters:
   * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**: Select **{{ ui-key.yc-ui-datasphere.common.docker }}**.
   * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}**: `triton`.
   * Under **{{ ui-key.yc-ui-datasphere.new-node.title.docker-image }}**, specify the path to the {{ container-registry-name }} image in the `cr.yandex/<registry_ID>/<image_name>:<tag>` format. You can get it in the management console by copying the full value (along with the tag) on the repository page. You can also fill out this field manually. You can get the registry ID in the CLI by running the `yc container registry list` command.
   * Click **{{ ui-key.yc-ui-datasphere.common.show-additional-parameters }}** and specify:
      * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.user-name }}**: `json_key`.
      * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.password-secret }}**: Select `key-for-sa`.
   * Under **{{ ui-key.yc-ui-datasphere.new-node.title.endpoint }}**:
      * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.type }}**: Select the **HTTP** protocol.
      * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.port }}**: 8000.
      * **{{ ui-key.yc-ui-datasphere.common.timeout }}**: Keep the default value (15 seconds).
      * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.idle-timeout }}**: Keep the default value (300 seconds).
   * Under **{{ ui-key.yc-ui-datasphere.new-node.title.telemetry }}**:
      * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**: Select **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.prometheus }}**.
      * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.http-path }}**: `/metrics`.
      * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.port }}**: 8000.
   * Under **{{ ui-key.yc-ui-datasphere.new-node.title.healthcheck }}**:
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.type }}**: Select **HTTP**.
      * **{{ ui-key.yc-ui-datasphere.common.port }}**: 8000.
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.path }}**: `/v2/health/ready`.
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.timeout }}**: 1.
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.interval }}**: 20.
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.fails-threshold }}**: 3.
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.passes-threshold }}**: 3.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}**, select `data-folder`.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}**, select the `g1.1` [configuration](../../datasphere/concepts/configurations.md) and the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md). Leave the [subnet](../../vpc/concepts/network.md#subnet) ID empty, as {{ ml-platform-name }} will use its default subnet.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.acl }}**, keep the default folder value.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

## Run a health check for the service you deployed {#check-node}

1. [Download a notebook](https://{{ s3-storage-host }}/doc-files/datasphere-nodefromdocker.ipynb) with the health check code and upload it to the `Node from Docker` project IDE.
1. Run the cells in the **Preparing environment** section: select the cells and press **Shift** + **Enter**.
1. Under **Authentication**, fill out the details to get authenticated in the node. Replace `<node ID>` and `<folder ID>` with your node ID (`triton`) and folder ID (`data-folder`).
1. Run the cells under **Authentication**.
1. Run the cells under **Test requests**. As you will access different models, the service will return objects it has detected in the image in response to each request.

## Delete the resources you created {#clear-out}

{% include [node warning](../../_includes/datasphere/nodes-pricing-warn.md) %}

1. [Delete the node](../../datasphere/operations/deploy/node-delete.md).
1. [Delete the secrets](../../datasphere/operations/data/secrets.md#delete).
1. [Delete the authorized key](../../iam/operations/authorized-key/delete.md) of the service account.
1. Delete the [Docker image](../../container-registry/operations/docker-image/docker-image-delete.md) and {{ container-registry-name }} [registry](../../container-registry/operations/registry/registry-delete.md).
