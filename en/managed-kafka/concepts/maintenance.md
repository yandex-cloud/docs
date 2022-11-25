# Maintenance in {{ mkf-name }}

Maintenance means:

* Automatic installation of {{ KF }} updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

Maintenance includes changes within one {{ KF }} version. For more information about version changes, see [{#T}](../operations/cluster-version-update.md).

In {{ mkf-name }} single-host clusters, a single [broker host](brokers.md) undergoes maintenance. So, such a cluster becomes unavailable if a single host needs to be restarted during maintenance.

In multi-host clusters, broker hosts undergo maintenance consecutively. The hosts are queued randomly. A broker host becomes unavailable while it's being restarted during maintenance.
