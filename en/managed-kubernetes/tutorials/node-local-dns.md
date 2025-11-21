---
title: Setting up NodeLocal DNS Cache
description: Follow this tutorial to set up NodeLocal DNS Cache.
canonical: '{{ link-docs }}/tutorials/container-infrastructure/node-local-dns'
---

# Setting up NodeLocal DNS Cache

To reduce the load from DNS queries in a [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster), enable NodeLocal DNS Cache.

{% note tip %}

If your {{ managed-k8s-name }} cluster has more than 50 [nodes](../concepts/index.md#node-group), use [DNS autoscaling](dns-autoscaler.md).

{% endnote %}

{% include [node-local-dns](../../_tutorials/k8s/node-local-dns.md) %}