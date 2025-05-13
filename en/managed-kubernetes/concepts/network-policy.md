# {{ k8s }} cluster network policies

{{ k8s }} network policies help configure network interchanges between groups of [pods](./index.md#pod) and network nodes. You can create network policies using the [{{ k8s }} Network Policy API](https://kubernetes.io/docs/concepts/services-networking/network-policies/) that sets rules for filtering traffic at the pod level. These rules determine which pods and services in a {{ k8s }} cluster can access each other.

{{ managed-k8s-name }} uses the [Calico](https://www.projectcalico.org/) and [Cilium](https://cilium.io/) controllers to manage network policies.

The Calico network controller uses the [iptables](https://en.wikipedia.org/wiki/Iptables) rules; Cilium uses the [eBPF](https://ebpf.io/) technology.

{% note warning %}

You can enable network policies only when [creating a cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md).

{% endnote %}

## Integration with load balancers {#balancers}

{% note warning %}

Due to the {{ yandex-cloud }} architecture, you cannot use `loadBalancerSourceRanges` in {{ managed-k8s-name }} when setting up network policy controllers. To allow traffic via the [{{ network-load-balancer-full-name }}](../../network-load-balancer/) or [{{ alb-full-name }}](../../application-load-balancer/) use [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

{% endnote %}

For step-by-step instructions on how to set up access to an application using NetworkPolicy, see [{#T}](../operations/create-load-balancer.md).

## Calico {#calico}

Calico enables you to configure [basic security policies](https://docs.projectcalico.org/reference/resources/) for {{ k8s }} clusters.

Step-by-step configuration instructions are provided at [{#T}](../operations/calico.md).

## Cilium {#cilium}

Unlike Calico, the Cilium controller has broader capabilities and enables you to:
* Use the same subnet ranges for pods and services in different clusters.
* Create more functional network policies, for example, by filtering pod-to-pod traffic at the [application layer (L7)](https://en.wikipedia.org/wiki/OSI_model#Layer_architecture) or using the DNS name of the external resource.
* Use the built-in [Hubble](https://docs.cilium.io/en/v1.9/intro/#why-cilium-hubble) tool to monitor network events.

In a {{ managed-k8s-name }} cluster, Cilium operates in [tunnel mode](https://docs.cilium.io/en/v1.14/network/concepts/routing/#encapsulation). This mode implements network connectivity between the cluster objects based on the [VxLAN technology](https://en.wikipedia.org/wiki/Virtual_Extensible_LAN) using Cilium CNI.

With Cilium's tunnel mode you can:
* Create clusters with overlapping IP addresses on the same network.
* Use an extended address range of up to `/8` for cluster pods and services.
* Create twice as many cluster nodes (as compared to Calico).

The cluster service account [needs the `k8s.tunnelClusters.agent` role](../security/index.md#yc-api) to use tunnel mode.

See [Creating a {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) to learn how to activate tunnel mode.

## Allow-all and deny-all network policies {#allow-deny-policies}

{% note warning %}

Use these policies for debugging tasks only; otherwise, granularly set up your policies to address particular tasks.

{% endnote %}

### Policies for incoming connections {#incoming-connections}

You can create a policy that allows all incoming connections to all pods in a namespace. If such a policy is present, no other policy can ban incoming connections to these pods.

For example:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-all-ingress
spec:
  podSelector: {}
  ingress:
  - {}
  policyTypes:
  - Ingress
```

You can create a policy that bans all incoming connections to all pods in a namespace. Such policy ensures that all incoming connections will be banned for pods not selected by any other network policy.

For example:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
spec:
  podSelector: {}
  policyTypes:
  - Ingress
```

### Policies for outgoing connections {#outgoing-connections}

You can create a policy that allows all outgoing connections from all pods in a namespace. If such a policy is present, no other policy can ban outgoing connections from these pods.

For example:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-all-egress
spec:
  podSelector: {}
  egress:
  - {}
  policyTypes:
  - Egress
```

You can create a policy that bans all outgoing connections from all pods in a namespace. Such policy ensures that all outgoing connections will be banned for pods not selected by any other network policy.

For example:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-egress
spec:
  podSelector: {}
  policyTypes:
  - Egress
```

To learn more about `NetworkPolicy`, see [this guide](../../network-load-balancer/k8s-ref/networkpolicy.md).

## Cluster requirements to enable network policies {#requirements}

To enable network policies in a {{ k8s }} cluster, [sufficient resources](node-group/allocatable-resources.md) in node groups are required. Using network policies requires additional memory and vCPU resources.

We recommend that you only enable your network policy controller in a cluster of at least two nodes.