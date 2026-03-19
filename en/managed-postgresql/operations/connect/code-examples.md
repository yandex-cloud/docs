---
title: Code examples for connecting to a {{ PG }} cluster in {{ mpg-full-name }}
description: These examples show you how to connect to a {{ PG }} cluster database from your application.
---

# Code examples for connecting to a {{ PG }} cluster

{% include [conn-strings-environment](../../../_includes/mdb/mpg-conn-strings-env.md) %}

Connections to public {{ PG }} hosts require an SSL certificate. [Prepare a certificate](./index.md#get-ssl-cert) before connecting to such hosts.

The examples below assume that the `root.crt` SSL certificate is located in the following directory:

* `/home/<home_directory>/.postgresql/` for Ubuntu.
* `$HOME\AppData\Roaming\postgresql` for Windows.

Connections without an SSL certificate are only supported for hosts that are not publicly accessible. In this case, internal cloud network traffic will not be encrypted during database connections.

You can connect to a cluster using either regular host [FQDNs](../../concepts/network.md#hostname), including a comma-separated list of several FQDNs, or [special FQDNs](./fqdn.md#special-fqdns). In our examples, we use the special FQDN pointing to the current master host.

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mpg-connection-strings](../../../_includes/mdb/mpg-conn-strings.md) %}

If your cluster connection and test query are successful, you will see the {{ PG }} version. One exception is the [userver framework example](#cpp-userver), where the `SELECT 1 as ping` test query will be executed for periodic {{ PG }} cluster availability checks.
