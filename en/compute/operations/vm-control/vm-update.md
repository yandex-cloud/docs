# Updating a VM

After you create a VM, you can edit its name, description, labels, platform, or metadata.

For information about editing a VM configuration, see [{#T}](vm-update-resources.md).

{% list tabs group=instructions %}

- Management console {#console}

  To update a VM:
  1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}** and click the name of the VM.
  1. Click ![image](../../../_assets/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. Change the VM parameters, e.g., rename the VM by editing the **{{ ui-key.yacloud.common.name }}** field.
  1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating VM parameters:

     ```bash
     yc compute instance update --help
     ```

  1. Get a list of VMs in the default folder:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select `ID` or `NAME` of the VM you need, e.g., `first-instance`.
  1. Change the VM parameters, e.g., rename the VM:

     ```bash
     yc compute instance update first-instance \
       --new-name windows-vm
     ```

- API {#api}

  To update a VM, use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Update](../../api-ref/grpc/Instance/update.md) gRPC API call.

{% endlist %}

{% note info %}

Changing the VM name does not change the host name or FQDN. For more information about generating the FQDN, see [{#T}](../../concepts/network.md#hostname).

{% endnote %}

## Examples {#examples}

### Viewing a list of configurable parameters {#viewing-a-list-of-configurable-parameters}

To view a list of configurable parameters, run this command:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc compute instance update --help
  ```

{% endlist %}

### Changing the name and description {#changing-the-name-and-description}

To change the name and description of a VM, follow these steps:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get a list of VMs in the default folder:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select the `ID` or `NAME` of the VM, e.g., `first-instance`.
  1. Update the VM name and description:

     ```bash
     yc compute instance update first-instance \
       --new-name first-vm \
       --description "changed description vm via CLI"
     ```

- API {#api}

  Use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Update](../../api-ref/grpc/Instance/update.md) gRPC API call.

{% endlist %}

{% note alert %}

Do not rename a VM if it belongs to a {{ managed-k8s-name }} cluster [node group](../../../managed-kubernetes/concepts/index.md#node-group). The names of these VMs are generated automatically, and changing them will disrupt the cluster.

{% endnote %}

### Changing metadata {#changing-metadata}

Metadata can vary across different operating systems. When you change the existing metadata, it is completely replaced by the data you provide in the command.

To change VM metadata, follow these steps:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get a list of VMs in the default folder:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select the `ID` or `NAME` of the VM, e.g., `first-instance`.
  1. Get the VM info with its metadata. All custom metadata is specified in the `user-data` key.

     ```bash
     yc compute instance get --full first-instance
     ```

  1. Change the VM metadata. You can change it using these flags:
     * `--metadata`: To change a single-line value.
     * `--metadata-from-file`: To change a multi-line value.

     {% include [cli-metadata-variables-substitution-notice](../../../_includes/compute/create/cli-metadata-variables-substitution-notice.md) %}

{% endlist %}

### Removing SSH keys from metadata {#delete-keys-from-metadata}

{% include [delete-keys-from-metadata](../../../_includes/compute/delete-keys-from-metadata.md) %}

### Enabling access via {{ oslogin }} {#enable-oslogin-access}

To make sure users can [connect](../vm-connect/os-login.md) to the VM via [{{ oslogin }}](../../../organization/concepts/os-login.md), enable this option in the VM settings:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}** and click the name of the VM.
  1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}**.
  1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating VM parameters:

     ```bash
     yc compute instance update --help
     ```

  1. Get a list of VMs in the default folder:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select `ID` or `NAME` of the VM you need, e.g., `first-instance`.

  1. Enable access via {{ oslogin }}:

     ```bash
     yc compute instance update first-instance \
       --metadata enable-oslogin=true
     ```

- API {#api}

  Use the `metadata` field to provide `enable-oslogin=true` in the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/) resource or in the [InstanceService/Update](../../api-ref/grpc/Instance/update.md) gRPC API call.

{% endlist %}

{% include [metadata-keys](../../../_includes/compute/metadata-keys.md) %}