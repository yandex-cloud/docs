# Managing {{ OS }} users

You can manage cluster users as an `admin` user. You can specify a password for this user when [creating](cluster-create.md#create-cluster) or [updating](update.md) a cluster.

For information about how to manage users and what interfaces can be used for that, see the [{{ OS }} documentation]({{ os.docs }}/security-plugin/access-control/users-roles).

To perform routine tasks, create individual users with the minimum required [set of permissions]({{ os.docs }}/security-plugin/access-control/permissions/). It's not recommended to use the `admin` account for these purposes, because it has full access to the cluster. Running an incorrect command under the admin account may cause the cluster to fail.
