# Maintenance in {{ mos-name }}

Maintenance means:

* Automatic installation of {{ OS }} updates and revisions for host groups (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

Maintenance includes changes within one {{ OS }} version. 

In {{ mos-name }} single-host clusters, a single host undergoes maintenance. So, such a cluster becomes unavailable if a single host needs to be restarted during maintenance.

In multi-host clusters, hosts undergo maintenance consecutively. The hosts are queued randomly. If a host needs to be restarted during maintenance, it becomes unavailable while it's being restarted. If you access the cluster using the FQDN or IP address of the {{ OS }} host, such a cluster may become unavailable. To make your application continuously available, access the cluster using a [special FQDN](../operations/connect.md#special-fqdns) always pointing to the available host.
