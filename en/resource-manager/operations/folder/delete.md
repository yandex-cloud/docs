# Deleting a folder

To delete a [folder](../../concepts/resources-hierarchy.md#folder), you must have the [`editor`](../../../iam/roles-reference.md#editor) role or higher for that folder. If you cannot perform this operation, contact an [administrator](../../../iam/roles-reference.md#admin) or the [folder owner](../../concepts/resources-hierarchy.md#owner).

{% list tabs group=instructions %}

- Management console {#console}

  1. On the management console [home page]({{ link-console-cloud }}), select the folder. This page displays folders for the selected cloud. You can [switch to another cloud](../cloud/switch-cloud.md), if required.
  
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the folder and select **{{ ui-key.yacloud.common.delete }}**.
  
  1. Specify folder deletion delay: the time period after which the folder will be deleted. Select one of the suggested periods or `{{ ui-key.yacloud_billing.component.iam-delete-folder-or-cloud-dialog.label_delete-now }}`. The default folder deletion delay is 7 days.

  1. Click **{{ ui-key.yacloud.common.delete }}**.

  The resources will be stopped, and the folder status will change to `PENDING_DELETION`. You can cancel the deletion of a folder that is `PENDING_DELETION`. To cancel, click ![***](../../../_assets/console-icons/ellipsis.svg) to the right of the folder and select **{{ ui-key.yacloud.iam.cloud.folders.button_cancel-deletion }}**.

- CLI {#cli}
  
  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. View a description of the folder delete command:
    
      ```bash
      yc resource-manager folder delete --help
      ```

  1. {% include [get-folder-id-or-name](../../../_includes/resource-manager/get-folder-id-or-name.md) %}

  1. Delete the folder:
    
      ```bash
      yc resource-manager folder delete <folder_ID>
      ```
      
      To display the details of an operation in progress before it is completed, set the `--async` flag.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To delete a folder created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the fragment describing the folder.

      {% cut "Example folder description in a {{ TF }} configuration" %}

     ```hcl
     ...
     resource "yandex_resourcemanager_folder" "folder1" {
       cloud_id    = "b1gia12......fvsleds"
       name        = "new-folder"
       description = "this is my default-folder"
     }
     ...
     ```

     {% endcut %}

     For more information about the `yandex_resourcemanager_folder` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/resourcemanager_folder).

  1. In the command line, go to the folder with the {{ TF }} configuration file.

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

     You can check the folder deletion using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

     ```
     yc resource-manager folder list
     ```

- API {#api}

  To delete a folder, use the [delete](../../api-ref/Folder/delete.md) REST API method for the [Folder](../../api-ref/Folder/index.md) resource or the [FolderService/Delete](../../api-ref/grpc/Folder/delete.md) gRPC API call.

{% endlist %}

Once the waiting timeout expires, the folder status will change to `DELETING`. This means it is being permanently deleted, which may take up to 72 hours; after that, the folder will be deleted along with all its resources.

{% note alert %}

While a folder is `PENDING_DELETION`, your disks, reserved IPs, and other data are still stored and billed. 

While a folder is `PENDING_DELETION`, you are still charged for paid resources if metrics detect their consumption.

The cost of such storage is charged at the previous rate. Track your resource costs in [{{ billing-name }}]({{ link-console-billing }}).

{% endnote %}