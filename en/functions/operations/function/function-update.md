# Updating a function

You can change the [name](function-update.md#update-name) and [description](function-update.md#update-description) of a function as well as [manage function labels](function-update.md#manage-label). To change the code or operation parameters of a function, [create a new function version](version-manage.md).

{% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

## Changing the name of a function {#update-name}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you want to change the name of a [function](../../concepts/function.md).
   1. Select **{{ sf-name }}**.
   1. Select a function.
   1. In the upper-right corner, click **Edit**.
   1. In the window that opens, enter the desired function name.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To change the function name, run the command:

   ```
   yc serverless function update <function name> --new-name <new function name>
   ```

   Result:
   ```
   id: b097d9ous3gep99khe83
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-06-06T11:36:48.688Z"
   name: my-beta-function
   labels:
    test: test
   log_group_id: eolv6578frac08uh5h6s
   http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
   status: ACTIVE
   ```

- API

   You can change the function name using the API [update](../../functions/api-ref/Function/update.md) method.

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To change the name of a function:

   1. Open the {{ TF }} configuration file and edit the `name` field in the fragment with the function description.

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

   You can verify the function name change using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function list
   ```

- {{ yandex-cloud }} Toolkit

   You can change the function name using the [{{ yandex-cloud }} Toolkit plugin]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} for the IDE family on the [IntelliJ platform]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} from [JetBrains](https://www.jetbrains.com/).

{% endlist %}


## Updating the description of a function {#update-description}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you want to change the [function](../../concepts/function.md) description.
   1. Select **{{ sf-name }}**.
   1. Select a function.
   1. In the upper-right corner, click **Edit**.
   1. In the window that opens, enter the description of the function.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To change the function description, run the command:

   ```
   yc serverless function update <function name> --description "<function description>"
   ```

   Result:

   ```
   id: b097d9ous3gep99khe83
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-06-06T11:36:48.688Z"
   name: my-beta-function
   description: My beta function.
   labels:
     test: test
   log_group_id: eolv6578frac08uh5h6s
   http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
   status: ACTIVE
   ```

- API

   You can update the function description using the API method [update](../../functions/api-ref/Function/update.md).

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To update the function description:

   1. Open the {{ TF }} configuration file and edit the `description` field in the fragment with the function description.

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

   You can verify the change to the function description using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function get <function_name>|<function_ID>
   ```

- {{ yandex-cloud }} Toolkit

   You can update the function description using the [{{ yandex-cloud }} Toolkit plugin]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} for the IDE family on the [IntelliJ platform]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Managing function labels {#manage-label}

You can perform the following actions with function labels:

- [Add](#add-label)
- [Edit](#update-label)
- [Delete](#remove-label)

### Adding a label {#add-label}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To add a label to a function, run the command:

   ```
   yc serverless function add-labels <function name> --labels <key>=<value>
   ```

   Result:

   ```
   id: b097d9ous3gep99khe83
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-06-06T11:36:48.688Z"
   name: my-beta-function
   description: My beta function.
   labels:
     test: test
     version: beta
   log_group_id: eolv6578frac08uh5h6s
   http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
   status: ACTIVE
   ```

- API

   You can add a label to a function using the API method [update](../../functions/api-ref/Function/update.md).

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To add a function label:

   1. In the {{ TF }} configuration file, add the `labels` section and specify a list of labels in it in `<key>:"<value>"` format.

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
          labels = {
            <key1>:"<value1>",
            <key2>:"<value2>"
          }
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

   You can check the addition of function labels using this [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function get <function_name>|<function_ID>
   ```

{% endlist %}

### Updating a label {#update-label}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To update the function label, run the command:

   {% note warning %}

   The existing set of `labels` is completely replaced by the set transmitted.

   {% endnote %}

   ```
   yc serverless function update <function name> --labels <key>=<value>
   ```

   Result:

   ```
   id: b097d9ous3gep99khe83
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-06-06T11:36:48.688Z"
   name: my-beta-function
   description: My beta function.
   labels:
     new_labels: my-beta-function
   log_group_id: eolv6578frac08uh5h6s
   http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
   ```

- API

   You can change function labels using the API method [update](../../functions/api-ref/Function/update.md).

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To change a function label:

   1. Open the {{ TF }} configuration file and edit the `labels` section.

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
          labels = {
            <key1>:"<value1>",
            <key2>:"<value2>"
          }
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

   You can verify the change to the function labels using this [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function get <function_name>|<function_ID>
   ```

{% endlist %}

### Deleting a label {#remove-label}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To delete a function label, run the command:

   ```
   yc serverless function remove-labels <function name> --labels <key>
   ```

   Result:

   ```
   id: b097d9ous3gep99khe83
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-06-06T11:36:48.688Z"
   name: my-beta-function
   description: My beta function.
   labels:
     version: beta
   log_group_id: eolv6578frac08uh5h6s
   http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
   status: ACTIVE
   ```

- API

   You can delete a function label using the API method [update](../../functions/api-ref/Function/update.md).

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a function label:

   1. Open the {{ TF }} configuration file and delete the unnecessary label in the `labels` section.

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
          labels = {
            <key1>:"<value1>",
            <key2>:"<value2>"
          }
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

   You can verify the deletion of the function labels using this [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function get <function_name>|<function_ID>
   ```

{% endlist %}
