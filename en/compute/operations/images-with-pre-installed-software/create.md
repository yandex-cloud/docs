# Creating a VM from a public image

To create a VM:

1. Open the folder where the VM will be created.

1. Click **Create resource**.

1. Select **Virtual machine**.

1. In the **Name** field, enter a name for the VM.

    {% include [name-format](../../../_includes/name-format.md) %}

1. Select the [availability zone](../../../overview/concepts/geo-scope.md) to host the VM in.

1. Select a public image with the software you want to use.

1. Under **Computing resources**:
    - Choose a [platform](../../concepts/vm-platforms.md).
    - Specify the necessary number of vCPUs and amount of RAM.

    {% note info %}

    To create a VM from a [GitLab](https://cloud.yandex.com/en-ru/marketplace/products/f2eb5e8deq602ccak537) image, at least 4 virtual cores (100% vCPU) and 4 GB of RAM are required.

    {% endnote %}

1. In the **Network settings** section, click **Add network**.

1. In the window that opens, select the subnet to connect the VM to while being created.

1. In **Public address**, choose:
    - **Automatically** — to set a public IP address automatically. The address is allocated from the {{ yandex-cloud }} address pool.
    - **List** — to select a public IP address from the list of static addresses. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md) in the {{ vpc-name }} documentation.
    - **No address** — don't assign a public IP address.

1. Select the [appropriate security groups](../../../vpc/concepts/security-groups.md) (if there is no corresponding field, all incoming and outgoing traffic will be allowed for the VM).

1. Specify data required for accessing the VM.

1. Click **Create VM**.

VM creation takes several minutes. When the VM status changes to `RUNNING`, proceed to [configuring software](setup.md). You can monitor VM statuses on the list of VMs in the folder.

