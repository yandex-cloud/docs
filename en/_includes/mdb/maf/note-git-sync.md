The `RSA`, `DSA`, `ECDSA`, and `Ed25519` private keys in `PKCS#1`, `PKCS#8`, `OpenSSL`, and `OpenSSH` formats are supported.

{% note warning %}

* The repository address must allow connections via the SSH protocol.

* The private key must not be password-protected.

* To use a Git repository, [configure internet access through a NAT gateway](../../../vpc/operations/create-nat-gateway.md) from the {{ maf-name }} cluster network. When configuring it, link a NAT gateway route table to all the cluster subnets.

{% endnote %}
