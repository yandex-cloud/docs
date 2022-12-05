# Maintenance in {{ mkf-name }}

Maintenance means:

* Automatic installation of {{ KF }} updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

Maintenance includes changes within one {{ KF }} major version. For more information about major version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the preferred maintenance time when [creating a cluster](../operations/cluster-create.md) or updating [its settings](../operations/cluster-update.md):

* **Unspecified time** (default): Maintenance is possible at any time.
* **By schedule**: Set the preferred maintenance start time: desired day of the week and UTC hour. For example, you can choose a time when cluster load is lightest.

## Maintenance procedure {#maintenance-order}

In {{ mkf-name }} single-host clusters, a single [broker host](brokers.md) undergoes maintenance. So, such a cluster becomes unavailable if a single host needs to be restarted during maintenance.

In multi-host clusters, broker hosts undergo maintenance consecutively. The hosts are queued randomly. A broker host becomes unavailable while it's being restarted during maintenance.
