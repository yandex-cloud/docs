---
title: FQDNs of {{ CH }} hosts
description: Follow this guide to get FQDNs of {{ CH }} hosts.
---

# FQDNs of {{ CH }} hosts

To connect to a host, you need its fully qualified domain name ([FQDN](../../concepts/network.md#hostname)). You can use the FQDN of a particular host in the cluster or a [special FQDN](#auto) always pointing to the available host.

Host FQDN example:

```text
{{ host-name }}.{{ dns-zone }}
```

## Getting host FQDN {#get-fqdn}

You can obtain the {{ CH }} host FQDN by doing one of the following:

* Look up the FQDN in the management console:

  1. Navigate to the cluster page.
  1. Navigate to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

* In the [management console]({{ link-console-main }}), copy the command for connecting to the cluster. This command contains the host FQDN. To get the command, go to the cluster page and click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.

* [Request a list of cluster hosts](../hosts.md#list-hosts) using the CLI or API.

## Special FQDN {#auto}

To avoid connecting to another host manually if the current one becomes unavailable, use a special FQDN.

{% note warning %}

Use special FQDN-based connections only for processes that can cope with the database being unavailable for writing for up to 10 minutes.

{% endnote %}

Special FQDNs can be in one of the following formats:

* `c-<cluster_ID>.rw.{{ dns-zone }}`: To connect to an available cluster host.

* `<shard_name>.c-<cluster_ID>.rw.{{ dns-zone }}`: To connect to an available [shard](../../concepts/sharding.md) host.

{% note warning %}

If, during [cluster maintenance](../../concepts/maintenance.md#maintenance-order), a special FQDN points to a host without public access, the cluster will not be available for connection from the internet. To avoid this, [enable public access](../hosts.md#update) for all the cluster hosts.

{% endnote %}

A special FQDN might temporarily point to an unavailable host (for up to 10 minutes). This is because it takes time to update DNS records for special FQDNs. If your request returns an error, repeat it later.

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
