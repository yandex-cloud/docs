---
title: "Relationship between {{ mms-name }} resources"
description: "The main entity operated by the {{ mms-name }} service is a database cluster. Each cluster consists of one or more database hosts — virtual machines with deployed DBMS servers. The cluster hosts can be located in different availability zones."
---

# Relationship between resources in {{ mms-name }}

The main entity used in {{ mms-name }} is a _database cluster_.

Each cluster consists of one or more _database hosts_, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones. [More about the geo scope of {{ yandex-cloud }}](../../overview/concepts/geo-scope.md).

* A cluster consisting of multiple hosts has automatic failover, because the hosts can take over each other's functions as the cluster's primary replica.

* A single-host cluster is cheaper, but it doesn't guarantee fault tolerance.

When creating a cluster, specify:

* _Host class_: A VM template for deploying the cluster hosts. For a list of available host classes and their characteristics, see [{#T}](instance-types.md).

* _Environment_: The environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your apps.
   * `PRESTABLE`: For testing, including the {{ mms-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

* {{ MS }} _version_.

  {{ mms-name }} clusters support `2016 ServicePack 2` for the following editions:

  * Standard Edition.

    This edition is only available for single-host clusters.

  * Enterprise Edition.

  For the full list of limitations imposed by {{ mms-name }} on the clusters of these editions, see [{#T}](limits.md).

  For more information about editions, see the [documentation for {{ MS }}](https://docs.microsoft.com/en-us/sql/sql-server/editions-and-components-of-sql-server-2016?view=sql-server-ver15).

{% if audience != "internal" %}
 A database cluster created in a folder can be accessed by all VMs connected to the same cloud network. [Learn more about networking](../../vpc/).
{% endif %}

{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

