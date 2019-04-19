1. In the management console, select the folder where you want to create an instance group.
1. Select **[!KEYREF compute-full-name]**.
1. On the **Virtual machines** page, go to the **Instance groups** tab.
1. Click **Create group**.
1. In the **Basic parameters** section, enter:
    - A group name in the **Name** field. The group name must be unique within the cloud.

        [!INCLUDE [name-format](../../_includes/name-format.md)]

    - A group description in the **Description** field.
1. In the **Allocation** section, select availability zones. Cluster VMs may reside in different availability zones and regions. [Learn more about the Cloud geography](../../overview/concepts/geo-scope.md).
1. In the **Instance template** section, click **Add**:
    - Select the required public [image](../../compute/operations/images-with-pre-installed-software/get-list.md).
    - In the **Disks** section:
        - Select the [disk type](../../compute/concepts/disk.md#disks_types) (HDD or NVME).

        - Specify the disk size.

            To add more disks, click **Add disk**.
    - In the **Computing resources** section:
        - Select the platform.
        - Specify the necessary number of vCPUs and amount of RAM.
    - In the **Network settings** section:
        - Select the [cloud network](../../compute/concepts/vm.md#network).
        - Specify if a public IP address is required.
    - In the **Access** section, specify data required for accessing the VM:
        - Enter the username in the **Login** field.

        - In the **SSH key** field, paste the contents of the public key file.

            You need to create a key pair for SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTygen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.
    - Click **Add**.
1. In the **Deployment** section, specify:
    - Expansion of group size for scaling up.

    - Reduction of group size for scaling down.

    - Maximum number of instances when creating a group.

    - Maximum number of instances when deleting a group.

        For more information, see [[!TITLE]](../../instance-groups/concepts/policies.md#deploy-policy).
1. In the **Scalability** section:
    - Select the [scale type](../../instance-groups/concepts/scale.md).
    - Specify the required number of instances.
1. Click **Create**.
