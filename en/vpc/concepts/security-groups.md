---
title: Security groups in {{ vpc-full-name }}
description: With security groups, you can manage networking between cloud resources.
---

# Security groups

A security group is the main mechanism for access control in {{ yandex-cloud }}.

{% note info %}

Currently, you can only use IPv4 in {{ yandex-cloud }} networks. IPv6 is not supported, so security groups can only work with IPv4 traffic.

{% endnote %}

A *security group* (SG) is a resource created at the [cloud network](./network.md#network) level. Once created, a security group can be used in {{ yandex-cloud }} services to control network access to an object it applies to.

A *default security group* (DSG) is created automatically while creating a [new cloud network](./network.md#network). The default security group has the following properties:

* It will allow any network traffic, both egress and ingress, in the new cloud network.
* It applies to traffic passing through all subnets in the network where the DSG is created.
* It is only used if no security group is explicitly assigned to the object yet.
* You cannot delete the DSG: it is deleted automatically when deleting the network.

You can combine security groups by assigning up to five groups per object.

{% note alert %}

Security groups are not designed to protect against DDoS attacks.

To filter out large volumes of unsolicited network traffic, use [{{ ddos-protection-full-name }}](../ddos-protection/index.md).

{% endnote %}

## Scope of use for security groups {#security-groups-apply}

Security groups can be used in the following {{ yandex-cloud }} service objects:

| Service name | Service objects |
| --- | --- |
| [{{ compute-short-name }}](../../compute/) | [VM interface](../../compute/concepts/network.md), [instance group template](../../compute/concepts/instance-groups/instance-template.md#network) |
| [{{ managed-k8s-name }}](../../managed-kubernetes/) | [Cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), [node group](../../managed-kubernetes/concepts/index.md#node-group) |
| [{{ alb-name }}](../../application-load-balancer/) | [Load balancer](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) |
| [{{ mpg-name }}](../../managed-postgresql/) | [Cluster](../../managed-postgresql/concepts/network.md#security-groups) |
| [{{ mch-name }}](../../managed-clickhouse/) | [Cluster](../../managed-clickhouse/concepts/network.md#security-groups) |
| [{{ mgp-name }}](../../managed-greenplum/) | [Cluster](../../managed-greenplum/concepts/network.md#security-groups) |
| [{{ mmy-name }}](../../managed-mysql/) | [Cluster](../../managed-mysql/concepts/network.md#security-groups) |
| [{{ mrd-name }}](../../managed-redis/) | [Cluster](../../managed-redis/concepts/network.md#security-groups) |
| [{{ mmg-name }}](../../managed-mongodb) | [Cluster](../../managed-mongodb/concepts/network.md#security-groups) |
| [{{ mkf-name }}](../../managed-kafka/) | [Cluster](../../managed-kafka/concepts/network.md#security-groups) |
| [{{ mos-name }}](../../managed-opensearch/) | [Cluster](../../managed-opensearch/concepts/network.md#security-groups) |
| [{{ dataproc-name }}](../../data-proc/) | [Cluster](../../data-proc/concepts/network.md#security-groups) |
| [{{ data-transfer-name }}](../../data-transfer/) | [Endpoint](../../data-transfer/concepts/network.md#security-groups) |
| [{{ load-testing-name }}](../../load-testing/) | [Test agent](../../load-testing/concepts/agent.md) |
| [{{ mgl-name }}](../../managed-gitlab/) | [Instance](../../managed-gitlab/operations/configure-security-group.md) |

{% note info %}

For more information about using security groups in a specific {{ yandex-cloud }} service, see the relevant documentation.

{% endnote %}

## Security group structure {#security-groups-structure}

Security groups consist of a list of `rules`. A security group with no rules blocks any network traffic between objects it applies to. This happens because the list of security group rules always implicitly ends with the "prohibit all" rule.

Security group rules for `ingress` and `egress` traffic are set separately. One group may have up to [50 rules](./limits.md#vpc-limits) in total for ingress and egress traffic.

A new rule is always added at the end of the list. You cannot add a new rule to a specific position in the list in-between existing rules.

### Description of security group rules {#security-groups-rules}

Each rule in a security group has a fixed set of fields:

| Parameter | Description |
| --- | --- |
| **Description** | Brief description of the rule. You can also describe metadata in this field.
| **Protocol** | Specifies the [network protocol](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml#protocol-numbers-1) to be used for this rule.<br> You can use the following protocols for security group rules:<ul><li>`TCP`</li><li>`UDP`</li><li>`ICMP`</li><li>`AH` (for IPsec connections)</li><li>`ESP` (for IPsec connections)</li><li>`GRE` (for tunnel connections)</li><li>`Any`: [Any network protocol](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml#protocol-numbers-1)</li></ul>
| **Port range** | Range of ports for the network protocol selected in the rule.<br> You can only specify a continuous port range. You cannot list arbitrary comma-separated ports.
| **Source** <br>For incoming traffic only | Traffic source IP addresses.<br>You can use the following methods to specify traffic source IP adresses:<ul><li>`CIDR`: List of traffic source IPv4 prefixes. You can set [up to 50 CIDR blocks](./limits.md#vpc-limits) per rule.</li><li>`Security group`: Name of an existing security group.</li><li>`Load balancer health checks`: Special rule that defines how to interact with [{{ network-load-balancer-name }} health check nodes](../../network-load-balancer/concepts/health-check.md#target-statuses).</li></ul>
| **Target** <br>For outgoing traffic only | Traffic target IP addresses.<br>You can use the following methods to specify traffic target IP addresses:<ul><li>`CIDR`: List of traffic target IPv4 prefixes. You can set [up to 50 CIDR blocks](./limits.md#vpc-limits) per rule.</li><li>`Security group`: Name of an existing security group.</li><li>`Load balancer health checks`: Special rule that defines how to interact with [{{ network-load-balancer-name }} health check nodes](../../network-load-balancer/concepts/health-check.md#target-statuses).</li></ul>

### Self rule {#self-rule}

A special security group named `Self` can act as a traffic source or target in a security group rule. It includes all IP addresses of objects this group will be applied to.

For example, you can create a `vm_group_sg` security group and describe it in {{ TF }} as follows:

```hcl
resource yandex_vpc_security_group vm_group_sg {
  ...  
  ingress {
      protocol          = "ANY"
      description       = "Allow incoming traffic from members of the same security group"
      from_port         = 0
      to_port           = 65535
      predefined_target = "self_security_group"
  }

  egress {
      protocol          = "ANY"
      description       = "Allow outgoing traffic to members of the same security group"
      from_port         = 0
      to_port           = 65535
      predefined_target = "self_security_group"
    }
}
```

Now, if you apply the `vm_group_sg` group to the network interfaces of two VMs connected to the same network, these VMs will be able to exchange traffic with no port restrictions. If you apply the same group to a third VM on the same network, all three of them will be able to exchange traffic.

{% note alert %}

Note that the `Self` rule only affects traffic going directly through the VM network interface that the security group is applied to.

In the case of a VM with a public IP address, the `Self` rule does not apply to egress traffic to the internet that goes through this network interface in the [one-to-one NAT](./address.md#public-addresses) direction.

{% endnote %}

### Rule with a link to a security group {#reference-rule} 

Security group rules allow you to use other security groups in the **Source** or **Destination** field.

Such rules will allow networking with the IP addresses of resources (VM interfaces) to which this security group already applies.

So you can refer to different types of objects in rules, such as:

* {{ managed-k8s-name }} cluster worker nodes
* Managed DB cluster hosts
* VM instances in instance groups

Using reference rules in security groups helps maintain the consistency of network access rules during autoscaling of cloud resources.

Here is an example of a service that consists of two components:

* [Instance group](../../compute/concepts/instance-groups/) with web servers behind a load balancer
* [{{ mpg-name }}](../../managed-postgresql/) cluster

It is necessary to enable access from the DB cluster to a group of web servers the number of which may vary depending on the load.

To do this, create two security groups:

* `web-sg`: For the group of web servers
* `db-sg`: For the {{ mpg-name }} cluster

```hcl
resource "yandex_vpc_security_group" "web_sg" {
  name                = "web-sg"
  ...
  ingress {
    description       = "Allow HTTPS"
    protocol          = "TCP"
    port              = 443
  }

  ingress {
    description       = "Allow HTTP"
    protocol          = "TCP"
    port              = 80
  }

  egress {
    description       = "Permit ANY"
    protocol          = "ANY"
    v4_cidr_blocks    = ["0.0.0.0/0"]
  }
  ...
}

resource "yandex_vpc_security_group" "db_sg" {
  name                = "db-sg"
  ...
  ingress {
    description       = "Permit DB access to Web VM's"
    protocol          = "TCP"
    port              = 6432
    security_group_id = [ yandex_vpc_security_group.web_sg.id ]
  }
}
```

When new servers are added to the group, security group rules will automatically apply to them.

## Security group specifics {#security-groups-notes}

#### Traffic direction {#traffic-destination}

Security group rules describe ingress and egress traffic separately.

#### Stateful connections {#stateful}

The state of network connections in security groups is tracked. If security group rules allow network traffic in one direction, it is not required to allow the reverse traffic.

#### Connection lifetime {#ttl}

Security groups automatically terminate idle TCP connections in 180 seconds. We do not recommend using session timeouts in applications for a longer period of time. See more about limits [here](./limits.md#vpc-limits).

#### Using security groups in rules {#security-groups-in-rules}

Rules may use existing security groups as traffic sources and targets.

#### Using multiple security groups {#multiple-security-groups}

If multiple security groups apply to one object at the same time, their rules will be combined into a single list. Network traffic will be allowed if it matches a rule in at least one of the groups. If not, traffic will be prohibited.

#### Security groups and {{ network-load-balancer-name }} {#security-groups-and-network-load-balancer}

Please keep in mind that you cannot apply security groups to a network load balancer's [traffic listener](../../network-load-balancer/concepts/listener.md). For [target group](../../network-load-balancer/concepts/target-resources.md) VMs hosted behind a load balancer, security groups can be applied to the VM network interfaces. Security groups of these VMs must include the `Health Checks` rule to allow [health check](../../network-load-balancer/concepts/health-check.md#target-statuses) traffic from the load balancer.


#### Security groups and services for DNS and VM metadata {#security-groups-and-metadata-dns}

For consistent and reliable operation of network services, you must explicitly allow the following network traffic in the outgoing rules of security groups:

* Requests to the [VM metadata service](../../compute/concepts/vm-metadata.md) at the `169.254.169.254` IP address over HTTP `(tcp/80)`.
* Requests to the DNS service towards the second IP address [in the subnet](./network.md#subnet) over DNS `(udp/53)`.

#### Security groups and {{ managed-k8s-name }} {#security-groups-and-k8s}

To avoid network connectivity issues when deploying and using {{ managed-k8s-name }} clusters, carefully follow [this guide](../../managed-kubernetes/operations/connect/security-groups.md).

#### Security groups and {{ alb-name }} tools for {{ managed-k8s-name }} {#security-groups-and-alb-for-k8s}

For your [ingress controller](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) or [Gateway API](https://github.com/kubernetes-sigs/gateway-api) to operate correctly, configure security groups for the {{ managed-k8s-name }} [cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and [node groups](../../managed-kubernetes/concepts/index.md#node-group), and for the {{ alb-name }} [L7 load balancer](../../application-load-balancer/concepts/application-load-balancer.md). For more information, see [this guide](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md).

{% note alert %}

{{ yandex-cloud }} supports automatic [filtering of egress SMTP traffic](./limits.md#vpc-egress-traffic-filter).

{% endnote %}

## Sample descriptions of security group rules {#security-groups-examples}

### VM with a web server {#security-group-vm-web}

```hcl
resource yandex_vpc_security_group vm_group_sg {
...
  ingress {
    description    = "Allow HTTP protocol from local subnets"
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["192.168.10.0/24", "192.168.20.0/24"]
  }

  ingress {
    description    = "Allow HTTPS protocol from local subnets"
    protocol       = "TCP"
    port           = 443
    v4_cidr_blocks = ["192.168.10.0/24", "192.168.20.0/24"]
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
```

### VM behind a network load balancer {#security-group-vm-nlb}

```hcl
resource yandex_vpc_security_group vm_group_sg {
...
  ingress {
    description    = "Allow HTTP protocol from local subnets"
    protocol       = "TCP"
    port           = "80"
    v4_cidr_blocks = ["192.168.10.0/24", "192.168.20.0/24"]
  }

  ingress {
    description    = "Allow HTTPS protocol from local subnets"
    protocol       = "TCP"
    port           = "443"
    v4_cidr_blocks = ["192.168.10.0/24", "192.168.20.0/24"]
  }

  ingress {
    description = "Health checks from NLB"
    protocol = "TCP"
    predefined_target = "loadbalancer_healthchecks" # [198.18.235.0/24, 198.18.248.0/24]
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
```

## Tools for managing security groups {#security-groups-tools}

In {{ yandex-cloud }}, you can work with security groups using:

* [Management console]({{ link-console-main }}/folders/{folder-id}/vpc/security-groups/)
* [Command line interface (CLI)](../../cli/cli-ref/vpc/cli-ref/security-group/index.md)
* {{ TF }}:
  * [Security Group](https://terraform-provider.yandexcloud.net/Resources/vpc_security_group)
  * [Security Group Rule](https://terraform-provider.yandexcloud.net/Resources/vpc_security_group_rule)
  * [Default Security Group](https://terraform-provider.yandexcloud.net/Resources/vpc_default_security_group)

## Step-by-step guides for working with security groups {#security-group-howto}

[Sample use cases for security groups](../../vpc/operations/index.md#security-groups) in {{ yandex-cloud }}


## Use cases {#examples}

* [{#T}](../tutorials/web-service.md)
* [{#T}](../tutorials/openvpn.md)
* [{#T}](../tutorials/usergate-proxy.md)
* [{#T}](../tutorials/bastion.md)
* [{#T}](../tutorials/data-processing-nat-instance.md)
* [{#T}](../tutorials/high-accessible-dmz.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
