---
title: How to connect to a {{ ytsaurus-name }} cluster
description: Follow this guide to connect to a {{ ytsaurus-name }} cluster.
---

# Connecting to a {{ ytsaurus-name }} cluster

You can connect to a {{ ytsaurus-name }} cluster:

* From {{ yandex-cloud }} VMs.
* Via the internet over HTTPS.

If your cluster has restrictions on incoming traffic, connect from the internet using an IP address within the allowed ranges. These restrictions do not impact access from {{ vpc-name }}. To change the list of allowed ranges, [update the cluster settings](cluster-update.md).

## Examples of connection strings {#connection-string}

**The examples for Linux were tested in the following environment**:
* {{ yandex-cloud }} VM running Ubuntu 20.04 LTS.
* Bash: `5.0.16`.
* Python: `3.8.2`; pip3: `20.0.2`.

{% include [Connection strings](../../_includes/managed-ytsaurus/conn-strings.md) %}
