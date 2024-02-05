* Over the internet, if you [configured](../../../managed-postgresql/operations/hosts.md#update) public access for the appropriate host. You can only connect to such hosts over an SSL connection.


* From {{ yandex-cloud }} virtual machines located in the same [cloud network](../../../vpc/concepts/network.md). If there is no public access to a host, using SSL for connections from such virtual machines is not required.

* From the [{{ serverless-containers-name }}](../../../serverless-containers/concepts/index.md) container. If the host is not publicly accessible, the container must be located on the same cloud network.


