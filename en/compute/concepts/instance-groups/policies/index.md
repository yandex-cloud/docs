# Policies

When creating an instance group, you need to set _policies_ that describe the [zones](allocation-policy.md) for [deploying](deploy-policy.md), [scaling](scale-policy.md), and [recovering](healing-policy.md) group instances.

In CLI, the policy description is provided together with the [instance template](../instance-template.md) description as a YAML file when creating or updating an instance group with the help of the `--file` parameter. This is a convenient method to provide values that consist of multiple strings. For more information, see [{#T}](../../../operations/instance-groups/create-fixed-group.md).

## Use cases {#examples}

* [{#T}](../../../tutorials/vm-autoscale/index.md)
* [{#T}](../../../tutorials/autoscale-monitoring.md)
