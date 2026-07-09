# Creating a metadata catalog

A _folder_ is a space where {{ yandex-cloud }} resources are created and [grouped](../../concepts/resources-hierarchy.md).

{% list tabs group=instructions %}

- Management console {#console}

  {% include [create-folder](../../../_includes/create-folder.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Read the `create folder` command description:

      ```bash
      yc resource-manager folder create --help
      ```

  2. Create a new folder:

      * with a name and without a description:
          ```bash
          yc resource-manager folder create \
            --name new-folder
          ```

          The naming requirements are as follows:

          {% include [name-format](../../../_includes/name-format.md) %}

      * with a name and description:

          ```bash
          yc resource-manager folder create \
            --name new-folder \
            --description "my first folder with description"
          ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the resources you want to create:

     * `cloud_id`: [ID of the cloud](../cloud/get-id.md) to create the folder in. This is an optional setting. It defaults to the value specified in the provider settings.
     * `name`: Name of the new folder. This is a required setting. The naming requirements are as follows:

       {% include [name-format](../../../_includes/name-format.md) %}

     * `description`: Folder description. This is an optional setting.

     Here is an example of the configuration file structure:

     ```hcl
     resource "yandex_resourcemanager_folder" "folder1" {
       cloud_id    = "<cloud_ID>"
       name        = "<name_of_the_new_folder>"
       description = "<folder_description>"
     }
     ```

     For more on the properties of the `yandex_resourcemanager_folder` resource in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/resourcemanager_folder).

  1. Make sure the configuration files are correct.

     1. In the command line, navigate to the directory where you created the configuration file.

     1. Check the configuration using this command:

        ```
        terraform validate
        ```
     
        If the configuration is valid, you will get this message:
     
        ```
        Success! The configuration is valid.
        ```

     1. Run this command:

        ```
        terraform plan
        ```

        If the configuration is correct, the terminal will display a list of the resources and their settings. Otherwise, {{ TF }} will show any detected errors. 

  1. Deploy the cloud resources.

     1. If the configuration is correct, run this command:

        ```
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` and press **Enter**.

        This will create the folder in the specified cloud. You can check the new folder and its settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

        ```
        yc resource-manager folder list
        ```

- API {#api}

  To create a folder, use the [create](../../api-ref/Folder/create.md) REST API method for the [Folder](../../api-ref/Folder/index.md) resource or the [FolderService/Create](../../api-ref/grpc/Folder/create.md) gRPC API call.

{% endlist %}
