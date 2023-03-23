* Over the internet, if you [configured](../../../managed-clickhouse/operations/hosts.md#update) public access for the appropriate host. You can only connect to such hosts over an SSL connection.


* From {{ yandex-cloud }} virtual machines located in the same [cloud network](../../../vpc/concepts/network.md). If there is no public access to a host, connections from this type of virtual machine don't need to be over SSL.

