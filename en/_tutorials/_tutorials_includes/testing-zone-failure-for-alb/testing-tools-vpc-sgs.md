We recommend using [VPC security groups](../../../vpc/concepts/security-groups.md) as an additional isolation tool for the disabled zone.

**Important note**: When using VPC security groups, consider the following specifics:
* Security groups support allowing rules only; therefore, to block traffic you need a separate set of rules that allow traffic between zones. To implement blocking, these rules will have to be deleted.
* By deleting the allowing rules from a security group you block new network connections without terminating the existing ones.