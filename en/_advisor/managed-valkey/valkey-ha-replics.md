### Risk of data loss and cluster unavailability in the event of a zone (replica) failure {#valkey_ha_replics}

**Description**

Your shards have no replicas, posing a risk of data loss and cluster unavailability. For high availability, make sure the specified shards have replicas in another zone.

**Action**

To add a host to a different zone:

1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
1. Select the cluster and open the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
1. In the host settings, specify an alternative availability zone.
1. Finish configuring the host and click **{{ ui-key.yacloud.redis.hosts.dialog.button_choose }}**.