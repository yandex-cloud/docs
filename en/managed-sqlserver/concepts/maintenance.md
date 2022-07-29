# Maintenance

Maintenance means:

* Automatic installation of DBMS updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

In {{ mms-name }} single-host clusters, a [primary replica](replication.md) undergoes maintenance. So, such a cluster becomes unavailable if a primary replica needs to be restarted during maintenance.

In multi-host clusters, the maintenance procedure is as follows:

1. Secondary replicas undergo maintenance consecutively. The replicas are queued randomly. A secondary replica becomes unavailable while it's being restarted during maintenance.
1. A primary replica undergoes maintenance and gets updated. If it's restarted during maintenance and becomes unavailable, one of the secondary replicas assumes its role. If you access the cluster using the FQDN or IP address of the primary replica, such a cluster may become unavailable. To make your application continuously available, access the cluster using a [special FQDN](../operations/connect.md#special-fqdns) always pointing to the primary replica.
