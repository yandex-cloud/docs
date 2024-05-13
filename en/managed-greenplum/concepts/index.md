# Resource relationships

The main entity used in the {{ mgp-name }} service is a _database cluster_.

Each cluster consists of database hosts, which are virtual machines with DBMS servers deployed on them. A {{ mgp-name }} cluster contains:

* Two _master hosts_.
* Two or more _segment hosts_.

The _primary_ master host (`PRIMARY`) accepts client connections and SQL queries and distributes them to the segment hosts for processing.

The _standby_ master host (`STANDBY`) continuously replicates the primary one's data but accepts no user connections.

If the primary master fails, the standby one takes over. This way, a cluster with two master hosts continues handling queries if a single master fails.

Segment hosts have standalone DBMS's (_segments_) deployed on them. They store data fragments and perform most operations for handling queries. Each cluster segment has a replica, i.e., a mirror segment that is located on another host and stores a copy of the data from the main segment.


All {{ mgp-name }} cluster hosts are located in a single availability zone: `{{ region-id }}-a`, `{{ region-id }}-b`, or `{{ region-id }}-d`. You cannot create hosts in `{{ region-id }}-c`, for it is being [discontinued](/blog/posts/2023/08/new-availability-zone). If you have hosts located in this availability zone, [restore your cluster from a backup](../operations/cluster-backups.md#restore). While restoring the cluster, specify a different availability zone.


VMs for cluster hosts can be hosted on:

* _Regular {{ yandex-cloud }} hosts_:

   These are physical servers for hosting cluster VMs. They are randomly selected from a pool of available hosts that meet the selected cluster configuration.


* _Dedicated {{ yandex-cloud }} hosts_:

   These are physical servers that only host your VMs. VMs on dedicated hosts have all features of regular VMs; additionally, they are physically isolated from other users' VMs.

   Dedicated hosts are selected from _dedicated host groups_ specified when creating a cluster.

   For more information, see [{#T}](../../compute/concepts/dedicated-host.md).


When creating a cluster, specify:

* _Host class_: Template for deploying cluster hosts. For a list of available host classes and their characteristics, see [Host classes](instance-types.md).

* _Environment_: Environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your apps.
   * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.

{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
