---
title: Storage in {{ mspqr-full-name }}
description: In this article, you will learn what a storage is in {{ mspqr-name }} and how to select the right disk type when creating a cluster.
keywords:
  - keyword: Storage in {{ mspqr-full-name }}
  - keyword: Disks in {{ mspqr-full-name }}
---

# Storage in {{ mspqr-full-name }}

With {{ mspqr-name }}, you can use network disks and local disks to set up a cluster storage. Network disks are based on network blocks, i.e., virtual disks in the {{ yandex-cloud }} infrastructure.

Your storage can use the following disk types:

* **Network HDD** (`network-hdd`): Standard network drive; HDD network block storage.

* **Network SSD** (`network-ssd`): Fast network drive; SSD network block storage.

{% include [available-storage](../../_includes/mdb/available-storage.md) %}

{{ mspqr-name }} allows you to use local storage for database clusters. Local drives are physically located on the database host servers.

To create a cluster, you use local SSDs (`local-ssd`), which are the highest-performing disks. The minimum storage size is 10 GB; the maximum, 20 GB.

In {{ mspqr-name }}, the number of hosts you can create together with a cluster depends on the sharding type rather than on the selected disk type:

* Standard sharding: One to seven `INFRA` hosts. To ensure that your cluster is fault-tolerant, we recommend creating at least three `INFRA` hosts in different availability zones.
* Advanced sharding:

  * From 1 to 100 `ROUTER` hosts. To ensure that your cluster is fault-tolerant, we recommend creating at least three `ROUTER` hosts in different availability zones.
  * From one to three `COORDINATOR` hosts. To ensure that such a cluster is fault-tolerant, we recommend creating three `COORDINATOR` hosts in different availability zones.