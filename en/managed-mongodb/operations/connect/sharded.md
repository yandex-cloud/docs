---
title: "How to connect to a sharded {{ MG }} cluster"
description: "In this tutorial, you will learn how to connect to a sharded {{ MG }} cluster."
---

# Connecting to a sharded {{ MG }} cluster

## Connecting from graphical IDEs {#connection-ide}

{% include [ide-environments](../../../_includes/mdb/mmg-ide-envs.md) %}

You can only use graphical IDEs to connect to public cluster hosts using SSL certificates.

{% include [note-connection-ide](../../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DataGrip {#datagrip}

   1. Create a data source:
      1. Select **File** → **New** → **Data Source** → **{{ MG }}**.
      1. On the **General** tab:
         1. Specify the connection parameters:
            * **User**, **Password**: DB user's name and password.
            * **URL**: Connection string:

               ```http
               mongodb://<FQDN_of_MONGOINFRA_or_MONGOS_host_1>:{{ port-mmg-sharded }},...<FQDN_of_MONGOINFRA_or_MONGOS_host_N>:{{ port-mmg-sharded }}/<DB_name>
               ```

               {% include [see-fdqn-host](../../../_includes/mdb/mmg/fqdn-host.md) %}

         1. Click **Download** to download the connection driver.
      1. On the **SSH/SSL** tab:
         1. Enable the **Use SSL** setting.
         1. In the **CA file** field, specify the path to the file with an [SSL certificate for the connection](./index.md#get-ssl-cert).
   1. Click **Test Connection** to test the connection. If the connection is successful, you will see the connection status and information about the DBMS and driver.
   1. Click **OK** to save the data source.

- DBeaver {#dbeaver}

   Connections to {{ MG }} clusters are only available in [DBeaver business editions](https://dbeaver.com/buy/).

   To connect to a cluster:

   1. Create a new DB connection:
      1. In the **Database** menu, select **New connection**.
      1. Select **{{ MG }}** from the DB list.
      1. Click **Next**.
      1. Specify the connection parameters on the **Main** tab:
         1. Under **Address**, change the **Type** value to `URL` and specify the connection string:

            ```http
            mongodb://<FQDN_of_MONGOINFRA_or_MONGOS_host_1>:{{ port-mmg-sharded }},...<FQDN_of_MONGOINFRA_or_MONGOS_host_N>:{{ port-mmg-sharded }}/<DB_name>
            ```

            {% include [see-fdqn-host](../../../_includes/mdb/mmg/fqdn-host.md) %}

         1. In the **Device** list, select `SCRAM-SHA-256` (type of password encryption when connecting to the DB).
         1. Under **Authentication**, specify the DB username and password.
      1. On the **SSL** tab:
         1. Enable **Use SSL**.
         1. In the **Root certificate** field, specify the path to the saved [SSL certificate](./index.md#get-ssl-cert) file.
         1. Under **Settings**, select **Skip hostname validation**.
   1. Click **Test connection ...** to test the connection. If the connection is successful, you will see the connection status and information about the DBMS and driver.
   1. Click **Ready** to save the database connection settings.

{% endlist %}

{% include [How to connect from a Dockerfile](../../../_includes/mdb/mmg/docker-and-mongodb.md) %}

## Examples of connection strings {#connection-string}

{% include [conn-strings-environment](../../../_includes/mdb/mdb-conn-strings-env.md) %}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

The examples below assume that the `root.crt` SSL certificate is located in the directory:

* `/home/<home_directory>/.mongodb/` for Ubuntu.
* `$HOME\.mongodb` for Windows.

If the connection to the cluster and the test query are successful, the following data is output:

* For PHP examples, the `ping` command result.
* For other examples, the name of the database the connection was established to.

{% include [mmg-connection-strings](../../../_includes/mdb/mmg/shard-conn-strings.md) %}
