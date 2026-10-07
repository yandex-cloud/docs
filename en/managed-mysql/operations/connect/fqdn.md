---
title: Getting FQDNs for {{ mmy-full-name }} hosts
description: Follow this guide to get an FQDN for connection to a {{ MY }} host.
---

# FQDNs of {{ MY }} hosts

To connect to a host, you need its fully qualified domain name ([FQDN](../../concepts/network.md#hostname)). You can use the [FQDN of a particular host](#get-fqdn) in the cluster or a special FQDN always pointing to the [current master host](#fqdn-master) or the [most recent replica](#fqdn-replica).

Here is a host FQDN example:

```text
{{ host-name }}.{{ dns-zone }}
```

## Getting a host FQDN {#get-fqdn}

There are several ways to get a {{ MY }} host's FQDN:

* Look up the FQDN in the management console:

    1. Navigate to the cluster page.
    1. Navigate to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

* In the [management console]({{ link-console-main }}), copy the cluster connection command (it contains the host’s FQDN). To get this command, navigate to the cluster page and click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.

* [Get the list of cluster hosts](../../operations/hosts.md#list) using the CLI or API.

## Special FQDNs {#special-fqdns}

{{ mmy-name }} provides the following special FQDNs:
* [FQDN of the current master](#fqdn-master)
* [FQDN of the most recent replica](#fqdn-replica)

{% include [special-fqdns-info](../../../_includes/mdb/special-fqdns-info.md) %}

{% note warning %}

If [automatic failover](../../concepts/replication.md#master-failover) promotes a host without public access to master or most recent replica, you will not be able to connect to that host from the internet. To avoid this, [enable public access](../hosts.md#update) for all cluster hosts.

{% endnote %}

### Current master {#fqdn-master}

An FQDN in `c-<cluster_ID>.rw.{{ dns-zone }}` format always points to the current master host in the cluster. You can get the cluster ID with the [list of clusters in the folder](../cluster-list.md#list-clusters).

When connecting to this FQDN, you can perform read and write operations.

{% include [special-fqdns-warning](../../../_includes/mdb/special-fqdns-warning.md) %}

### Most recent replica {#fqdn-replica}

An FQDN in `c-<cluster_ID>.ro.{{ dns-zone }}` format points to the [replica](../../concepts/replication.md) that is most up-to-date with the current master. You can get the cluster ID with the [list of clusters in the folder](../cluster-list.md#list-clusters).

**Specifics:**

* When connecting to this FQDN, you can only perform read operations.
* If there are no active replicas in the cluster, you cannot connect to this FQDN as the respective DNS CNAME record will point to a `null` object.

## Aliases {#aliases}

With aliases, you can access the master, most recent replica, or each particular host of your {{ mmy-name }} cluster using a stable, human-readable name no matter what their internal FQDNs are. Aliases are user-defined and function exactly like regular or [special FQDNs](#special-fqdns).

### Cluster alias {#cluster-alias}

A cluster alias always points to the current master host in the {{ mmy-name }} cluster. It has the following format:

```
c-<short_name>-my-<folder_ID>.rw.{{ dns-zone }}
```

Where `<short_name>` is a name set by the user when creating the alias.

A cluster alias must be unique within the folder. You can assign only one alias per cluster.

With cluster aliases, you can switch workloads from one cluster to another, e.g., after restoring from a backup. To do this, simply reassign the alias to the new cluster, no application-side updates required.

{% note warning %}

{% include [special-fqdns-warning](../../../_includes/mdb/special-fqdns-info.md) %}

{% endnote %}


### Host aliases {#hosts-aliases}

An alias pointing to a specific cluster host has the following format:

```
h-<host_short_name>-my-<folder_ID>.{{ dns-zone }}
```

Where `<host_short_name>` is a name set by the user when creating the host alias.

Each host alias must be unique within the folder. You can assign only one alias per host.
