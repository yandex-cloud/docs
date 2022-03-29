---
title: Elasticsearch Storage Types
description: 'The Elasticsearch service allows you to use network and local storage for clusters. The network storage is implemented on the basis of network blocks, virtual disks in the Yandex Cloud infrastructure.'
keywords:
  - Elasticsearch storage
  - Elasticsearch repositories
  - Elasticsearch
---

# Storage types

{{ mes-name }} lets you use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the cluster servers.

{% include [storage-type-nrd](../../_includes/mdb/mes/storage-type.md) %}

## Specifics of local SSD storage {#local-storage-features}

* Local SSD storage doesn't provide fault tolerance for a single-host cluster: if a disk fails, the data is permanently lost. To ensure fault tolerance, create clusters of three or more hosts and configure index [sharding and replication](scalability-and-resilience.md).
* You are charged for a cluster with this storage type even if it's stopped. Read more in the [pricing policy](../pricing.md).

## Specifics of non-replicated SSD storage {#network-nrd-storage-features}

{% include [nrd-storage-details](../../_includes/mdb/nrd-storage-details.md) %}
