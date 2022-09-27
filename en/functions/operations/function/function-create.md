# Creating a function

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a function.
   1. Open **{{ sf-name }}**.
   1. Click **Create function**.
   1. Enter a name and description for the function. Name format:

      {% include [name-format](../../../_includes/name-format.md) %}

   1. Click **Create**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create a function, run the command:

   ```
   yc serverless function create --name=<function name>
   ```

   Result:

   ```
   id: b09bhaokchn9pnbrlseb
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-06-14T10:03:37.475Z"
   name: python_function
   log_group_id: eolm8aoq9vcppsieej6h
   http_invoke_url: https://functions.yandexcloud.net/b09bhaokchn9pnbrlseb
   status: ACTIVE
   ```

- API

   You can create a function using the [create](../../functions/api-ref/Function/create.md).

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a function:

   1. In the configuration file, describe the parameters of resources that you want to create:

      * `yandex_function`: Description of the function being created and its source code:
         * `name`: Function name.
         * `folder_id`: ID of the folder.
         * `description`: Text description of the function.
         * `labels`: Function labels in `key:value` format.
         * `user_hash`: An arbitrary string that identifies the function version. When the function changes, update this string, too. The function will update when this string is updated.
         * `runtime`: The function [runtime environment](../../concepts/runtime/index.md).
         * `entrypoint`: Function name in the source code that will serve as an entry point to the applications.
         * `memory`: The amount of memory allocated for function execution, in MB.
         * `execution_timeout`: Function execution timeout.
         * `service_account_id`: ID of the service account that should be used to invoke the function.
         * `environment`: Environment variables in `key:value` format.
         * `tags`: Function tags.
         * `version`: Function version.
         * `image_size`: Size of the image for the function.
         * `loggroup_id`: ID of the log group for the function.
         * `package`: Package with the source code of the function version. You can only use either the `package` or `content` field.
         * `package.0.sha_256`: SHA256 hash of the deployed package.
         * `package.0.bucket_name`: Name of the bucket in {{ objstorage-name }} that stores the source code of the function version.
         * `package.0.object_name`: Name of the object in {{ objstorage-name }} that contains the source code of the function version.
         * `content`: Function source code. You can only use either the `content` or `package` field.
         * `content.0.zip_filename`: Name of the ZIP archive that contains the function source code.

      Example configuration file structure:

      

      ```
      provider "yandex" {
          token     = "<OAuth or static key of service account>"
          folder_id = "<folder ID>"
          zone      = "{{ region-id }}-a"
      }

      resource "yandex_function" "test-function" {
          name               = "test-function"
          description        = "Test function"
          user_hash          = "first-function"
          runtime            = "python37"
          entrypoint         = "main"
          memory             = "128"
          execution_timeout  = "10"
          service_account_id = "<ID of the service account>"
          tags               = ["my_tag"]
          content {
              zip_filename = "<path to ZIP archive>"
          }
      }

      output "yandex_function_test-function" {
          value = "${yandex_function.test-function.id}"
      }
      ```




      For more information about the `yandex_function` resource parameters, see the [provider documentation]({{ tf-provider-link }}/function).

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contain errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```
   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```
      yc serverless function list
      ```

- Yandex Cloud Toolkit

   You can create a function using the [Yandex Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}
