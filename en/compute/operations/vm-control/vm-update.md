# Updating a VM

After you create a VM, you can change its name, description, tags, platform, or metadata.

For more information about how to update a VM configuration, see [{#T}](vm-update-resources.md).

{% list tabs %}

- Management console

   To update a VM:
   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ compute-name }}**.
   1. Click on the VM name.
   1. Click **Edit VM**.
   1. Change the VM parameters, for example, rename it by editing the **Name** field.
   1. At the bottom of the page, click **Save changes**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's update VM parameter command:

      ```
      $ yc compute instance update --help
      ```

   1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the VM `ID` or `NAME` (for example, `first-instance`).
   1. Change the VM parameters, for example, rename it:

      ```
      $ yc compute instance update first-instance \
          --new-name windows-vm
      ```

- API

   To change the VM, use the [update](../../api-ref/Instance/update.md) method for the [Instance](../../api-ref/Instance/).

{% endlist %}

{% note info %}

If you change the VM name, the host name and FQDN are not changed. For more information about generating FQDN names, see [{#T}](../../concepts/network.md#hostname).

{% endnote %}

## Examples {#examples}

### Viewing a list of configurable parameters {#viewing-a-list-of-configurable-parameters}

To view the list of configurable parameters, run the command:

{% list tabs %}

- CLI

   ```
   $ yc compute instance update --help
   ```
{% endlist %}

### Changing the name and description {#changing-the-name-and-description}

To change the name and description of a VM, follow these steps:

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the VM `ID` or `NAME` (for example, `first-instance`).
   1. Change the VM's name and description:

      ```
      $ yc compute instance update first-instance \
          --new-name first-vm \
          --description "changed description vm via CLI"
      ```

{% endlist %}

### Changing metadata {#changing-metadata}

Metadata based on different operating systems may differ. When you change an existing set of metadata, it is completely replaced by the set passed in the command.

To change a VM's metadata, follow these steps:

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the VM `ID` or `NAME` (for example, `first-instance`).
   1. Get information about the VM with the metadata. All user-defined metadata is specified in the `user-data` key.

      ```
      $ yc compute instance get --full first-instance
      ```

   1. Change the VM's metadata. You can change the metadata using the flags:

      - `--metadata`: to change a value from a single string.
      - `--metadata-from-file`: to change a value from multiple strings.

            
      Example of changing the administrator password on a Windows-based VM:

      1. Create a YAML file (for example, `metadata.yaml`) and specify the following:

         ```yaml
         #ps1
         net user administrator '<password>'
         ```

      1. Run the command:

         ```
         $ yc compute instance update first-instance \
             --metadata-from-file user-data=metadata.yaml
         ```

         The existing metadata set will be completely overwritten.
      

{% endlist %}
