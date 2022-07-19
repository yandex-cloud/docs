# Updating a folder

The management console only allows you to change the name of a folder. To change its description, use the CLI or API.

{% list tabs %}

- Management console

   1. Select the folder on the management console [home page]({{ link-console-cloud }}). This page displays folders for the selected cloud. If necessary, [switch to another cloud](../cloud/switch-cloud.md).
   1. Click ![image](../../../_assets/options.svg) next to the folder and select **Edit**.
   1. Enter a new name for the folder.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. See the description of the update folder command:

      ```bash
      yc resource-manager folder update --help
      ```
   1. If you know the folder ID or name, proceed to the next step. If not, use one of these methods to get them:

      * Get a list of folders:

         ```bash
         yc resource-manager folder list
         ```

         Result:

         ```
         +----------------------+--------------------+--------+--------+-------------+
         |          ID          |        NAME        | LABELS | STATUS | DESCRIPTION |
         +----------------------+--------------------+--------+--------+-------------+
         | b1gppulhhm2aaufq9eug | yet-another-folder |        | ACTIVE |             |
         | b1gvmob95yysaplct532 | default            |        | ACTIVE |             |
         +----------------------+--------------------+--------+--------+-------------+
         ```

      * If you know the ID of the resource that belongs to the required folder, you can get the folder ID from the information about that resource:

         ```bash
         yc <service-name> <resource> get <resource-id>
         ```

         Where:
         * `<service-name>`: The service name, such as `compute`.
         * `<resource>`: The resource type, such as `instance`.
         * `<resource-id>`: The resource ID.

         For example, the `fhmp74bfis2aim728p2a` VM belongs to the `b1gpvjd9ir42nsng55ck` folder:

         ```bash
         yc compute instance get fhmp74bfis2ais728p2a
         ```

         Result:

         ```
         id: fhmp74bfis2ais728p2a
         folder_id: b1gpvjd9ia42nsng55ck
         ...
         ```

   1. Change the folder parameters, such as name and description. You can specify the folder to update by its name or ID.

      ```bash
      yc resource-manager folder update default \
        --new-name myfolder \
        --description "this is my default-folder"
      ```

      The command will rename the `default` folder to `myfolder` and update its description.

      {% include [name-format](../../../_includes/name-format.md) %}

- API

   To edit the folder, use the [update](../../api-ref/Folder/update.md) method for the [Folder](../../api-ref/Folder/index.md) resource.

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To edit the settings of a folder created with {{ TF }}:

   1. Open the {{ TF }} configuration file and edit the section containing the folder description.

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

      For more information about the parameters of the `yandex_resourcemanager_folder` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/resourcemanager_folder).

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change in the folder using the [management console]({{ link-console-main }}) or the following [CLI](../../../cli/quickstart.md) command:

      ```
      yc resource-manager folder list-operations <folder name>|<folder ID>
      ```

{% endlist %}
