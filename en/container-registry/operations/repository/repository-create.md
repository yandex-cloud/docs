# Creating a repository

To create a [repository](../../concepts/repository.md):

{% list tabs %}

- {{ TF }}

  If you don't have {{ TF }}, [install it and configure the provider {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Describe the properties of the `yandex_container_repository` resource in a configuration file:
     * `name`: Repository name as `<registry id>/<Docker image name>`. You can retrieve the [registry](../../concepts/registry.md) ID from the [folder registry list](../registry/registry-list.md#registry-list).

     > Example configuration file structure:
     >
     > ```
     > resource "yandex_container_repository" "my-repository" {
     >   name = "abcd12316s9a2t7gd8ef/test-repository"
     > }
     > ```

     For more information about resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/container_repository).
  1. Run the check using the command:

     ```bash
     terraform plan
     ```

     The terminal will display a list of resources with parameters. This is a test step. No resources are created. If the configuration contain errors, {{ TF }} will point them out.

     {% note alert %}

     You will be charged for all the resources created with {{ TF }}. Check the plan carefully.

     {% endnote %}

  1. To create resources, run the command:

     ```bash
     terraform apply
     ```

  1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

     {{ TF }} will create all the required resources. You can check that the resources are there using the [management console]({{ link-console-main }}) or the [{{ yandex-cloud }} CLI](../../../cli/) command below:

     ```bash
     yc container repository list --registry-id <registry id>
     ```

{% endlist %}