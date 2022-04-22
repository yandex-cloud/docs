# Managing {{ k8s }} cluster node labels

You can add labels to all nodes in a node group at the same time. To do this, specify a set of labels using the `node_labels` parameter when creating a node group.

1. Create a {{ k8s }} cluster.

   You can use an existing {{ k8s }} cluster or create a new one.

   {% cut "How to create a cluster" %}

   {% list tabs %}

   - Management console

     {% include [create-cluster](../../../_includes/managed-kubernetes/cluster-create.md) %}

   - CLI

     {% include [cli-install](../../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

     Create a {{ k8s }} cluster:

     ```bash
     yc managed-kubernetes cluster create \
       --name k8s-labels \
       --service-account-name k8s \
       --node-service-account-name docker \
       --zone ru-central1-a \
       --network-name k8s-labels
     ```

     Where:
     * `--name`: The {{ k8s }} cluster name.
     * `--service-account-id`: The unique ID of the service account for the resources. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
     * `--node-service-account-id`: The unique ID of the service account for the nodes. Nodes will download the Docker images they require from the registry on behalf of this account.
     * `--zone`: Availability zone.
     * `--network-name`: Name of the network.

     Command output:

     ```bash
     done (6m9s)
     id: abcsk1s2f3fmb5h0pd94
     folder_id: d4f56ga82mev0cljderg
     created_at: "2020-09-24T13:20:45Z"
     name: k8s-labels
     status: RUNNING
     health: HEALTHY
     network_id: higph7rfondivd8jflu9
     master:
      zonal_master:
        zone_id: ru-central1-a
        internal_v4_address: 10.0.0.32
      version: "1.16"
      endpoints:
        internal_v4_endpoint: https://10.0.0.32
      master_auth:
        cluster_ca_certificate: |
          -----BEGIN CERTIFICATE-----
          MIICyDCCAbCgAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl
          ...
          piOjXzqDCLzCkfFuNimHejsSvVFN4N1bYYBCBMkhaYDzV5Ypfy/Jy0aHJ9U=
          -----END CERTIFICATE-----
      version_info:
        current_version: "1.16"
      maintenance_policy:
        auto_upgrade: true
        maintenance_window:
          anytime: {}
     ip_allocation_policy:
      cluster_ipv4_cidr_block: 10.112.0.0/16
      node_ipv4_cidr_mask_size: "24"
      service_ipv4_cidr_block: 10.96.0.0/16
     service_account_id: ajedclfluactb5868n99
     node_service_account_id: ajeo8f063dmnicot7t7j
     release_channel: REGULAR
     ```

   - API

     To create a {{ k8s }} cluster, use the [create](../../api-ref/Cluster/create.md) method for a [Cluster](../../api-ref/Cluster/) resource.

   {% endlist %}

   {% endcut %}

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
        * Specify the required number of vCPUs, [guaranteed vCPU performance](../../../compute/concepts/performance-levels.md), and RAM.
     1. Under **Storage**:
        * Specify the **Disk type**:
          * **HDD**: Standard network drive. Network block storage on an HDD.
          * **SSD**: Fast network drive. Network block storage on an SSD.
         * Specify the disk size.
     1. Under **Network settings**:
        * In the **Public IP** field, choose a method for assigning an IP address:
          * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
          * **No address**: Don't assign a public IP address.
        * Specify how nodes should be distributed across availability zones and networks.
     1. Under **Access**, specify the information required to access the node:
        * Enter the username in the **Login** field.
        * In the **SSH key** field, paste the contents of the [public key file](../../operations/node-connect-ssh.md#creating-ssh-keys).
     1. Under **Maintenance window settings**:
        * In the **Maintenance frequency / Disable** field, choose the maintenance window:
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
     * `--name`: Name of the node group.
     * `--cluster-name`: Name of the {{ k8s }} cluster where the node group is created.
     * `--disk-type`: The type of the disk on the node.
     * `--fixed-size`: Number of nodes in the group.
     * `--node-labels`: Node labels. You can specify multiple labels separated by commas.

     Command output:

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
       - zone_id: ru-central1-a
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

     Command output:

     ```bash
     NAME                        STATUS   ROLES    AGE  VERSION
     catkugtyu07enihqmk51-hgjd   Ready    <none>   1h   v1.17.8
     catkugtyu07enihqmk51-lskc   Ready    <none>   1h   v1.17.8
     ```

     1. Get information on a selected {{ k8s }} cluster node:

     ```bash
     kubectl describe node catkugtyu07enihqmk51-hgjd
     ```

     Command output:

     ```bash
     Name:               catkugtyu07enihqmk51-hgjd
     Roles:              <none>
     Labels:             apps/tier=backend
                         beta.kubernetes.io/arch=amd64
                         beta.kubernetes.io/instance-type=standard-v2
                         beta.kubernetes.io/os=linux
                         environment=production
                         failure-domain.beta.kubernetes.io/zone=ru-central1-a
                         kubernetes.io/arch=amd64
                         kubernetes.io/hostname=catkugtyu07enihqmk51-hgjd
                         kubernetes.io/os=linux
                         node.kubernetes.io/kube-proxy-ds-ready=true
                         node.kubernetes.io/masq-agent-ds-ready=true
                         node.kubernetes.io/node-problem-detector-ds-ready=true
                         yandex.cloud/node-group-id=catkugtyu07enihqmk51
                         yandex.cloud/pci-topology=k8s
                         yandex.cloud/preemptible=false
     ```

   - API

     To view information about the node, use the [list](../../api-ref/NodeGroup/list.md) method for the [NodeGroup](../../api-ref/NodeGroup/) resource.

   {% endlist %}