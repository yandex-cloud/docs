---
title: '{{ vpc-full-name }} release notes'
description: This section contains {{ vpc-name }} release notes.
---

# {{ vpc-full-name }} release notes

## Q1 2025 {#q1-2025}

* Virtual network's data plane now deploys faster. Network downtime during data plane update was reduced from 60 seconds to 1 second or less.
* Implemented disconnecting availability zone from network load balancers.
* Virtual machines are no longer created if the network is guaranteed not to operate when they start.
* {{ interconnect-name }} has been implemented between {{ vpc-name }} and {{ baremetal-name }}.
* Optimized the gRPC API and accessing the control plane database by network load balancers: load balancers get status updates and instance groups respond to issues faster. Accelerated the balancing rule updates, e.g., in case of network problems or when changing target groups.

## Q3 2024 {#q3-2024}

* You can now create [service connections](./concepts/private-endpoint.md). The feature is at the Preview stage; [contact support](../support/overview.md) for access. 
* Implemented integration with {{ dns-name }} to state DNS records in public IP address specifications.

## Q2 2024 {#q2-2024}

* Increased network connection [limits](../compute/concepts/limits.md).
* Added validation of resource names and labels.

## Q1 2024 {#q1-2024}

* Added network connection metrics.
* Added the `vpc.publicUser` role.
