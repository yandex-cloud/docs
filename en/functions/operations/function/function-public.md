# Making a function public

To allow any user to invoke a function without passing an authorization header, make it public.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ sf-name }}**.
   1. Select the function you want to make public.
   1. On the **Overview** page, under **General information,** switch the **Public function** option to on.

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

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To make a function public:

   1. Describe the properties of the function access rights in a configuration file:

      ```
      resource "yandex_function_iam_binding" "function-iam" {
        function_id = "<function_ID>"
        role        = "{{ roles-functions-ivoker }}"
        members = [
          "system:allUsers",
        ]
      }
      ```

      Where:

      * `function_id`: Function ID. To find out the function ID, [get a list of functions](function-list.md) in the folder.
      * `role`: Role to assign.
      * `members`: List of users to assign the role to.

         To make a function public, assign the `{{ roles-functions-ivoker }}` role to all unauthorized users (`allUsers` [system group](../../../iam/concepts/access-control/system-group.md)).

      For more information about the parameters of the `yandex_function_iam_binding` resource, see the [provider documentation]({{ tf-provider-link }}/function_iam_binding).

   1. Check the configuration using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```text
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

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

   You can make a function public using the [setAccessBindings](../../functions/api-ref/Function/setAccessBindings.md) API method.

{% endlist %}
