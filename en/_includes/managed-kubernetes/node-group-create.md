To create a [{{ managed-k8s-name }} node group](../../managed-kubernetes/concepts/index.md#node-group):
1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).
1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Select the {{ managed-k8s-name }} cluster to create a node group for.
1. On the {{ managed-k8s-name }} cluster page, go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
1. Click **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}**.
1. Enter a name and description for the {{ managed-k8s-name }} node group.
1. In the **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}** field, select the {{ k8s }} version for the {{ managed-k8s-name }} nodes.
1. In the **{{ ui-key.yacloud.k8s.node-groups.create.field_container-runtime }}** field, select `{{ ui-key.yacloud.k8s.node-groups.create.label_runtime-CONTAINERD }}`.
1. In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, add the [node cloud labels](../../managed-kubernetes/concepts/index.md#node-labels).

1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_scale }}**, select its type:
   * `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-fixed }}`: To keep a fixed number of {{ managed-k8s-name }} nodes in the group. Specify the number of {{ managed-k8s-name }} nodes in the group.

     The **{{ ui-key.yacloud.k8s.node-groups.create.field_scale-size }}** setting will become available.
   * `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-auto }}`: To manage the number of group nodes using the [{{ managed-k8s-name }} cluster autoscaling](../../managed-kubernetes/concepts/autoscale.md#ca).

     The following settings will become available:
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_min-size }}**.
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_max-size }}**.
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_initial-size }}** with which the {{ managed-k8s-name }} group will be created.

   {% note warning %}

   You cannot change the scaling type after creating a {{ managed-k8s-name }} node group.

   {% endnote %}

1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_deploy }}**, specify the maximum number of nodes by which you can exceed the size of the group when updating it, as well as the maximum number of unavailable nodes during the update.

   {% include [note-expansion-group-vm](note-expansion-group-vm.md) %}

1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
   * Select a [platform](../../compute/concepts/vm-platforms.md).
   * Enter the required number of [GPUs](../../compute/concepts/gpus.md) and vCPUs, [guaranteed vCPU performance](../../compute/concepts/performance-levels.md), and the amount of RAM.
   * Optionally, make the VM instance [preemptible](../../compute/concepts/preemptible-vm.md) by checking the relevant box.
   * Optionally, enable a [software-accelerated network](../../compute/concepts/software-accelerated-network.md).

     {% include [note-software-accelerated-network](note-software-accelerated-network.md) %}

   {% note info %}

   The set of parameters depends on the platform you select.

   {% endnote %}

1. Optionally, under **{{ ui-key.yacloud.k8s.node-groups.create.section_gpu-settings }}**, specify whether the {{ managed-k8s-name }} node group should have no pre-installed NVIDIA® drivers and CUDA® libraries for [GPU acceleration](../../compute/concepts/gpus.md).
1. Optionally, under **{{ ui-key.yacloud.k8s.node-group.overview.section_placement-policy }}**, enter a name for the {{ managed-k8s-name }} node [placement group](../../compute/concepts/placement-groups.md). You will not be able to edit this setting after creating the {{ managed-k8s-name }} node group.

    {% include [placement-groups](placement-groups.md) %}

1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_disk }}**:
   * Specify the {{ managed-k8s-name }} node **{{ ui-key.yacloud.k8s.node-groups.create.field_disk-type }}**:
     * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-hdd }}`: [Standard network drive](../../compute/concepts/disk.md#disks-types); HDD network block storage.
     * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd }}`: Fast network drive; SSD network block storage.
     * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-nonreplicated }}`: Network drive with enhanced performance achieved by eliminating redundancy. You can only change the size of this disk type in 93 GB increments.

       {% include [nrd-no-backup-note](nrd-no-backup-note.md) %}

     * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-io-m3 }}`: Network drive with the same performance specifications as `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-nonreplicated }}`, plus redundancy. You can only change the size of this disk type in 93 GB increments.

   * Specify the {{ managed-k8s-name }} node disk size.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_network }}**:
   * In the **{{ ui-key.yacloud.k8s.node-groups.create.field_address-type }}** field, select the IP address assignment method:
     * `{{ ui-key.yacloud.k8s.node-groups.create.switch_auto }}`: Assign a random [IP address](../../vpc/concepts/address.md) from the {{ yandex-cloud }} IP address pool.
     * `{{ ui-key.yacloud.k8s.node-groups.create.switch_none }}`: Do not assign a public IP address.
   * Select [security groups](../../vpc/concepts/security-groups.md).

     {% include [security-groups-alert](security-groups-alert.md) %}

