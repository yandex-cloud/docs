# Policies

When creating an instance group, you need to define _policies_ for [deploying](deploy-policy.md) and [scaling](scale-policy.md) instances and selecting [zones](allocation-policy.md).

Both the policy and [instance template](../instance-template.md) descriptions are provided to the CLI as a YAML file using the `--file` flag when creating or updating an instance group. This is a convenient method to provide values that consist of multiple strings. For more information, see [{#T}](../../../operations/instance-groups/create-fixed-group.md).