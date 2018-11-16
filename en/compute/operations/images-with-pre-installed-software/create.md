# Creating a VM from a public image

To create a VM:

1. Open the folder where the VM will be created.
1. Click **Create resource**.
1. Select **Virtual machine**.
1. In the **Name** field, enter the VM name.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

1. Select the [availability zone](../../../overview/concepts/geo-scope.md) to locate the VM in.
1. Select a public image with the software you want to use.
1. In the **Computing resources** section, select the [type of core usage](../../concepts/vm-types.md) (partial or full), specify the necessary number of vCPUs, and the amount of RAM.

    > [!NOTE]
    >
    >To create a VM from a **GitLab** image, at least 4 virtual cores (100% vCPU) and 4 GB of RAM are required.

1. In the **Network settings** section, select the subnet to connect the VM to when creating it.
1. Specify data required for accessing the VM.
1. Click **Create VM**.

VM creation takes several minutes. When the VM gets the `RUNNING` status, proceed to [configuring software](setup.md). You can monitor VM statuses on the list of VMs in the folder.
