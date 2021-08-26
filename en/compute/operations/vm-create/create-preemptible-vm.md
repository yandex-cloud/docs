# Creating a preemptible VM

To create a preemptible VM:

{% list tabs %}

- Management console

  1. Open the folder where the VM will be created.

  1. Click **Create resource**.

  1. Select **Virtual machine**.

  1. In the **Name** field, enter a name for the VM.

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

  1. Select an [availability zone](../../../overview/concepts/geo-scope.md) to host the VM in.

  1. Select one of the [public images](../../operations/images-with-pre-installed-software/get-list.md) on Linux.

  1. Under **Computing resources**:
      - Choose a [platform](../../concepts/vm-platforms.md).
      - Specify the required amount of computing resources.
      - Set the **Preemptible** flag.

  1. In the **Network settings** section, click **Add network**.

  1. In the window that opens, select the subnet to connect the VM to while being created.

  1. In **Public address**, choose:
      - **Automatically** — to set a public IP address automatically. The address is allocated from the pool of Yandex.Cloud addresses.
      - **List** — to select a public IP address from the list of static addresses. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md) in the {{ vpc-name }} documentation.
      - **No address**: Don't assign a public IP address.

  1. Specify data required for accessing the VM:
      - Enter the username in the **Login** field.
      - In the **SSH key** field, paste the contents of the public key file.
You need to create a key pair for SSH connection yourself. Learn more in [{#T}](../vm-connect/ssh.md#creating-ssh-keys).

  1. Click **Create VM**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for creating a VM:

      ```
      $ yc compute instance create --help
      ```

  1. Prepare the key pair (public and private keys) for SSH access to the VM.

  1. Select a public [image](../images-with-pre-installed-software/get-list.md) based on a Linux OS (for example, [CentOS 7](https://cloud.yandex.com/en-ru/marketplace/products/f2esfplfav536pn90mdo)).

      {% include [standard-images](../../../_includes/standard-images.md) %}

  1. Create a VM in the default folder:

      ```
      $ yc compute instance create \
          --name first-preemptible-instance \
          --zone ru-central1-a \
          --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
          --preemptible \
          --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
          --ssh-key ~/.ssh/id_rsa.pub
      ```

      This command creates a preemptible VM with the following characteristics:
      - Named `first-preemptible-instance`.
      - Running CentOS 7.
      - In the `ru-central1-a` availability zone.
      - In the `default-a` subnet.
      - With a public IP.

      To create a VM without a public IP address, disable the `nat-ip-version=ipv4` option.

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

- API

  Use the [Create](../../api-ref/Instance/create.md) method for the `Instance` resource.

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

#### See also {#see-also}

- [{#T}](../vm-connect/ssh.md)

