### Risk of data loss and cluster unavailability in the event of a zone failure {#mysql_ha_zone}

**Description**

All cluster hosts are in the same availability zone. In case the zone fails, the cluster becomes unavailable. Put replicas in different zones to ensure high availability.


{% include [one-host-cluster](../concept/one-host-cluster.md) %}

**Action**

To add a host to another zone:

1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Select the cluster and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
1. In the host parameters, specify an alternative availability zone.
1. Finish configuring the host and click **{{ ui-key.yacloud.mysql.hosts.dialog.button_choose }}**.