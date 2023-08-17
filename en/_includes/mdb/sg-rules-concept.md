Specifics of working with security groups:

- To connect to a cluster, you need rules that allow traffic between the cluster and the connecting host, even if they are assigned to the same security group. By default, such rules are also included in the security group created along with the cloud network. Those are the `Self` rules that allow unlimited traffic within a security group.

- Security group settings only affect whether it will be possible to connect to the cluster. They do not affect cluster features, such as replication, sharding, and backups.

For more information, see the [{{ vpc-name }} documentation](../../vpc/concepts/security-groups.md).
