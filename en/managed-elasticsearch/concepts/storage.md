---
title: Elasticsearch Storage Types
description: 'The Elasticsearch service allows you to use network and local storage for clusters. The network storage is implemented on the basis of network blocks, virtual disks in the Yandex.Cloud infrastructure.'
keywords:
  - Elasticsearch storage
  - Elasticsearch repositories
  - Elasticsearch

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Storage types

{{ mes-name }} allows you to use network and local storage for clusters. Network storage is based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local storage is organized on disks, which are physically located on the cluster servers.

{% include [mes-storage-type](../../_includes/mdb/storage-type.md) %}

## Local storage features {#local-storage-features}

* Local storage doesn't provide fault tolerance for a single-host cluster: if a local disk fails, the data is permanently lost. To ensure fault tolerance, create clusters of two or more hosts and configure index [sharding and replication](scalability-and-resilience.md).
* You are charged for a cluster with local storage even if it's stopped. Read more in the [pricing policy](../pricing.md).

