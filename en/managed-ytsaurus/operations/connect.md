---
title: How to connect to a {{ ytsaurus-name }} cluster
description: Follow this guide to connect to a {{ ytsaurus-name }} cluster.
---

# Connecting to a cluster {{ ytsaurus-name }}

You can connect to a {{ ytsaurus-name }} cluster:

* From {{ yandex-cloud }} VMs.
* Via the internet over HTTPS.

## Examples of connection strings {#connection-string}

**The examples for Linux were tested in the following environment**:

* {{ yandex-cloud }} VM running Ubuntu 20.04 LTS.
* Bash: `5.0.16`.
* Python: `3.8.2`; pip3: `20.0.2`.
* Go: `1.24.8`.

{% include [Connection strings](../../_includes/managed-ytsaurus/conn-strings.md) %}
