# Managing container revisions

You can [create](#create) a revision, get [information](#get) about a revision or a [list of a container's revisions](#list), [add environment variables](#revision-env), [pass a {{ lockbox-name }} secret to the container](#lockbox), and [specify a cloud network](#networking) where the container will be executed.

{% include [manage-revision-note](../../_includes/serverless-containers/manage-revision-note.md) %}

To manage container revisions, you need the name or unique ID of the container that this revision belongs to. To get them, [get a list of containers](./list.md).

{% include [create-revision-note](../../_includes/serverless-containers/create-revision-note.md) %}

## Creating a revision {#create}

{% include [create-revision](../../_includes/serverless-containers/create-revision.md) %}

## Getting a list of revisions {#list}

{% include [revision-list](../../_includes/serverless-containers/revision-list.md) %}

## Getting information about a revision {#get}

{% include [revision-get](../../_includes/serverless-containers/revision-get.md) %}

## Adding environment variables {#revision-env}

When you add environment variables, a new container revision is created. You can't add environment variables to an existing revision.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ serverless-containers-name }}**.
   1. Select the container whose version you want to add an environment variable for.
   1. Go to the **Editor** tab.
   1. In the window that opens, under **Image parameters**, specify the environment variable and click **Add**. You can add multiple environment variables.
   1. Click **Create revision**. A new container revision with the specified environment variables is created.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add environment variables, run the command:

   {% note warning %}

   If the previous revision contained environment variables, this command overwrites them.

   {% endnote %}

   ```
   yc serverless container revision deploy \
     --container-name <container_name> \
     --image <Docker_image_URL> \
     --cores 1 \
     --memory 1GB \
     --service-account-id <service_account_ID> \
     --environment <environment_variables>
   ```

   Where:

   * `--cores`: Number of cores available for the container.
   * `--memory`: Required memory. The default is 128 MB.
   * `--environment`: Environment variables in `key=value` format. You can specify multiple pairs separated by commas.

- API

   To add an environment variable to a container revision, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) API method.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To add environment variables:

   1. Open the {{ TF }} configuration file and, under the `yandex_serverless_container` resource, add an environment list with the `environment` variables to the `image` section:

      ```hcl
      ...
      resource "yandex_serverless_container" "test-container" {
        name               = "my-container"
        memory             = 256
        service_account_id = "ajec........34ova"
        image {
            url = "{{ registry }}/yc/test-image:v1"
            environment = {
                <key> = "<value>"
            }
        }
      }
      ...
      ```

      `--environment`: Environment variables in `key="value"` format. You can specify more than one pair.

      For more information about the `yandex_serverless_container` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/serverless_container).

   1. Check the configuration using the command:
      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify that you have added the environment variables in the [management console]({{ link-console-main }}) or with the following [CLI](../../cli/) command:

   ```
   yc serverless container revision get <revision_ID>
   ```

{% endlist %}

## Specifying a cloud network {#networking}

{% include [note-preview](../../_includes/note-preview.md) %}

You can specify a [cloud network](../../vpc/concepts/network.md#network) where the container will be executed.

{% include [network](../../_includes/functions/network.md) %}

For more information about [networking](../concepts/networking.md), see {{ serverless-containers-name }}.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ serverless-containers-name }}**.
   1. Select the container.
   1. Go to the **Editor** tab.
   1. Under **Parameters**, in the **Network** field, choose a cloud network for container execution.
   1. Click **Create revision**.

- API

   To specify the cloud network where the container will run, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) API method.

{% endlist %}

## Transmitting a {{ lockbox-name }} secret {#lockbox}

{% include [note-preview-pp](../../_includes/note-preview-pp.md) %}

[{{ lockbox-name }}](../../lockbox/) is a service for storing secrets. You can transmit a {{ lockbox-name }} secret to a container in the [environment variable](../concepts/runtime.md#environment-variables).

A container can access the secret when a service account with the `lockbox.payloadViewer` role is specified in the container's parameters. [How to create a service account](../../iam/operations/sa/create.md).

A new revision of a container is created when {{ lockbox-name }} secrets are transmitted. You can't transmit secrets to an existing revision.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Open **{{ serverless-containers-name }}**.
   1. Select a container to which you want to transmit a secret.
   1. Go to the **Editor** tab.
   1. In the window that opens, under **Image parameters**, in the **{{ lockbox-name }} secret** field, specify:
      * The name of the environment variable where the secret will be kept.
      * Secret ID.
      * Secret version ID.
      * Non-secret key ID.
   1. Click **Add**. You can transmit several secrets to a container.
   1. Click **Create revision**. A new container revision with the specified secrets is created.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To transmit {{ lockbox-name }} secrets to a container, run the command:

   {% note warning %}

   If the secrets were already passed to the previous revision, they are overwritten.

   {% endnote %}

   ```
   yc serverless container revision deploy \
      --container-name test \
      --image {{ registry }}/crpp35**************/repository:tag \
      --cores 1 \
      --memory 1GB \
      --service-account-id bfbtfc************** \
      --secret environment-variable=KEY,id=fc3q4a**************,version-id=fc3gvv**************,key=key-id
   ```

   Where:

   * `--container-name`: Container name.
   * `--image`: URL of a Docker image.
   * `--cores`: Number of cores available for the container.
   * `--memory`: Required memory. The default is 128 MB.
   * `--service-account-id`: ID of a service account with the `lockbox.payloadViewer` role.
   * `--secret`:
      * `environment-variable`: Name of the environment variable where the secret will be kept.
      * `id`: Secret ID.
      * `version-id`: Secret version ID.
      * `key`: Non-secret key ID.

- API

   To transmit a {{ lockbox-name }} secret to a container, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) API method.

{% endlist %}
