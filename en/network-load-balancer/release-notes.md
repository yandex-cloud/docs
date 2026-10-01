---
title: '{{ network-load-balancer-full-name }} release notes'
description: This section contains the {{ network-load-balancer-name }} release notes.
---

# {{ network-load-balancer-full-name }} release notes

## Q1 2025 {#q1-2025}

* Implemented disconnecting an [availability zone](../overview/concepts/geo-scope.md) from network load balancers.
* Optimized the gRPC API and accessing the control plane database by network load balancers: load balancers get status updates and instance groups respond to issues faster. Enabled faster balancing rule updates, e.g., in case of network problems or when modifying target groups.

## Q3 2024 {#q3-2024}

Optimized health checks by eliminating throttling.
