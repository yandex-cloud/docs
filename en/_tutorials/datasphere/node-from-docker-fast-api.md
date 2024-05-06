# Deploying a service based on a Docker image with FastAPI

In this tutorial, you will deploy a FastAPI service based on a [Docker image](../../datasphere/concepts/deploy/index.md#docker-node). The service provides metrics in [Prometheus](https://prometheus.io/docs/instrumenting/exposition_formats/#text-based-format) text format. The service will run on the `0.0.0.0.0` IP address and port `9875`.

To deploy a service based on a Docker image with FastAPI:

1. [Prepare your infrastructure](#infra).
1. [Prepare a Docker image for the service deployment](#docker).
1. [Deploy the service in {{ ml-platform-name }}](#deploy).
1. [Run a health check for the service you deployed](#check-node).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

The cost of deploying a service based on a Docker image includes:

* Fee for continuously running node instances (see [{{ ml-platform-name }} pricing](../../datasphere/pricing.md)).
* Fee for running code cells for health checks of the deployed service.
* Amount of storage used by {{ container-registry-full-name }} data (see [{{ container-registry-name }} pricing](../../container-registry/pricing.md)).

## Prepare the infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Create a folder {#create-folder}

{% note info %}

In our example, both the {{ yandex-cloud }} infrastructure and the service deployed operate in the same {{ yandex-cloud }} folder; however, this is not a requirement.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Give your folder a name, e.g., `data-folder`.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a registry in {{ container-registry-name }} {#create-registry}

{{ ml-platform-name }} can create a node from a Docker image hosted in [{{ container-registry-full-name }}](../../container-registry/). To push an image, create a registry.

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the `data-folder` folder.
   1. In the list of services, select **{{ container-registry-name }}**.
   1. Click **{{ ui-key.yacloud.cr.overview.button_create }}**.
   1. Specify a name for the registry, e.g., `datasphere-registry`, and click **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.

{% endlist %}

### Create a service account for the {{ ml-platform-name }} project {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the `data-folder` folder.
   1. In the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab, click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter a name for the [service account](../../iam/concepts/users/service-accounts.md), e.g., `sa-for-datasphere`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the following [roles](../../iam/concepts/access-control/roles.md) to the service account:
      * `container-registry.images.puller` to allow {{ ml-platform-name }} to pull your Docker image for creating a node.
      * `vpc.user` to use the {{ ml-platform-name }} network.
      * `datasphere.user` to send requests to the node.

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
   1. Save both the public and private keys. The private key is not saved in {{ yandex-cloud }}, and you will not be able to view the public key in the management console.

      {% note tip %}

      You can save the file with the key on your computer. You will need its contents later when creating a secret to access {{ ml-platform-name }} in {{ container-registry-name }}.

      {% endnote %}

{% endlist %}

## Prepare your Docker image for the service deployment {#docker}

If you do not have Docker yet, [install](https://docs.docker.com/install/) it.

### Create a Docker image for your service {#create-docker}

1. Create a folder to store the configuration of the Docker image and all the required files, e.g., `/home/docker-images`.
1. Clone the [repository on GitHub](https://github.com/yandex-cloud-examples/yc-datasphere-fastapi-service-deploy) and place the files in the created folder.
1. Run [Docker Desktop](https://docs.docker.com/desktop/).
1. In the command shell, navigate to the folder with `Dockerfile` you created.

   ```bash
   cd docker-images
   ```

1. Build a Docker image:

   ```bash
   docker build --platform linux/amd64 -t fastapi-docker .
   ```

### Push the Docker image to {{ container-registry-name }} {#push-docker}

{% include [install cli](../../_includes/cli-install.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

   1. [Set](../../cli/operations/profile/manage-properties.md) `data-folder` as your default folder:

      ```bash
      yc config set folder-id <folder_ID>
      ```

   1. [Get authenticated in {{ container-registry-name }}](../../container-registry).

      1. Issue an [IAM token](../../iam/concepts/authorization/iam-token.md) for your service account.

      ```bash
      yc iam create-token
      ```

      The response will contain the IAM token: If you are authenticating using a federated account, the CLI will redirect you to the management console to authenticate and then send you an IAM token.

      {% note info %}

      {% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

      {% endnote %}

      1. Run the command with the token value you got in the previous step in place of `<IAM_token>`:

      ```bash
      docker login \
        --username iam \
        --password <IAM_token> \
        {{ registry }}
      ```

   1. Get a list of registries in `data-folder`:

      ```bash
      yc container registry list
      ```

      You will need the registry ID at the next step. Command output example:

      ```text
      +----------------------+---------------------+----------------------+
      |          ID          |        NAME         |      FOLDER ID       |
      +----------------------+---------------------+----------------------+
      | crp86bmgl1da******** | datasphere-registry | b1g4bh24c406******** |
      +----------------------+---------------------+----------------------+
      ```

   1. Push the Docker image to {{ container-registry-name }} by substituting your `datasphere-registry` ID:

      ```bash
      docker tag fastapi-docker {{ registry }}/<registry_ID>/fastapi:v1
      docker push {{ registry }}/<registry_ID>/fastapi:v1
      ```

{% endlist %}

## Deploy the service in {{ ml-platform-name }} {#deploy}

1. {% include [ui-find-community](../../_includes/datasphere/ui-find-community.md) %}
1. Select a community with a billing account linked.
1. [Create a project](../../datasphere/operations/projects/create.md) named `Node from Docker`.
1. [In the project settings](../../datasphere/operations/projects/update.md), specify:
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.default-folder }}**: `data-folder`
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.service-account }}**: `sa-for-datasphere`
1. [Create](../../datasphere/operations/data/secrets.md) a secret named `key-for-sa` to store the full contents of the authorized key file for the `sa-for-datasphere` service account.
1. Create a node. To do this, click **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}** in the top-right corner of the project page. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.node }}**. Specify the node settings:
   1. In the **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}** field, enter the node name: `fastapi`.
   1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.docker-image }}**:
      * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**: Select **{{ ui-key.yc-ui-datasphere.common.docker }}**.
      * **{{ ui-key.yc-ui-datasphere.new-node.source }}**: Select **{{ ui-key.yc-ui-datasphere.new-node.ycr }}**.
      * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.image-path }}**: Specify the path to the {{ container-registry-name }} image in the `cr.yandex/<registry_ID>/<image_name>:<tag>` format. You can get it in the management console by copying the full value on the repository page. You can also fill out this field manually. You can get the registry ID in the CLI by running the `yc container registry list` command.
      * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.password-secret }}**: Select `key-for-sa`.
   1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.endpoint }}**:
      * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.type }}**: Select **HTTP**.
      * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.port }}**: 9875.
   1. Enable **{{ ui-key.yc-ui-datasphere.new-node.title.telemetry }}** and specify:
      * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**: Select **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.prometheus }}**.
      * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.http-path }}**: `/metrics`.
      * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.port }}**: 9875.
   1. Enable **{{ ui-key.yc-ui-datasphere.new-node.title.healthcheck }}** and specify:
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.type }}**: Select **HTTP**.
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.path }}**: `0.0.0.0`.
      * **{{ ui-key.yc-ui-datasphere.common.port }}**: 9875.
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.timeout }}**: 1.
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.interval }}**: 15.
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.fails-threshold }}**: 3.
      * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.passes-threshold }}**: 3
   1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}**, select `data-folder`.
   1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}**, select the `g1.1` [configuration](../../datasphere/concepts/configurations.md).
   1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

