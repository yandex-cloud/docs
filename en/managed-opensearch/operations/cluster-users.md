# Managing {{ OS }} users

You can manage cluster users as `admin`. You can set a password for this user when [creating](cluster-create.md#create-cluster) or [updating](update.md) a cluster.

Learn how to manage users and what interfaces you can use for that in [this {{ OS }} guide]({{ os.docs }}/security-plugin/access-control/users-roles).

To perform routine tasks, create individual users with the minimum required [permissions]({{ os.docs }}/security-plugin/access-control/permissions/). We do not recommend using the `admin` account for these purposes as it has full access to the cluster. Running an incorrect command as `admin` may cause the cluster to fail.
