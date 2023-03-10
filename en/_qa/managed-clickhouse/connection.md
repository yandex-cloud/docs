# Connection to {{ CH }}

#### Is it possible to connect to individual {{ CH }} hosts? {#connect-node}

Yes. You can connect to {{ CH }} cluster hosts:

* Using the [HTTPS interface]({{ ch.docs }}/interfaces/http/):
   * Via an encrypted SSL connection on port 8443.
   * Without encryption through port 8123.

* Using the [command-line client]({{ ch.docs }}/interfaces/cli/):
   * Via an encrypted SSL connection on port 9440.
   * Without encryption through port 9000.

SSH connections are not supported.

#### Why can't I connect to a host from the internet? {#fail-connection}

Most likely, no public access is enabled for the cluster, so you can only connect to it from a VM in {{ yandex-cloud }}. You can only request public access when [creating a new host](../../managed-clickhouse/concepts/network.md#public-access-to-a-host) in your cluster.

#### How do I connect to a non-public host in {{ yandex-cloud }}? {#private-host}

[Connect](../../managed-clickhouse/operations/connect.md) to a host from a VM in {{ yandex-cloud }} hosted in the same cloud network, or [add](../../managed-clickhouse/operations/hosts.md#add-host) a new cluster host with public access and connect to a non-public host through it.

#### Can I connect to a public cluster without SSL? {#without-ssl}

No. You can only connect to public hosts using an SSL connection. For more information, see the [documentation](../../managed-clickhouse/operations/connect.md).
