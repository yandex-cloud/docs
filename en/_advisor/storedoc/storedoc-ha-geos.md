### Risk of data loss and cluster unavailability in the event of a zone failure {#storedoc_ha_geos}

**Description**

The current distribution of cluster hosts does not ensure fault protection in a single availability zone. Distribute replicas across different zones to ensure high availability.

{% include [one-host-cluster](../concept/one-host-cluster.md) %}

**Action**

To add a host to a different zone:

1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Select the cluster and open the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
1. In the host settings, specify an alternative availability zone.
1. Finish configuring the host and click **{{ ui-key.yacloud.redis.hosts.dialog.button_choose }}**.