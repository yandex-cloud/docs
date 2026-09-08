### Risk of data loss and cluster unavailability in the event of a zone (replica) failure {#storedoc_ha_replics}

**Description**

Your shards have no replicas, posing a risk of data loss and cluster unavailability. To ensure high availability, add replicas in a different zone for the specified shards.

**Action**

To migrate hosts from one availability zone to another, do the following:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the target availability zone for the hosts.
1. Add a host to the cluster: in the [management console]({{ link-console-main }}), select a folder.
1. [Navigate]({{ link-console-main }}/link/storedoc) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Locate the {{ mmg-name }} cluster you need in the list, click its name, and select the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
1. Specify the following host settings:

    * Target availability zone for your hosts.
    * New subnet.
    * To make the host accessible from outside {{ yandex-cloud }}, select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.
1. Delete the hosts in the source availability zone.