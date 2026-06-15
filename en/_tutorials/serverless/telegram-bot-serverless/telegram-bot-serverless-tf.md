1. [Get your cloud ready](#before-you-begin).
1. [Create a Telegram bot](#create-bot).
1. [Create the infrastructure](#deploy).
1. [Test your Telegram bot](#test-bot).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/paid-resources.md) %}


## Create a Telegram bot {#create-bot}

{% include [create-bot](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/create-bot.md) %}


## Create the infrastructure {#deploy}

{% include [terraform-definition](../../_tutorials_includes/terraform-definition.md) %}

To create your infrastructure via {{ TF }}:
1. [Install {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [obtain authentication credentials](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider. For details, see [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1.
1. Prepare your infrastructure description files:

    {% list tabs group=infrastructure_description %}

    - Ready-made configuration {#ready}

      1. Clone the [repository](https://sourcecraft.dev/yandex-cloud-examples/yc-telegram-bot-serverless) with the configuration files required to create the bot. Do it by running this [git](https://git-scm.com/) command in the terminal:

          ```bash
          git clone https://git@git.sourcecraft.dev/yandex-cloud-examples/yc-telegram-bot-serverless.git
          ```

      1. Navigate to the repository directory. It should now contain the following files:
          * `telegram-bot.tf`: New infrastructure configuration.
          * `telegram-bot.auto.tfvars`: User data file.
          * `telegram-bot-function.tpl`: Template for creating a function in {{ sf-full-name }}.
          * `telegram-bot-gw-spec.tpl`: API gateway specification template.
          * `sayhello.png`: Your bot image.
          * `package.json`: Manifest for the Node.js function.

    - Manually {#manual}

      1. Create a folder for configuration files.

      1. In the folder, create:

          1. `telegram-bot.tf` configuration file:

              {% cut "telegram-bot.tf" %}

              {% include [telegram-bot-tf-config](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/telegram-bot-tf-config.md) %}

              {% endcut %}

          1. `telegram-bot-function.tpl` template for creating a function in {{ sf-full-name }}:

              {% cut "telegram-bot-function.tpl" %}

              {% include [telegram-bot-index-js](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/telegram-bot-index-js.md) %}

              {% endcut %}

          1. `telegram-bot-gw-spec.tpl` API gateway specification template:

              {% cut "telegram-bot-gw-spec.tpl" %}

              {% include [telegram-bot-gw-spec](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/telegram-bot-gw-spec.md) %}

              {% endcut %}

          1. `telegram-bot.auto.tfvars` user data file:

              ```text
              bot_token   = "<Telegram_bot_token>"
              bucket_name = "<bucket_name>"
              cloud_id    = "<cloud_ID>"
              folder_id   = "<folder_ID>"
              ```

          1. `package.json` manifest for the Node.js function:

              {% include [telegram-bot-package-json](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/telegram-bot-package-json.md) %}

    {% endlist %}

    For more information about {{ TF }} resource properties, see the relevant provider guides:
    * [Service account](../../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * Assigning a [role](../../../iam/concepts/access-control/roles.md) to a service account: [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Static access key](../../../iam/concepts/authorization/access-key.md): [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
    * [Bucket](../../../storage/concepts/bucket.md): [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket)
    * [Object](../../../storage/concepts/object.md): [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object)
    * [API gateway](../../../api-gateway/concepts/index.md): [yandex_api_gateway]({{ tf-provider-resources-link }}/api_gateway).
    * [Function](../../../functions/concepts/index.md): [yandex_function]({{ tf-provider-resources-link }}/function).
    * Assigning [roles for a function](../../../functions/security/index.md): [yandex_function_iam_binding]({{ tf-provider-resources-link }}/function_iam_binding).

1. In the `telegram-bot.auto.tfvars` file, specify these custom settings:
   * `bot_token`: Telegram bot token.
   * `bucket_name`: Bucket name.
   * `cloud_id`: Cloud ID.
   * `folder_id`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).

1. Create the resources:

    {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

1. Configure a link between the function and the Telegram bot.

    1. Update the API gateway specification by adding the `fshtb-function` section at the end of the code:

        {% include [telegram-bot-function-bind](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/telegram-bot-function-bind.md) %}

    1. Apply the configuration changes:

        ```bash
        terraform apply
        ```

    1. Type `yes` and press **Enter** to confirm the changes.

    1. {% include [telegram-bot-setwebhook](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/telegram-bot-setwebhook.md) %}


## Test your Telegram bot {#test-bot}

{% include [test-bot](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/test-bot.md) %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. Open the `telegram-bot.tf` file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}