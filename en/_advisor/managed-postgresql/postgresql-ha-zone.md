### Risk of data loss and cluster unavailability if an availability zone fails {#postgresql_ha_zone}

**Description**

All cluster hosts are in the same availability zone. In case the zone fails, the cluster becomes unavailable. Put replicas in different zones to ensure high availability.

{% include [one-host-cluster](../concept/one-host-cluster.md) %}

**Action**

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