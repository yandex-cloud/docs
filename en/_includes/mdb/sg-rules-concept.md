Features of using security groups:

- Even if the cluster and host share the same security group, you still need rules allowing traffic between them to be able to connect to the cluster from the host. By default, such rules are included in the security group created along with the cloud network. These are the `Self` rules that allow unlimited traffic within the security group.

- Security group settings only determine whether connecting to the cluster is possible. They do not affect cluster features, such as replication, sharding, and backups.

For more information, see [this {{ vpc-name }} article](../../vpc/concepts/security-groups.md).
