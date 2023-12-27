# Using deprecated host classes in {{ mmy-name }}

Starting January 1, 2024, the `b1.nano`, `b1.micro`, `b1.small`, `b2.nano`, `b2.micro`, and `b2.small` host classes will be deprecated for {{ mmy-name }}.

What this means for you as a user:

- You will no longer be able to run your cluster if it uses the `b1.nano`, `b1.micro`, `b1.small`, `b2.nano`, `b2.micro`, or `b2.small` host classes.

- If your cluster uses hosts of these classes, you will not be able [to add new hosts of any class to your cluster](../operations/hosts.md).

   To add hosts to your cluster, first [change the host class](../operations/update.md#change-resource-preset) to a [supported one](instance-types.md), for example, `b1.medium` or `b2.medium`.

- You can [restore a cluster from a backup](../operations/cluster-backups.md) only to [existing host classes](instance-types.md).

   You cannot restore a cluster from a backup to `b1.nano`, `b1.micro`, `b1.small`, `b2.nano`, `b2.micro`, or `b2.small` hosts even if the backup was created from a cluster consisting of such hosts.
