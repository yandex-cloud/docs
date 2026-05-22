---
title: FQDNs of {{ OS }} hosts
description: Follow this guide to get a host's FQDN.
---

# FQDNs of {{ OS }} hosts

To connect to a host, you need its fully qualified domain name ([FQDN](../../concepts/network.md#hostname)). You can use the FQDN of a particular host in the cluster or a [special FQDN](#special-fqdns) always pointing to the available host with the `DASHBOARDS` role.

Here is a host FQDN example:

```text
{{ host-name }}.{{ dns-zone }}
```

## Getting a host FQDN {#get-fqdn}

There are several ways to get a {{ OS }} host's FQDN:

* Look up the FQDN in the management console:

    1. Navigate to the cluster page.
    1. Navigate to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

* In the [management console]({{ link-console-main }}), copy the cluster connection command (it contains the host’s FQDN). To get this command, navigate to the cluster page and click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.

* [Get the list of cluster hosts](../host-groups.md#list-hosts) using the CLI or API.

## Special FQDN {#special-fqdns}

An FQDN in `c-<cluster_ID>.rw.{{ dns-zone }}` format always points to the available {{ OS }} host with the `DASHBOARDS` role in the cluster. You can get the cluster ID with the [list of clusters in the folder](../cluster-list.md#list-clusters).

You can connect to hosts with the `DATA` role using a special FQDN with port `9200`. In which case the load balancer located on the host with the `DASHBOARDS` role will redirect the request to one of the hosts with the `DATA` role using the [round-robin](https://en.wikipedia.org/wiki/Round-robin_scheduling) scheduling algorithm. To implement this connection scheme, your cluster must have at least one host with the `DASHBOARDS` role.

You can use a special FQDN to send requests to a specific host group with the `DATA` role. To do this, add the `X-Yandex-OpenSearch-NodeGroup=<host_group_name>` header to the request.

You can get the host group name with [cluster details](../cluster-list.md#get-cluster).

In clusters with multiple `DATA` or `DASHBOARDS` hosts, a special FQDN may temporarily point to an unavailable host (for up to 10 minutes). This is because it takes time to update DNS records for special FQDNs. If your request returns an error, repeat it later.

{% note warning %}

Use special FQDN-based connections only for processes that allow for indexes being not available for writing for up to 10 minutes.

{% endnote %}
