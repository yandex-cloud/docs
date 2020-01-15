# Updating a VM

After you create a VM, you can change its name, description, tags, platform, or metadata.

For more information about how to update a VM's configuration, see the section [{#T}](vm-update-resources.md).

{% list tabs %}

- CLI

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI's update VM parameter command:

      ```
      $ yc compute instance update --help
      ```

  1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).
  1. Change the VM parameters, for example, rename it:

      ```
      $ yc compute instance update first-instance \
          --new-name windows-vm
      ```

- API

  To change the VM, use the [update](../../../_api-ref/compute/api-ref/Instance/update.md) method for the [Instance](../../../_api-ref/compute/api-ref/Instance/) resource.

{% endlist %}

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

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).
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

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).
  1. Get information about the VM with the metadata. All user-defined metadata is specified in the `user-data` key.

      ```
      $ yc compute instance get --full first-instance
      ```

  1. Change the VM's metadata. You can change the metadata using the flags:
      - `--metadata` — to change a value from a single string.
      - `--metadata-from-file` — to change a value from multiple strings.

      Example of changing the administrator's password on a Windows-based VM:

      1. Create a YAML file (for example, `metadata.yaml`) and specify the following:

          ```yaml
          #ps1
          net user administrator "<password>"
          ```

      1. Run the command:

          ```
          $ yc compute instance update first-instance \
              --metadata-from-file user-data=metadata.yaml
          ```

      The existing metadata set will be completely overwritten.

{% endlist %}
