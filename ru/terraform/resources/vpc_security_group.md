---
subcategory: Virtual Private Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/vpc_security_group.md
---

# yandex_vpc_security_group (Resource)

Manages a Default Security Group within the Yandex Cloud. For more information, see the official documentation of [security group](https://yandex.cloud/docs/vpc/concepts/security-groups) or [default security group](https://yandex.cloud/docs/vpc/concepts/security-groups#default-security-group).

{% note warning %}

This resource is not intended for managing security group in general case. To manage normal security group use [yandex_vpc_security_group](vpc_security_group.html)

{% endnote %}


When [network](https://yandex.cloud/docs/vpc/concepts/network) is created, a non-removable security group, called a *default security group*, is automatically attached to it. Life time of default security group cannot be controlled, so in fact the resource `yandex_vpc_default_security_group` does not create or delete any security groups, instead it simply takes or releases control of the default security group.

{% note warning %}

When Terraform takes over management of the default security group, it **deletes** all info in it (including security group rules) and replace it with specified configuration. When Terraform drops the management (i.e. when resource is deleted from statefile and management), the state of the security group **remains the same** as it was before the deletion.

{% endnote %}


{% note warning %}

Duplicating a resource (specifying same `network_id` for two different default security groups) will cause errors in the apply stage of your's configuration.

{% endnote %}


## Example usage

```terraform
//
// Create a new VPC Security Group.
//
resource "yandex_vpc_security_group" "sg1" {
  name        = "My security group"
  description = "description for my security group"
  network_id  = yandex_vpc_network.lab-net.id

  labels = {
    my-label = "my-label-value"
  }

  ingress {
    protocol       = "TCP"
    description    = "rule1 description"
    v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
    port           = 8080
  }

  egress {
    protocol       = "ANY"
    description    = "rule2 description"
    v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
    from_port      = 8090
    to_port        = 8099
  }

  egress {
    protocol       = "UDP"
    description    = "rule3 description"
    v4_cidr_blocks = ["10.0.1.0/24"]
    from_port      = 8090
    to_port        = 8099
  }
}

// Auxiliary resources
resource "yandex_vpc_network" "lab-net" {
  name = "lab-network"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `network_id` (**Required**)(String). ID of the network this security group belongs to.
- `status` (*Read-Only*) (String). Status of this security group.
- `egress` [Block]. A list of egress rules.
  - `description` (String). Description of the rule.
  - `from_port` (Number). Minimum port number.
  - `id` (*Read-Only*) (String). The resource identifier.
  - `labels` (Map Of String). Labels to assign to this rule.
  - `port` (Number). Port number (if applied to a single port).
  - `predefined_target` (String). Special-purpose targets. `self_security_group` refers to this particular security group. `loadbalancer_healthchecks` represents [loadbalancer health check nodes](https://yandex.cloud/docs/network-load-balancer/concepts/health-check).
  - `protocol` (**Required**)(String). One of `ANY`, `TCP`, `UDP`, `ICMP`, `IPV6_ICMP`.
  - `security_group_id` (String). Target security group ID for this rule.
  - `to_port` (Number). Maximum port number.
  - `v4_cidr_blocks` (List Of String). The blocks of IPv4 addresses for this rule.
  - `v6_cidr_blocks` (List Of String). The blocks of IPv6 addresses for this rule. `v6_cidr_blocks` argument is currently not supported. It will be available in the future.
- `ingress` [Block]. A list of ingress rules.
  - `description` (String). Description of the rule.
  - `from_port` (Number). Minimum port number.
  - `id` (*Read-Only*) (String). The resource identifier.
  - `labels` (Map Of String). Labels to assign to this rule.
  - `port` (Number). Port number (if applied to a single port).
  - `predefined_target` (String). Special-purpose targets. `self_security_group` refers to this particular security group. `loadbalancer_healthchecks` represents [loadbalancer health check nodes](https://yandex.cloud/docs/network-load-balancer/concepts/health-check).
  - `protocol` (**Required**)(String). One of `ANY`, `TCP`, `UDP`, `ICMP`, `IPV6_ICMP`.
  - `security_group_id` (String). Target security group ID for this rule.
  - `to_port` (Number). Maximum port number.
  - `v4_cidr_blocks` (List Of String). The blocks of IPv4 addresses for this rule.
  - `v6_cidr_blocks` (List Of String). The blocks of IPv6 addresses for this rule. `v6_cidr_blocks` argument is currently not supported. It will be available in the future.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_vpc_security_group.<resource Name> <resource Id>
terraform import yandex_vpc_security_group.sg1 enphq**********cjsw4
```
