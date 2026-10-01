### Risk of data loss and cluster unavailability if an availability zone fails {#clickhouse_ha_shard}

**Description**

* The shard has no replicas, which poses a risk of data loss and cluster unavailability. Make sure the specified shards have replicas in another zone.
* The current distribution of shard hosts does not ensure fault protection in a single availability zone. Make sure the replicas are distributed across different availability zones.

**Action**

To move {{ CH }} hosts:

1. In the [management console]({{ link-console-main }}), select the folder containing the cluster.
1. [Navigate]({{ link-console-main }}/link/managed-clickhouse) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
1. Specify the following host settings:

    * Target availability zone for your hosts.
    * New subnet.
    * To make the host accessible from outside {{ yandex-cloud }}, select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

For more information, see [this host migration guide](../../managed-clickhouse/operations/host-migration.md).