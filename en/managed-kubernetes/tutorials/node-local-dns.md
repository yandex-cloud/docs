---
title: Setting up NodeLocal DNS Cache
description: Follow this guide to configure NodeLocal DNS Cache.
canonical: '{{ link-docs }}/tutorials/container-infrastructure/node-local-dns'
---

# Setting up NodeLocal DNS Cache

To reduce the number of DNS requests to a [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster), enable NodeLocal DNS Cache.

{% note tip %}

If a {{ managed-k8s-name }} cluster contains more than 50 [nodes](../concepts/index.md#node-group), use [automatic DNS scaling](dns-autoscaler.md).

{% endnote %}

{% include [node-local-dns](../../_tutorials/k8s/node-local-dns.md) %}