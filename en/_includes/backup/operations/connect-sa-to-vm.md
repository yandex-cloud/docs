{% include [connect-sa-to-vm-intro](../../connect-sa-to-vm-intro.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to connect a VM.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Click the VM name.
  1. In the top-right corner of the page, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**, select a service account with the `backup.editor` role.
  1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  1. View the description of the VM update command:

      ```bash
      yc compute instance update --help
      ```

  1. Link a service account to the VM by running this command:

      ```bash
      yc compute instance update <VM_name_or_ID> \
        --service-account-name <service_account_name>
      ```

      Where `--service-account-name`: Name of the service account with the `backup.editor` role.

      Result:

      ```text
      id: epddj31hkik0********
      folder_id: b1g681qpemb4********
      created_at: "2025-04-21T11:07:34Z"
      name: my-vm
      ...
      service_account_id: ajelprpohp7r********
      ...
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../terraform-install.md) %}

  1. In {{ TF }} configuration file, in the section with the description of the `yandex_compute_instance` resource, add the `service_account_id` parameter and give the ID of a service account with the `backup.editor` role:

      ```hcl
      resource "yandex_compute_instance" "vm-1" {
        ...
        service_account_id = "<service_account_ID>"
        ...
      }
      ```

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will change all required resources. You can check the resources updates in the [management console]({{ link-console-main }}).

  For more information about `yandex_compute_instance` properties, see [this {{ TF }} article]({{ tf-provider-datasources-link }}/compute_instance).

- API {#api}

  Use the [update](../../../compute/api-ref/Instance/update.md) REST API method for the [Instance](../../../compute/api-ref/Instance/) resource or the [InstanceService/Update](../../../compute/api-ref/grpc/Instance/update.md) gRPC API call. Specify the ID of the service account with the `backup.editor` role in your request.

{% endlist %}

For more information, see [{#T}](../../../compute/operations/vm-control/vm-update.md).