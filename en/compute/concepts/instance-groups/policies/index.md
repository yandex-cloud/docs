---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Policies

When creating an instance group, you need to define _policies_ for [zone allocation](allocation-policy.md), [deployment](deploy-policy.md), and [scaling](scale-policy.md) of instances in the instance group.

The policy description and [instance template](../instance-template.md) description are passed to the CLI as a YAML file when creating or updating an instance group with the `--file` flag. This is convenient for passing values that consist of multiple strings. For more information, see [{#T}](../../../operations/instance-groups/create-fixed-group.md).

