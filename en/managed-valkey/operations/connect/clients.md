---
title: How to connect to a {{ VLK }} cluster in {{ mrd-full-name }}
description: Follow this guide to connect to a {{ VLK }} cluster.
---

# Connecting to an {{ VLK }} cluster from applications

You can connect to a {{ VLK }} cluster using [command line tools](#command-line-tools), [graphical IDEs](#connection-ide), or [Docker containers](#connection-docker). To learn how to connect from your application code, see [Code examples](./code-examples.md).

## Command line tools {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

The setup method depends on whether [sharding](../../concepts/sharding.md) is enabled in the cluster.

### redis-cli {#redis-cli}

For {{ VLK }} clusters, there is support for encrypted connections on port `{{ port-mrd-tls }}` and unencrypted connections on port `{{ port-mrd }}`.

{% include [How to use TLS](../../../_includes/mdb/mvk/connect/how-to-use-tls.md) %}

To always connect to the master in a non-sharded cluster, use a [special FQDN](fqdn.md#special-fqdn) that always points to the master, or track the roles of all cluster hosts yourself.

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

    1. {% include [Install requirements](../../../_includes/mdb/mvk/connect/bash/install-requirements.md) %}

    1. **Connect directly to the master host:**

       * In a sharded cluster:

          ```bash
          redis-cli \
              -h c-<cluster_ID>.rw.{{ dns-zone }} \
              -a <password>
          ```
       * In a non-sharded cluster:

          ```bash
           redis-cli \
               -c \
               -h <FQDN_of_master_host_in_target_shard> \
               -a <password>
           ```

- Connecting with SSL {#with-ssl}

    1. {% include [Install requirements SSL](../../../_includes/mdb/mvk/connect/bash/install-requirements-ssl.md) %}

    1. **Connect directly to the master host:**

       * In a sharded cluster:

         {% include [default-connstring](../../../_includes/mdb/mvk/default-connstring.md) %}

       * In a non-sharded cluster:

          ```bash
          redis-cli \
              -c \
              -h <FQDN_of_master_host_in_target_shard> \
              -a <password> \
              -p {{ port-mrd-tls }} \
              --tls \
              --cacert ~/.redis/{{ crt-local-file }} \
          ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mvk/fqdn-host.md) %}

{% include [after-connect](../../../_includes/mdb/mvk/connect/bash/after-connect.md) %}

### {{ VLK }} Sentinel {#redis-sentinel}

{{ VLK }} Sentinel is a {{ VLK }} host management system that enables monitoring, notification, [automatic failover](../failover.md), and providing clients with the current host addresses.

For non-sharded clusters, there is support for unencrypted connections on port `{{ port-mrd-sentinel }}` with any {{ VLK }} version.

If your client application does not support connecting via Sentinel, connect directly to the master. Otherwise, use Sentinel for more reliable cluster host management:

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

    1. {% include [Install requirements](../../../_includes/mdb/mvk/connect/bash/install-requirements.md) %}

    1. **Get the master host address by using Sentinel and any {{ VLK }} host:**

        ```bash
        redis-cli \
            -h <FQDN_of_any_{{ VLK }}_host> \
            -p {{ port-mrd-sentinel }} \
            sentinel \
            get-master-addr-by-name <{{ VLK }}_cluster_name> | head -n 1
        ```

    1. **Connect to the host with this address:**

        ```bash
        redis-cli \
            -h <{{ VLK }}_master_host_address> \
            -a <{{ VLK }}_password>
        ``` 

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mvk/fqdn-host.md) %}

{% include [after-connect](../../../_includes/mdb/mvk/connect/bash/after-connect.md) %}

For more information about Sentinel, see [{#T}](../../concepts/replication.md) and [this {{ VLK }} guide](https://redis.io/topics/sentinel).

## Connecting from graphical IDEs {#connection-ide}

{% include [IDE environment settings](../../../_includes/mdb/mvk/ide-envs.md) %}

You can only use graphical IDEs to connect to cluster hosts through an SSL tunnel using the [VM you created](./index.md). Before connecting, [prepare a certificate](./index.md#get-ssl-cert).

{% include [note-connection-ide](../../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DBeaver {#dbeaver}

    Connections to {{ VLK }} clusters are only available in [DBeaver commercial editions](https://dbeaver.com/buy/).

    To connect to your cluster:

    1. Create a new database connection:
        1. In the **Database** menu, select **New connection**.
        1. Select **{{ VLK }}** from the DB list.
        1. Click **Next**.
        1. Specify the connection settings on the **Main** tab:
            * **Host**: [FQDN of the master host](./fqdn.md) or a [special FQDN](./fqdn.md#special-fqdns) always pointing to the current master host.
              When connecting to a sharded cluster, specify comma-separated [FQDNs of master hosts](./fqdn.md) in each shard.
            * **Port**: `{{ port-mrd }}` for a regular cluster, or `{{ port-mrd-tls }}` for a cluster with SSL encryption enabled.
            * Under **Authentication**, enter the cluster password.
        1. On the **SSH** tab:
            1. Enable **Use SSL tunnel**.
            1. Configure the SSH tunnel:
                * **Host/IP**: Public IP address of the [VM to connect to](./index.md).
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
    1. Click **Done** to save the database connection settings.

{% endlist %}

{% include [How to connect from a Dockerfile](../../../_includes/mdb/mvk/connect/docker-and-redis.md) %}
