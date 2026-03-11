### Access to Kubernetes components is limited by IP address, port, and protocol {#network-firewall-scope}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | k8s.network-firewall-scope ||
|#

#### Description

We recommend using [security groups](https://yandex.cloud/en/docs/vpc/concepts/security-groups) to configure safe access to Kubernetes cluster components under the principle of least privilege. To establish access to cluster components, only open the required ports over the required network protocols, and only for trusted IP addresses.

#### Guides and solutions to use

[Create](https://yandex.cloud/en/docs/vpc/operations/security-group-create) a security group and [configure](https://yandex.cloud/en/docs/managed-kubernetes/operations/connect/security-groups) it for working in a Kubernetes cluster.

In your configuration, follow the key principles that apply to security group settings for Kubernetes clusters:

* Do not use security rules with broad access rules:

    * **Port range**: `0-65535`.
    * **Protocol**: `Any`.
    * **Source**: `CIDR`.
    * **CIDR blocks**: IPv4 `0.0.0.0/0` or IPv6 `::/0` (access allowed from any address).
* Create dedicated security groups for:

    * Kubernetes [masters](https://yandex.cloud/en/docs/managed-kubernetes/concepts/#master)
    * Kubernetes [nodes](https://yandex.cloud/en/docs/managed-kubernetes/concepts/#node-group)
    * [Load balancers](https://yandex.cloud/en/docs/application-load-balancer/concepts/application-load-balancer) and [ingress controllers](https://yandex.cloud/en/docs/application-load-balancer/tools/k8s-ingress-controller/)
    * Databases and backends
    * [Bastion hosts](https://yandex.cloud/en/docs/tutorials/routing/bastion)
* In your security rules, use links to other security groups instead of resource IP addresses (in the **Source**/**Target** field, select **Security groups** instead of **CIDR**). This enables maintaining network access when editing resource IP addresses.
* Limit egress traffic. We recommend that you clearly indicate ranges of IP addresses and ports as well as target protocols in the security rules for outgoing traffic.
* Enable logging for Kubernetes clusters.
* Enable [Flow Logs Kubernetes](https://yandex.cloud/en/docs/security/domains/kubernetes#flow-logs-kubernetes) to monitor traffic.