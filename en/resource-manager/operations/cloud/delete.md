# Deleting a cloud


To be able to delete a cloud, you must have the `{{ roles-cloud-owner }}` role for the cloud. If you cannot do this, contact the [cloud owner](../../concepts/resources-hierarchy.md#owner).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate cloud in the list on the left.
   1. Click ![image](../../../_assets/options.svg) in the top-right corner and select **{{ ui-key.yacloud.common.delete }}**.
   1. Select a cloud deletion delay, after which the cloud will be deleted. Select one of the available delays or `Delete now`. The default cloud deletion delay is 7 days.
   1. Click **{{ ui-key.yacloud.common.delete }}**.

- API

   To delete the cloud, use the [CloudService/Delete](../../api-ref/grpc/cloud_service.md#Delete) gRPC API call.

- {{ TF }}

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

      For more information about the `yandex_resourcemanager_cloud` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/resourcemanager_cloud).
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

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can check the update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc resource-manager cloud list
      ```

{% endlist %}

The resources will be stopped, and the cloud's status will change to `PENDING_DELETION`. You can [cancel](delete-cancel.md) the deletion of a cloud whose status is `PENDING_DELETION`.

{% include [alert-pending-deletion](../../../_includes/resource-manager/alert-pending-deletion.md) %}

Once the delay ends, the cloud's status will change to `DELETING`. When a cloud has this status, it is being irreversibly deleted, which can take up to 72 hours.
