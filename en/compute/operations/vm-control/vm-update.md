# Updating a VM

After you create a VM, you can edit its name, description, tags, platform, or metadata.

For information about editing a VM configuration, see [{#T}](vm-update-resources.md).

{% list tabs %}

- Management console

  To update a VM:
  1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
  1. Select **{{ compute-name }}**.
  1. Click the name of the desired VM.
  1. Click **Edit VM**.
  1. Edit the VM parameters. Rename the machine, for example, by editing the **Name** field.
  1. At the bottom of the page, click **Save changes**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command for updating VM parameters:

     ```bash
     yc compute instance update --help
     ```

  1. Get a list of VMs in the default folder:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select the VM `ID` or `NAME` (for example, `first-instance`).
  1. Change the VM parameters. For example, rename it:

     ```bash
     yc compute instance update first-instance \
       --new-name windows-vm
     ```

- API

  To update a VM, use the [update](../../api-ref/Instance/update.md) method for the [Instance](../../api-ref/Instance/) resource.

{% endlist %}

{% note info %}

Changing the VM name does not change the host name or the FQDN. For more information about generating FQDN names, see [{#T}](../../concepts/network.md#hostname).

{% endnote %}

## Examples {#examples}

### Viewing a list of configurable parameters {#viewing-a-list-of-configurable-parameters}

To view the list of configurable parameters, run the command:

{% list tabs %}

- CLI

  ```bash
  yc compute instance update --help
  ```

{% endlist %}

### Changing the name and description {#changing-the-name-and-description}

To update a VM name or description, perform the following steps:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get a list of VMs in the default folder:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select the VM `ID` or `NAME` (for example, `first-instance`).
  1. Update the VM name and description:

     ```bash
     yc compute instance update first-instance \
       --new-name first-vm \
       --description "changed description vm via CLI"
     ```

{% endlist %}

{% note alert %}

Do not update the VM name if the VM belongs to a {{ managed-k8s-name }} cluster [node group](../../../managed-kubernetes/concepts/index.md#node-group). The names of these VMs are generated automatically, and updating them will disrupt cluster operations.

{% endnote %}

### Changing metadata {#changing-metadata}

Metadata based on different operating systems may differ. When you change an existing set of metadata, it is completely replaced by the set passed in the command.

To update VM metadata, perform the following steps:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get a list of VMs in the default folder:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select the VM `ID` or `NAME` (for example, `first-instance`).
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

     1. Run the command:

        ```bash
        yc compute instance update first-instance \
          --metadata-from-file user-data=metadata.yaml
        ```

        The existing metadata set will be completely overwritten.

{% endlist %}