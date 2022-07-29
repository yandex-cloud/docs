---
title: "Relationship of resources of the Yandex Managed Service for MongoDB"
description: "The main entity operated by the Managed Service for MongoDB is a database cluster. Each cluster consists of one or more database hosts - virtual machines with deployed DBMS servers. Cluster hosts can be located in different availability zones. A cluster of several hosts automatically fault tolerant - one of the replica hosts will take over the role of master if the current master host fails."
---

# Relationships between resources in {{ mmg-name }}

The main entity used in {{ mmg-name }} is a _database cluster_.

Each cluster consists of one or more _database hosts_, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones and even different availability regions. {% if audience != "internal" %}[More about the geo scope of {{ yandex-cloud }}](../../overview/concepts/geo-scope.md).{% endif %}

* A cluster consisting of multiple hosts supports automatic failover, because the hosts can take over each other's functions as the primary replica.

* A single-host cluster is cheaper, but it doesn't guarantee fault tolerance.

When creating a cluster, specify:
* _Host class_: A VM template for deploying the cluster hosts. For a list of available host classes and their characteristics, see [{#T}](instance-types.md).

* _Environment_: The environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your apps.
   * `PRESTABLE`: For testing, including the {{ mmg-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

{% if audience != "internal" %}
A database cluster created in a folder can be accessed by all VMs connected to the same cloud network. [Learn more about networking](../../vpc/).

{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

{% endif %}
