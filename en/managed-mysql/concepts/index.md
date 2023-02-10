---
title: "Relationship between {{ mmy-full-name }} resources"
description: "The main entity used in {{ mmy-name }} is a database cluster. Each cluster consists of one or more database hosts, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones. A cluster with multiple hosts features automatic failover: one of the replica hosts becomes the master if the current master host is down."
---

# Relationship between resources in {{ mmy-name }}

The main entity used in {{ mmy-name }} is a _database cluster_.

Each cluster consists of one or more _database hosts_, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones and even different availability regions. {% if audience != "internal" %}[More about the geo scope of {{ yandex-cloud }}](../../overview/concepts/geo-scope.md).{% endif %}

* A cluster consisting of multiple hosts has automatic failover, because the hosts can take over each other's functions as the cluster's primary replica.

* A single-host cluster is cheaper, but it doesn't guarantee fault tolerance.

When creating a cluster, specify:
* _Host class_: A VM template for deploying the cluster hosts. For a list of available host classes and their characteristics, see [{#T}](instance-types.md).

* _Environment_: The environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your apps.
   * `PRESTABLE`: For testing, including the {{ mmy-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

{% if audience != "internal" %}

A database cluster created in a folder can be accessed by all VMs connected to the same cloud network. [Learn more about networking](../../vpc/).

{% endif %}

{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}
