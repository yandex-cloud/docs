# Using deprecated {{ MG }} host classes

As of June 1, 2020, the `s1.nano` host class is deprecated for {{ mmg-short-name }}.

What this means for you as a user:
- Now you cannot change the host class to `s1.nano` for your cluster.
- You can still operate your cluster if it uses the `s1.nano` class, but you cannot [add new hosts](../operations/hosts.md) of any class to such a cluster.

   To add hosts to your cluster, you will need to [change the host class](../operations/update.md#change-resource-preset) to a [supported one](instance-types.md) first.

   For example, you can migrate from `s1.nano` to:
   - `s2.micro`: This is the most affordable host class with 100% guaranteed vCPU performance. It contains twice as many resources as `s1.nano`.
   - `b2.medium`: The closest host class in terms of computing resources. It costs less than `s1.nano`, but the guaranteed vCPU performance is lower: 50% instead of 100%.


- [Pricing rules](../pricing.md) for previously created `s1.nano` hosts don't change.

- You can [restore a cluster from a backup](../operations/cluster-backups.md) only to [existing host classes](instance-types.md).

   You cannot restore a cluster from a backup to `s1.nano` hosts even if the backup was created from a cluster consisting of such hosts.

