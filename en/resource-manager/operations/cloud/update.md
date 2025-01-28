# Renaming a cloud

To rename a cloud, you must have the [`editor`](../../../iam/roles-reference.md#editor) role or higher for that cloud. You cannot rename a suspended cloud. If you cannot perform this operation, contact the cloud [administrator](../../../iam/roles-reference.md#admin) or [owner](../../concepts/resources-hierarchy.md#owner).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the appropriate cloud from the list on the left.
  1. Click ![horizontal-ellipsis](../../../_assets/console-icons/ellipsis.svg) in the top-right corner and select **{{ ui-key.yacloud.common.edit }}**.
  1. In the window that opens, enter a new cloud name. The naming requirements are as follows:

	 {% include [name-format.md](../../../_includes/name-format.md) %}

  1. Click **{{ ui-key.yacloud.iam.cloud.edit.popup-edit-cloud_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. View the description of the cloud update command:

      ```bash
      yc resource-manager cloud update --help
      ```

  1. Get a list of available clouds:

      ```bash
      yc resource-manager cloud list
      ```

      Result:

      ```text
      +----------------------+------------------+----------------------+--------+
      |          ID          |       NAME       |   ORGANIZATION ID    | LABELS |
      +----------------------+------------------+----------------------+--------+
      | b1go33ek97iq******** | my-cloud         | bpf2c65rqcl8******** |        |
      | b1gbi30tq0m9******** | my-new-cloud     | bpfaidqca8vd******** |        |
      +----------------------+------------------+----------------------+--------+
      ```

  1. To rename a cloud, run this command:

      ```bash
      yc resource-manager cloud update \
        --name <current_cloud_name> \
        --new-name <new_cloud_name>
      ```

      Where:

      * `--name`: Current name of the cloud you want to change. Instead of the cloud name, you can provide its [ID](../../../resource-manager/operations/cloud/get-id.md) in the `--id` parameter.
      * `--new-name`: New cloud name.

          {% include [name-format.md](../../../_includes/name-format.md) %}

      Result:

      ```text
      id: b1go33ek97iq********
      created_at: "2024-12-10T09:25:22Z"
      name: my-old-cloud
      organization_id: bpf2c65rqcl8********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To rename a cloud created using {{ TF }}:

  1. Open the {{ TF }} configuration file and edit the `name` parameter value in the cloud description fragment.

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

      The terminal will display a list of resources with their parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the updated cloud name in the [management console]({{ link-console-main }}) or the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc resource-manager cloud list
      ```

- API {#api}

  To rename a cloud, use the [update](../../api-ref/Cloud/update.md) REST API method for the [Cloud](../../api-ref/Cloud/index.md) resource or the [CloudService/Update](../../api-ref/grpc/Cloud/update.md) gRPC API call.

{% endlist %}