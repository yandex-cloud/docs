# Maintenance

Maintenance means:

* Automatic installation of {{ ES }} updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

Maintenance includes changes within one {{ ES }} version. For more information about version changes, see [{#T}](../operations/cluster-version-update.md).

In single-host {{ mes-name }} clusters, a single host with the [_Data node_ role](./hosts-roles.md#data-node) undergoes maintenance. So, such a cluster becomes unavailable if a single host needs to be restarted during maintenance.

In multi-host clusters, hosts with the _Data node_ role undergo maintenance consecutively. The hosts are queued randomly. If a host needs to be restarted during maintenance, it becomes unavailable while it's being restarted. If you access the cluster using the FQDN or IP address of the {{ ES }} host, such a cluster may become unavailable. To make your application continuously available, access the cluster using a [special FQDN](../operations/cluster-connect.md#automatic-host-selection) always pointing to the available host.
