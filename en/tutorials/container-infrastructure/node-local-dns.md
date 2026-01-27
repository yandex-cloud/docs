---
title: Setting up NodeLocal DNS in {{ managed-k8s-full-name }}
description: Follow this guide to set up NodeLocal DNS in {{ managed-k8s-name }}.
---

# Setting up NodeLocal DNS in {{ managed-k8s-full-name }}

To reduce the load from DNS queries in a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), use NodeLocal DNS.

{% note tip %}

If your {{ managed-k8s-name }} cluster has more than 50 [nodes](../../managed-kubernetes/concepts/index.md#node-group), use [DNS autoscaling](dns-autoscaler.md).

{% endnote %}

{% note warning %}

If the {{ managed-k8s-name }} cluster uses a Cilium network policy controller, the setup will have some unique features. Use [this guide](../../managed-kubernetes/operations/cilium-node-local-dns.md).

{% endnote %}

{% include [node-local-dns](../../_tutorials/k8s/node-local-dns.md) %}
