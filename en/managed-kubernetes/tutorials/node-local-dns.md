---
title: Setting up NodeLocal DNS
description: Follow this tutorial to set up NodeLocal DNS.
canonical: '{{ link-docs }}/tutorials/container-infrastructure/node-local-dns'
---

# Setting up NodeLocal DNS

{% note tip %}

If your {{ managed-k8s-name }} cluster has more than 50 [nodes](../concepts/index.md#node-group), use [DNS autoscaling](dns-autoscaler.md).

{% endnote %}

{% note warning %}

If the {{ managed-k8s-name }} cluster uses a Cilium network policy controller, the setup will have some unique features. Use [this guide](../../compute/operations/vm-create/create-from-user-image.md).

{% endnote %}

{% include [node-local-dns](../../_tutorials/k8s/node-local-dns.md) %}
