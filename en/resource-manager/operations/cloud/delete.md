# Deleting a cloud

To delete a cloud, you must have the [{{ roles-resource-manager-editor }}](../../security/index.md#resource-manager-editor) role or higher for that cloud. If you cannot perform this operation, contact the [cloud owner](../../concepts/resources-hierarchy.md#owner).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the appropriate cloud from the list on the left.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) in the top-right corner and select **{{ ui-key.yacloud.common.delete }}**.
  1. Select a cloud deletion delay, after which the cloud will be deleted. Select one of the suggested periods or `{{ ui-key.yacloud_billing.component.iam-delete-folder-or-cloud-dialog.label_delete-now }}`. The default cloud deletion delay is 7 days.
  1. Click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. View a description of the cloud delete command:

      ```bash
      yc resource-manager cloud delete --help
      ```

  1. Get a list of available clouds:

      {% include [get-cloud-list](../../../_includes/resource-manager/get-cloud-list.md) %}

  1. Delete the cloud by specifying its name or ID:

      ```bash
      yc resource-manager cloud delete <cloud_name_or_ID> \
        --delete-after <cloud_deletion_delay> \
        --async
      ```

      Where:

      * `--delete-after`: Cloud deletion delay in `HhMmSs` format. Cloud deletion process will start after the specified delay. For example, `--delete-after 22h30m50s`.
      
          Specify `0s` to delete the cloud now.
      * `--async`: Asynchronous deletion flag.
      
          Deleting a cloud can take up to 72 hours. Run the command in asynchronous mode to return to terminal management without waiting for the command to complete.

      Result:

      ```text
      id: b1gqkbbj04d9********
      description: Delete cloud
      created_at: "2024-10-17T05:16:30.648219069Z"
      created_by: ajei280a73vc********
      modified_at: "2024-10-17T05:16:30.648219069Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.resourcemanager.v1.DeleteCloudMetadata
        cloud_id: b1g66mft1vop********
        delete_after: "2024-10-18T03:47:19.441433Z"
      ```

      Where `id` is the operation ID you can use to track the operation status later.

  1. (Optional) Get information about the deletion operation status:

      ```bash
      yc operation get <operation_ID>
      ```

      After cloud deletion is complete, the response will contain the `done` field set to `true` (`done: true`).

  For more information about the `yc resource-manager cloud delete` command, see the [CLI reference](../../../cli/cli-ref/resource-manager/cli-ref/cloud/delete.md).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To delete a cloud created using {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the fragment with the cloud description.

      {% cut "Example cloud description in {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_resourcemanager_cloud" "cloud1" {
        name            = "cloud-main"
        organization_id = "bpf7nhb9hkph********"
      }
      ...
      ```

      {% endcut %}

      For more information about the `yandex_resourcemanager_cloud` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/resourcemanager_cloud).

  1. In the command line, change to the folder where you edited the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check the update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc resource-manager cloud list
      ```

- API {#api}

  To delete the cloud, use the [CloudService/Delete](../../api-ref/grpc/Cloud/delete.md) gRPC API call.

{% endlist %}

The resources will be stopped, and the cloud status will change to `PENDING_DELETION`. You can [cancel](delete-cancel.md) the deletion of a cloud when it is `PENDING_DELETION`.

{% include [alert-pending-deletion](../../../_includes/resource-manager/alert-pending-deletion.md) %}

Once the waiting timeout expires, the cloud status switches to `DELETING`. This status means it is being permanently deleted, which can take up to 72 hours. All the cloud's resources will be deleted together with it.
