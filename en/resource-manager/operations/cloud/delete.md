# Deleting a cloud


To delete a cloud, you must have the [editor](../../../iam/roles-reference.md#editor) role or higher for that cloud. If you cannot perform this operation, contact the [cloud owner](../../concepts/resources-hierarchy.md#owner).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the appropriate cloud from the list on the left.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) in the top-right corner and select **{{ ui-key.yacloud.common.delete }}**.
  1. Select a cloud deletion delay, after which the cloud will be deleted. Select one of the suggested periods or `Delete now`. The default cloud deletion delay is 7 days.
  1. Click **{{ ui-key.yacloud.common.delete }}**.

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

Once the waiting timeout expires, the cloud status switches to `DELETING`. This status means it is being permanently deleted, which can take up to 72 hours.
