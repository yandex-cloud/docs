# Connecting to a database in a {{ MG }} cluster

You can connect to {{ mmg-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

To connect to {{ mmg-name }} cluster hosts, specify port 27018. In the case of a sharded {{ mmg-name }} cluster, specify port 27017.

{% note info %}

If public access is only configured for certain hosts in your cluster, automatic primary replica change may make the primary replica unavailable over the internet.

{% endnote %}

## Connection limits {#connection-limits}

{% include [mmg-conn-limits](../../_includes/mdb/mmg-conn-limits.md) %}

Amount of RAM available to the host is determined by the host class. All available options are listed in [{#T}](../concepts/instance-types.md).

## Configuring an SSL certificate {#configuring-an-ssl-certificate}

{{ MG }} hosts with public access only support connections with an SSL certificate. You can prepare a certificate as follows:

{% if audience != "internal" %}

```bash
mkdir ~/.mongodb && \
wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.mongodb/root.crt && \
chmod 0600 ~/.mongodb/root.crt
```

{% else %}

```bash
mkdir ~/.mongodb && \
wget "{{ pem-path }}" -O ~/.mongodb/root.crt && \
chmod 0600 ~/.mongodb/root.crt
```

{% endif %}

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

You can connect to public {{ MG }} hosts only if you use an SSL certificate. Before connecting to such hosts, [prepare the certificate](#configuring-an-ssl-certificate).

These examples assume that the `root.crt` SSL certificate is located in the `/home/<home directory>/.mongodb/` folder.

Connecting without an SSL certificate is only supported for hosts that are not publicly accessible. For connections to the database, traffic inside the virtual network isn't encrypted in this case.

Write requests will be automatically routed to the primary cluster replica.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

### Connecting to a non-sharded cluster {#cluster-connect}

{% include [mmg-connection-strings](../../_includes/mdb/mmg-conn-strings.md) %}

If the connection to the cluster and the test query are successful, the following data is output:

1. For PHP examples, the `ping` command result.
1. For other examples, the name of the database the connection was established to.

### Connecting to a sharded cluster {#shard-connect}

{% include [mmg-connection-strings](../../_includes/mdb/mmg-shard-conn-strings.md) %}

If the connection to the cluster and the test query are successful, the following data is output:

1. For PHP examples, the `ping` command result.
1. For other examples, the name of the database the connection was established to.

