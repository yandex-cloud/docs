# Updating a folder

The management console only allows you to change the name of a folder. To change its description, use the CLI or API.

{% list tabs %}

- Management console

   1. Select the folder on the management console [home page]({{ link-console-cloud }}). This page displays folders for the selected cloud. If necessary, [switch to another cloud](../cloud/switch-cloud.md).
   1. Click ![image](../../../_assets/options.svg) next to the folder and select **{{ ui-key.yacloud.common.edit }}**.
   1. Enter a new name for the folder.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders.popup-edit_button_save }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. See the description of the update folder command:

      ```bash
      yc resource-manager folder update --help
      ```
   1. If you know the folder ID or name, proceed to the next step. Otherwise, use one of these methods to get them:

      * Get a list of folders:

         ```bash
         yc resource-manager folder list
         ```

         Result:

         ```
         +----------------------+--------------------+--------+--------+-------------+
         |          ID          |        NAME        | LABELS | STATUS | DESCRIPTION |
         +----------------------+--------------------+--------+--------+-------------+
         | b1gppulhhm2a******** | yet-another-folder |        | ACTIVE |             |
         | b1gvmob95yys******** | default            |        | ACTIVE |             |
         +----------------------+--------------------+--------+--------+-------------+
         ```

      * If you know the ID of the resource that belongs to the required folder, you can get the folder ID from the information about that resource:

         ```bash
         yc <service-name> <resource> get <resource-id>
         ```

         Where:
         * `<service-name>`: Service name, e.g., `compute`
         * `<resource>`: Resource category, e.g., `instance`
         * `<resource-id>`: Resource ID

         For example, the `fhmp74bfis2a********` VM belongs to the `b1gpvjd9ir42********` folder:

         ```bash
         yc compute instance get fhmp74bfis2ais728p2a
         ```

         Result:

         ```
         id: fhmp74bfis2a********
         folder_id: b1gpvjd9ia42********
         ...
         ```

   1. Change the folder parameters, e.g., name and description. You can specify the folder to update by its name or ID.

      ```bash
      yc resource-manager folder update default \
        --new-name myfolder \
        --description "this is my default-folder"
      ```

      The command will rename the `default` folder to `myfolder` and update its description. The folder naming requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

- API

   To update a folder, use the [update](../../api-ref/Folder/update.md) REST API method for the [Folder](../../api-ref/Folder/index.md) resource or the [FolderService/Update](../../api-ref/grpc/folder_service.md#Update) gRPC API call.

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To edit the settings of a folder created with {{ TF }}:

   1. Open the {{ TF }} configuration file and edit the fragment with the folder description.

      {% cut "Example folder description in a {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_resourcemanager_folder" "folder1" {
        cloud_id    = "b1gia12......fvsleds"
        name        = "myfolder"
        description = "this is my default-folder"
      }
      ...
      ```

      {% endcut %}

      For more information about the parameters of the `yandex_resourcemanager_folder` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/resourcemanager_folder).

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

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check the folder update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```
      yc resource-manager folder list-operations <folder name>|<folder ID>
      ```

{% endlist %}

