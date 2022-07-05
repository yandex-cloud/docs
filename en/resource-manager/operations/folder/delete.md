# Deleting a folder

To delete a folder, you must have the [`editor`](../../../iam/concepts/access-control/roles.md#editor) role or higher for the folder. If you are unable to perform this operation, contact an [administrator](../../../iam/concepts/access-control/roles.md#admin) or the [folder owner](../../concepts/resources-hierarchy.md#owner).

{% list tabs %}

- Management console

   1. Select the folder on the management console [home page]({{ link-console-cloud }}). This page displays folders for the selected cloud. If necessary, [switch to another cloud](../cloud/switch-cloud.md).

   1. Click ![image](../../../_assets/options.svg) next to the folder and select **Delete**.

   1. Specify the folder delete time: the delay, after which the folder will be deleted. Select one of the available delays or **Delete now**. The default folder delete delay is 7 days.

   1. Click **Delete**.

   The resources will be stopped, and the folder status will change to `PENDING_DELETION`. You can cancel the deletion of a folder that is `PENDING_DELETION`. To cancel, click ![***](../../../_assets/options.svg) to the right of the folder and select **Cancel deletion**.

- Terraform

   If you don't have Terraform, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a folder created using Terraform:

   1. Open the Terraform configuration file and delete the section with the folder description.

      {% cut "Example folder description in a Terraform configuration" %}

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

      For more information about the parameters of the `yandex_resourcemanager_folder` resource in Terraform, see the [provider documentation]({{ tf-provider-link }}/resourcemanager_folder).

   1. In the command line, go to the directory with the Terraform configuration file.

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, Terraform points them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify that the folder has been deleted using the [management console]({{ link-console-main }}) or a [CLI](../../../cli/quickstart.md) command:

      ```
      yc resource-manager folder list
      ```

{% endlist %}

{% note alert %}

While a folder's status is `PENDING_DELETION`, your disks, reserved IPs, and other data are preserved. The cost of such storage is charged at the previous rate. Track your resource costs in [billing]({{ link-console-billing }}).

{% endnote %}

Once the delay ends, the folder's status will change to `DELETING`. When a cloud has this status, it is being irreversibly deleted, which can take up to 72 hours.
