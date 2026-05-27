---
title: FQDNs of {{ mrd-full-name }} hosts
description: Follow this guide to get an FQDN for connection to a {{ mrd-full-name }} host.
---

# FQDNs of {{ VLK }} hosts

To connect to a host, you need its fully qualified domain name ([FQDN](../../concepts/network.md#hostname)). You can get it using one of the following methods:

* [Request a list of cluster hosts](../hosts.md#list-hosts).
* In the [management console]({{ link-console-main }}), copy the cluster connection command (it contains the host’s FQDN). To get the command, go to the cluster page and click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
* Look up the FQDN in the management console:

   1. Navigate to the cluster page.
   1. Navigate to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

You can also use the following FQDNs to connect:

* [Special FQDN](#special-fqdns): Only to a non-sharded cluster.
* [Stable FQDNs](#stable-fqdns): To any cluster.

## Special FQDN {#special-fqdns}

{{ mrd-name }} provides a special FQDN that can be used instead of [regular host FQDNs](index.md#fqdn) to connect to non-sharded clusters.

In a non-sharded cluster, an FQDN of `c-<cluster_ID>.rw.{{ dns-zone }}` format always points to the current master host. You can get the cluster ID with the [list of clusters in the folder](../cluster-list.md#list-clusters). When connecting to this FQDN, you can perform read and write operations.

In multi-host clusters, a special FQDN may temporarily point to a replica host (for up to 10 minutes). This is because it takes time to update DNS records for special FQDNs. If your write request returns an error, repeat it later.

{% note warning %}

If [automatic failover](../../concepts/replication.md#master-failover) promotes a host without public access to master, you will not be able to connect to that host from the internet. To avoid this, [enable public access](../hosts.md#update) for all cluster hosts.

{% endnote %}

Here is an example of an SSL-encrypted connection to a master host for a cluster with the `c9qash3nb1v9********` ID:

```bash
redis-cli -h c-c9qash3nb1v9********.rw.{{ dns-zone }} \
  -p 6380 \
  --tls \
  --cacert ~/.redis/{{ crt-local-file }} \
  -a <{{ VLK }}_password>
```

{% include [special-fqdns-warning](../../../_includes/mdb/special-fqdns-warning.md) %}


## Stable FQDNs {#stable-fqdns}

For {{ mrd-name }}, stable FQDNs are available that always point to live hosts in different availability zones:

* `c-<cluster_ID>-valkey0.{{ dns-zone }}`
* `c-<cluster_ID>-valkey1.{{ dns-zone }}`
* `c-<cluster_ID>-valkey2.{{ dns-zone }}`

You can request the cluster ID with the [list of clusters in the folder](../cluster-list.md#list-clusters).

You can use these FQDNs for connection to hosts in either a sharded or non-sharded cluster alongside [special FQDNs](#special-fqdns) and [regular host FQDNs](index.md#fqdn).

If the cluster hosts reside in one or two availability zones, or there are less than three hosts, stable FQDNs can point to the same host. The target host can be either a master or a replica. After connecting, request information:

* On master hosts:

  * In a non-sharded cluster, via the `INFO` command.
  * In a sharded cluster, via the `CLUSTER INFO` command.

* On shards in a sharded cluster, via the `CLUSTER SHARDS` command.

When connecting to stable FQDNs, read and write operations are allowed.

Here is an example of an SSL-encrypted connection to a cluster host with the `c9qash3nb1v9********` ID:

```bash
redis-cli -h c-c9qash3nb1v9********-valkey1.{{ dns-zone }} \
  -p 6380 \
  --tls \
  --cacert ~/.redis/{{ crt-local-file }} \
  -a <{{ VLK }}_password>
```
