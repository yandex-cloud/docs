1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click **{{ ui-key.yacloud.k8s.clusters.button_create }}**.
1. Enter a name and description for your {{ managed-k8s-name }} cluster. The {{ managed-k8s-name }} cluster name must be unique within {{ yandex-cloud }}.
1. Specify a **{{ ui-key.yacloud.k8s.clusters.create.field_service-account }}** to be used to create your resources.
1. Specify a **{{ ui-key.yacloud.k8s.clusters.create.field_node-service-account }}** to be used by the [{{ managed-k8s-name }} nodes](../../managed-kubernetes/concepts/index.md#node-group) to access the [{{ container-registry-full-name }}](../../container-registry/) [Docker image registry](../../container-registry/concepts/registry.md).
1. (Optional) Specify the **{{ ui-key.yacloud.k8s.clusters.create.field_kms-key }}** that will be used for [encrypting secrets](../../managed-kubernetes/concepts/encryption.md).

   {% include [write-once-settings](write-once-setting.md) %}

1. Specify a [release channel](../../managed-kubernetes/concepts/release-channels-and-updates.md).

   {% include [write-once-settings](write-once-setting.md) %}

1. Add [cloud labels](../../managed-kubernetes/concepts/index.md#cluster-labels) in the **{{ ui-key.yacloud.component.label-set.label_labels }}** field.

1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}**:
   * (Optional) Expand the **Compute resources** section and select a [resource configuration](../../managed-kubernetes/concepts/index.md#master-resources) for the master.

     {% include [master-default-config](../../_includes/managed-kubernetes/master-default-config.md) %}

     To allow further changes to the master's resource configuration, select **Allow resource volume to increase in response to loads**.

     {% include [master-config-preview-note](../../_includes/managed-kubernetes/master-config-preview-note.md) %}

   * In the **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}** field, select the {{ k8s }} version to be installed on the [{{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master) master.
   * In the **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}** field, select an [IP address](../../vpc/concepts/address.md) assignment method:
     * `{{ ui-key.yacloud.k8s.clusters.create.switch_auto }}`: Assign a random IP address from the {{ yandex-cloud }} IP pool.
     * `{{ ui-key.yacloud.k8s.clusters.create.switch_none }}`: Not to assign a public IP address.

     {% include [nat-instance-restriction](nat-instance-restriction.md) %}

     {% include [write-once-settings](write-once-setting.md) %}

   * In the **{{ ui-key.yacloud.k8s.clusters.create.field_master-type }}** field, select the {{ managed-k8s-name }} master type:
     * `Basic`: Contains one master host in one availability zone. This type of master is cheaper but not fault-tolerant. Its former name is _zonal_.

       {% note warning %}

       {% include [base-zonal-pricing](../../_includes/managed-kubernetes/base-zonal-pricing.md) %}

       {% endnote %}

     * `Highly available`: Contains three master hosts. Its former name is _regional_.

       {% note warning %}

       {% include [ha-regional-pricing](../../_includes/managed-kubernetes/ha-regional-pricing.md) %}

       {% endnote %}

   * In the **{{ ui-key.yacloud.k8s.clusters.create.field_network }}** field, select the [network](../../vpc/concepts/network.md#network) to create a {{ managed-k8s-name }} master in. If there are no networks available, [create one](../../vpc/operations/network-create.md).

      {% include [note-another-catalog-network](note-another-catalog-network.md) %}

   * For a highly available master, select master host placement in the **Distribution of masters by availability zone** field:
     * `One zone`: In one availability zone and one subnet. This is a good choice of master if you want to ensure high availability of the cluster and reduce network latency within it.
     * `Different zones`: In three different availability zones. This master ensures the greatest fault tolerance: if one zone becomes unavailable, the master will remain operational.

   * Depending on the type of master you select:
     * For a basic or highly available master in a single zone, specify the availability zone and subnet. 
     * For a highly available master in different zones, specify subnets in each zone. 

     If there are no subnets, [create](../../vpc/operations/subnet-create.md) them.

     {% note warning %}

     You cannot change the master type and location after you create a cluster.

     {% endnote %}

   * Select [security groups](../../vpc/concepts/security-groups.md) for the {{ managed-k8s-name }} cluster's network traffic.

     {% include [security-groups-alert](security-groups-alert.md) %}

1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_maintenance }}**:
   * In the **{{ ui-key.yacloud.k8s.clusters.create.field_maintenance-window }}** field, configure the maintenance window:
     * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-disabled }}`: Automatic updates disabled.
     * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-anytime }}`: Updates allowed at any time.
     * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-daily }}`: Updates will take place within the time interval specified in the **{{ ui-key.yacloud.k8s.clusters.create.field_maintenance-daily }}** field.
     * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-weekly }}`: Updates will take place within the time interval specified in the **{{ ui-key.yacloud.k8s.clusters.create.label_maintenance-weekly }}** field.
1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_allocation }}**:
   * (Optional) Select [the network policy controller](../../managed-kubernetes/concepts/network-policy.md#policy-controllers):

     {% include [write-once-setting](write-once-setting.md) %}

     {% include [calico-cilium-mutual-exclusion](calico-cilium-mutual-exclusion.md) %}

     * **{{ ui-key.yacloud.k8s.clusters.create.field_network-policy }}** to use Calico.
     * **{{ ui-key.yacloud.k8s.clusters.create.field_tunnel-mode }}** to use Cilium.


   * Specify the **{{ ui-key.yacloud.k8s.clusters.create.field_cluster-cidr }}**, which is a range of IP addresses to allocate [pod](../../managed-kubernetes/concepts/index.md#pod) IPs from.
   * Specify the **{{ ui-key.yacloud.k8s.clusters.create.field_service-cidr }}**, which is a range of IP addresses to allocate [service](../../managed-kubernetes/concepts/index.md#service) IPs from.
   * Set the {{ managed-k8s-name }} node subnet mask and the maximum number of pods per node.
1. Click **{{ ui-key.yacloud.common.create }}**.