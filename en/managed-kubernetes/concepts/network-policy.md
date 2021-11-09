# {{ k8s }} cluster network policies

{{ k8s }} network policies help configure network interchanges between groups of [pods](./index.md#pod) and network nodes. You can create network policies using the [Kubernetes Network Policy API](https://kubernetes.io/docs/concepts/services-networking/network-policies/) that sets rules for filtering traffic at the pod level. These rules determine which pods and services in a {{ k8s }} cluster can access each other.

To manage network policies, {{ managed-k8s-name }} uses the [Calico](https://www.projectcalico.org/) and [Cilium](https://cilium.io/) controllers.

The Calico network controller uses the [iptables](https://ru.wikipedia.org/wiki/Iptables) rules while Cilium utilizes [eBPF](https://ebpf.io/) technology.

{% note warning %}

You can enable network policies only when [creating a cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md).

{% endnote %}

## Calico {#calico}

Calico enables you to configure [basic security policies](https://docs.projectcalico.org/reference/resources/) for {{ k8s }} clusters.

Step-by-step configuration instructions are provided at [{#T}](../operations/calico.md).

## Cilium {#cilium}

Unlike Calico, the Cilium controller has broader capabilities and enables you to:
* Use the same subnet ranges for pods and services in different clusters.
* Create more functional network policies, for example, by filtering pod-to-pod traffic at the [L7 application layer](https://en.wikipedia.org/wiki/OSI_model#Layer_architecture) or using the DNS name of an external resource.
* Use the built-in [Hubble](https://docs.cilium.io/en/v1.9/intro/#why-cilium-hubble) tool to monitor network events.

In a {{ managed-k8s-name }} cluster, Cilium operates in [tunneling mode](https://docs.cilium.io/en/v1.9/concepts/networking/routing/#encapsulation). This mode implements network connectivity for cluster objects based on [VxLAN technology](https://ru.wikipedia.org/wiki/Virtual_Extensible_LAN) using Cilium CNI.

Cilium tunneling mode helps:
* Create clusters with overlapping IP addresses on the same network.
* Use an extended address range of up to `/8` for pod and cluster services.
* Create twice as many cluster nodes (as compared to Calico).

{% note info %}

Tunneling mode is at the [Preview](../../overview/concepts/launch-stages.md) stage.

{% endnote %}

## Cluster requirements to enable network policies {#requirements}

Prerequisites for enabling network policies in a {{ k8s }} cluster:
* [Sufficient node group resources](./node-group/allocatable-resources.md).

  Using network policies requires additional memory and vCPU resources.

* The Cilium controller requires {{ k8s }} version 1.19 or better released through the `RAPID` channel.

We recommend that you only enable your network policy controller in a cluster of at least two nodes.