1. Open the folder where the VM will be created.
1. Click **Create resource**.
1. Select **Virtual machine**.
1. In the **Name** field, enter the VM name.

    [!INCLUDE [name-format](../../_includes/name-format.md)]

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to locate the VM in.
1. Select one of the public [images](../operations/images-with-pre-installed-software/get-list.md) on Windows.
1. In the **Computing resources** section:
    - Choose the [type of virtual machine](../concepts/vm-types.md) (light or standard).
    - Specify the required amount of vCPUs and RAM.
1. In the **Network settings** section, select the subnet to connect the VM to when creating it.
1. When you create a VM, the `Administrator` user is automatically created in the operating system. In the **Password** field, set a password for this user to log in to the VM via RDP.

    [!INCLUDE [password-requirements](../../_includes/password-requirements.md)]

1. Click **Create VM**.

