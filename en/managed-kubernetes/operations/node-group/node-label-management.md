# Managing {{ k8s }} cluster node labels

You can add [{{ k8s }}-labels](../../concepts/index.md#node-labels) to all nodes in a [node group](../../concepts/index.md#node-group) at the same time. To do this, specify a set of labels using the `node_labels` parameter when [creating a node group](../../operations/node-group/node-group-create.md).

1. Create a [cluster{{ k8s }}](../../concepts/index.md#kubernetes-cluster).

   You can use an existing {{ k8s }} cluster or [create a new one](../kubernetes-cluster/kubernetes-cluster-create.md).
1. Create a group of nodes with labels.

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the folder where the {{ k8s }} cluster was created.
     1. In the list of services, select **{{ managed-k8s-name }}**.
     1. Select the {{ k8s }} cluster to create a node group for.
     1. On the {{ k8s }} cluster page, go to the **Nodes manager** tab.
     1. Click **Create node group**.
     1. Enter a node group name.
     1. Specify the **{{ k8s }} version** for the node.
     1. In the **Scaling** section:
        * Select the scaling policy type.
        * Specify the number of nodes in the node group.
     1. Under **Allow when creating and updating**, specify the maximum number of instances that you can exceed and reduce the size of the group by.
     1. Under **Computing resources**:
        * Choose a [platform](../../../compute/concepts/vm-platforms.md).
        * Specify the requisite number of vCPUs and [guaranteed vCPU performance](../../../compute/concepts/performance-levels.md) as well as the amount of RAM.
     1. Under **Storage**:
        * Specify the **Disk type**:
          * **HDD**: Standard network drive. Network block storage on an HDD.
          * **SSD**: Fast network drive. Network block storage on an SSD.
        * Specify the [disk](../../../compute/concepts/disk.md) size.
     1. Under **Network settings**:
        * In the **Public address** field, choose a method for assigning an IP address:
          * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
          * **No address**: Don't assign a public IP address.
        * Specify how nodes should be distributed across availability zones and networks.
     1. Under **Access**, specify the information required to access the node:
        * Enter the username in the **Login** field.
        * In the **SSH key** field, paste the contents of the [public key](../../operations/node-connect-ssh.md#creating-ssh-keys) file.
     1. Under **Maintenance window settings**:
        * In the **Maintenance frequency / Disable** field, choose the [maintenance](../../concepts/release-channels-and-updates.md#updates) window:
          * **Disabled**: Automatic updates are disabled.
          * **Anytime**: Maintenance is allowed at any time.
          * **Daily**: Maintenance is performed during the interval specified in the **Time (UTC) and duration** field.
          * **On selected days**: Maintenance is performed during the interval specified in the **Schedule by day** field.
     1. In the **Additional** section:
        * In the **Node labels** field, click **Add label** and specify the label key and value. Add multiple labels if needed.
     1. Click **Create node group**.

   - CLI

     Create a node group:

     ```bash
     yc managed-kubernetes node-group create \
      --name k8s-labels-node \
      --cluster-name k8s-labels \
      --disk-type network-ssd \
      --fixed-size 1 \
      --node-labels environment=production,apps/tier=backend
     ```

     Where:

     * `--name`: The name of the node group.
     * `--cluster-name`: Name of the {{ k8s }} cluster where the node group is created.
     * `--disk-type`: [Type of the disk](../../../compute/concepts/disk.md) on the node.
     * `--fixed-size`: Number of nodes in the group.
     * `--node-labels`: Node labels. You can specify multiple labels separated by commas.

     Command result:

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

     A node group will be re-created from scratch.

     {% endnote %}

     1. Open the current configuration file with the description of the node group.

        For more information about creating this file, see [{#T}](node-group-create.md).
     1. Add the `node_labels` property to the node group description:

        ```hcl
        resource "yandex_kubernetes_node_group" "<node group name>" {
          cluster_id = yandex_kubernetes_cluster.<cluster name>.id
          ...
          node_labels = {
            "<label1>" = "<value1>"
            "<label2>" = "<value2>"
            ...
          }
        }
        ```

     1. Make sure that the configuration files are valid.

        {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

     1. Confirm the update of resources.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

   - API

     To create a node group, use the [create](../../api-ref/NodeGroup/create.md) method for the [NodeGroup](../../api-ref/NodeGroup/) resource.

   {% endlist %}

1. Get information about the created group of labeled nodes:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the folder where the {{ k8s }} cluster was created.
     1. In the list of services, select **{{ managed-k8s-name }}**.
     1. Select the {{ k8s }} cluster where the node group was created.
     1. On the {{ k8s }} cluster page, go to **Nodes manager**.
     1. On one of the node pages, go to the **Labels** tab. The tab lists the node's system and user labels.

   - CLI

     1. View all the nodes in a {{ k8s }} cluster:

     ```bash
     kubectl get nodes
     ```

     Command result:

     ```bash
     NAME                        STATUS   ROLES    AGE  VERSION
     catkuapro07enihqmk51-hgjd   Ready    <none>   1h   v1.17.8
     catkuapro07enihqmk51-lskc   Ready    <none>   1h   v1.17.8
     ```

     1. Get information on a selected {{ k8s }} cluster node:

     ```bash
     kubectl describe node catkuapro07enihqmk51-hgjd
     ```

     Command result:

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

     To view node information, use the [list](../../api-ref/NodeGroup/list.md) method for the [NodeGroup](../../api-ref/NodeGroup/) resource.

   {% endlist %}