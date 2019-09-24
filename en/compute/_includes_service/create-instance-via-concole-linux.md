1. Open the folder where the VM will be created.

1. Click **Create resource**.

1. Select **Virtual machine**.

1. In the **Name** field, enter the VM name.

    {% include [name-format](../../_includes/name-format.md) %}

    {% note info %}

    The virtual machine name is used for generating the FQDN, which cannot be changed later. If the FQDN is important to you, choose an appropriate name for the virtual machine at the creation stage. For more information about generating FQDN names, see the section [{#T}](../concepts/network.md#hostname).

    {% endnote %}

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to locate the VM in.

1. Select one of the public [images](../operations/images-with-pre-installed-software/get-list.md) on Linux.

1. In the **Computing resources** section:
    - Choose the [platform](../concepts/vm-platforms.md).
    - Specify the necessary number of vCPUs and amount of RAM.

1. In the **Network settings** section, click **Add network**.

1. In the window that opens, select the subnet to connect the VM to when creating it.

1. In **Public address**, choose:
    - **Automatically** — to set a public IP address automatically. The address is allocated from the pool of Yandex.Cloud addresses.
    - **List** — to select a public IP address from the list of static addresses. For more information, see the section [{#T}](../../vpc/operations/set-static-ip.md) in the {{ vpc-name }} service documentation.
    - **No address** — to not assign a public IP address.

1. Specify data required for accessing the VM:
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the public key file.
You need to create a key pair for SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTygen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.

1. Click **Create VM**.

