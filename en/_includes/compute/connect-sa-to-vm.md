{% include [connect-sa-to-vm-intro](../connect-sa-to-vm-intro.md) %}

### Linking to an existing VM {#link-with-exist-instance}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the VM belongs to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Click the VM name.
  1. In the top-right corner of the page, click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**, select an existing service account or create a new one.
  1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Update the VM parameters by specifying the service account using `--service-account-name` or `--service-account-id`:

  ```bash
  yc compute instance update my-instance --service-account-name test
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../terraform-install.md) %}

  1. Open the {{ TF }} configuration file with the description of the VM you want to link the service account to. See [an example of the VM configuration file](../../compute/operations/vm-create/create-linux-vm.md#tf_1).
  1. In the section with the `yandex_compute_instance` resource description, add the `service_account_id` parameter and specify the service account ID:

      ```hcl
      resource "yandex_compute_instance" "vm-1" {
        ...
        service_account_id = "<service_account_ID>"
        ...
      }
      ```

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will change all required resources. You can check the new resources using the [management console]({{ link-console-main }}).

  For more information about `yandex_compute_instance` properties, see [this {{ TF }} article]({{ tf-provider-datasources-link }}/compute_instance).

- API {#api}

  Use the [update](../../compute/api-ref/Instance/update.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Update](../../compute/api-ref/grpc/Instance/update.md) gRPC API call. Specify the service account ID in your request.

{% endlist %}

### Linking to a new VM {#link-with-new-instance}

{% list tabs group=instructions %}

- Management console {#console}

  In the management console, you can link a service account to a virtual machine. This service account must be in the same [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) as the VM. If the service account is in a different folder, use the CLI or API.

  To link a service account to a VM, select it under **{{ ui-key.yacloud.compute.instances.create.section_additional }}** in the **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** field when [creating the VM](../../compute/operations/index.md#vm-create). You can select an existing service account or create a new one.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Create a VM by specifying the service account using `--service-account-name` or `--service-account-id`:

  ```bash
  yc compute instance create \
    --name my-instance \
    --network-interface subnet-name=default,nat-ip-version=ipv4 \
    --ssh-key ~/.ssh/id_ed25519.pub \
    --service-account-name my-robot
  ```

- {{ TF }} {#tf}

  1. Open the {{ TF }} configuration file with the description of the VM you want to link the service account to. See [an example of the VM configuration file](../../compute/operations/vm-create/create-linux-vm.md#tf_1).
  1. In the section with the `yandex_compute_instance` resource description, add the `service_account_id` parameter and specify the service account ID:

      ```hcl
      resource "yandex_compute_instance" "vm-1" {
        ...
        service_account_id = "<service_account_ID>"
        ...
      }
      ```

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}).

  For more information about `yandex_compute_instance` properties, see [this {{ TF }} article]({{ tf-provider-datasources-link }}/compute_instance).

- API {#api}

  Use the [create](../../compute/api-ref/Instance/create.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md) gRPC API call. Specify the service account ID in your request.

{% endlist %}