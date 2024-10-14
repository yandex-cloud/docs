Specifics of working with security groups:

- Even if the cluster and host are in the same security group, rules allowing traffic between them must be in place to establish a connection to the cluster from that host. By default, such rules are included in the security group created together with the cloud network. They are the `Self` rules that allow unlimited traffic within a security group.

- Security group settings only affect whether it will be possible to connect to the cluster. They do not affect cluster features, such as replication, sharding, and backups.

For more information, see the [{{ vpc-name }} documentation](../../vpc/concepts/security-groups.md).
