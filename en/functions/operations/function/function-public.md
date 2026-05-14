# Making a function public

To allow any user to invoke a function without providing an authorization header, make it public.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder containing the function.
    1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select the function you want to make public.
    1. On the **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}** page, enable **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}**.
    
- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To make a function public, run this command:
    
    ```bash
    yc serverless function allow-unauthenticated-invoke <function_name>
    ```

    Result:

    ```text
    done (1s)
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To make a function public:

  1. Describe the function access permissions in the configuration file:

     ```hcl
     resource "yandex_function_iam_binding" "function-iam" {
       function_id = "<function_ID>"
       role        = "{{ roles-functions-invoker }}"
       members = [
         "system:allUsers",
       ]
     }
     ```

     Where:

     * `function_id`: Function ID. To find out the function ID, [get the list of functions](function-list.md) in the folder.
     * `role`: Role to assign.
     * `members`: List of users to assign the role to.

        To make a function public, assign the `{{ roles-functions-invoker }}` role to all unauthorized users (the `All users` [public group](../../../iam/concepts/access-control/public-group.md)).

     For more information about the `yandex_function_iam_binding` properties, see [this provider guide]({{ tf-provider-resources-link }}/function_iam_binding).

  1. Validate your configuration using this command:

     ```bash
     terraform validate
     ```

     If the configuration is valid, you will get this message:

     ```text
     Success! The configuration is valid.
     ```

  1. Run this command:

     ```bash
     terraform plan
     ```

     You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors in the configuration. 

  1. Apply the configuration changes:

     ```bash
     terraform apply
     ```

  1. Type `yes` and press **Enter** to confirm the changes.

     You can check the assignment of the function role using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

     ```bash
     yc serverless function list-access-bindings <function_name>
     ```

- API {#api}

   To make a function public, use the [setAccessBindings](../../functions/api-ref/Function/setAccessBindings.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/SetAccessBindings](../../functions/api-ref/grpc/Function/setAccessBindings.md) gRPC API call.

{% endlist %}
