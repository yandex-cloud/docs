[Security groups](../../vpc/concepts/security-groups.md) follow the rule that all traffic is denied unless you explicitly allow it. To connect to a cluster, configure security group rules. These rules allow traffic from certain ports, IP addresses, or other security groups. For example, a VM will not be able to connect to a cluster in the following cases:

* The VM is in the `10.128.0.0/16` subnet, whereas the inbound rules only allow `10.133.0.0/24`.
* The VM is in the `10.133.0.0/24` subnet but attempts to access a port not exposed in the security group rules.
