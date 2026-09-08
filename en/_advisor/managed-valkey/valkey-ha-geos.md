### Risk of data loss and cluster unavailability in the event of a zone failure {#valkey_ha_geos}

**Description**

The current distribution of cluster hosts does not ensure fault protection in a single availability zone. Put replicas in different zones to ensure high availability.

{% include [one-host-cluster](../concept/one-host-cluster.md) %}

**Action**

To migrate hosts from one availability zone to another, add hosts in the target availability zone to the cluster and delete hosts from the source availability zone:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the target availability zone for the hosts.
1. If your cluster uses the `b2.medium` or `b3-c1-m4` [host class](../../managed-valkey/concepts/instance-types.md#available-flavors), change it. Otherwise, you will not be able to add hosts to the cluster and perform migration.

   The cluster is unavailable for about five to seven minutes after changing the host class.

   You can revert to the previous host class after the migration is complete.

1. Add a host to your cluster: [Navigate]({{ link-console-main }}/link/managed-valkey) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
1. Click ![image](../../_assets/console-icons/plus.svg) {{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}.
1. Specify the following host settings:

    * Target availability zone for your hosts.
    * New subnet.
    * To make the host accessible from outside {{ yandex-cloud }}, select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**. 
1. Delete the hosts in the source availability zone.
