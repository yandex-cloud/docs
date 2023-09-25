# Maintenance in {{ mgp-name }}

Maintenance means:

* Automatic installation of DBMS updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

## Maintenance window {#maintenance-window}

You can set the preferred maintenance time when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/update.md):

* **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** (default): Maintenance can be performed at any time.
* **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}**: Set the preferred maintenance start time, i.e., the day and time (UTC) you want to perform maintenance at. For example, you can choose a time window when the cluster is least loaded.

## Maintenance procedure {#maintenance-order}

Maintenance is performed as follows:

1. [Segment hosts](index.md) undergo maintenance one by one. The hosts are queued randomly. If a segment host needs to be restarted during maintenance, it becomes unavailable while being restarted.
1. Maintenance is performed on the `STANDBY` master host. If it needs to be restarted during maintenance, it becomes unavailable while being restarted.
1. Maintenance is performed on the `PRIMARY` master host. If it is restarted during maintenance and becomes unavailable, the standby master host will take its role. If you access a cluster using the FQDN of the primary master host, the cluster may become unavailable. To make your application continuously available, access the cluster using a [special FQDN](../operations/connect.md#fqdn-master) always pointing to the primary master host.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
