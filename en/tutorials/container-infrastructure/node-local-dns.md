---
title: Setting up NodeLocal DNS Cache in {{ managed-k8s-full-name }}
description: Follow this guide to configure NodeLocal DNS Cache in {{ managed-k8s-name }}.
---

# Setting up NodeLocal DNS Cache in {{ managed-k8s-full-name }}

To reduce the number of DNS requests to a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), enable NodeLocal DNS Cache.

{% note tip %}

If a {{ managed-k8s-name }} cluster contains more than 50 [nodes](../../managed-kubernetes/concepts/index.md#node-group), use [automatic DNS scaling](dns-autoscaler.md).

{% endnote %}

{% include [node-local-dns](../../_tutorials/k8s/node-local-dns.md) %}