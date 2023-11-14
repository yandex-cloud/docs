# Managing {{ managed-k8s-name }} cluster node labels

You can add [{{ k8s }}-labels](../../concepts/index.md#node-labels) to all {{ managed-k8s-name }} nodes in a [node group](../../concepts/index.md#node-group) at the same time. To do this, specify a set of labels using the `node_labels` parameter when [creating a {{ managed-k8s-name }} node group](../../operations/node-group/node-group-create.md).
1. Create a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster).

   You can use an existing {{ managed-k8s-name }} cluster or [create a new one](../kubernetes-cluster/kubernetes-cluster-create.md).
1. Create a {{ managed-k8s-name }} node group with labels.

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you created the {{ managed-k8s-name }} cluster.
     1. In the list of services, select **{{ managed-k8s-name }}**.
     1. Select the {{ managed-k8s-name }} cluster to create a node group for.
     1. On the {{ managed-k8s-name }} cluster page, go to the **Nodes manager** tab.
     1. Click **Create node group**.
     1. Enter a name for the {{ managed-k8s-name }} node group.
     1. Specify the **{{ k8s }} version** for the {{ managed-k8s-name }} nodes.
     1. In the **Scaling** section:
        * Select the scaling policy type.
        * Specify the number of nodes in the {{ managed-k8s-name }} node group.
     1. Under **Allow when creating and updating**, specify the maximum number of [instances](../../../compute/concepts/vm.md) by which you can increase or decrease the size of the {{ managed-k8s-name }} group.
     1. Under **Computing resources**:
        * Choose a [platform](../../../compute/concepts/vm-platforms.md).
        * Specify the required number of vCPUs, [guaranteed vCPU performance](../../../compute/concepts/performance-levels.md), and the amount of RAM.
     1. Under **Storage**:
        * Specify the {{ managed-k8s-name }} node **Disk type**:
          * **HDD**: Standard network drive; network block storage on an HDD.
          * **SSD**: Fast network drive; network block storage on an SSD.
          * **Non-replicated SSD**: Network drive with enhanced performance achieved by removing redundancy. You can only change the size of this type of disk in 93 GB increments.
          * **SSD IO**: Network drive with the same performance characteristics as **non-replicated SSD**, plus redundancy. You can only change the size of this type of disk in 93 GB increments.
        * Specify the {{ managed-k8s-name }} node [disk](../../../compute/concepts/disk.md) size.
     1. Under **Network settings**:
        * In the **Public IP** field, choose a method for assigning an IP address:
          * **Auto**: Assign a random [IP address](../../../vpc/concepts/address.md) from the {{ yandex-cloud }} IP pool.
          * **No address**: Do not assign a public IP address.
        * Specify how {{ managed-k8s-name }} nodes should be distributed across the [availability zones](../../../overview/concepts/geo-scope.md) and [networks](../../../vpc/concepts/network.md#network).
     1. Under **Access**, specify the information required to access the {{ managed-k8s-name }} node:
        * Enter the username in the **Login** field.
        * In the **SSH key** field, paste the contents of the [public key](../../operations/node-connect-ssh.md#creating-ssh-keys) file.
     1. Under **Maintenance window settings**:
        * In the **Maintenance frequency / Disable** field, choose the [maintenance](../../concepts/release-channels-and-updates.md#updates) window:
          * **Disabled**: Automatic updates are disabled.
          * **Anytime**: Maintenance is allowed at any time.
          * **Daily**: Maintenance is performed during the interval specified in the **Time (UTC) and duration** field.
          * **On selected days**: Maintenance is performed during the interval specified in the **Schedule by day** field.
     1. In the **Advanced** section:
        * In the **Node labels** field, click **Add label** and specify the label key and value. Add multiple labels if needed.
     1. Click **Create node group**.

   - CLI

     Create a {{ managed-k8s-name }} node group:

     ```bash
     yc managed-kubernetes node-group create \
      --name k8s-labels-node \
      --cluster-name k8s-labels \
      --disk-type network-ssd \
      --fixed-size 1 \
      --node-labels environment=production,apps/tier=backend
     ```

     Where:

     * `--name`: Name of the {{ managed-k8s-name }} node group.
     * `--cluster-name`: Name of the {{ managed-k8s-name }} cluster where the node group is created.
     * `--disk-type`: [Disk type](../../../compute/concepts/disk.md) on the {{ managed-k8s-name }} node.
     * `--fixed-size`: Number of {{ managed-k8s-name }} nodes in the group.
     * `--node-labels`: {{ managed-k8s-name }} node labels. You can specify multiple labels separated by commas.

     Result:

     ```bash
     done (2m19s)
     id: catkuapro07enihqmk51
     cluster_id: abcsk1s2f3fmb5h0pd94
     created_at: "2020-09-24T13:32:24Z"
     name: k8s-labels-node
     status: RUNNING
     node_template:
       platform_id: standard-v2
       resources_spec:
         memory: "4294967296"
         cores: "2"
         core_fraction: "100"
       boot_disk_spec:
         disk_type_id: network-ssd
         disk_size: "103079215104"
       v4_address_spec: {}
       scheduling_policy: {}
     scale_policy:
       fixed_scale:
         size: "1"
     allocation_policy:
       locations:
       - zone_id: {{ region-id }}-a
         subnet_id: e9bm87gkjd81eroc6dqg
     deploy_policy:
       max_expansion: "3"
     instance_group_id: cl1v2gh33j1c71df9jsv
     node_version: "1.17"
     version_info:
       current_version: "1.17"
     maintenance_policy:
       auto_upgrade: true
       auto_repair: true
       maintenance_window:
         anytime: {}
     node_labels:
       apps/tier: backend
       environment: production
     ```

   - {{ TF }}

     {% note warning %}

     A {{ managed-k8s-name }} node group will be recreated from scratch.

     {% endnote %}

     1. Open the current configuration file describing the {{ managed-k8s-name }} node group.

        For more information about creating this file, see [{#T}](node-group-create.md).
     1. Add the `node_labels` property to the {{ managed-k8s-name }} node group description:

        ```hcl
        resource "yandex_kubernetes_node_group" "<node_group_name>" {
          cluster_id = yandex_kubernetes_cluster.<cluster_name>.id
          ...
          node_labels = {
            "<label1>" = "<value1>"
            "<label2>" = "<value2>"
            ...
          }
        }
        ```

     1. Make sure the configuration files are valid.

        {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

     1. Confirm updating the resources.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

   - API

     To create a {{ managed-k8s-name }} node group, use the [create](../../api-ref/NodeGroup/create.md) method for the [NodeGroup](../../api-ref/NodeGroup/) resource.

   {% endlist %}

1. Get information about the created group of labeled {{ managed-k8s-name }} nodes:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the folder where the {{ managed-k8s-name }} cluster was created.
     1. In the list of services, select **{{ managed-k8s-name }}**.
     1. Select the {{ managed-k8s-name }} cluster where the node group was created.
     1. On the {{ managed-k8s-name }} cluster page, go to the **Nodes manager** tab.
     1. Open the page of one of the {{ managed-k8s-name }} nodes and go to the **Labels** tab. The tab lists the system and user labels of the {{ managed-k8s-name }} node.

   - CLI

     1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
     1. View all the nodes in a {{ managed-k8s-name }} cluster:

         ```bash
         kubectl get nodes
         ```

         Result:

         ```bash
         NAME                        STATUS   ROLES    AGE  VERSION
         catkuapro07enihqmk51-hgjd   Ready    <none>   1h   v1.17.8
         catkuapro07enihqmk51-lskc   Ready    <none>   1h   v1.17.8
         ```

     1. Get information on a selected {{ managed-k8s-name }} cluster node:

         ```bash
         kubectl describe node catkuapro07enihqmk51-hgjd
         ```

         Result:

         ```bash
         Name:               catkuapro07enihqmk51-hgjd
         Roles:              <none>
         Labels:             apps/tier=backend
                             beta.kubernetes.io/arch=amd64
                             beta.kubernetes.io/instance-type=standard-v2
                             beta.kubernetes.io/os=linux
                             environment=production
                             failure-domain.beta.kubernetes.io/zone={{ region-id }}-a
                             kubernetes.io/arch=amd64
                             kubernetes.io/hostname=catkuapro07enihqmk51-hgjd
                             kubernetes.io/os=linux
                             node.kubernetes.io/kube-proxy-ds-ready=true
                             node.kubernetes.io/masq-agent-ds-ready=true
                             node.kubernetes.io/node-problem-detector-ds-ready=true
                             yandex.cloud/node-group-id=catkuapro07enihqmk51
                             yandex.cloud/pci-topology=k8s
                             yandex.cloud/preemptible=false
         ```

   - API

     To view {{ managed-k8s-name }} node details, use the [list](../../api-ref/NodeGroup/list.md) method for the [NodeGroup](../../api-ref/NodeGroup/) resource.

   {% endlist %}