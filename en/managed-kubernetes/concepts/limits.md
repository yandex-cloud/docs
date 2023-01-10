---
title: "Quotas and limits in {{ managed-k8s-name }}"
description: "{{ managed-k8s-name }} has limits and quotas for the total number of vCPUs for all nodes, total RAM, total disk storage capacity, and the maximum number of {{ k8s }} clusters per cloud. For more information about the service restrictions, read this article."
---

# Quotas and limits in {{ managed-k8s-name }}

{{ managed-k8s-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{{ managed-k8s-name }} uses the specified maximum node group size as the actual size, regardless of the current size.

{% include [limits-managed-kube](../../_includes/managed-kube-limits.md) %}