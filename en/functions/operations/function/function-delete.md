# Deleting a function

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder from which you wish to delete the function.
   1. Select **{{ sf-name }}**.
   1. In the line of the function, click ![image](../../../_assets/options.svg) and select **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   {% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

   To delete a function, run the command:

   ```
   yc serverless function delete <function_name>
   ```
   Result:
   ```
   done (1s)
   id: b09kk2ujb8js********
   folder_id: aoek49ghmknn********
   created_at: "2019-06-13T13:21:40.022Z"
   name: my-functions
   log_group_id: eolq9ac97486********
   http_invoke_url: https://functions.yandexcloud.net/b09kk2ujb8js********
   status: DELETING
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a function created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the fragment with the function description.

      Example function description in the {{ TF }} configuration:

      ```
       resource "yandex_function" "test-function" {
           name               = "test-function"
           description        = "Test function"
           user_hash          = "first-function"
           runtime            = "python37"
           entrypoint         = "main"
           memory             = "128"
           execution_timeout  = "10"
           service_account_id = "<service account ID>"
           tags               = ["my_tag"]
           content {
               zip_filename = "<path to ZIP archive>"
           }
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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```
   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify that you have deleted the function in the [management console]({{ link-console-main }}) or using the [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function list
   ```

- {{ yandex-cloud }} Toolkit

   You can delete a function using the [{{ yandex-cloud }} Toolkit plugin]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} for the IDE family on the [IntelliJ platform]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} from [JetBrains](https://www.jetbrains.com/).

{% endlist %}
