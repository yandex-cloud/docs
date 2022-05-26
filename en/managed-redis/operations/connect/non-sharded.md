# Connecting to a non-sharded cluster

You can connect to a non-sharded Redis cluster:

* Using Redis Sentinel.

   {{ RD }} Sentinel is a {{ RD }} host management system that provides monitoring, notification, [automatic failover](../failover.md), and reporting of up-to-date host addresses to the clients.

   Unencrypted connection is supported via port `{{ port-mrd-sentinel }}` for clusters with any version of {{ RD }}.

   If a client application does not support connecting via Sentinel, connect directly to the master host. If there is no need for a direct connection, use Sentinel for more reliable cluster host management.

   For more information about Sentinel, see [{#T}](../../concepts/replication.md) and the [{{ RD }} documentation](https://redis.io/topics/sentinel).

* Directly to the master host.

   Encrypted connection is supported via port `{{ port-mrd-tls }}` and unencrypted via port `{{ port-mrd }}`.

   {% include [How to use TLS](../../../_includes/mdb/mrd/connect/how-to-use-tls.md) %}

   To always connect to the master host in a non-sharded cluster, use a [special FQDN](#special-fqdns) that always points to the master host, or track the roles of all the cluster hosts yourself.

## Special FQDNs {#special-fqdns}

{{ mrd-name }} provides special FQDNs that can be used instead of regular [host FQDNs](../hosts.md#list) to connect to non-sharded clusters.

### Current master {#fqdn-master}

A FQDN like `c-<cluster ID>.rw.{{ dns-zone }}` in a non-sharded cluster always points to the current master host. The cluster ID can be requested with a [list of clusters in the folder](../cluster-list.md#list-clusters).

When connecting to this FQDN, both read and write operations are allowed.

An example an SSL-encrypted connection to a master host for a cluster with `c9qash3nb1v9ulc8j9nm` as the ID:

```bash
redis-cli -h c-c9qash3nb1v9ulc8j9nm.rw.{{ dns-zone }} \
  -p 6380 \
  --tls \
  --cacert ~/.redis/YandexInternalRootCA.crt \
  -a <{{ RD }} password>
```

## Connecting to cluster hosts from graphical IDEs {#connection-ide}

{% include [IDE environment settings](../../../_includes/mdb/mrd/ide-envs.md) %}

You can only use graphical IDEs to connect to cluster hosts through an SSL tunnel using a [created VM](./index.md#connect). Before connecting [prepare a certificate](./index.md#get-ssl-cert).

{% list tabs %}

* DBeaver

   Connections to {{ RD }} clusters are only available in [commercial versions of DBeaver](https://dbeaver.com/buy/).

   To connect to a cluster:

   1. Create a new DB connection:
      1. In the **Database** menu, select **New connection**.
      1. Select the **{{ RD }}** database from the list.
      1. Click **Next**.
      1. Specify the connection parameters on the **Main** tab:
         * **Host**: FQDN of the master host or a [special FQDN](./non-sharded.md#special-fqdns) always pointing to the current master host.
         * **Port**: `{{ port-mrd }}` for a regular cluster or `{{ port-mrd-tls }}` for a cluster with SSL encryption enabled.
         * Under **Authentication**, specify the cluster password.
      1. On the **SSH** tab:
         1. Enable the **Use SSL tunnel** setting.
         1. Specify the SSH tunnel parameters:
            * **Host/IP**: Public IP address of the [VM to connect to](./index.md#connect).
            * **Username**: Username for connecting to the VM.
            * **Authentication method**: `Public key`.
            * **Secret key**: Path to the file with the private key used for connecting to the VM.
            * **Passphrase**: Password of the private key.
      1. On the **SSL** tab:
         1. Enable the **Use SSL** and **Skip hostname validation** settings.
         1. Under **Method**:
            1. Enable the **Set of certificates** setting.
            1. In the **Root certificate** field, specify the path to the file with an [SSL certificate for the connection](./index.md#get-ssl-cert).
   1. Click **Test Connection ...** to test a DB connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
   1. Click **Ready** to save the database connection settings.

{% endlist %}

## Sample connection strings {#connection-string}

{% include [Environment settings](../../../_includes/mdb/mdb-conn-strings-env.md) %}

{% include [How to see FQDN](../../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [Connection strings for non-sharded cluster](../../../_includes/mdb/mrd/conn-strings-non-sharded.md) %}
