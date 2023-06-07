# Using deprecated {{ PG }} host classes

Starting June 1, 2020, the `s1.nano` and all `m1.*` host classes are deprecated for {{ mpg-short-name }}.

What this means for you as a user:
- Now you can no longer change the host class to `s1.nano` or `m1.*` for your cluster.
- You can still work with your cluster if it uses the `s1.nano` or `m1.*` class; however, you cannot [add new hosts](../operations/hosts.md) of any class to such a cluster.

   To add hosts to your cluster, you will need to [change the host class](../operations/update.md#change-resource-preset) to a [supported one](instance-types.md) first.

   For example, you can migrate:
   - From `s1.nano` to:
      - `s2.micro`: This is the most affordable host class with 100% guaranteed vCPU performance. It contains twice as many resources as `s1.nano`.
      - `b2.medium`: The closest host class in terms of computing resources. It costs less than `s1.nano`, but the guaranteed vCPU performance is lower: 50% instead of 100%.
   - From `m1.*` to `m2.*` (`m1.medium` to `m2.medium`).
- The [pricing](../pricing.md) for previously created `s1.nano` and `m1.*` does not change.
- You can [restore a cluster from a backup](../operations/cluster-backups.md) only to [existing host classes](instance-types.md).

   You cannot restore a cluster from a backup to `s1.nano` or `m1.*` hosts even if the backup was created from a cluster consisting of such hosts.