1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**:
   * Select the [availability zone](../../overview/concepts/geo-scope.md) and [subnet](../../vpc/concepts/network.md#subnet) to place the group nodes in.
   * Optionally, you can place nodes of a group with the fixed scaling type across multiple availability zones. To do this, click **{{ ui-key.yacloud.k8s.node-groups.create.label_add-location }}** and specify an additional availability zone and subnet.

   {% include [autoscaled-node-group-restriction](autoscaled-node-group-restriction.md) %}

1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_access }}**, configure one of the methods of connecting to nodes in a {{ managed-k8s-name }} node group:

    * To connect to nodes via {{ oslogin }}, select **{{ ui-key.yacloud.k8s.node-group.access-method.field_os-login-access-method }}**.

        In this case, you will not be able to specify SSH keys because these connection methods are mutually exclusive.

        For more information on how to configure and use {{ oslogin }}, see [{#T}](../../managed-kubernetes/operations/node-connect-oslogin.md).

    * To connect to nodes using SSH keys, specify the required credentials:

        * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the username.

        * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../managed-kubernetes/operations/node-connect-ssh.md#creating-ssh-keys) file.

        For more information about preparing, configuring, and using SSH keys, see [{#T}](../../managed-kubernetes/operations/node-connect-ssh.md).

    {% include [node-group-metadata-postponed-update-note](./node-group-metadata-postponed-update-note.md) %}

1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_maintenance }}**:
   * In the **{{ ui-key.yacloud.k8s.MaintenanceSection.maintenance-window-field-with-none-option_tx5Wn }}** field, select your preferred maintenance window:
     * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-disabled }}`: Automatic updates disabled.
     * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-anytime }}`: Updates allowed at any time.
     * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-daily }}`: Updates will take place within the time interval specified in the **{{ ui-key.yacloud.k8s.clusters.create.field_maintenance-daily }}** field.
     * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-weekly }}`: Updates will take place within the time interval specified in the **{{ ui-key.yacloud.k8s.clusters.create.label_maintenance-weekly }}** field.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_additional }}**:
   * To be able to edit [unsafe kernel parameters](../../managed-kubernetes/concepts/index.md#node-group) on the {{ managed-k8s-name }} group nodes, click **{{ ui-key.yacloud.k8s.node-groups.create.button_add-sysctl }}**. To enter the name of each kernel parameter, create a separate field.
   * To set up [taints for {{ managed-k8s-name }} nodes](../../managed-kubernetes/concepts/index.md#taints-tolerations), click **{{ ui-key.yacloud.k8s.node-groups.create.button_add-node-taint }}**. Enter the key, value, and effect for each taint in a separate set of fields.
   * To set up [{{ k8s }} labels](../../managed-kubernetes/concepts/index.md#node-labels) for group nodes, click **{{ ui-key.yacloud.k8s.node-groups.create.button_add-node-label }}**. Enter the key and value for each {{ k8s }} label in a separate set of fields.

1. Optionally, expand the **{{ ui-key.yacloud.common.metadata }}** section and add metadata for the nodes.

    {% note warning %}

    {% include [node-group-metadata-warning](./node-group-metadata-warning.md) %}

    {% endnote %}

    To add metadata, click **{{ ui-key.yacloud.common.metadata-add-field }}**. Specify the key and value for each metadata element in a separate set of fields.

    {% include [node-group-metadata-postponed-update-note](./node-group-metadata-postponed-update-note.md) %}

1. Click **{{ ui-key.yacloud.common.create }}**.