## Run a health check for the service you deployed {#check-node}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. In the list of services, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. Click the `Node from Docker` you created.
1. Go to the **{{ ui-key.yc-ui-datasphere.node-page.tab.request }}** tab.
1. In the **{{ ui-key.yc-ui-datasphere.node-page.request.create-test-request }}** form, select the `GET` method.
1. In the **Path** field, enter `/urls`.
1. Click **{{ ui-key.yc-ui-datasphere.common.execute }}** to get a complete list of URIs to test performance and metrics.

   Result:

   ```json
   [
   {
      "path": "/openapi.json",
      "name": "openapi"
   },
   {
      "path": "/docs",
      "name": "swagger_ui_html"
   },
   {
      "path": "/docs/oauth2-redirect",
      "name": "swagger_ui_redirect"
   },
   {
      "path": "/redoc",
      "name": "redoc_html"
   },
   {
      "path": "/metrics",
      "name": "metrics"
   },
   {
      "path": "/",
      "name": "root"
   },
   {
      "path": "/urls",
      "name": "get_all_urls"
   },
   {
      "path": "/health-check",
      "name": "healthcheck"
   }
   ]
   ```

## How to delete the resources you created {#clear-out}

{% include [node warning](../../_includes/datasphere/nodes-pricing-warn.md) %}

1. [Delete the node](../../datasphere/operations/deploy/node-delete.md).
1. [Delete the secret](../../datasphere/operations/data/secrets.md#delete).
1. [Delete the authorized key](../../iam/operations/authorized-key/delete.md) of the service account.
1. [Delete the Docker image](../../container-registry/operations/docker-image/docker-image-delete.md).
1. [Delete](../../container-registry/operations/registry/registry-delete.md) the {{ container-registry-name }} registry.
