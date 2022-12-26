# Relationships between service resources

The main entity used in {{ mgp-name }} is a _database cluster_.

Each cluster consists of database hosts, which are virtual machines with DBMS servers deployed on them. A {{ mgp-name }} cluster contains:

* Two _master hosts_.
* Two or more _segment hosts_.

One of the master hosts is _PRIMARY_ and the other _STANDBY_. The primary master host accepts client connections and SQL queries and distributes them across segment hosts. The standby master host continuously replicates the primary's data and doesn't accept any user connections. A cluster with two master hosts continues to handle queries if one of them fails.

Standalone DBMS (_segments_) are deployed on segment hosts. They store data fragments and perform most operations for handling queries. Each cluster segment has one replica, a mirror segment that is located on another host and stores a copy of the data from the main segment.


All hosts in the {{ mgp-name }} cluster are located in a single availability zone: `{{ region-id }}-a` or `{{ region-id }}-b`. You can't create hosts in the `{{ region-id }}-c` zone. For more information, see [{#T}](../../overview/concepts/geo-scope.md) and [{#T}](../../overview/concepts/ru-central1-c-deprecation.md).


VMs corresponding to cluster hosts can be hosted:

* On {{ yandex-cloud }} _standard hosts_.

   These are physical servers for hosting cluster VMs. They are randomly selected from a pool of available hosts that meet the selected cluster configuration.


* On {{ yandex-cloud }} _dedicated hosts_.

   These are physical servers that only host your VMs. These VMs provide for the operation of both the cluster and your other services that support dedicated hosts. Such hosts are selected from _dedicated host groups_ specified when creating a cluster.

   This placement option ensures physical isolation of VMs. A {{ mgp-name }} cluster using dedicated hosts includes all the features of a regular cluster.

   For more information, see [{#T}](../../compute/concepts/dedicated-host.md).


When creating a cluster, specify:

* _Host class_: A VM template for deploying the cluster hosts. For a list of available classes and their characteristics, see [{#T}](instance-types.md).

* _Environment_: The environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your apps.
   * `PRESTABLE`: For testing, including the {{ mgp-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
