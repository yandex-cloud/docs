### Risk of data loss and cluster unavailability in the event of a zone (replica) failure {#mysql_ha_replics}

**Description**

The cluster uses only asynchronous replicas, which does not guarantee fault tolerance. Add at least one synchronous replica to another zone to ensure high availability.

**Action**

To migrate hosts from one availability zone to another, do the following:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the target availability zone for the hosts.
1. Add a host to your cluster: [navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
1. Click ![image](../../_assets/console-icons/plus.svg) {{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}.
1. Specify the following host settings:

    * Target availability zone for your hosts.
    * New subnet.
    * To make the host accessible from outside {{ yandex-cloud }}, select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.
1. Delete the hosts in the source availability zone.
