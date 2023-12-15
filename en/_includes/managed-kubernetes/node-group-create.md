To create a [{{ managed-k8s-name }} node group](../../managed-kubernetes/concepts/index.md#node-group):
1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) in.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Select the {{ managed-k8s-name }} cluster to create a node group for.
1. On the {{ managed-k8s-name }} cluster page, go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
1. Click **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}**.
1. Enter a name and description for the {{ managed-k8s-name }} node group.
1. In the **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}** field, select a {{ k8s }} version for {{ managed-k8s-name }} nodes.
1. In the **{{ ui-key.yacloud.k8s.node-groups.create.field_container-runtime }}** field, select `{{ ui-key.yacloud.k8s.node-groups.create.label_runtime-DOCKER }}` or `{{ ui-key.yacloud.k8s.node-groups.create.label_runtime-CONTAINERD }}`.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_scale }}**, select its type:
   * `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-fixed }}`: Number of {{ managed-k8s-name }} nodes in the group remains constant. Specify the number of {{ managed-k8s-name }} nodes in the group.

     The **{{ ui-key.yacloud.k8s.node-groups.create.field_scale-size }}** setting will become available.
   * `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-auto }}`: To control the number of group nodes via the [{{ managed-k8s-name }} cluster autoscaling](../../managed-kubernetes/concepts/autoscale.md#ca).

     The following settings will become available:
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_min-size }}**.
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_max-size }}**.
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_initial-size }}** with which the {{ managed-k8s-name }} group will be created.

   {% note warning %}

   You cannot change the scaling type after you create your {{ managed-k8s-name }} node group.

   {% endnote %}

1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_deploy }}**, specify the maximum number of [VM instances](../../compute/concepts/vm.md) that you can exceed and reduce the size of the {{ managed-k8s-name }} node group by.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
   * Choose a [platform](../../compute/concepts/vm-platforms.md).
   * Enter the required number of [GPUs](../../compute/concepts/gpus.md) and vCPUs, [guaranteed vCPU performance](../../compute/concepts/performance-levels.md), and the amount of RAM.
   * (Optional) Specify that you want the VM to be [preemptible](../../compute/concepts/preemptible-vm.md).
   * (Optional) Enable a [software-accelerated network](../../compute/concepts/software-accelerated-network.md).

      {% include [note-software-accelerated-network](note-software-accelerated-network.md) %}

   {% note info %}

   The set of parameters depends on the platform you select.

   {% endnote %}

1. (Optional) Under **{{ ui-key.yacloud.k8s.node-groups.create.section_gpu-settings }}**, specify if the {{ managed-k8s-name }} node group should have no pre-installed NVIDIA® drivers and CUDA® libraries for [GPU acceleration](../../compute/concepts/gpus.md).
1. (Optional) Under **{{ ui-key.yacloud.k8s.node-group.overview.section_placement-policy }}**, enter a name for the {{ managed-k8s-name }} node [placement group](../../compute/concepts/placement-groups.md). This setting cannot be changed after the {{ managed-k8s-name }} node group is created.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_disk }}**:
   * Specify the {{ managed-k8s-name }} node **{{ ui-key.yacloud.k8s.node-groups.create.field_disk-type }}**:
     * `{{ ui-key.yacloud.k8s.node-groups.create.value_network-hdd }}`: [Standard network drive](../../compute/concepts/disk.md#disks-types); network block storage on an HDD.
     * `{{ ui-key.yacloud.k8s.node-groups.create.value_network-ssd }}`: Fast network drive; network block storage on an SSD.
     * `{{ ui-key.yacloud.k8s.node-groups.create.value_network-ssd-nonreplicated }}`: Network drive with enhanced performance achieved by removing redundancy. You can only change the size of this type of disk in 93 GB increments.

       {% include [nrd-no-backup-note](nrd-no-backup-note.md) %}

     * `{{ ui-key.yacloud.k8s.node-groups.create.value_network-ssd-io-m3 }}`: Network drive with the same performance characteristics as `{{ ui-key.yacloud.k8s.node-groups.create.value_network-ssd-nonreplicated }}`, plus redundancy. You can only change the size of this type of disk in 93 GB increments.

   * Specify the {{ managed-k8s-name }} node disk size.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_network }}**:
   * In the **{{ ui-key.yacloud.k8s.node-groups.create.field_address-type }}** field, choose a method for assigning an IP address:
     * `{{ ui-key.yacloud.k8s.node-groups.create.switch_auto }}`: Assign a random [IP address](../../vpc/concepts/address.md) from the {{ yandex-cloud }} IP pool.
     * `{{ ui-key.yacloud.k8s.node-groups.create.switch_none }}`: Do not assign a public IP address.
   * Select [security groups](../../vpc/concepts/security-groups.md).

     {% include [security-groups-alert](security-groups-alert.md) %}

   
   * Specify how {{ managed-k8s-name }} nodes should be distributed across the [availability zones](../../overview/concepts/geo-scope.md) and [networks](../../vpc/concepts/network.md#network).
   * (Optional) Click **{{ ui-key.yacloud.k8s.node-groups.create.label_add-location }}** and specify an additional availability zone and network to create {{ managed-k8s-name }} nodes in different zones.


1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_access }}**, specify the information required to access the {{ managed-k8s-name }} node:
   * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
   * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../managed-kubernetes/operations/node-connect-ssh.md#creating-ssh-keys) file.
1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_maintenance }}**:
   * In the **{{ ui-key.yacloud.k8s.clusters.create.field_maintenance-window }}** field, select your preferred maintenance window:
     * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-disabled }}`: Automatic updates disabled.
     * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-anytime }}`: Updates allowed at any time.
     * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-daily }}`: Updates will take place within the time interval specified in the **{{ ui-key.yacloud.k8s.clusters.create.field_maintenance-daily }}** field.
     * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-weekly }}`: Updates will take place within the time interval specified in the **{{ ui-key.yacloud.k8s.clusters.create.label_maintenance-weekly }}** field.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_additional }}**:
   * To be able to edit [unsafe kernel parameters](../../managed-kubernetes/concepts/index.md#node-group) on the {{ managed-k8s-name }} group nodes, click **{{ ui-key.yacloud.k8s.node-groups.create.button_add-sysctl }}**. To enter the name of each kernel parameter, create a separate field.
   * To set up [taint policies for {{ managed-k8s-name }} nodes](../../managed-kubernetes/concepts/index.md#taints-tolerations), click **{{ ui-key.yacloud.k8s.node-groups.create.button_add-node-taint }}**. Enter the key, value, and effect of each taint policy in a separate set of fields.
   * To set up [{{ k8s }} labels](../../managed-kubernetes/concepts/index.md#node-labels) for group nodes, click **{{ ui-key.yacloud.k8s.node-groups.create.button_add-node-label }}**. Enter the key and value of each {{ k8s }} label in a separate set of fields.
1. Click **{{ ui-key.yacloud.common.create }}**.

Creating a group of {{ managed-k8s-name }} nodes may take a few minutes depending on the number of nodes.