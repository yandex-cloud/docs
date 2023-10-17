---
title: "External cluster nodes"
description: "This article describes the features of external cluster nodes."
---

# External cluster nodes

{% note info %}

Connecting external nodes is at the [Preview](../../overview/concepts/launch-stages.md) stage. You will not be charged for using them.

{% endnote %}

{{ managed-k8s-name }} enables you to connect servers from outside {{ yandex-cloud }} as [{{ k8s }} cluster](./index.md#kubernetes-cluster) nodes.

## Requirements for connecting external resources to a cluster {#requirements}

To connect external nodes to a {{ managed-k8s-name }} cluster, the following requirements must be met:
* L3 network connectivity between your servers' local network infrastructure and your {{ managed-k8s-name }} cluster's [cloud network](../../vpc/concepts/network.md#network). External nodes connect to a cluster [master](./index.md#master) via its {{ yandex-cloud }} cloud network internal IP address.

  
  You can use the following methods to establish a private dedicated connection between your local network infrastructure and {{ yandex-cloud }}:
  * Via [{{ interconnect-full-name }}](../../interconnect/index.yaml).
  * Manually, via a VPN.
  
* A {{ managed-k8s-name }} cluster uses network [tunneling](../concepts/network-policy.md#cilium).
* Connecting servers must have internet access.
* Connecting servers must have Ubuntu 20.04 as their operating system.

For information on connecting external nodes to a {{ managed-k8s-name }} cluster, please see [{#T}](../operations/external-nodes-connect.md).

## Responsibility matrix

For external nodes to run predictably in a cluster, it is key that the elements below function without interruption:
* Computing infrastructure, such as the servers used and their relevant operating system.
  * We do not recommend using connecting servers in any capacity other than as nodes in a cluster.
* Local network infrastructure made up of the servers utilized.
* Links between your local network infrastructure and {{ yandex-cloud }}.


{{ yandex-cloud }} offers reliable private connections between your local network and cloud infrastructure that is part of [{{ interconnect-name }}](../../interconnect/index.yaml). Alternatively, you can configure and maintain the quality of such a connection yourself using a VPN.


{{ yandex-cloud }} does not offer management services or guarantee the reliability of any computing or network infrastructure outside {{ yandex-cloud }} data centers. You can take advantage of a managed infrastructure by using {{ managed-k8s-name }} [regular node groups](../operations/node-group/node-group-create.md).

## Restrictions when working with external nodes

When designing load balancing for nodes in a {{ managed-k8s-name }} cluster, you have to take the following into consideration:
* You cannot connect `PersistentVolume` [objects](volume.md) built on cloud disks in {{ yandex-cloud }} to external nodes.
* [Services](./index.md#service) based on {{ yandex-cloud }} L3 load balancers (such as `LoadBalancer`) do not distribute traffic to these nodes.

You must deploy any loads requiring this functionality on {{ managed-k8s-name }} cluster nodes located in {{ yandex-cloud }} only. You may take advantage of [node affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity) settings to accomplish this:

```yaml
...
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: yandex.cloud/node-group-id # Node labels for nodes located in {{ yandex-cloud }}.
            operator: Exists
...
```

You can manage traffic at L7 instead of doing it with L3 load balancers. To accomplish this, install an Ingress controller in your {{ managed-k8s-name }} cluster and use `Ingress` resources.

Currently, the [{{ alb-full-name }}-based Ingress Controller](../tutorials/alb-ingress-controller.md) does not support load balancing for external nodes. You can use one of the [alternative ingress controllers](../tutorials/ingress-cert-manager.md) as a workaround.