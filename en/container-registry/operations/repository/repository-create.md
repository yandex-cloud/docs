# Creating a repository

To create a [repository](../../concepts/repository.md):

{% list tabs %}

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}
  1. Describe the properties of the `yandex_container_repository` resource in a configuration file:
     * `name`: Repository name as `<registry id>/<Docker image name>`. You can retrieve the [registry](../../concepts/registry.md) ID from the [folder registry list](../registry/registry-list.md#registry-list).

     > Example of the configuration file structure:
     >
     > ```
     > resource "yandex_container_repository" "my-repository" {
     >   name = "abcd12316s9a2t7gd8ef/test-repository"
     > }
     > ```

     For more information about resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/container_repository).

  1. Run a check using this command:

     ```
     terraform plan
     ```

     The terminal will display a list of resources with parameters. This is a test step; no resources will be created. If the configuration contains any errors, {{ TF }} will point them out.

     {% note alert %}

     You will be charged for all the resources created with {{ TF }}. Check the pricing plan carefully.

     {% endnote %}

  1. To create resources, run the command:

     ```
     terraform apply
     ```

  1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

     {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [YC CLI](../../../cli/) command:

     ```bash
     yc container repository list --registry-id <registry id>
     ```

{% endlist %}