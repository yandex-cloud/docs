---
title: Code examples for connecting to a {{ mgp-full-name }} cluster
description: These examples show you how to connect to a {{ mgp-name }} cluster database from your application.
---

# Code examples for connecting to a {{ mgp-name }} cluster

{% include [conn-strings-environment](../../../_includes/mdb/mgp/conn-strings-env.md) %}

Creating a {{ mgp-name }} cluster does not entail creating a user database. To test the connection, use the `postgres` service database.

To connect to a publicly accessible cluster, [prepare an SSL certificate](index.md#get-ssl-cert). In these examples, the `root.crt` SSL certificate is located in the following directory:

* `/home/<home_directory>/.postgresql/` for Ubuntu.
* `$HOME\AppData\Roaming\postgresql` for Windows.

You can connect to a cluster using either a master host's regular FQDN or a primary master host's [special FQDN](./fqdn.md#fqdn-master). When connecting using a JDBC connector, you can specify two master hosts at the same time. To learn how to get a host’s FQDN, see [this guide](./fqdn.md#get-fqdn).

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mgp-connection-strings](../../../_includes/mdb/mgp/conn-strings.md) %}
