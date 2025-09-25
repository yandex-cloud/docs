# Using deprecated host classes in {{ mmg-name }}

Starting January 1, 2024, the `b1.nano`, `b1.micro`, `b1.small`, `b2.nano`, `b2.micro`, and `b2.small` host classes are deprecated for {{ mmg-name }}.

What this means for you as a user:

- You will not be able to continue using your cluster if it uses host classes `b1.nano`, `b1.micro`, `b1.small`, `b2.nano`, `b2.micro`, or `b2.small`.

- If your cluster uses hosts of these classes, you will not be able [to add new hosts of any class to it](../operations/hosts.md).

  To add hosts, first [change the cluster's host class](../operations/update.md#change-resource-preset) to a [valid one](instance-types.md), e.g., `b1.medium` or `b2.medium`.

- You can [restore a cluster from a backup](../operations/cluster-backups.md) only to [valid host classes](instance-types.md).

  You cannot restore a cluster from a backup to `b1.nano`, `b1.micro`, `b1.small`, `b2.nano`, `b2.micro`, and `b2.small` class hosts even if the backup was created from a cluster consisting of such hosts.
