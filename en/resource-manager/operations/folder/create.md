# Creating a folder

A _folder_ is a space where {{ yandex-cloud }} resources are created and [grouped](../../concepts/resources-hierarchy.md).

{% list tabs %}

- Management console

   {% include [create-folder](../../../_includes/create-folder.md) %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. See a description of the create folder command:

      ```bash
      yc resource-manager folder create --help
      ```

   2. Create a new folder:

      * with a name and without a description:
         ```bash
         yc resource-manager folder create \
           --name new-folder
         ```

         {% include [name-format](../../../_includes/name-format.md) %}

      * with a name and description:

         ```bash
         yc resource-manager folder create \
           --name new-folder \
           --description "my first folder with description"
         ```

- API

   To create a folder, use the [create](../../api-ref/Folder/create.md) REST API method for the [Folder](../../api-ref/Folder/index.md) resource or the [FolderService/Create](../../api-ref/grpc/folder_service.md#Create) gRPC API call.

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of the resources you want to create:

      * `cloud_id`: [ID of the cloud](../cloud/get-id.md) where the folder will be created. This is an optional parameter. By default, the value specified in the provider settings is used.
      * `name`: Name of the folder to be created. This parameter is required. The naming requirements are as follows:

         {% include [name-format](../../../_includes/name-format.md) %}

      * `description`: Folder description. This is an optional parameter.

      Example of the configuration file structure:

      ```hcl
      resource "yandex_resourcemanager_folder" "folder1" {
        cloud_id    = "<cloud ID>"
        name        = "<name of folder to be created>"
        description = "<folder description>"
      }
      ```

      For more information about the parameters of the `yandex_resourcemanager_folder` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/resourcemanager_folder).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.

      1. Check the configuration using this command:

         ```
         terraform validate
         ```

         If the configuration is correct, you will get this message:

         ```
         Success! The configuration is valid.
         ```

      1. Run this command:

         ```
         terraform plan
         ```

         If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      The folder will be created in the specified cloud. You can use the [management console]({{ link-console-main }}) or a [CLI](../../../cli/quickstart.md) command to verify that the folder is there:

      ```
      yc resource-manager cloud list
      ```

{% endlist %}
