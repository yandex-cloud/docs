# Maintenance

Maintenance means:

* Automatic installation of DBMS updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

Maintenance is performed as follows:

1. [Segment hosts](index.md) undergo maintenance consecutively. The hosts are queued randomly. A host segment becomes unavailable for the time it's restarted during maintenance.
1. Maintenance is performed on a standby master host. A standby master host becomes unavailable while it's being restarted during maintenance.
1. Maintenance is performed on a primary master host. If it's restarted during maintenance and becomes unavailable, the standby master host assumes its role. If you access the cluster using the FQDN or IP address of the primary master host, such a cluster may become unavailable. To make your application continuously available, access the cluster using a [special FQDN](../operations/connect.md#fqdn-master) always pointing to the primary master host.
