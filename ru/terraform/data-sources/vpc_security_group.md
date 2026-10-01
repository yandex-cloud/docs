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
- `description` (*Read-Only*) (String). The resource description.
- `egress` (*Read-Only*) (Set Of Object). A list of egress rules.
  - `description` . 
  - `from_port` . 
  - `id` . 
  - `labels` . 
  - `port` . 
  - `predefined_target` . 
  - `protocol` . 
  - `security_group_id` . 
  - `to_port` . 
  - `v4_cidr_blocks` . 
  - `v6_cidr_blocks` . 
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `ingress` (*Read-Only*) (Set Of Object). A list of ingress rules.
  - `description` . 
  - `from_port` . 
  - `id` . 
  - `labels` . 
  - `port` . 
  - `predefined_target` . 
  - `protocol` . 
  - `security_group_id` . 
  - `to_port` . 
  - `v4_cidr_blocks` . 
  - `v6_cidr_blocks` . 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `network_id` (*Read-Only*) (String). ID of the network this security group belongs to.
- `security_group_id` (String). ID of Security Group that owns the rule.
- `status` (*Read-Only*) (String). Status of this security group.


