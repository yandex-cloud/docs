---
title: Quotas and Limits in Managed Service for Kubernetes
description: 'Managed Service for Kubernetes has limits and quotas for the total number of vCPUs for all nodes, the total amount of RAM, the total amount of disks, the maximum number of Kubernetes clusters in one cloud. You will learn more about the limitations of the service in this article.'
---

# Quotas and limits in {{ managed-k8s-name }}

{{ managed-k8s-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{{ managed-k8s-name }} uses the specified maximum node group size as the actual size, regardless of the current size.

{% include [limits-managed-kube](../../_includes/managed-kube-limits.md) %}