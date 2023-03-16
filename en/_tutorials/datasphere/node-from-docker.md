# Deploying a service based on a Docker image

{{ ml-platform-name }} enables you to deploy and run services based on any Docker image.

In this tutorial, you will, using a [node built from a Docker image](../../datasphere/concepts/deploy/index.md#docker-node), deploy an object detection service based on [NVIDIA Triton Inference Server](https://github.com/triton-inference-server).

1. [Prepare the infrastructure](#infra).
1. [Prepare a Docker image for the service deployment](#docker).
1. [Deploy the service in {{ ml-platform-name }}](#deploy).
1. [Run a health check for the service you deployed](#check-node).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

What the cost of deploying a service based on a Docker image includes:

* A fee for continuously running node instances (see [{{ ml-platform-name }} pricing](../../datasphere/pricing.md)).
* A fee for running code cells for health checks of the deployed service
* The amount of storage used by {{ container-registry-full-name }} data (see [{{ container-registry-name }} pricing](../../container-registry/pricing.md)).

## Prepare the infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

### Create a folder {#create-folder}


Create a folder to host the infrastructure and store logs of your service.

{% note info %}

In our example, both the {{ yandex-cloud }} infrastructure and the deployed service run in the same {{ yandex-cloud }} folder; however, this is not required.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/plus-sign.svg) **Create folder**.
   1. Give your folder a name, e.g., `data-folder`.
   1. Click **Create**.

{% endlist %}

### Create a registry in {{ container-registry-name }} {#create-registry}

{{ ml-platform-name }} can create a node from a Docker image hosted in {{ container-registry-full-name }}. To push an image, create a registry.

{% list tabs %}

- Management console

   1. Go to the `data-folder` folder.
   1. In the list of services, select **{{ container-registry-name }}**.
   1. Specify a name for the registry, for example, `datasphere-registry`.
   1. Click **Create registry**.

{% endlist %}


### Create a service account for the {{ ml-platform-name }} project {#create-sa}

{% list tabs %}

- Management console

   1. Go to the `data-folder` folder.
   1. In the **Service accounts** tab, click **Create service account**.
   1. Enter the name of the [service account](../../iam/concepts/users/service-accounts.md), e.g., `sa-for-datasphere`.
   1. Click **Add role** and assign the following [roles](../../iam/concepts/access-control/roles.md) to the service account:
      * `container-registry.images.puller` to allow {{ ml-platform-name }} to pull your Docker image for creating a node.
      * `vpc.user` to use the {{ ml-platform-name }} cluster network.
      * (optional) `datasphere.user` to send requests to the node.

   1. Click **Create**.

{% endlist %}

### Create an authorized key for the service account {#create-key}

To allow your service account to [get authenticated in {{ container-registry-full-name }}](../../container-registry/operations/authentication.md), create an authorized key.

{% include [disclaimer](../../_includes/iam/authorized-keys-disclaimer.md) %}

{% list tabs %}

- Management console

   1. In the `data-folder` folder, go to the **Service accounts** tab.
   1. Choose the `sa-for-datasphere` service account and click the line with its name.
   1. Click **Create new key** in the top panel.
   1. Click **Create authorized key**.
   1. Select the encryption algorithm.
   1. Enter a description of the key so that you can easily find it in the management console.
   1. Save both the public and private keys. The private key is not saved in {{ yandex-cloud }}, and you won't be able to view the public key in the management console.

      {% note tip %}

      You can save the file with the key on your computer. You will need its contents later when creating a secret to access {{ ml-platform-name }} in {{ container-registry-name }}

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
   RUN mkdir -p /models/resnet50_640x640/1/model.savedmodel/ &&\
     curl -L "https://tfhub.dev/tensorflow/faster_rcnn/resnet50_v1_640x640/1?tf-hub-format=compressed" |\
     tar -zxvC /models/resnet50_640x640/1/model.savedmodel/ &&\
     mkdir -p /models/resnet101_640x640/1/model.savedmodel/ &&\
     curl -L "https://tfhub.dev/tensorflow/faster_rcnn/resnet101_v1_640x640/1?tf-hub-format=compressed" |\
     tar -zxvC /models/resnet101_640x640/1/model.savedmodel/ && \
     mkdir -p /models/resnet152_640x640/1/model.savedmodel/ &&\
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

1. Run [Docker Desktop](https://docs.docker.com/desktop/):
1. In the command shell, switch to the folder with your Dockerfile.

   ```bash
   cd docker-images
   ```

1. Build a Docker image:

   ```bash
   docker build -t triton-docker .
   ```

1.

### Upload the Docker image to {{ container-registry-name }} {#push-docker}

{% include [install cli](../../_includes/cli-install.md) %}

{% list tabs %}

- CLI

   1. [Set](../../cli/operations/profile/manage-properties.md) `data-folder` as your default folder:

      ```bash
      yc config set folder-name data-folder
      ```

   1. Get a list of registries in `data-folder`.

      ```bash
      yc container registry list
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
        cr.yandex
      ```

   1. Push the Docker image to {{ container-registry-name }}. For <Registry ID>, use the ID of your registry (`datasphere-registry`):

      ```bash
      docker tag triton-docker cr.yandex/<registry ID>/triton:v1
      docker push cr.yandex/<Registry ID>/triton:v1
      ```

{% endlist %}

## Deploy the service in {{ ml-platform-name }} {#deploy}

1. [On the {{ ml-platform-name }} home page]({{ link-datasphere-main }}) under **Communities**, select a community with a billing account linked.
1. Create a project named `Node from Docker`.
1. [In the project settings](../../datasphere/operations/projects/update.md), specify:
   * **Service account**: `sa-for-datasphere`.
   * **Folder**: `data-folder`.
1. [Create a secret](../../datasphere/operations/data/secrets.md) named `iam-secret` including an IAM token of your user account.
1. Create a secret named `key-for-sa` storing the complete authorized key for the `sa-for-datasphere` service account.
1. Create a node. To do this, click **Create resource** in the top right corner of the project page. In the window that opens, select **Node**. Specify the basic node parameters:
   * **Type**: Select **Docker image**.
   * **Name**: `triton`.
   * Under **Docker image**, specify the path to the {{ container-registry-name }} image. You can obtain it in the management console or CLI by running the `yc container registry list` command.
   * Click **Show additional parameters** and set the following:
      * **Username**: `json_key`.
      * **Password secret**: Select `key-for-sa`.
   * Under **Endpoint**:
      * **Type**: Select the **HTTP** protocol.
      * **Port**: 8000.
      * **Timeout**: Keep the default value (15 seconds).
      * **Idle timeout**: Keep the default value (15 seconds).
   * Under **Telemetry**:
      * **Type**: Select **Prometheus**.
      * **HTTP address**: `/metrics`.
      * **Port**: 8000.
   * Under **Check**:
      * **Type**: Select **HTTP**.
      * **Port**: 8020.
      * **Path**: `/v2/health/ready`.
      * **Timeout**: 1.
      * **Interval**: 20.
      * **Failed checks**: 3.
      * **Passed checks**: 3.
1. Under **Folder**, select `data-folder`.
1. Under **Maintenance**, select the `c1.4` [configuration](../../datasphere/concepts/configurations.md) and the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md). Leave the [subnet](../../vpc/concepts/network.md#subnet) ID empty, as {{ ml-platform-name }} will use its default subnet.
1. Under **Access control list (ACL)**, keep the default folder value.
1. Click **Create**.

## Run a health check for the service you deployed {#check-node}

1. [Download a notebook](https://storage.yandexcloud.net/doc-files/datasphere-nodefromdocker.ipynb) with the health check code and upload it to the `Node from Docker` project IDE.
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
