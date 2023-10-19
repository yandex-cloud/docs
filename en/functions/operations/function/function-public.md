# Making a function public

To allow any user to invoke a function without passing an authorization header, make it public.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Select the function you want to make public.
   1. On the **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}** page, enable **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To make a function public, run the command:

   ```
   yc serverless function allow-unauthenticated-invoke <function name>
   ```

   Result:

   ```
   done (1s)
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To make a function public:

   1. Describe the properties of the function access rights in a configuration file:

      ```
      resource "yandex_function_iam_binding" "function-iam" {
        function_id = "<function_ID>"
        role        = "{{ roles-functions-invoker }}"
        members = [
          "system:allUsers",
        ]
      }
      ```

      Where:

      * `function_id`: Function ID. To find out the function ID, [get a list of functions](function-list.md) in the folder.
      * `role`: Role to assign.
      * `members`: List of users to assign the role to.

         To make a function public, assign the `{{ roles-functions-invoker }}` role to all unauthorized users (`allUsers` [system group](../../../iam/concepts/access-control/system-group.md)).

      For more information about the parameters of the `yandex_function_iam_binding` resource, see the [provider documentation]({{ tf-provider-resources-link }}/function_iam_binding).

   1. Check the configuration using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```text
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check that the function role has been assigned using the [management console]({{ link-console-main }}) or the [CLI command](../../../cli/quickstart.md):

      ```bash
      yc serverless function list-access-bindings <function_name>
      ```

- API

   To make a function public, use the [setAccessBindings](../../functions/api-ref/Function/setAccessBindings.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/SetAccessBindings](../../functions/api-ref/grpc/function_service.md#SetAccessBindings) gRPC API call.

{% endlist %}
