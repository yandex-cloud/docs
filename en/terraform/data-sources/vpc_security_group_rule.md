---
subcategory: Virtual Private Cloud
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

- `description` (*Read-Only*) (String). 
- `direction` (*Read-Only*) (String). 
- `from_port` (*Read-Only*) (Number). 
- `id` (*Read-Only*) (String). 
- `labels` (*Read-Only*) (Map Of String). 
- `port` (*Read-Only*) (Number). 
- `predefined_target` (*Read-Only*) (String). 
- `protocol` (*Read-Only*) (String). 
- `rule_id` (**Required**)(String). 
- `security_group_binding` (**Required**)(String). 
- `security_group_id` (*Read-Only*) (String). 
- `to_port` (*Read-Only*) (Number). 
- `v4_cidr_blocks` (*Read-Only*) (List Of String). 
- `v6_cidr_blocks` (*Read-Only*) (List Of String).


