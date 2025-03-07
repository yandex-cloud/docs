# Updating a VM

After you create a VM, you can edit its name, description, labels, platform, or metadata.

For information about editing a VM configuration, see [{#T}](vm-update-resources.md).

{% list tabs group=instructions %}

- Management console {#console}

  To update a VM:
  1. In the [management console]({{ link-console-main }}), select the folder this VM belongs to.
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

{% include [update-metadata-part1](../../../_includes/compute/metadata/update-metadata-part1.md) %}

### Removing SSH keys from metadata {#delete-keys-from-metadata}

{% include [delete-keys-from-metadata](../../../_includes/compute/delete-keys-from-metadata.md) %}

### Enabling access via {{ oslogin }} {#enable-oslogin-access}

{% include [update-metadata-part2-oslogin](../../../_includes/compute/metadata/update-metadata-part2-oslogin.md) %}
