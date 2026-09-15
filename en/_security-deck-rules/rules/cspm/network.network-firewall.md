### In Virtual Private Cloud, a security group is created; the default security group is not used {#network-firewall}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | network.network-firewall ||
|#

#### Description

A [security group](https://yandex.cloud/en/docs/vpc/concepts/security-groups) in [Virtual Private Cloud](https://yandex.cloud/en/docs/vpc/) controls inbound and outbound network traffic for cloud objects it is attached to — virtual machines, Managed Service for Kubernetes clusters, load balancers, managed databases.

A new cloud network always has a [default security group](https://yandex.cloud/en/docs/vpc/concepts/security-groups#default-security-group) — it is created automatically and allows all inbound and outbound traffic. The default group is convenient when you start, but it does not enforce any restrictions: an object that has no other security group attached gets unrestricted network access through it.

For real workloads, create your own security groups with explicit rules — for example, only `HTTP/HTTPS` for a web server or only `SSH` from a bastion host — and attach them to objects in the network. Up to five security groups can be attached to one object.

**Risks if the rule is not followed:** Using only the default security group means all cloud objects in the network have unrestricted inbound and outbound traffic. Without custom security groups with explicit allow rules, there is no network-level segmentation — any compromised resource can freely communicate with all other resources in the network, and any internet-facing port is accessible to external attackers.

#### Instructions and solutions

For each cloud network:

1. [Create a security group](https://yandex.cloud/en/docs/vpc/operations/security-group-create) with [rules](https://yandex.cloud/en/docs/vpc/concepts/security-groups#security-groups-rules) that allow only the protocols, ports, and source addresses that the workload really needs.
2. Attach this group to virtual machines, Kubernetes clusters, managed databases, and other objects in the network — this overrides the default group for them.
3. In rules, prefer references to other security groups over hardcoded IP addresses (in the **Source/Destination** field choose **Security group** instead of **CIDR**) — this keeps access rules working when IP addresses change.
