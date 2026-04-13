---
title: 'Getting FQDNs for {{ GP }} hosts '
description: Follow this guide to get host FQDNs for connecting to a database in a {{ GP }} cluster.
---

# FQDNs of {{ GP }} hosts

To connect to a master host, you need its [FQDN](../../concepts/network.md#hostname). You can use the FQDN of a particular host in the cluster or a [special FQDN](#fqdn-master) always pointing to the primary master host. When connecting via _psql_ or using a JDBC connector, you can specify two master hosts at the same time.

Host FQDN example:

```text
{{ host-name }}.{{ dns-zone }}
```

## Getting a host FQDN {#get-fqdn}

There are several ways to get a {{ GP }} host's FQDN:

* Look up the FQDN in the management console:

    1. Navigate to the cluster page.
    1. Navigate to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

* In the [management console]({{ link-console-main }}), copy the cluster connection command (it contains the host’s FQDN). To get this command, navigate to the cluster page and click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.

* [Request a list of cluster hosts](../cluster-list.md#get-hosts) using the CLI or API.

## Special primary master FQDN {#fqdn-master}

If you do not want to manually connect to another master host when the current one becomes unavailable, use a special FQDN in `c-<cluster_ID>.rw.{{ dns-zone }}` format. It always points to the primary master host in the cluster. Connection to this FQDN is permitted, with both read and write operations allowed.

A special FQDN may temporarily point to an unavailable master host (for up to 10 minutes). This is because it takes time to update DNS records for special FQDNs. If your request returns an error, repeat it later.

Here is an example of connecting to a primary master host in a cluster with the `{{ cluster-id }}` ID:

```bash
psql "host=c-{{ cluster-id }}.rw.{{ dns-zone }} \
      port={{ port-mgp }} \
      sslmode=verify-full \
      dbname=<DB_name> \
      user=<username>"
```

{% include [special-fqdns-warning](../../../_includes/mdb/special-fqdns-warning.md) %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
