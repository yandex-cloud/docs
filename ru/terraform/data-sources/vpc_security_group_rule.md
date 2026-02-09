---
subcategory: Virtual Private Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/vpc_security_group_rule.md
---

# yandex_vpc_security_group_rule (DataSource)



## Example usage

```terraform
//
// Get information about existing VPC Security Group Rule.
//
data "yandex_vpc_security_group_rule" "rule1" {
  security_group_binding = "my-sg-id"
  rule_id                = "my-rule-id"
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
- `rule_id` (**Required**)(String). 
- `security_group_binding` (**Required**)(String). The id of target security group which rule belongs to.
- `security_group_id` (String). Target security group ID for this Security group rule.
- `to_port` (Number). Maximum port number. Applicable for TCP and UDP protocols.
- `v4_cidr_blocks` (List Of String). The list of IPv4 CIDR prefixes for this Security group rule.
- `v6_cidr_blocks` (List Of String). The list of IPv6 CIDR prefixes for this Security group rule. Not supported yet.


