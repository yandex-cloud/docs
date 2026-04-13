### There is no access to Kubernetes API {#api-security}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | k8s.api-security ||
|#

#### Description

We do not recommend granting access to Kubernetes API from the internet. Use firewall protection where needed (for example, [security groups](https://yandex.cloud/en/docs/vpc/concepts/security-groups)).

{% note info "**Note**" %}

This rule checks only for external IP addresses on Kubernetes clusters.

{% endnote %}

#### Guides and solutions to use

**Guides and solutions to use:**
It is recommended to use Kubernetes clusters that are not accessible from the internet. For guidance on creating such a cluster, see [Creating and configuring a Kubernetes cluster with no internet access](https://yandex.cloud/en/docs/managed-kubernetes/tutorials/k8s-cluster-with-no-internet).

If a cluster must be accessible from the internet, configure it using these firewall options:

* [Configure security groups for the cluster](https://yandex.cloud/en/docs/managed-kubernetes/operations/connect/security-groups).
* Use network policy configuration tools via the [Calico](https://yandex.cloud/en/docs/managed-kubernetes/concepts/network-policy#calico) (basic) or [Cilium CNI](https://yandex.cloud/en/docs/managed-kubernetes/concepts/network-policy#cilium) (advanced) plugins in Yandex Cloud. Apply `default deny` rules for inbound and outbound traffic by default, permitting only necessary traffic.
* For online endpoints, allocate an independent Kubernetes cluster or independent node groups (using such mechanisms as [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/#:~:text=Node%20affinity%20is%20a%20property,onto%20nodes%20with%20matching%20taints) + [Node affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)). This creates a DMZ, limiting your attack surface so that if your nodes are compromised online, the impact is minimized.
* Use an [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) resource to enable incoming network access to your workloads via HTTP/HTTPS. There are at least two Ingress controller options that you can use in Yandex Cloud:

    * [NGINX Ingress Controller](https://yandex.cloud/en/docs/managed-kubernetes/tutorials/ingress-cert-manager).
    * [Yandex Application Load Balancer Ingress controller](https://yandex.cloud/en/docs/application-load-balancer/tools/k8s-ingress-controller/).
