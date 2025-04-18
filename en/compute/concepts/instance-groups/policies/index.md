# Policies

When creating an instance group, you need to set _policies_ that describe the [zones](allocation-policy.md) for [deploying](deploy-policy.md), [scaling](scale-policy.md), and [recovering](healing-policy.md) group instances.

Both the policy and [instance template](../instance-template.md) descriptions are provided to the CLI as a YAML file using the `--file` flag when creating or updating an instance group. This is a convenient method to provide values that consist of multiple strings. For more information, see [{#T}](../../../operations/instance-groups/create-fixed-group.md).

## Use cases {#examples}

* [{#T}](../../../tutorials/vm-autoscale/index.md)
* [{#T}](../../../tutorials/autoscale-monitoring.md)
