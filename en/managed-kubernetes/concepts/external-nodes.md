---
title: External cluster nodes
description: This article describes the features of external cluster nodes.
---

# External cluster nodes

{% note info %}

Connecting external nodes is at the [Preview](../../overview/concepts/launch-stages.md) stage. You will not be charged for using them.

{% endnote %}

With {{ managed-k8s-name }}, you can connect servers from outside {{ yandex-cloud }} as [{{ k8s }} cluster](./index.md#kubernetes-cluster) nodes.

## Requirements for connecting external nodes to a cluster {#requirements}

There are certain requirements you should fulfill to connect external nodes to a {{ managed-k8s-name }}:
* L3 network connectivity between your servers' local network infrastructure and your {{ managed-k8s-name }} cluster's [cloud network](../../vpc/concepts/network.md#network). External nodes only connect to a cluster [master](./index.md#master) via its {{ yandex-cloud }} cloud network internal IP address.

  You can establish a private dedicated connection between your local network infrastructure and {{ yandex-cloud }}:
  * Using [{{ interconnect-full-name }}](../../interconnect/index.yaml).
  * Manually, via a VPN, e.g., [IPSec](../operations/external-nodes-connect-ipsec.md) or [WireGuard](../operations/external-nodes-connect-wireguard.md).

* A {{ managed-k8s-name }} cluster uses network [tunneling](../concepts/network-policy.md#cilium).
* Your external servers must have internet access.
* External server OS: Ubuntu 24.04.

For information on connecting external nodes to a {{ managed-k8s-name }} cluster, see [{#T}](../operations/external-nodes-connect.md).

## Responsibility {#responsibility}

For reliable operation of external nodes, you must ensure continuous operation of:
* Your computing infrastructure, i.e., servers and their operating system.
  * We do not recommend using external servers for anything other than the cluster node functions.
* Local network infrastructure of your servers.
* Connection between your local network infrastructure and {{ yandex-cloud }}.

{{ yandex-cloud }} offers reliable private connections between your local network and cloud infrastructure by means of [{{ interconnect-name }}](../../interconnect/index.yaml). Alternatively, you can configure and maintain the quality of such a connection yourself using a VPN.

{{ yandex-cloud }} does not offer management services or guarantee the reliability of any computing or network infrastructure outside the {{ yandex-cloud }} data centers. You can take advantage of a managed infrastructure by using {{ managed-k8s-name }} [regular node groups](../operations/node-group/node-group-create.md).

## External node operation limitations {#restrictions}

When designing load balancing for nodes in a {{ managed-k8s-name }} cluster, you have to consider the following aspects:
* You cannot connect `PersistentVolume` [objects](volume.md) based on {{ yandex-cloud }} disks to external nodes.
* [Services](./index.md#service) based on {{ yandex-cloud }} L3 load balancers, e.g., `LoadBalancer`, do not distribute traffic to these nodes.

You must deploy any loads requiring this feature on {{ managed-k8s-name }} cluster nodes located in {{ yandex-cloud }} only. For this, use the [node affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity) settings:

```yaml
...
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: yandex.cloud/node-group-id # {{ k8s }} label for nodes located in {{ yandex-cloud }}.
            operator: Exists
...
```

You can manage traffic at L7 instead of doing it using L3 load balancers. To do this, install an Ingress controller in your {{ managed-k8s-name }} cluster and use the `Ingress` resources.

Marketplace products [Ingress controller](../tutorials/alb-ingress-controller.md) and [Gateway API](../tutorials/marketplace/gateway-api.md) based on [{{ alb-full-name }}](../../application-load-balancer/) do not support balancing to external nodes.

Use the [Gwin](../alb-ref/gwin-index.md) controller or one of the [alternative Ingress controllers](../tutorials/ingress-cert-manager.md) for balancing to external nodes.

To use the Gwin controller for balancing to external nodes:
* The {{ alb-name }} L7 load balancer must have access to the external node address.
* The external node address must be present in the node's `status` as a resource, for example:

  ```bash
  kubectl get no -o yaml example-cluster-node-1 | yq ".status.addresses"
  ```

  ```yaml
  - address: 10.0.0.7
    type: InternalIP
  - address: 2001:db8::1
    type: InternalIP
  - address: example-cluster-node-1
    type: Hostname
  ```
