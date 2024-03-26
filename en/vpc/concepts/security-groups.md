---
title: "Security groups in {{ vpc-full-name }}"
description: "With security groups, you can manage networking between cloud resources."
---

# Security groups

A security group is the main mechanism for access control in {{ yandex-cloud }}.

{% note info %}

Currently, you can only use IPv4 in {{ yandex-cloud }} networks. IPv6 is not supported, so security groups can only work with IPv4 traffic.

{% endnote %}

A *security group* (SG) is a resource that is created at the [cloud network](./network.md#network) level. Once created, a security group can be used in {{ yandex-cloud }} services to control network access to an object it applies to.

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

For more information about using security groups in a specific {{ yandex-cloud }} service, see the documentation for the service.

{% endnote %}

## Security group structure {#security-groups-structure}

A security group consists of a list of `rules`. A security group with no rules blocks any network traffic between objects it applies to. This happens because the list of security group rules always implicitly ends with the "prohibit all" rule.

Security group rules for `ingress` and `egress` traffic are set separately. One group may have up to [50 rules](./limits.md#vpc-limits) in total for ingress and egress traffic.

A new rule is always added at the end of the list. You cannot add a new rule to a specific position in the list in-between existing rules.

### Description of security group rules {#security-groups-rules}

Each rule in a security group has a fixed set of fields:

| Parameter | Description |
| --- | --- |
| **Description** | Brief description of the rule. You can also describe metadata in this field. |
| **Protocol** | Specifies the [network protocol](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml#protocol-numbers-1) to be used for this rule.<br> You can use the following protocols for security group rules:<ul><li>`TCP`</li><li>`UDP`</li><li>`ICMP`</li><li>`AH` (for IPsec connections)</li><li>`ESP` (for IPsec connections)</li><li>`GRE` (for tunnel connections)</li><li>`Any`: [Any network protocol](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml#protocol-numbers-1)</li></ul> |
| **Port range** | Range of ports for the network protocol selected in the rule.<br> You can only specify a continuous port range. You cannot list arbitrary comma-separated ports. |
| **Source** <br>For ingress traffic only | Traffic source IP addresses.<br>You can use the following methods to specify traffic source IPs:<ul><li>`CIDR`: List of traffic source IPv4 prefixes. You can set [up to 50 CIDR blocks](./limits.md#vpc-limits) per rule.</li><li>`Security group`: Name of an existing security group.</li><li>`Load balancer health checks`: Special rule that defines how to interact with [{{ network-load-balancer-name }} health check nodes](../../network-load-balancer/concepts/health-check.md#target-statuses).</li></ul> |
| **Destination** <br>For egress traffic only | Traffic target IP addresses.<br>You can use the following methods to specify traffic target IPs:<ul><li>`CIDR`: List of traffic target IPv4 prefixes. You can set [up to 50 CIDR blocks](./limits.md#vpc-limits) per rule.</li><li>`Security group`: Name of an existing security group.</li><li>`Load balancer health checks`: Special rule that defines how to interact with [{{ network-load-balancer-name }} health check nodes](../../network-load-balancer/concepts/health-check.md#target-statuses).</li></ul> |

### Self rule {#self-rule}

A special security group named `Self` can act as a traffic source or target in a security group rule. It includes all IP addresses of objects this group will be applied to.

For example, you can create a `vm_group_sg` security group and describe it as follows in {{ TF }}:

```
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

Please note that the `Self` rule only applies to traffic passing directly through the VM network interface that the security group is applied to.

On VMs with public IPs, egress traffic to the internet that passes through this network interface in the [one-to-one NAT](./address.md#public-addresses) direction will not be subject to the `Self` rule.

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

* `web-sg` for the web server group
* `db-sg` for the {{ mpg-name }} cluster

```
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

* [VM metadata service](../../compute/concepts/vm-metadata.md) requests at the `169.254.169.254` IP address over HTTP `(tcp/80)`.
* DNS requests towards the second IP address [in the subnet](./network.md#subnet) over DNS `(udp/53)`.

#### Security groups and {{ managed-k8s-name }} {#security-groups-and-k8s}

To avoid network connectivity issues when deploying and using {{ managed-k8s-name }} clusters, carefully follow [this guide](../../managed-kubernetes/operations/connect/security-groups.md).

{% note alert %}

{{ yandex-cloud }} supports automatic [filtering of egress SMTP traffic](./limits.md#vpc-egress-traffic-filter).

{% endnote %}

## Sample descriptions of security group rules {#security-groups-examples}

### VM with a web server {#security-group-vm-web}

```
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

```
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

* [Management console](https://console.cloud.yandex.ru/folders/{folder-id}/vpc/security-groups/)
* [Command line interface (CLI)](https://cloud.yandex.ru/docs/cli/cli-ref/managed-services/vpc/security-group/)
* {{ TF }}:
   * [Security Group](https://terraform-provider.yandexcloud.net/Resources/vpc_security_group)
   * [Security Group Rule](https://terraform-provider.yandexcloud.net/Resources/vpc_security_group_rule)
   * [Default Security Group](https://terraform-provider.yandexcloud.net/Resources/vpc_default_security_group)

## Step-by-step guides for working with security groups {#security-group-howto}

[Sample use cases for security groups](../../vpc/operations/index.md#security-groups) in {{ yandex-cloud }}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
