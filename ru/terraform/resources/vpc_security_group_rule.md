---
subcategory: Virtual Private Cloud
---

# yandex_vpc_security_group_rule (Resource)

Manages `Security Group Rule` within the Yandex Cloud. For more information, see [Documentation](https://yandex.cloud/docs/vpc/concepts/security-groups).

{% note warning %}

There is another way to manage security group rules by `ingress` and `egress` arguments in `yandex_vpc_security_group` resource. Both ways are similar but not compatible with each other. Using `Security Group Rule` at the same time with `yandex_vpc_security_group` resource will cause a conflict of rules configuration and it's not recommended!

{% endnote %}


{% note warning %}

Either one `port` argument or both `from_port` and `to_port` arguments can be specified.

{% endnote %}


{% note warning %}

If `port` or `from_port`/`to_port` aren't specified or set by -1, ANY port will be sent.

{% endnote %}

{% note warning %}

Can't use specified port if protocol is one of `ICMP` or `IPV6_ICMP`.

{% endnote %}


{% note warning %}

One of arguments `v4_cidr_blocks`/`v6_cidr_blocks` or `predefined_target` or `security_group_id` must be specified.

{% endnote %}


## Example usage

```terraform
//
// Create a new VPC Security Group Rule.
//
resource "yandex_vpc_security_group" "group1" {
  name        = "My security group"
  description = "description for my security group"
  network_id  = yandex_vpc_network.lab-net.id

  labels = {
    my-label = "my-label-value"
  }
}

resource "yandex_vpc_security_group_rule" "rule1" {
  security_group_binding = yandex_vpc_security_group.group1.id
  direction              = "ingress"
  description            = "rule1 description"
  v4_cidr_blocks         = ["10.0.1.0/24", "10.0.2.0/24"]
  port                   = 8080
  protocol               = "TCP"
}

resource "yandex_vpc_security_group_rule" "rule2" {
  security_group_binding = yandex_vpc_security_group.group1.id
  direction              = "egress"
  description            = "rule2 description"
  v4_cidr_blocks         = ["10.0.1.0/24"]
  from_port              = 8090
  to_port                = 8099
  protocol               = "UDP"
}

// Auxiliary resources
resource "yandex_vpc_network" "lab-net" {
  name = "lab-network"
}
```

## Arguments & Attributes Reference

- `description` (String). The resource description.
- `direction` (**Required**)(String). Direction of the Security group rule. Can be `ingress` (inbound network traffic to the VPC network) or `egress` (outbound network traffic from the VPC network).
- `from_port` (Number). Minimum port number. Applicable for TCP and UDP protocols.
- `id` (*Read-Only*) (String). The resource identifier.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `port` (Number). Port number (if applied to a single port).
- `predefined_target` (String). Special-purpose targets. The `self_security_group` target refers to this particular security group. The `loadbalancer_healthchecks` target represents [NLB health check nodes](https://yandex.cloud/docs/network-load-balancer/concepts/health-check).
- `protocol` (String). Specific network protocol. Can be one of `ANY`, `TCP`, `UDP`, `ICMP`, `IPV6_ICMP`.
- `security_group_binding` (**Required**)(String). The id of target security group which rule belongs to.
- `security_group_id` (String). Target security group ID for this Security group rule.
- `to_port` (Number). Maximum port number. Applicable for TCP and UDP protocols.
- `v4_cidr_blocks` (List Of String). The list of IPv4 CIDR prefixes for this Security group rule.
- `v6_cidr_blocks` (List Of String). The list of IPv6 CIDR prefixes for this Security group rule. Not supported yet.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_vpc_security_group_rule.<resource Name> <security_group ID>:<resource Id>
terraform import yandex_vpc_security_group_rule.myrule enphq**********cjsw4:enp2h**********7akj7
```
