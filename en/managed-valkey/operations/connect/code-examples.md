---
title: Code examples for connecting to a {{ VLK }} cluster in {{ mrd-full-name }}
description: These examples show you how to connect to a {{ VLK }} cluster database from your application.
alternate:
  - href: en/managed-valkey/operations/connect/code-examples.md
    type: text/markdown
    title: Markdown version
---

# Code examples for connecting to a {{ VLK }} cluster

The available connection methods depend on whether the [sharding](../../concepts/sharding.md) is enabled in the cluster:

* [Connecting to a non-sharded cluster](./non-sharded-code-examples.md).
* [Connecting to a sharded cluster](./sharded-code-examples.md).

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [Environment settings](../../../_includes/mdb/mdb-conn-strings-env.md) %}