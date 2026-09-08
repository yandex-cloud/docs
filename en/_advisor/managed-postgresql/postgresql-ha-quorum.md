### Risk of data loss and cluster unavailability in the event of a zone failure (quorum) {#postgresql_ha_quorum}

**Description**

Your current configuration allows the replication quorum to be met entirely within a single availability zone. If this zone becomes unavailable, you may lose your data. Increase the host count in other zones or make sure the quorum number is larger than the number of hosts in any single zone.

**Action**

To add a host to another zone:

1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Select the cluster and open the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
1. In the host parameters, specify an alternative availability zone.
1. Finish configuring the host and click **{{ ui-key.yacloud.postgresql.hosts.dialog.button_choose }}**.

To move a host to a different availability zone:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the target availability zone for the host.
1. Add a host to your cluster: [navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Click the cluster name and navigate to the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.
1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
1. Specify the following host settings:

    * Target availability zone for your hosts.
    * New subnet.
    * To make the host accessible from outside {{ yandex-cloud }}, select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

To learn more about the replication quorum, see [Replication in {{ mpg-name }}](../../managed-postgresql/concepts/replication.md).