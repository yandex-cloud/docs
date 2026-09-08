### Risk of data loss and cluster unavailability in the event of a zone failure (quorum) {#mysql_ha_quorum}

**Description**

The number of hosts required to confirm a transaction is less than the maximum number of hosts per availability zone. To avoid data loss in case the zone fails, replace the `Rpl semi sync master wait for slave count` [value](../../managed-mysql/concepts/settings-list.md#setting-rpl-wait-slave-count) with one larger than the number of host per availability zone, or migrate some of the hosts to other availability zones.

**Action**

To migrate hosts from one availability zone to another, do the following:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the target availability zone for the hosts.
1. Add a host to your cluster: [navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
1. Specify the following host settings:

    * Target availability zone for your hosts.
    * New subnet.
    * To make the host accessible from outside {{ yandex-cloud }}, select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.
1. Delete the hosts in the source availability zone.

To change the `Rpl semi sync master wait for slave count` [value](../../managed-mysql/concepts/settings-list.md#setting-rpl-wait-slave-count):

1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
1. Change the setting by clicking **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** under **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
1. Save your changes.

For more on the quorum setting, see [{{ MY }} settings](../../managed-mysql/concepts/settings-list.md#setting-rpl-wait-slave-count).