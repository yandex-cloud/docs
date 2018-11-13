1. Open the folder where the VM will be created.
1. Click **Create resource**.
1. Select **Virtual machine**.
1. In the **Name** field, enter the VM name.

    [!INCLUDE [name-format](../../_includes/name-format.md)]

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to locate the VM in.
1. Select one of the public [images](../operations/images-with-pre-installed-software/get-list.md) on Linux.
1. In the **Computing resources** section, choose the [type of core usage](../concepts/vm-types.md) (partial or full), and specify the required amount of vCPUs and RAM.
1. In the **Network settings** section, select the subnet to connect the VM to when creating it.
1. Specify data required for accessing the VM.
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the public key file.
    You need to create a key pair for SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTygen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.
1. Click **Create VM**.


