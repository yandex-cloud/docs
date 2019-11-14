# Creating a VM from a public Linux image

This section provides guidelines for creating a VM with Linux OS To create a Windows-based VM, follow the instructions [{#T}](create-windows-vm.md).

To create a VM:

{% list tabs %}

- Management console

  {% include [create-instance-via-console-linux](../../_includes_service/create-instance-via-console-linux.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI's create VM command:

      ```
      $ yc compute instance create --help
      ```

  1. Prepare the key pair (public and private) for SSH access to the VM.

  1. Select a public [image](../images-with-pre-installed-software/get-list.md) based on Linux OS (for example, CentOS 7).

      {% include [standard-images](../../../_includes/standard-images.md) %}

  1. Create a VM in the default folder:

      ```
      $ yc compute instance create \
          --name first-instance \
          --zone ru-central1-a \
          --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
          --ssh-key ~/.ssh/id_rsa.pub
      ```

      This command creates a VM instance with the following characteristics:
      - Named `first-instance`.
      - Running on CentOS 7.
      - In the `ru-central1-a` availability zone.

      {% include [name-format](../../../_includes/name-format.md) %}

- API

  Use the [Create](../../../_api-ref/compute/api-ref/Instance/create.md) method for the `Instance` resource.

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

#### See also

- [{#T}](../vm-connect/ssh.md)

