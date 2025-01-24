---
title: Disk types in {{ mmy-full-name }}
description: In this article, you will learn about disk types in {{ mmy-name }} and discover how to select the right disk type when creating a cluster.
---

# Disk types in {{ mmy-name }}



{{ mmy-name }} allows you to use network and local storage drives for database clusters. Network drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on the database host servers.

{% include [storage-type](../../_includes/mdb/mmy/storage-type.md) %}


## Selecting disk type during cluster creation {#storage-type-selection}

The number of hosts you can create together with a {{ MY }} cluster depends on the selected disk type:

* You can create a cluster only with three or more hosts when using the following disk types:

    * Local SSDs (`local-ssd`)
    * Non-replicated SSDs (`network-ssd-nonreplicated`)

   This cluster will be fault-tolerant.

   Local SSD storage has an effect on how much a cluster will cost: you pay for it even if it is stopped. For more information, refer to the [pricing policy](../pricing.md).

* You can add any number of hosts within the [current quota](./limits.md) when using the following disk types:

    * Network HDDs (`network-hdd`)
    * Network SSDs (`network-ssd`)    * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`)

For more information about limits on the number of hosts per cluster, see [Quotas and limits](./limits.md).


