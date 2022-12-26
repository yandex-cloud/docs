---
title: "Relationship of resources of the Yandex Managed Service for Redis"
description: "{{ RD }} is a high-performance in-memory database for key-value data. The {{ mrd-name }} service allows you to easily create clusters of hosts {{ RD }} with high fault tolerance. The main entity that operates service {{ mrd-name }}, - database cluster."
---

# Relationship between resources in {{ mrd-name }}

{{ RD }} is a high-performance key-value store that runs in RAM. {{ mrd-name }} lets you easily create {{ RD }} host clusters with a high level of fault tolerance.

The main entity used in {{ mrd-name }} is a _database cluster_.

Each cluster consists of one or more _database hosts_, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones and even different availability regions. {% if audience != "internal" %}[More about the geo scope of {{ yandex-cloud }}](../../overview/concepts/geo-scope.md).{% endif %}

* A cluster consisting of 3 and more hosts has automatic failover, because the hosts can take over each other's functions as the cluster's primary replica.

* A cluster of one or two hosts is cheaper, but it doesn't guarantee fault tolerance.

When creating a cluster, specify:

* _Host class_: A VM template for deploying the cluster hosts. For a list of available host classes and their characteristics, see [{#T}](instance-types.md).

* _Environment_: The environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your apps.
   * `PRESTABLE`: For testing, including the {{ mrd-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

{% note info %}

The amount of memory allocated to a host is also determined by the `maxmemory` configuration parameter for Redis hosts: the max amount of data is 75% of the available memory. For example, for a host class with 8 GB RAM, the `maxmemory` value will be 6 GB.

{% endnote %}

{% if audience != "internal" %} 
A DB cluster connected to a cloud network can be accessed by all VMs connected to the same cloud network. [Learn more about networking](../../vpc/).
{% endif %}

{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

