---
title: How do I connect to a non-sharded {{ RD }} cluster in {{ mrd-full-name }}?
description: Follow this guide to connect to a non-sharded {{ RD }} cluster.
---

# Connecting to a non-sharded {{ RD }} cluster

You can connect to a non-sharded {{ RD }} cluster:

* Using {{ RD }} Sentinel.

    {{ RD }} Sentinel is a {{ RD }} host management system that provides monitoring, notification, [automatic failover](../failover.md), and reporting of up-to-date host addresses to the clients.

    Unencrypted connection is supported via port `{{ port-mrd-sentinel }}` for clusters with any version of {{ RD }}.

    If a client application does not support connecting via Sentinel, connect directly to the master host. If there is no need for a direct connection, use Sentinel for more reliable cluster host management.

    For more information about Sentinel, see [{#T}](../../concepts/replication.md) and the [{{ RD }} documentation](https://valkey.io/topics/sentinel).

* Directly to the master host.

    Encrypted connection is supported via port `{{ port-mrd-tls }}` and unencrypted via port `{{ port-mrd }}`.

    {% include [How to use TLS](../../../_includes/mdb/mrd/connect/how-to-use-tls.md) %}

    To always connect to the master host in a non-sharded cluster, use a [special FQDN](#special-fqdns) that always points to the master host, or track the roles of all the cluster hosts yourself.

## Special FQDNs {#special-fqdns}

{{ mrd-name }} provides special FQDNs that can be used instead of regular [host FQDNs](index.md#fqdn) to connect to non-sharded clusters.

{% note warning %}

If, when the [master host is changed automatically](../../concepts/replication.md#master-failover), a host with no public access becomes a new master host, you will not be able to connect to it from the internet. To avoid this, [enable public access](../hosts.md#update) for all cluster hosts.

{% endnote %}

### Current master {#fqdn-master}

In a non-sharded cluster, an FQDN of `c-<cluster_ID>.rw.{{ dns-zone }}` format always points to the current master host. You can get the cluster ID with a [list of clusters in the folder](../cluster-list.md#list-clusters).

When connecting to this FQDN, both read and write operations are allowed.

Here is an example of an SSL-encrypted connection to a master host for a cluster with the `c9qash3nb1v9********` ID:

```bash
redis-cli -h c-c9qash3nb1v9********.rw.{{ dns-zone }} \
  -p 6380 \
  --tls \
  --cacert ~/.redis/{{ crt-local-file }} \
  -a <{{ RD }}_password>
```

## Connecting from graphical IDEs {#connection-ide}

{% include [IDE environment settings](../../../_includes/mdb/mrd/ide-envs.md) %}

You can only use graphical IDEs to connect to cluster hosts through an SSL tunnel using a [created VM](./index.md#connect). Before connecting, [prepare a certificate](./index.md#get-ssl-cert).

{% include [note-connection-ide](../../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DBeaver {#dbeaver}

    Connections to {{ RD }} clusters are only available in [DBeaver business editions](https://dbeaver.com/buy/).

    To connect to a cluster:

    1. Create a new DB connection:
        1. In the **Database** menu, select **New connection**.
        1. Select **{{ RD }}** from the DB list.
        1. Click **Next**.
        1. Specify the connection parameters on the **Main** tab:
            * **Host**: [FQDN of the master host](./index.md#fqdn) or a [special FQDN](./non-sharded.md#special-fqdns) always pointing to the current master host.
            * **Port**: `{{ port-mrd }}` for a regular cluster or `{{ port-mrd-tls }}` for a cluster with SSL encryption enabled.
            * Under **Authentication**, specify the cluster password.
        1. On the **SSH** tab:
            1. Enable the **Use SSL tunnel** setting.
            1. Specify the SSH tunnel parameters:
                * **Host/IP**: Public IP address of the [VM for connection](./index.md#connect).
                * **Username**: Username for connecting to the VM.
                * **Authentication method**: `Public key`.
                * **Secret key**: Path to the file with the private key used for connecting to the VM.
                * **Passphrase**: Private key password.
        1. On the **SSL** tab:
            1. Enable the **Use SSL** and **Skip hostname validation** settings.
            1. Under **Parameters**:
                1. Select **Method**: **Set of certificates**.
                1. In the **Root certificate** field, specify the path to the saved [SSL certificate](./index.md#get-ssl-cert) file.
    1. Click **Test Connection ...** to test the DB connection. If the connection is successful, you will see the connection status and information about the DBMS and driver.
    1. Click **Ready** to save the database connection settings.

{% endlist %}

{% include [How to connect from a Dockerfile](../../../_includes/mdb/mrd/connect/docker-and-redis.md) %}

## Examples of connection strings {#connection-string}

{% include [Environment settings](../../../_includes/mdb/mdb-conn-strings-env.md) %}

{% include [How to see FQDN](../../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [Connection strings for non-sharded cluster](../../../_includes/mdb/mrd/conn-strings-non-sharded.md) %}
