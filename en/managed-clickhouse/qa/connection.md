# Connection

#### Is it possible to connect to individual {{ CH }} hosts? {#connect-node}

Yes. You can connect to {{ CH }} cluster hosts:

* Using the [HTTPS interface](https://{{ ch-domain }}/docs/en/interfaces/http_interface/):
    * Via an encrypted SSL connection on port 8443.
    * Without encryption through port 8123.

* Using the [command-line client](https://{{ ch-domain }}/docs/en/interfaces/cli/):
    * Via an encrypted SSL connection on port 9440.
    * Without encryption through port 9000.

SSH connections are not supported.

#### Why can't I connect to a host from the internet? {#fail-connection}

Most likely, no public access is enabled in your cluster, so you can only connect to it from a VM in {{ yandex-cloud }}. You can only request public access when [creating a new host](../concepts/network.md#public-access-to-a-host) in a cluster.

#### How do I connect to a non-public host in {{ yandex-cloud }}? {#private-host}

[Add](../operations/hosts.md#add-host) a new host with public access to your cluster and connect to a non-public host through it.

#### Can I connect to a public cluster without SSL? {#without-ssl}

No, you can only connect to public hosts using an SSL connection. For more information, see the [documentation](../operations/connect.md).
