1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click **{{ ui-key.yacloud.k8s.clusters.button_create }}**.
1. Enter a name and description for the {{ managed-k8s-name }} cluster. The {{ managed-k8s-name }} cluster name must be unique within {{ yandex-cloud }}.
1. Specify a **{{ ui-key.yacloud.k8s.clusters.create.field_service-account }}** to be used to create your resources.
1. Specify a **{{ ui-key.yacloud.k8s.clusters.create.field_node-service-account }}** to be used by the [{{ managed-k8s-name }} nodes](../../managed-kubernetes/concepts/index.md#node-group) to access the [{{ container-registry-full-name }}](../../container-registry/) [Docker image registry](../../container-registry/concepts/registry.md).
1. (Optional) Specify the **{{ ui-key.yacloud.k8s.clusters.create.field_kms-key }}** that will be used for [encrypting secrets](../../managed-kubernetes/concepts/encryption.md).

   {% include [write-once-settings](write-once-setting.md) %}

1. Specify a [release channel](../../managed-kubernetes/concepts/release-channels-and-updates.md). You cannot edit this setting after you create a {{ managed-k8s-name }} cluster.
1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}**:
   * In the **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}** field, select the {{ k8s }} version to be installed on the [{{ managed-k8s-name }} master](../../managed-kubernetes/concepts/index.md#master).
   * In the **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}** field, choose a method for [IP address](../../vpc/concepts/address.md) assignment:
      * `{{ ui-key.yacloud.k8s.clusters.create.switch_auto }}`: Assign a random IP address from the {{ yandex-cloud }} IP pool.
      * `{{ ui-key.yacloud.k8s.clusters.create.switch_none }}`: Do not assign a public IP address.
   * In the **{{ ui-key.yacloud.k8s.clusters.create.field_master-type }}** field, select the {{ managed-k8s-name }} master type:
      * `{{ ui-key.yacloud.k8s.clusters.create.switch_zone }}`: Master created in a [subnet](../../vpc/concepts/network.md#subnet) in one [availability zone](../../overview/concepts/geo-scope.md).


      * `{{ ui-key.yacloud.k8s.clusters.create.switch_region }}`: Master created and distributed in three subnets in each availability zone.
      * Select the availability zone to create a {{ managed-k8s-name }} master in.

      This step is only available for the {{ managed-k8s-name }} zonal master.


   * In the **{{ ui-key.yacloud.k8s.clusters.create.field_network }}** field, select the [network](../../vpc/concepts/network.md#network) to create a {{ managed-k8s-name }} master in. If there are no networks available, [create one](../../vpc/operations/network-create.md).

      {% include [note-another-catalog-network](note-another-catalog-network.md) %}

   * In the **{{ ui-key.yacloud.k8s.clusters.create.field_subnetwork }}** field, select the subnet to create a {{ managed-k8s-name }} master in. If there are no subnets available, [create one](../../vpc/operations/subnet-create.md).


      For the {{ managed-k8s-name }} regional master, specify a subnet in each availability zone.


   * Select [security groups](../../vpc/concepts/security-groups.md) for the {{ managed-k8s-name }} cluster's network traffic.

      {% include [security-groups-alert](security-groups-alert.md) %}

1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_maintenance }}**:
   * In the **{{ ui-key.yacloud.k8s.clusters.create.field_maintenance-window }}** field, configure the maintenance window:
      * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-disabled }}`: Automatic updates disabled.
      * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-anytime }}`: Updates allowed at any time.
      * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-daily }}`: Updates will take place within the time interval specified in the **{{ ui-key.yacloud.k8s.clusters.create.field_maintenance-daily }}** field.
      * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-weekly }}`: Updates will take place within the time interval specified in the **{{ ui-key.yacloud.k8s.clusters.create.label_maintenance-weekly }}** field.
1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_allocation }}**:
   * (Optional) Select the [network policy controller](../../managed-kubernetes/concepts/network-policy.md#policy-controllers):
      * **{{ ui-key.yacloud.k8s.clusters.create.field_network-policy }}** to use Calico.
      * **{{ ui-key.yacloud.k8s.clusters.create.field_tunnel-mode }}** to use Cilium.
   * Specify the **{{ ui-key.yacloud.k8s.clusters.create.field_cluster-cidr }}**, which is a range of IP addresses to allocate [pod](../../managed-kubernetes/concepts/index.md#pod) IPs from.
   * Specify the **{{ ui-key.yacloud.k8s.clusters.create.field_service-cidr }}**, which is a range of IP addresses to allocate [service](../../managed-kubernetes/concepts/index.md#service) IPs from.
   * Set the {{ managed-k8s-name }} node subnet mask and the maximum number of pods per node.
1. Click **{{ ui-key.yacloud.common.create }}**.
