To create a [{{ managed-k8s-name }} node group](../../managed-kubernetes/concepts/index.md#node-group):
1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) in.
1. In the list of services, select **{{ managed-k8s-name }}**.
1. Select the {{ managed-k8s-name }} cluster to create a node group for.
1. On the {{ managed-k8s-name }} cluster page, go to the **Nodes manager** tab.
1. Click **Create node group**.
1. Enter a name and description for the {{ managed-k8s-name }} node group.
1. Specify the **{{ k8s }} version** for the {{ managed-k8s-name }} nodes.
1. Specify the **Container runtime environment**: **Docker** or **containerd**.
1. Under **Scaling**, select a type:
   * **Fixed**: Number of {{ managed-k8s-name }} nodes in the group remains constant. Specify the number of {{ managed-k8s-name }} nodes in the group.

     This will make the **Number of nodes** setting available.
   * **Automatic**: To control the number of group nodes via the [{{ managed-k8s-name }} cluster autoscaling](../../managed-kubernetes/concepts/autoscale.md#ca).

     As a result, the following settings will be available:
     * **Minimum number of nodes**.
     * **Maximum number of nodes**.
     * **Initial number of nodes** with which the {{ managed-k8s-name }} group will be created.

   {% note warning %}

   You cannot change the scaling type after you create your {{ managed-k8s-name }} node group.

   {% endnote %}

1. Under **Allow when creating and updating**, specify the maximum number of [VM instances](../../compute/concepts/vm.md) that you can exceed and reduce the size of the {{ managed-k8s-name }} node group by.
1. Under **Computing resources**:
   * Choose a [platform](../../compute/concepts/vm-platforms.md).
   * Enter the required number of [GPUs](../../compute/concepts/gpus.md) and vCPUs, [guaranteed vCPU performance](../../compute/concepts/performance-levels.md), and the amount of RAM.
   * (Optional) Specify that you want the VM to be [preemptible](../../compute/concepts/preemptible-vm.md).
   * (Optional) Enable a [software-accelerated network](../../compute/concepts/software-accelerated-network.md).

      {% include [note-software-accelerated-network](note-software-accelerated-network.md) %}

   {% note info %}

   The set of parameters depends on the platform you select.

   {% endnote %}

1. (Optional) Under **{{ ui-key.yacloud.k8s.node-groups.create.section_gpu-settings }}**, specify if the {{ managed-k8s-name }} node group should have no pre-installed NVIDIA® drivers and CUDA® libraries for [GPU acceleration](../../compute/concepts/gpus.md).
1. (Optional) Under **Placement**, enter a name for the {{ managed-k8s-name }} node [placement group](../../compute/concepts/placement-groups.md). This setting cannot be changed after the {{ managed-k8s-name }} node group is created.
1. Under **Storage**:
   * Specify the {{ managed-k8s-name }} node **Disk type**:
     * **HDD**: [Standard network drive](../../compute/concepts/disk.md#disks-types); network block storage on an HDD.
     * **SSD**: Fast network drive; network block storage on an SSD.
     * **Non-replicated SSD**: Improved-performance network drive. You can only change the size of this type of disk in 93 GB increments.

       {% include [nrd-no-backup-note](nrd-no-backup-note.md) %}

     * **SSD IO**: Network drive with the same performance characteristics as **non-replicated SSD**, plus redundancy. You can only change the size of this type of disk in 93 GB increments.

   * Specify the {{ managed-k8s-name }} node disk size.
1. Under **Network settings**:
   * In the **Public IP** field, choose a method for assigning an IP address:
     * **Auto**: Assign a random [IP address](../../vpc/concepts/address.md) from the {{ yandex-cloud }} IP pool.
     * **No address**: Do not assign a public IP address.
   * Select [security groups](../../vpc/concepts/security-groups.md).

     {% include [security-groups-alert](security-groups-alert.md) %}

   
   * Specify how {{ managed-k8s-name }} nodes should be distributed across the [availability zones](../../overview/concepts/geo-scope.md) and [networks](../../vpc/concepts/network.md#network).
   * (Optional) Click **Add location** and specify an additional availability zone and network to create {{ managed-k8s-name }} nodes in different zones.


1. Under **Access**, specify the information required to access the {{ managed-k8s-name }} node:
   * Enter the username in the **Login** field.
   * In the **SSH key** field, paste the contents of the [public key](../../managed-kubernetes/operations/node-connect-ssh.md#creating-ssh-keys) file.
1. Under **Maintenance window settings**:
   * In the **Maintenance frequency / Disable** field, choose the maintenance window:
     * **Disabled**: Automatic updates are disabled.
     * **Anytime**: Maintenance is allowed at any time.
     * **Daily**: Maintenance is performed during the interval specified in the **Time (UTC) and duration** field.
     * **On selected days**: Maintenance is performed during the interval specified in the **Schedule by day** field.
1. In the **Advanced** section:
   * To be able to edit [unsafe kernel parameters](../../managed-kubernetes/concepts/index.md#node-group) on the {{ managed-k8s-name }} group nodes, click **Add variable**. To enter the name of each kernel parameter, create a separate field.
   * To set up [taint policies for {{ managed-k8s-name }} nodes](../../managed-kubernetes/concepts/index.md#taints-tolerations), click **Add policy**. Enter the key, value, and effect of each taint policy in a separate set of fields.
   * To set up [{{ managed-k8s-name }} node labels](../../managed-kubernetes/concepts/index.md#node-labels) for the node group, click **Add label**. Enter the key and value of each label in a separate set of fields.
1. Click **Create node group**.

Creating a group of {{ managed-k8s-name }} nodes may take a few minutes depending on the number of nodes.