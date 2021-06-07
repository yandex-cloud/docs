Specifics of working with security groups:

- Security group settings only affect the capacity to connect to the cluster. They don't affect cluster features, such as replication, sharding, and backups.

- Even if the cluster and the connecting host are in the same security group, the connection won't be possible unless rules that allow traffic between the host and cluster are set up in this group.

  However, by default, those rules are contained in the security group that is added automatically when creating a cloud network. Those are the `Self` rules that allow unlimited traffic within a group.

For more information, see the [Virtual Private Cloud documentation](../../vpc/concepts/security-groups.md).

