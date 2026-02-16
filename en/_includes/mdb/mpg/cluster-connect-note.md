* Via the internet, if you [configured](../../../managed-postgresql/operations/hosts.md#update) public access for the host. You can connect over the internet in the following ways:
  * Using an SSL connection.
  * Using IAM authentication.



* From {{ yandex-cloud }} virtual machines located in the same [cloud network](../../../vpc/concepts/network.md). For hosts without public access, SSL is not required to connect to them from these virtual machines.

* From the [{{ serverless-containers-name }}](../../../serverless-containers/concepts/index.md) container. For hosts without public access, the container must reside in the same cloud network.

