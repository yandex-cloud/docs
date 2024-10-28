[Security groups](../../vpc/concepts/security-groups.md) follow the _All traffic that is not allowed is prohibited_ principle. To connect to a cluster, configure security group rules. These rules allow traffic from certain ports, IP addresses, or other security groups. For example, a VM will not be able to connect to a cluster in the following cases:

* The VM is in subnet 10.128.0.0/16, whereas the incoming traffic rules only specify subnet 10.133.0.0/24.
* The VM is in subnet 10.133.0.0/24 but attempts to access a port not specified in the security group rules.
