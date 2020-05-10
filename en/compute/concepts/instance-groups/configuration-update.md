# Instance group configuration update

On public image-based VMs, the OS and software are not updated automatically. You can update them on your own.

To do this:

1. Describe the appropriate instance [template](instance-template.md).
1. Set the desired [deployment policy](policies.md#deploy-policy).
1. Run the [update operation](../../operations/instance-groups/update.md) for the group.

## Update with group degradation {#update-with-group-degradation}

Sequential updates of instances in a group.

For example, to update a group by taking one instance out of service at a time, set the following parameters in the `deploy-policy`:

```
...
deploy-policy:
    max_unavailable: 1
    max_expansion: 0
    ...
...
```


## Update with additional resources allocated {#max-expansion}

Update by creating instances with a new configuration. As you add instances with a new configuration to the group, those with the old configuration are deleted.

For example, to update one group instance at a time, set the following parameters in the `deploy-policy`:

```
...
deploy-policy:
    max_unavailable = 0
    max_expansion = 1
    ...
...
```
