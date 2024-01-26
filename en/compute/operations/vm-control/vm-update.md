# Updating a VM

After you create a VM, you can edit its name, description, tags, platform, or metadata.

For information about editing a VM configuration, see [{#T}](vm-update-resources.md).

{% list tabs group=instructions %}

- Management console {#console}

  To update a VM:
  1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}** and click the name of the VM you need.
  1. Click ![image](../../../_assets/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. Edit the VM parameters, e.g., rename it by editing the **{{ ui-key.yacloud.compute.instances.create.field_name }}** field.
  1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command for updating VM parameters:

     ```bash
     yc compute instance update --help
     ```

  1. Get a list of VMs in the default folder:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select the `ID` or `NAME` of the VM, e.g., `first-instance`.
  1. Change the VM parameters, e.g., rename it:

     ```bash
     yc compute instance update first-instance \
       --new-name windows-vm
     ```

- API {#api}

  To update a VM, use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update) gRPC API call.

{% endlist %}

{% note info %}

Changing the VM name does not change the host name or the FQDN. For more information about generating FQDN names, see [{#T}](../../concepts/network.md#hostname).

{% endnote %}

## Examples {#examples}

### Viewing a list of configurable parameters {#viewing-a-list-of-configurable-parameters}

To view the list of configurable parameters, run the command:

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

  Use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update) gRPC API call.

{% endlist %}

{% note alert %}

Do not update the VM name if the VM belongs to a {{ managed-k8s-name }} cluster [node group](../../../managed-kubernetes/concepts/index.md#node-group). The names of these VMs are generated automatically, and updating them will disrupt cluster operations.

{% endnote %}

### Changing metadata {#changing-metadata}

Metadata based on different operating systems may differ. When you change an existing set of metadata, it is completely replaced by the set passed in the command.

To update VM metadata, follow these steps:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get a list of VMs in the default folder:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select the `ID` or `NAME` of the VM, e.g., `first-instance`.
  1. Retrieve VM information with its metadata. All user-defined metadata is specified in the `user-data` key.

     ```bash
     yc compute instance get --full first-instance
     ```

  1. Update the VM metadata. You can change the metadata using the flags:
     * `--metadata`: To change a value from a single string.
     * `--metadata-from-file`: To change a value from multiple strings.

     Example administrator password update on a Windows-based VM:
     1. Create a YAML file (for example, `metadata.yaml`) and specify the following:

        ```yaml
        #ps1
        net user administrator '<password>'
        ```

     1. Run this command:

        ```bash
        yc compute instance update first-instance \
          --metadata-from-file user-data=metadata.yaml
        ```

        The existing metadata set will be completely overwritten.

{% endlist %}

### Removing SSH keys from metadata {#delete-keys-from-metadata}

{% include [delete-keys-from-metadata](../../../_includes/compute/delete-keys-from-metadata.md) %}

### Enabling access via OS Login {#enable-oslogin-access}

To make sure that users can [connect](../vm-connect/os-login.md) to the VM via [OS Login](../../../organization/concepts/os-login.md), enable this option in the VM settings:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}** and click the name of the VM you need.
   1. Click ![image](../../../_assets/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, enable the **{{ ui-key.yacloud.compute.instances.create.field_os-login-access-method }}** option.
   1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for updating VM parameters:

      ```bash
      yc compute instance update --help
      ```

   1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the `ID` or `NAME` of the VM, e.g., `first-instance`.

   1. Enable access via OS Login:

      ```bash
      yc compute instance update first-instance \
        --metadata enable-oslogin=true
      ```

- API {#api}

   In the `metadata` field, set `enable-oslogin=true` in the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/) resource or in the [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update) gRPC API call.

{% endlist %}