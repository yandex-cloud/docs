{% note warning %}

* The repository address must allow connections via the SSH protocol.

* The private key must not be password-protected.

* To use a Git repository, [configure internet access through a NAT gateway](../../../vpc/operations/create-nat-gateway.md) from the {{ maf-name }} cluster network. When configuring it, link a NAT gateway route table to all the cluster subnets.

{% endnote %}
