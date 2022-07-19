# Managing container revisions

You can [create](#create) a revision, get revision [information](#get), or a [list of revisions](#list) of a container as well as [add environment variables](#revision-env).

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
   1. Open **{{ serverless-containers-name }}**.
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

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To add environment variables:

   1. Open the {{ TF }} configuration file and, under the `yandex_serverless_container` resource, add an `environment` list with the environment variables to the `image` section:

      ```hcl
      ...
      resource "yandex_serverless_container" "test-container" {
        name               = "my-container"
        memory             = 256
        service_account_id = "ajec........34ova"
        image {
            url = "cr.yandex/yc/test-image:v1"
            environment = {
                <key> = "<value>"
            }
        }
      }
      ...
      ```

      Where `--environment` is an environment variables in `key="value"` format. You can specify more than one pair.

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.

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
