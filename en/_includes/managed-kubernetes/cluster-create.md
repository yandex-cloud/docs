1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster{{ k8s }}.
1. Select **{{ managed-k8s-name }}**.
1. Click **Create cluster**.
1. Enter a name and description for the {{ k8s }} cluster. The cluster name must be unique within {{ yandex-cloud }}.
1. Specify a **service account for the resources**. This is used to create the resources.
1. Specify a **service account for nodes**. The nodes use this service account to access the [Docker image registry](../../container-registry/concepts/registry.md).
1. (Optional) Specify the **Encryption key** that will be used for [encrypting secrets](../../managed-kubernetes/concepts/encryption.md).

   {% include [write-once-settings](write-once-setting.md) %}

1. Specify a [release channel](../../managed-kubernetes/concepts/release-channels-and-updates.md). You cannot edit this setting after you create a cluster.
1. Under **Master configuration**:
   * In the **{{ k8s }} version** field, select the {{ k8s }} version to be installed on the master.
   * In the **Public IP** field, choose a method for assigning an IP address:
      * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
      * **No address**: Don't assign a public IP address.
   * In the **Master type** field, select the type of master:
      * **Zonal**: A master created in a subnet in one availability zone.

      {% if product == "yandex-cloud" %}

      * **Regional**: A master created and distributed in three subnets in each availability zone.
   * Select the [availability zone](../../overview/concepts/geo-scope.md) to create a [master](../../managed-kubernetes/concepts/index.md#master) in.

      This step is only available for the zonal master.

      {% endif %}

   * In the **Cloud network** field, select the network to create the master on. If there aren't any networks, [create one](../../vpc/operations/network-create.md).
   * In the **Subnet** field, select the subnet to create the master in. If aren't any subnets, [create one](../../vpc/operations/subnet-create.md).

      {% if product == "yandex-cloud" %}

      For the regional master, specify a subnet in each availability zone.

      {% endif %}

   * Select security groups to control the cluster's network traffic.

      {% include [security-groups-alert](security-groups-alert.md) %}

1. Under **Maintenance window settings**:
   * In the **Maintenance frequency / Disable** field, configure the maintenance window:
      * **Disabled**: Automatic updates are disabled.
      * **Anytime**: Maintenance is allowed at any time.
      * **Daily**: Maintenance is performed in the time interval specified in the **Time (UTC) and duration** field.
      * **On selected days**: Maintenance is performed in the time interval specified in the **Weekly schedule** field.
1. Under **Cluster network settings**:
   * (optional) Select the [network policy controller](../../managed-kubernetes/concepts/network-policy.md#policy-controllers):
      * **Enable network policies** to activate Calico.
      * **Enable tunneling mode** to use Cilium.
   * Specify the **cluster CIDR**, which is a range of IP addresses for allocating pod addresses.
   * Specify the **service CIDR**, which is a range of IP addresses for allocating service addresses.
   * Set the node subnet mask and the maximum number of pods in a node.
1. Click **Create cluster**.