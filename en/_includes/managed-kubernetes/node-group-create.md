To create a node group:

1. In [management console]({{ link-console-main }}), select the folder where you want to create your {{ k8s }} cluster.
1. In the list of services, select **{{ managed-k8s-name }}**.
1. Select the {{ k8s }} cluster to create a node group for.
1. On the {{ k8s }} cluster page, go to the **Node groups** tab.
1. Click **Create node group**.
1. Enter a name and description for the node group.
1. Specify the **{{ k8s }} version** for the nodes.
1. Specify the number of nodes in the node group.
1. Under **Scalability**:
    - Select the scaling policy type.
    - Specify the number of nodes in the node group.
1. Under **Allow when creating and updating**, specify the maximum number of instances that you can exceed and reduce the size of the group by.
1. Under **Computing resources**:
    - Choose a [platform](../../compute/concepts/vm-platforms.md).
    - Specify the required number of vCPUs, [guaranteed vCPU performance](../../compute/concepts/performance-levels.md), and RAM.
    - (optional) Specify that the VM must be [preemptible](../../compute/concepts/preemptible-vm.md).
1. Under **Storage**:
    - Specify the **Disk type**:
        - **HDD**: Standard network drive. Network block storage on an HDD.
        - **SSD**: Fast network drive. Network block storage on an SSD.
    - Specify the disk size.
1. Under **Network settings**:
    - In the **Public IP** field, choose a method for assigning an IP address:
        - **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
        - **No address**: Don't assign a public IP address.
    - Specify how nodes should be distributed across availability zones and networks.
    - (optional) Click **Add location** and specify an additional availability zone and network to create nodes in different zones.
1. Under **Access**, specify the information required to access the node:
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the [public key file](../../managed-kubernetes/operations/node-connect-ssh.md#creating-ssh-keys).
1. Under **Maintenance window settings**:
    - In the **Maintenance frequency / Disable** field, choose the maintenance window:
        - **Disabled**: Automatic updates are disabled.
        - **Anytime**: Maintenance is allowed at any time.
        - **Daily**: Maintenance is performed during the interval specified in the **Time (UTC) and duration** field.
        - **On selected days**: Maintenance is performed during the interval specified in the **Schedule by day** field.
1. Click **Create node group**.

