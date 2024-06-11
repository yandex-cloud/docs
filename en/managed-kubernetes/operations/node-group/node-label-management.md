# Managing {{ k8s }} node labels

## Assigning {{ k8s }} labels when creating a node group {#node-group-creation}

You can add [{{ k8s }} labels](../../concepts/index.md#node-labels) to all {{ managed-k8s-name }} nodes in a [node group](../../concepts/index.md#node-group) at the same time. To do this, specify the labels using the `node_labels` parameter when [creating a {{ managed-k8s-name }} node group](../../operations/node-group/node-group-create.md).

1. Create a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster).

   You can use an existing {{ managed-k8s-name }} cluster or [create a new one](../kubernetes-cluster/kubernetes-cluster-create.md).

1. Create a node group with {{ k8s }} labels:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you created the {{ managed-k8s-name }} cluster.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
      1. Select the {{ managed-k8s-name }} cluster to create a node group for.
      1. On the {{ managed-k8s-name }} cluster page, go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
      1. Click **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}**.
      1. Enter a name for the {{ managed-k8s-name }} node group.
      1. In the **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}** field, select a {{ k8s }} version for {{ managed-k8s-name }} nodes.
      1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_scale }}**:
         * Select the scaling policy type.
         * Specify the number of nodes in the {{ managed-k8s-name }} node group.
      1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_deploy }}**, specify the maximum number of [instances](../../../compute/concepts/vm.md) by which you can exceed or reduce the size of the {{ managed-k8s-name }} group.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
         * Choose a [platform](../../../compute/concepts/vm-platforms.md).
         * Specify the required number of vCPUs, [guaranteed vCPU performance](../../../compute/concepts/performance-levels.md), and the amount of RAM.
      1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_disk }}**:
         * Specify the {{ managed-k8s-name }} node **{{ ui-key.yacloud.k8s.node-groups.create.field_disk-type }}**:
            * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-hdd }}`: Standard network drive; network block storage on an HDD.
            * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd }}`: Fast network drive; network block storage on an SSD.
            * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-nonreplicated }}`: Network drive with enhanced performance achieved by removing redundancy. You can only change the size of this type of disk in 93 GB increments.
            * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-io-m3 }}`: Network drive with the same performance characteristics as `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-nonreplicated }}`, plus redundancy. You can only change the size of this type of disk in 93 GB increments.
         * Specify the {{ managed-k8s-name }} node [disk](../../../compute/concepts/disk.md) size.
      1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_network }}**:
         * In the **{{ ui-key.yacloud.k8s.node-groups.create.field_address-type }}** field, choose a method for assigning an IP address:
            * `{{ ui-key.yacloud.k8s.node-groups.create.switch_auto }}`: Assign a random [IP address](../../../vpc/concepts/address.md) from the {{ yandex-cloud }} IP pool.
            * `{{ ui-key.yacloud.k8s.node-groups.create.switch_none }}`: Do not assign a public IP address.
         * Specify how {{ managed-k8s-name }} nodes should be distributed across the [availability zones](../../../overview/concepts/geo-scope.md) and [networks](../../../vpc/concepts/network.md#network).
      1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_access }}**, specify the information required to access the {{ managed-k8s-name }} node:
         * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
         * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../operations/node-connect-ssh.md#creating-ssh-keys) file.
      1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_maintenance }}**:
         * In the **{{ ui-key.yacloud.k8s.clusters.create.field_maintenance-window }}** field, select your preferred [maintenance](../../concepts/release-channels-and-updates.md#updates) window:
            * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-disabled }}`: Automatic updates disabled.
            * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-anytime }}`: Updates allowed at any time.
            * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-daily }}`: Updates will take place within the time interval specified in the **{{ ui-key.yacloud.k8s.clusters.create.field_maintenance-daily }}** field.
            * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-weekly }}`: Updates will take place within the time interval specified in the **{{ ui-key.yacloud.k8s.clusters.create.label_maintenance-weekly }}** field.
      1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_additional }}**:
         * In the **{{ ui-key.yacloud.k8s.node-groups.create.field_node-labels }}** field, click **{{ ui-key.yacloud.k8s.node-groups.create.button_add-node-label }}** and specify the label key and value. Add multiple labels if needed.
      1. Click **{{ ui-key.yacloud.common.create }}**.

   - CLI {#cli}

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
      id: catkuapro07e********
      cluster_id: abcsk1s2f3fm********
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
          subnet_id: e9bm87gkjd81********
      deploy_policy:
        max_expansion: "3"
      instance_group_id: cl1v2gh33j1c********
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

   - {{ TF }} {#tf}

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
             "<label_1>" = "<value_1>"
             "<label_2>" = "<value_2>"
             ...
           }
         }
         ```

      1. Make sure the configuration files are correct.

         {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

      1. Confirm updating the resources.

         {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

         For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

   - API {#api}

      To create a {{ managed-k8s-name }} node group, use the [create](../../api-ref/NodeGroup/create.md) method for the [NodeGroup](../../api-ref/NodeGroup/) resource.

   {% endlist %}

1. Get information about the created node group with {{ k8s }} labels:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where the {{ managed-k8s-name }} cluster was created.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
      1. Select the {{ managed-k8s-name }} cluster where the node group was created.
      1. On the {{ managed-k8s-name }} cluster page, go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
      1. Open the page of one of the {{ managed-k8s-name }} nodes and go to the **{{ ui-key.yacloud.k8s.node.overview.label_labels }}** tab. The tab lists the system and user {{ k8s }} node labels.

   - CLI {#cli}

      1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
      1. View all the nodes in a {{ managed-k8s-name }} cluster:

         ```bash
         kubectl get nodes
         ```

         Result:

         ```bash
         NAME                        STATUS   ROLES    AGE  VERSION
         catkuapro07e********-hgjd   Ready    <none>   1h   v1.17.8
         catkuapro07e********-lskc   Ready    <none>   1h   v1.17.8
         ```

      1. Get information on a selected {{ managed-k8s-name }} cluster node:

         ```bash
         kubectl describe node catkuapro07e********-hgjd
         ```

         Result:

         ```bash
         Name:               catkuapro07e********-hgjd
         Roles:              <none>
         Labels:             apps/tier=backend
                             beta.kubernetes.io/arch=amd64
                             beta.kubernetes.io/instance-type=standard-v2
                             beta.kubernetes.io/os=linux
                             environment=production
                             failure-domain.beta.kubernetes.io/zone={{ region-id }}-a
                             kubernetes.io/arch=amd64
                             kubernetes.io/hostname=catkuapro07e********-hgjd
                             kubernetes.io/os=linux
                             node.kubernetes.io/kube-proxy-ds-ready=true
                             node.kubernetes.io/masq-agent-ds-ready=true
                             node.kubernetes.io/node-problem-detector-ds-ready=true
                             yandex.cloud/node-group-id=catkuapro07e********
                             yandex.cloud/pci-topology=k8s
                             yandex.cloud/preemptible=false
         ```

   - API {#api}

      To view {{ managed-k8s-name }} node details, use the [list](../../api-ref/NodeGroup/list.md) method for the [NodeGroup](../../api-ref/NodeGroup/) resource.

   {% endlist %}

## Assigning a {{ k8s }} label for an existing node group {#assign-label}

Assigning {{ k8s }} labels does not result in recreation of a node group.

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To assign a {{ k8s }} label for an existing node group, run this command:

   ```bash
   {{ yc-k8s }} node-group add-node-labels \
      --id <node_group_ID> \
      --labels <key>=<value>, ...
   ```

   The command contains the following parameters:

   * `--id`: Node group ID. You can [get it with the list](node-group-list.md#list) of node groups in the {{ managed-k8s-name }} cluster.
   * `--labels`: {{ k8s }} labels in `<key>=<value>` format. You can specify one label or multiple labels separated by commas.

- {{ TF }} {#tf}

   To assign a {{ k8s }} label for an existing node group:

   1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

      For more information about creating this file, see [{#T}](node-group-create.md).

   1. In the node group description, add the `node_labels` section:

      ```hcl
      resource "yandex_kubernetes_node_group" "<node_group_name>" {
        ...
        node_labels {
          "<label_name>" = "<label_value>"
          ...
        }
        ...
      }
      ```

      You can assign multiple labels. To do so, specify each label in a separate line.

   1. Make sure the configuration files are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

   To assign a {{ k8s }} label to an existing node group, use the [update](../../api-ref/NodeGroup/update.md) method for the [NodeGroup](../../api-ref/NodeGroup/index.md) resource and provide the following in the request:

   * {{ k8s }} labels in the `nodeLabels` parameter.
   * `nodeLabels` parameter to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Deleting a {{ k8s }} label from a node group {#remove-label}

Deleting {{ k8s }} labels does not result in recreation of a node group.

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To remove a {{ k8s }} label from a node group, run this command:

   ```bash
   {{ yc-k8s }} node-group remove-node-labels \
      --id <node_group_ID> \
      --labels <label_key>, ...
   ```

   The command contains the following parameters:

   * `--id`: Node group ID. You can [get it with the list](node-group-list.md#list) of node groups in the {{ managed-k8s-name }} cluster.
   * `--labels`: Keys of the {{ k8s }} labels to remove. You can specify one label or multiple labels separated by commas.

- {{ TF }} {#tf}

   To remove a {{ k8s }} label from a node group:

   1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

      For more information about creating this file, see [{#T}](node-group-create.md).

   1. In the node group description, delete the {{ k8s }} labels you no longer need under `node_labels`.

   1. Make sure the configuration files are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

   To remove a {{ k8s }} label from a node group, use the [update](../../api-ref/NodeGroup/update.md) method for the [NodeGroup](../../api-ref/NodeGroup/index.md) resource and provide the following in the request:

   * New set of {{ k8s }} labels in the `nodeLabels` parameter. If you want to remove all the labels, provide `"nodeLabels": {}` in the request.
   * `nodeLabels` parameter to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

{% endlist %}
