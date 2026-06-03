---
title: Coordination services in {{ mch-name }}
description: You will learn about coordination services used in {{ mch-full-name }}.
---

# Coordination services in {{ mch-name }}

A _coordination service_ manages consistency across cluster nodes, provides data [replication](replication.md), and runs distributed DDL queries.

{{ mch-name }} offers these coordination services:

* Built-in {{ CK }}.
* {{ CK }} running on separate hosts.
* {{ ZK }}.

{% note warning %}

After you select a coordination service, you cannot change or disable it. The hosts of both services are counted towards the used cloud [resource quota]({{ link-console-quotas }}) and the [cluster cost](../pricing.md).

{% endnote %}

## Selecting a coordination service {#coordination-system-selection}

The choice between the [{{ CK }}](#ck) services depends on the use case:

* Built-in {{ CK }} runs on {{ CH }} hosts and is well-equipped to handle testing or low-load applications.
* {{ CK }} deployed on separate hosts lends itself well for stable releases and high-load applications.

[{{ ZK }}](#zk) also works well for stable releases and high-load applications. However, {{ ZK }} is a legacy solution, so we recommend using {{ CK }} on separate hosts instead. Going forward, {{ ZK }} will no longer be available for creating new clusters.

## {{ CK }} {#ck}

{{ CK }} is a {{ CH }} solution that ensures the consistency of data reads and writes. {{ CK }} implements a {{ ZK }}-compatible client-server protocol, so you can use any standard {{ ZK }} client to work with it. However, snapshots, logs, and the {{ CK }} inter-server protocol are not compatible with {{ ZK }}, so {{ CK }} and {{ ZK }} hosts cannot be used in the same cluster.

For more information about {{ CK }}, see [this {{ CH }} guide]({{ ch.docs }}{{ lang }}/guides/sre/keeper/clickhouse-keeper).

In {{ mch-name }}, the {{ CK }} coordination service is now available in the following modes:

* **{{ ui-key.yacloud.clickhouse.cluster.value_coordination-service-embedded-clickhouse-keeper }}**: {{ CK }} runs on {{ CH }} hosts. For replication, the cluster must consist of three or more {{ CH }} hosts.
* **{{ ui-key.yacloud.clickhouse.cluster.value_coordination-service-separated-clickhouse-keeper }}**: {{ CK }} runs on separate hosts. For replication, the cluster must consist of two or more {{ CH }} hosts and include three or five {{ CK }} hosts.

  This mode is used by default in the [management console]({{ link-console-main }}) when you create a cluster with two or more {{ CH }} hosts per shard or configure the coordination service.

You can turn on the {{ CK }} coordination service:
  
* When [creating a cluster](../operations/cluster-create.md).
* When [updating a cluster](../operations/update.md), if created without a coordination service.

Once {{ CK }} is is turned on, you cannot turn it off.

## {{ ZK }} {#zk}

{{ ZK }} is one of the first open-source coordination services. Unlike {{ CK }}, it provides consistency of data writes only, but not that of reads.

For more information about {{ ZK }}, see [this {{ ZK }} guide](https://zookeeper.apache.org/).

{{ ZK }} runs on separate hosts. For successful replication, your {{ mch-name }} cluster must have [three or five {{ ZK }} hosts](../qa/cluster-settings.md#zookeeper-hosts-number).

{{ ZK }} is used by default when you create a {{ mch-name }} cluster in the [{{ yandex-cloud }} CLI](../../cli/index.yaml), {{ TF }}, or API.


If you create a cluster with two or more {{ CH }} hosts per shard and the cluster [network](../../vpc/concepts/network.md) has [subnets](../../vpc/concepts/network.md#subnet) in each [availability zone](../../overview/concepts/geo-scope.md), the system automatically adds three {{ ZK }} hosts, one in each subnet. If only some availability zones have subnets, specify the {{ ZK }} host settings manually.


The minimum number of cores per {{ ZK }} host depends on the total number of cores on {{ CH }} hosts:

| Total number of {{ CH }} host cores | Minimum number of cores per {{ ZK }} host |
|-------------------------------------------|-------------------------------------------------------|
| Less than 48                                  | 2                                                     |
| 48 or more                                | 4                                                     |

You can change {{ ZK }} host class and storage size when [updating cluster settings](../operations/update.md#change-resource-preset). Still, you cannot change the {{ ZK }} settings or connect directly to its hosts.

You can turn on the {{ ZK }} coordination service:
  
* When [creating a cluster](../operations/cluster-create.md).
* When [updating a cluster](../operations/update.md), if created without a coordination service.

Once {{ ZK }} is is turned on, you cannot turn it off.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}