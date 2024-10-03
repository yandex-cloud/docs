---
title: '{{ dataproc-full-name }} maintenance'
description: In this tutorial, you will learn what {{ dataproc-name }} maintenance includes and how it is carried out.
---

# {{ dataproc-name }} maintenance

Maintenance means:

* Changes to the host class and storage size.
* Other maintenance activities.

Maintenance is performed as follows:

1. Data storage and processing [subcluster](./index.md) hosts undergo maintenance one by one. The subclusters and hosts are queued randomly. If a host needs to be restarted during maintenance, it becomes unavailable while being restarted.
1. The master host undergoes maintenance and gets its updates. If a cluster needs to be restarted during maintenance, it will become unavailable.
