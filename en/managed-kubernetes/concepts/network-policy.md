# {{ k8s }} cluster network policies

{{ k8s }} network policies help configure network interchanges between groups of [pods](./index.md#pod) and network nodes. You can create network policies using the [{{ k8s }} Network Policy API](https://kubernetes.io/docs/concepts/services-networking/network-policies/) that sets rules for filtering traffic at the pod level. These rules determine which pods and services in a {{ k8s }} cluster can access each other.

To manage network policies, {{ managed-k8s-name }} uses the [Calico](https://www.projectcalico.org/) and [Cilium](https://cilium.io/) controllers.

The Calico network controller uses the [iptables]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Iptables){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Iptables){% endif %} rules while Cilium utilizes the [eBPF](https://ebpf.io/) technology.

{% note warning %}

You can enable network policies only when [creating a cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md).

{% endnote %}

## Integration with load balancers {#balancers}

{% note warning %}

Due to the {{ yandex-cloud }} architecture, you can't use `loadBalancerSourceRanges` in {{ managed-k8s-name }} when setting up network policy controllers. To allow traffic via the [{{ network-load-balancer-full-name }}](../../network-load-balancer/) or [{{ alb-full-name }}](../../application-load-balancer/) use [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

{% endnote %}

For step-by-step instructions on how to set up access to an application using NetworkPolicy, see [{#T}](../operations/create-load-balancer.md).

## Calico {#calico}

Calico enables you to configure [basic security policies](https://docs.projectcalico.org/reference/resources/) for {{ k8s }} clusters.

Step-by-step configuration instructions are provided at [{#T}](../operations/calico.md).

## Cilium {#cilium}

Unlike Calico, the Cilium controller has broader capabilities and enables you to:
* Use the same subnet ranges for pods and services in different clusters.
* Create more functional network policies, for example, by filtering pod-to-pod traffic at the [L7 application layer]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Сетевая_модель_OSI#Уровни_модели_OSI){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/OSI_model#Layer_architecture){% endif %} or using the DNS name of an external resource.
* Use the built-in [Hubble](https://docs.cilium.io/en/v1.9/intro/#why-cilium-hubble) tool to monitor network events.

In a {{ managed-k8s-name }} cluster, Cilium operates in [tunneling mode](https://docs.cilium.io/en/v1.9/concepts/networking/routing/#encapsulation). This mode implements network connectivity for cluster objects based on [VxLAN technology]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Virtual_Extensible_LAN){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Virtual_Extensible_LAN){% endif %} using Cilium CNI.

Cilium tunneling mode helps:
* Create clusters with overlapping IP addresses on the same network.
* Use an extended address range of up to `/8` for pod and cluster services.
* Create twice as many cluster nodes (as compared to Calico).

To be able to use tunnel mode, a service account [requires the `k8s.tunnelClusters.agent` role](../security/index.md#yc-api).

{% note info %}

Tunneling mode is at the [Preview](../../overview/concepts/launch-stages.md) stage.

{% endnote %}

## Cluster requirements to enable network policies {#requirements}

Prerequisites for enabling network policies in a {{ k8s }} cluster:
* [A sufficient amount of resources](node-group/allocatable-resources.md) in node groups.

   Using network policies requires additional memory and vCPU resources.
* The Cilium controller requires {{ k8s }} version 1.19 or better released through the `RAPID` channel.

We recommend that you only enable your network policy controller in a cluster of at least two nodes.