---
title: "Service resource relationship {{ mes-full-name }}"
description: "{{ ES }} is a specialized distributed document storage system. When a document is added to {{ ES }}, it is indexed. Data from the indexed document becomes available for search and analysis. Service {{ mes-full-name }} helps to deploy and maintain {{ ES }} server clusters in the {{ yandex-cloud }} infrastructure. "
---

# Relationship between resources in {{ mes-name }}

With {{ mes-full-name }}, you can deploy and maintain {{ ES }} server clusters in the {{ yandex-cloud }} infrastructure.

{{ ES }} is a specialized distributed document storage system. When a document is added to {{ ES }}, it gets added to the [index](indexing.md). Data from the indexed document becomes available for [search and analysis](searching.md).

When [creating a cluster](../operations/cluster-create.md), specify the following:

- _Host class_: A VM template for deploying the cluster hosts. For a list of available host classes and their characteristics, see [{#T}](instance-types.md).

- _Host role_: [_Data node_](hosts-roles.md#data-node) or [_Master node_](hosts-roles.md#master-node).

- _Environment_ where the cluster will be deployed:
    - `PRODUCTION`: For stable versions of your apps.
    - `PRESTABLE`: For testing, including the {{ mes-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

- _User password_ `admin`.

  {% include [mes-superuser](../../_includes/mdb/mes-superuser.md)%}

- _Version_ of {{ ES }}.

- _Edition_ of {{ ES }}. For a list of available editions and supported features, see [{#T}](es-editions.md).

An {{ ES }} cluster created in a folder can be accessed by all VMs connected to the same [cloud network](../../vpc/) as the cluster.

A single-host cluster doesn't guarantee fault tolerance. A cluster with multiple hosts automatically provides fault tolerance for the _Master node_ role. To ensure data safety in such a cluster, you need to configure index [sharding and replication](scalability-and-resilience.md).

Cluster hosts may reside in different availability zones.{% if audience != "internal" %} Learn more about the geo scope of {{ yandex-cloud }} in [{#T}](../../overview/concepts/geo-scope.md).{% endif %}

{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

