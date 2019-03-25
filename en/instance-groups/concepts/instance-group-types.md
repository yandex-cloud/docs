# Group types

When creating a group, you need to select its type. The type determines whether the group will be scaled automatically or manually. Currently, groups can only be scaled manually.

To set the type, select the appropriate [scaling policy](instance-group-policies.md#scale-policy) when creating a group.

## A fixed-size group {#fixed-scale}

[!KEYREF compute-full-name] allows you to create groups of similar instances of a fixed size. To do this, select a fixed [scaling policy](instance-group-policies.md#scale-policy) for instances. The group size will be set manually.

With manual control, you can:

- Add the required number of instances if your application needs additional computing resources.
- Reduce the number of instances in the group if the instances are not used at full capacity.

