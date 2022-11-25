# Using deprecated host classes in {{ mmy-name }}

Starting June 1, 2020, host classes `s1.nano` and all `m1.*` are deprecated for {{ mmy-short-name }}.

What this means for service users:
- Now you can't change the host class to `s1.nano` and `m1.*` for your cluster.
- You can still operate your cluster if it uses the `s1.nano` or `m1.*` class but you can't [add new hosts](../operations/hosts.md) of any class to such a cluster.

   To be able to add hosts to the cluster, [change the host class](../operations/update.md#change-resource-preset) to a [supported class](instance-types.md).

   For example, you can migrate:
   - From `s1.nano` to:
      - `s2.micro`: The most affordable host class with 100% guaranteed vCPU performance. Contains twice as many resources as `s1.nano`.
      - `b2.medium`: The closest host class in terms of computing resources. Costs less than `s1.nano`, but the guaranteed vCPU performance is lower: 50% instead of 100%.
   - From `m1.*` to `m2.*` (from `m1.medium` to `m2.medium`).
      - [Pricing rules](../pricing.md) for earlier created `s1.nano` and `m1.*` hosts don't change.
- You can [restore a cluster from a backup](../operations/cluster-backups.md) only to [existing host classes](instance-types.md).

   You can't restore a cluster from a backup to `s1.nano` or `m1.*` hosts even if the backup was created from a cluster consisting of such hosts.
