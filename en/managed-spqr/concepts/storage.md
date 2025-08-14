---
title: '{{ mspqr-full-name }} storage'
description: In this article, you will learn what a storage is in {{ mspqr-name }} and how to select the right disk type when creating a cluster.
---

# {{ mspqr-full-name }} storage

{% note info %}

At the [Preview](../../overview/concepts/launch-stages.md) stage, {{ mspqr-name }} does not use a storage, but you cannot create a cluster without one. You will need a storage later to aggregate data that does not fit into the RAM of the `SPQRINFRA` and `SPQRROUTER` hosts.

{% endnote %}

With {{ mspqr-name }}, you can use network storage drives to set up your cluster storage. Network drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure.

Your storage can use the following disk types:

* **Network HDD** (`network-hdd`): Standard network drive; HDD network block storage.

* **Network SSD** (`network-ssd`): Fast network drive; SSD network block storage.

{% include [available-storage](../../_includes/mdb/available-storage.md) %}

In {{ mspqr-name }}, the number of hosts you can create together with a cluster depends on the sharding type rather than on the selected disk type:

* Standard sharding: One to seven `SPQRINFRA` hosts. To ensure that your cluster is fault-tolerant, we recommend creating at least three `SPQRINFRA` hosts in different availability zones.
* Advanced sharding:

  * At least one `SPQRROUTER` host. The maximum number of `SPQRROUTER` hosts is not limited.
  * At least five `SPQRCOORDINATOR` hosts. To ensure that such a cluster is fault-tolerant, we recommend creating three `SPQRCOORDINATOR` hosts in different availability zones.
