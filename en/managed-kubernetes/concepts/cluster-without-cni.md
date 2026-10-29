---
title: Clusters without a preinstalled CNI
description: 'Clusters without a preinstalled CNI in {{ managed-k8s-name }}: independent network plugin management, use cases, and the shared responsibility model.'
---

# Clusters without a preinstalled CNI

In {{ managed-k8s-full-name }}, you can create clusters without a preinstalled *CNI* (Container Network Interface) plugin. In such a cluster, you can select, install, and configure a plugin to match your application requirements.

A custom CNI allows you to manage the {{ k8s }} network beyond the [network settings available in the service](network-policy.md): choose plugin versions and use advanced capabilities for traffic protection, connectivity to external systems, and inter-cluster communication. This setup is suitable for teams that need control over the network configuration and are ready to maintain the plugin independently.

{% include [cluster-without-cni-preview](../../_includes/managed-kubernetes/cluster-without-cni-preview.md) %}

For more on how responsibility is shared in clusters without a preinstalled CNI, see [this article](../../overview/concepts/kubernetes-responsibilities.md#responsibility).

## Use cases {#examples}

A custom CNI helps adapt the network to your specific infrastructure and application requirements. Below are examples of such use cases implemented with Cilium and Calico. The exact capabilities available to you depend on the plugin you choose, its version, and configuration.

### Uniform network configuration {#cilium}

A team runs multiple clusters and wants to apply consistent approaches to network and network policy configuration across all of them. With a custom CNI, you can choose a familiar plugin and its version. For example, use Cilium to set up communication between pods in VXLAN tunnel mode and define network policies.

### Cross-pod traffic encryption {#encryption}

An application transmits data between components located on different cluster nodes. If security requirements require encrypting this traffic, you can configure the encryption at the network plugin level without modifying the application. For example, Cilium supports encryption of traffic traveling between pods hosted on different nodes via WireGuard or IPsec.

### Outbound traffic management {#egress-gateway}

An application connects to an external system that allows connections only from specific IP addresses. To ensure its access rules do not depend on pod placement, outbound traffic can be routed through dedicated gateway nodes. For example, you can use Cilium Egress Gateway to specify such nodes and IP addresses for the traffic originating from the selected pods.

### Cluster mesh {#cluster-mesh}

Application components are distributed across multiple clusters and need to communicate with each other or interface with shared services. A network plugin with inter-cluster communication support allows you to set up this connectivity. For example, Cilium Cluster Mesh provides network connectivity between pods in different clusters and enables the use of shared services.

### Processing service traffic using CNI {#calico-ebpf}

A team wants to process {{ k8s }} service traffic using an eBPF-based network plugin. With a custom CNI, you can choose a plugin that supports this specific operating mode. For example, Calico eBPF can replace `kube-proxy` given a compatible cluster configuration.

#### Useful links {#see-also}

* [{#T}](network.md)
* [{#T}](network-policy.md)
