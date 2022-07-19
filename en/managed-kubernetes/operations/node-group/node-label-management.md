# Managing {{ k8s }} cluster node labels

You can add labels to all nodes in a node group at the same time. To do this, specify a set of labels using the `node_labels` parameter when creating a node group.

You can add [{{ k8s }}-labels](../../concepts/index.md#node-labels) to all nodes in a [node group](../../concepts/index.md#node-group) at the same time. To do this, specify a set of labels using the `node_labels` parameter when [creating a node group](../../operations/node-group/node-group-create.md).
1. Create a [cluster{{ k8s }}](../../concepts/index.md#kubernetes-cluster).

   You can use an existing {{ k8s }} cluster or [create a new one](../kubernetes-cluster/kubernetes-cluster-create.md).
1. Create a group of nodes with labels.

   When creating a node group, specify node labels as `key:value` pairs:
   * Management console: In the **Advanced** section in the **Node labels** field.
   * CLI: Use the `--node-labels key=value[,key=value...]` flag.
   * API: Execute a request using the [create](../../api-ref/NodeGroup/create.md) method for a [NodeGroup](../../api-ref/NodeGroup/) resource and specify the node labels.

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the folder where the {{ k8s }} cluster was created.
     1. In the list of services, select **{{ managed-k8s-name }}**.
     1. Select the {{ k8s }} cluster to create a node group for.
     1. On the {{ k8s }} cluster page, go to the **Node groups** tab.
     1. Click **Create node group**.
     1. Enter a node group name.
     1. Specify the **{{ k8s }} version** for the node.
     1. In the **Scalability** section:
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
        * In the **Public IP** field, choose a method for assigning an IP address:
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
     1. In the **Advanced** section:
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

     Result:

     ```bash
     done (2m19s)
     id: catkuapro07enihqmk51
     cluster_id: abcsk1s2f3fmb5h0pd94
     ...
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

     1. Make sure that the configuration files are correct.

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
     1. On the {{ k8s }} cluster page, click the **Nodes** tab.
     1. On one of the node pages, go to the **Labels** tab. The tab lists the node's system and user labels.

   - CLI

     1. View all the nodes in a {{ k8s }} cluster:

     ```bash
     kubectl get nodes
     ```

     Result:

     ```bash
     NAME                        STATUS   ROLES    AGE  VERSION
     catkuапро07enihqmk51-hgjd   Ready    <none>   1h   v1.17.8
     catkuапро07enihqmk51-lskc   Ready    <none>   1h   v1.17.8
     ```

     1. Get information on a selected {{ k8s }} cluster node:

     ```bash
     kubectl describe node catkuапро07enihqmk51-hgjd
     ```

     Result:

     ```bash
     Name:               catkuапро07enihqmk51-hgjd
     Roles:              <none>
     Labels:             apps/tier=backend
     ...
                         yandex.cloud/node-group-id=catkuапро07enihqmk51
                         yandex.cloud/pci-topology=k8s
                         yandex.cloud/preemptible=false
     ```

   - API

     To view information about the node, use the [list](../../api-ref/NodeGroup/list.md) method for the [NodeGroup](../../api-ref/NodeGroup/) resource.

   {% endlist %}