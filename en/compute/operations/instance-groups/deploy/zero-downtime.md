---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Updating without downtime

To avoid service unavailability, you can update an instance group by creating additional instances with a new configuration.

As you add instances with a new configuration to the group, the instances with the old configuration are deleted.

To do this:

1. Define the desired [template](../../../concepts/instance-groups/instance-template.md) of an instance.
1. Set the [deployment policy](../../../concepts/instance-groups/policies/deploy-policy.md) with a non-zero value of `max_expansion`: the maximum number of additionally created instances.
1. Run the [update operation](../../../operations/instance-groups/update.md) for the group.

For example, to update a group using the algorithm described, set the following parameters in the `deploy-policy`:

```
...
deploy-policy:
    max_unavailable = 0
    max_expansion = 1
    ...
...
```

The group will be updated as follows:

![Blue-green deployment](../../../../_assets/instance-groups/blue-green.gif "Zero-downtime deployment")

