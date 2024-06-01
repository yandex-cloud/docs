# Connecting to a sharded {{ RD }} cluster

To connect to a [sharded](../../concepts/sharding.md) Redis cluster, in connection strings, specify the FQDNs of master hosts in each shard.

Encrypted connection is supported via port `{{ port-mrd-tls }}` and unencrypted via port `{{ port-mrd }}`.

{% include [How to use TLS](../../../_includes/mdb/mrd/connect/how-to-use-tls.md) %}

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
         * **Host**: Specify comma-separated FQDNs of master hosts in each shard.

            {% include [see-fqdn](../../../_includes/mdb/mrd/fqdn-host.md) %}

         * **Port**: `{{ port-mrd }}` for a regular cluster or `{{ port-mrd-tls }}` for a cluster with SSL encryption enabled.
         * Under **Authentication**, specify the cluster password.
      1. On the **SSH** tab:
         1. Enable the **Use SSL tunnel** setting.
         1. Specify the SSH tunnel parameters:
            * **Host/IP**: Public IP address of the [VM to connect to](./index.md#connect).
            * **Username**: Username for connecting to the VM.
            * **Authentication method**: `Public key`.
            * **Secret key**: Path to the file with the private key used for connecting to the VM.
            * **Passphrase**: Private key password.
      1. On the **SSL** tab:
         1. Enable the **Use SSL** and **Skip hostname validation** settings.
         1. Under **Parameters**:
            1. Select **Method**: **Set of certificates**.
            1. In the **Root certificate** field, specify the path to the saved [SSL certificate](./index.md#get-ssl-cert) file.
   1. Click **Test connection ...** to test a DB connection. If the connection is successful, you will see the connection status and information about the DBMS and driver.
   1. Click **Ready** to save the database connection settings.

{% endlist %}

{% include [How to connect from a Dockerfile](../../../_includes/mdb/mrd/connect/docker-and-redis.md) %}

## Examples of connection strings {#connection-string}

{% include [Environment settings](../../../_includes/mdb/mdb-conn-strings-env.md) %}

{% include [How to see FQDN](../../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [Connection strings for sharded cluster](../../../_includes/mdb/mrd/conn-strings-sharded.md) %}
