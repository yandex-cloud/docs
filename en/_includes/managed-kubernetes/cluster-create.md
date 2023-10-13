1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).
1. Select **{{ managed-k8s-name }}**.
1. Click **Create cluster**.
1. Enter a name and description for the {{ managed-k8s-name }} cluster. The {{ managed-k8s-name }} cluster name must be unique within {{ yandex-cloud }}.
1. Specify a **service account for the resources**. This is used to create the resources.
1. Specify a **Service account for nodes**. The [{{ managed-k8s-name }} nodes](../../managed-kubernetes/concepts/index.md#node-group) use this service account to access the [{{ container-registry-full-name }}](../../container-registry/) [Docker image registry](../../container-registry/concepts/registry.md).
1. (Optional) Specify the **Encryption key** that will be used for [encrypting secrets](../../managed-kubernetes/concepts/encryption.md).

   {% include [write-once-settings](write-once-setting.md) %}

1. Specify a [release channel](../../managed-kubernetes/concepts/release-channels-and-updates.md). You cannot edit this setting after you create a {{ managed-k8s-name }} cluster.
1. Under **Master configuration**:
   * In the **{{ k8s }} version** field, select the {{ k8s }} version to be installed on the [{{ managed-k8s-name }} master](../../managed-kubernetes/concepts/index.md#master).
   * In the **Public IP** field, choose a method for assigning an [IP address](../../vpc/concepts/address.md):
      * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
      * **No address**: Do not assign a public IP address.
   * In the **Master type** field, select the {{ managed-k8s-name }} master type:
      * **Zonal**: Master created in a [subnet](../../vpc/concepts/network.md#subnet) in one [availability zone](../../overview/concepts/geo-scope.md).

      
      * **Regional**: Master created and distributed in three subnets in each availability zone.
   * Select the availability zone to create a {{ managed-k8s-name }} master in.

      This step is only available for the {{ managed-k8s-name }} zonal master.


   * In the **Cloud network** field, select the [network](../../vpc/concepts/network.md#network) to create the {{ managed-k8s-name }} master in. If there are no networks available, [create one](../../vpc/operations/network-create.md).

      {% include [note-another-catalog-network](note-another-catalog-network.md) %}

   * In the **Subnet** field, select the subnet to create the {{ managed-k8s-name }} master in. If there are no subnets available, [create one](../../vpc/operations/subnet-create.md).

      
      For the {{ managed-k8s-name }} regional master, specify a subnet in each availability zone.


   * Select [security groups](../../vpc/concepts/security-groups.md) for the {{ managed-k8s-name }} cluster's network traffic.

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
   * Specify the **cluster CIDR**, which is a range of IP addresses to allocate [pod](../../managed-kubernetes/concepts/index.md#pod) IPs from.
   * Specify the **service CIDR**, which is a range of IP addresses to allocate [service](../../managed-kubernetes/concepts/index.md#service) IPs from.
   * Set the {{ managed-k8s-name }} node subnet mask and the maximum number of pods per node.
1. Click **Create cluster**.