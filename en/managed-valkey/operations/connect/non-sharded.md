---
title: How to connect to a non-sharded {{ VLK }} cluster in {{ mrd-full-name }}
description: Follow this guide to connect to a non-sharded {{ VLK }} cluster.
---

# Connecting to a non-sharded {{ VLK }} cluster

You can connect to a non-sharded {{ VLK }} cluster:

* Using {{ VLK }} Sentinel.

    {{ VLK }} Sentinel is a {{ VLK }} host management system that enables monitoring, notification, [automatic failover](../failover.md), and providing clients with the current host addresses.

    Clusters of any {{ VLK }} version support unencrypted connections on port `{{ port-mrd-sentinel }}`.

    If your client application does not support connecting via Sentinel, connect directly to the master. Otherwise, use Sentinel for more reliable cluster host management.

    For more information about Sentinel, see [{#T}](../../concepts/replication.md) and [this {{ VLK }} guide](https://valkey.io/topics/sentinel).

* Directly to the master.

    Encrypted connections use port `{{ port-mrd-tls }}`, while unencrypted ones, port `{{ port-mrd }}`.

    {% include [How to use TLS](../../../_includes/mdb/mvk/connect/how-to-use-tls.md) %}

    To always connect to the master in a non-sharded cluster, use a [special FQDN](#special-fqdns) that always points to the master, or track the roles of all cluster hosts yourself.

## Special FQDN {#special-fqdns}

{{ mrd-name }} provides a special FQDN that can be used instead of [regular host FQDNs](index.md#fqdn) to connect to non-sharded clusters.

In a non-sharded cluster, an FQDN of `c-<cluster_ID>.rw.{{ dns-zone }}` format always points to the current master host. You can get the cluster ID with the [list of clusters in the folder](../cluster-list.md#list-clusters). When connecting to this FQDN, you can perform read and write operations.

In multi-host clusters, a special FQDN may temporarily point to a replica host (for up to 10 minutes). This is because it takes time to update DNS records for special FQDNs. If your write request returns an error, repeat it later.

{% note warning %}

If [automatic failover](../../concepts/replication.md#master-failover) promotes a host without public access to master, you will not be able to connect to that host from the internet. To avoid this, [enable public access](../hosts.md#update) for all cluster hosts.

{% endnote %}

Here is an example of an SSL-encrypted connection to a master host for a cluster with the `c9qash3nb1v9********` ID:

```bash
redis-cli -h c-c9qash3nb1v9********.rw.{{ dns-zone }} \
  -p 6380 \
  --tls \
  --cacert ~/.redis/{{ crt-local-file }} \
  -a <{{ VLK }}_password>
```

{% include [special-fqdns-warning](../../../_includes/mdb/special-fqdns-warning.md) %}

## Connecting from graphical IDEs {#connection-ide}

{% include [IDE environment settings](../../../_includes/mdb/mvk/ide-envs.md) %}

You can only use graphical IDEs to connect to cluster hosts through an SSL tunnel using the [VM you created](./index.md#connect). Before connecting, [prepare a certificate](./index.md#get-ssl-cert).

{% include [note-connection-ide](../../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DBeaver {#dbeaver}

    Connections to {{ VLK }} clusters are only available in [DBeaver business editions](https://dbeaver.com/buy/).

    To connect to your cluster:

    1. Create a new database connection:
        1. In the **Database** menu, select **New connection**.
        1. Select **{{ VLK }}** from the database list.
        1. Click **Next**.
        1. Specify the connection settings on the **Main** tab:
            * **Host**: [FQDN of the master host](./index.md#fqdn) or a [special FQDN](./non-sharded.md#special-fqdns) always pointing to the current master host.
            * **Port**: `{{ port-mrd }}` for a regular cluster, or `{{ port-mrd-tls }}` for a cluster with SSL encryption enabled.
            * Under **Authentication**, enter the cluster password.
        1. On the **SSH** tab:
            1. Enable **Use SSL tunnel**.
            1. Configure the SSH tunnel:
                * **Host/IP**: Public IP address of the [VM to connect to](./index.md#connect).
                * **Username**: Username for connecting to the VM.
                * **Authentication method**: `Public key`.
                * **Secret key**: Path to the private key file for the VM connection.
                * **Passphrase**: Private key password.
        1. On the **SSL** tab:
            1. Enable **Use SSL** and **Skip hostname validation** settings.
            1. Under **Parameters**:
                1. Select **Method**: **Set of certificates**.
                1. In the **Root certificate** field, specify the path to the saved [SSL certificate](./index.md#get-ssl-cert) file.
    1. Click **Test Connection ...**. If the connection is successful, you will see the connection status, DBMS information, and driver details.
    1. Click **Ready** to save the database connection settings.

{% endlist %}

{% include [How to connect from a Dockerfile](../../../_includes/mdb/mvk/connect/docker-and-redis.md) %}

## Examples of connection strings {#connection-string}

{% include [Environment settings](../../../_includes/mdb/mdb-conn-strings-env.md) %}

{% include [How to see FQDN](../../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [Connection strings for non-sharded cluster](../../../_includes/mdb/mvk/conn-strings-non-sharded.md) %}
