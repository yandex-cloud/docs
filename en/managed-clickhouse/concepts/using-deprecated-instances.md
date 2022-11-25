# Using deprecated host classes in {{ mch-name }}

As of June 1, 2020, the `s1.nano` host class is deprecated for {{ mch-short-name }}.

What this means for service users:
- Now you can't change the host class to `s1.nano` for your cluster.
- You can still operate your cluster if it uses the `s1.nano` class but you can't [add new hosts to such a cluster](../operations/hosts.md).

   To be able to add hosts to the cluster, [change the host class](../operations/update.md#change-resource-preset) to a [supported class](instance-types.md).

   For example, you can migrate from `s1.nano` to:
   - `s2.micro`: The most affordable host class with 100% guaranteed vCPU performance. Contains twice as many resources as `s1.nano`.
   - `b2.medium`: The closest host class in terms of computing resources. Costs less than `s1.nano`, but the guaranteed vCPU performance is lower: 50% instead of 100%.
{% if audience != "internal" %}
- [Pricing rules](../pricing.md) for previously created `s1.nano` hosts don't change.
{% endif %}
- You can [restore a cluster from a backup](../operations/cluster-backups.md) only to [existing host classes](instance-types.md).

   You can't restore a cluster from a backup to `s1.nano` hosts even if the backup was made from a cluster with these hosts.
