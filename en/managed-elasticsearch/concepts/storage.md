---
title: "Elasticsearch disk types"
description: "Elasticsearch allows you to use network and local storage drives for clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure."
keywords:
  - Elasticsearch storage
  - Elasticsearch storage types
  - Elasticsearch
---

# {{ ES }} disk types

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}


{{ mes-name }} allows you to use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the cluster servers.

{% include [storage-type-nrd](../../_includes/mdb/mes/storage-type.md) %}

## Selecting disk type during cluster creation {#storage-type-selection}

The number of hosts with the _Data node_ role that can be created along with a {{ ES }} cluster depends on the selected disk type:

* With local SSD (`local-ssd`) or non-replicated SSD (`network-ssd-nonreplicated`) storage, you can create a cluster with three or more hosts.

   This cluster will be fault-tolerant. To ensure fault tolerance, you can also set up index [sharding and replication](scalability-and-resilience.md).

   Local SSD storage impacts the cost of a cluster: you are charged for it even if it is not running. For more information, refer to the [pricing policy](../pricing.md).

* With network HDD (`network-hdd`) or network SSD (`network-ssd`) storage, you can add any number of hosts within the current quota.

For more information about limits on the number of hosts per cluster, see [{#T}](./limits.md).

