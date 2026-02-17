---
subcategory: Virtual Private Cloud
---

# yandex_vpc_security_group (DataSource)

Get information about a Yandex VPC Security Group Rule. For more information, see [the official documentation](https://yandex.cloud/docs/vpc/concepts/security-groups).

This data source used to define Security Group Rule that can be used by other resources.

## Example usage

```terraform
//
// Get information about existing VPC Security Group.
//
data "yandex_vpc_security_group" "group1" {
  security_group_id = "my-id"
}

data "yandex_vpc_security_group" "group1" {
  name = "my-group1"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
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
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
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
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `network_id` (**Required**)(String). ID of the network this security group belongs to.
- `security_group_id` (String). ID of Security Group that owns the rule.
- `status` (*Read-Only*) (String). Status of this security group.


