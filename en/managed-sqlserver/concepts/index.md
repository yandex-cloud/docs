---
title: "Relationship between {{ mms-name }} resources"
description: "The main entity operated by the {{ mms-name }} service is a database cluster. Each cluster consists of one or more database hosts — virtual machines with deployed DBMS servers. The cluster hosts can be located in different availability zones."
---

# Relationships between resources in {{ mms-name }}

The main entity used in {{ mms-name }} is a _database cluster_.

Each cluster consists of one or more _database hosts_, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones. [More about the geo scope of {{ yandex-cloud }}](../../overview/concepts/geo-scope.md).

* A cluster consisting of multiple hosts supports automatic failover, because the hosts can take over each other's functions as the cluster's primary replica.

* A single-host cluster is cheaper, but it doesn't guarantee fault tolerance.

VMs corresponding to cluster hosts can be hosted:

* On {{ yandex-cloud }} _standard hosts_.

    These are physical servers for hosting cluster VMs. They are randomly selected from a pool of available hosts that meet the selected cluster configuration.

* On {{ yandex-cloud }} _dedicated hosts_.

    These are physical servers that only host your VMs. These VMs provide for the operation of both the cluster and your other services that support dedicated hosts. Such hosts are selected from _dedicated host groups_ specified when creating a cluster.

    This placement option ensures physical isolation of VMs. A {{ mms-name }} cluster using dedicated hosts includes all the features of a regular cluster.

    For more information, see [{#T}](../../compute/concepts/dedicated-host.md).

When creating a cluster, specify:
* _Host class_: A VM template for deploying the cluster hosts. For a list of available host classes and their characteristics, see [{#T}](instance-types.md).

* _Environment_: The environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your apps.
   * `PRESTABLE`: For testing, including the {{ mms-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

* {{ MS }} _version_. A {{ mms-name }} cluster supports the following versions:

  * 2016 ServicePack 2.
  * 2017\.
  * 2019\.

  The following editions are supported for each version:

  * Standard Edition. Only available for single-host clusters.
  * Enterprise Edition.

  For a full list of limitations imposed by {{ mms-name }} on these cluster editions, see [{#T}](limits.md).

  For more information about the features of these editions, see the [{{ MS }} documentation]({{ ms.docs }}/sql/sql-server/editions-and-components-of-sql-server-2016?view=sql-server-ver15).

A database cluster created in a folder can be accessed by all VMs connected to the same cloud network. [Learn more about networking](../../vpc/).

{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}
