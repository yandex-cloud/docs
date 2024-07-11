---
title: "Connecting to a {{ CH }} cluster in {{ mch-full-name }}"
description: "Follow this guide to connect to a database in a {{ CH }} cluster using command line tools, browser, graphical IDEs, and Docker container."
---

# Connecting to a {{ CH }} cluster from applications

This section provides settings for connecting to {{ mch-name }} cluster hosts using [command line tools](#command-line-tools), [graphical IDEs](#ide), [browser](#browser), and [Docker container](#docker). To learn how to connect from your application code, see [Code examples](code-examples.md).

You can connect to public {{ CH }} cluster hosts only if you use [SSL certificates](index.md#get-ssl-cert). The examples below assume that `{{ crt-local-file-root }}` and `{{ crt-local-file-int }}` certificates are:

* Located in the `{{ crt-local-dir }}` folder (for Ubuntu).
* Imported to the trusted root certificate store (for Windows).

Connecting without SSL certificates is only supported for non-public hosts. For connections to the database, traffic inside the virtual network is not encrypted in this case.

Before connecting, [configure security groups](index.md#configure-security-groups) for the cluster, if required.

The examples for Linux were tested in the following environment:

* {{ yandex-cloud }} virtual machine running Ubuntu 20.04 LTS
* Bash: `5.0.16`

The examples for Windows were tested in the following environment:

* A local machine with Windows 10 Pro build `19042.1052`
* PowerShell: `5.1.19041`

## Command line tools {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

### clickhouse-client {#clickhouse-client}

**Before connecting**:

1. Connect the [DEB repository]({{ ch.docs }}/getting-started/install/#install-from-deb-packages) {{ CH }}:

   ```bash
   sudo apt update && sudo apt install --yes apt-transport-https ca-certificates dirmngr && \
   sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD2B48D754 && \
   echo "deb https://packages.{{ ch-domain }}/deb stable main" | sudo tee \
   /etc/apt/sources.list.d/clickhouse.list
   ```

1. Install the dependencies:

   ```bash
   sudo apt update && sudo apt install --yes clickhouse-client
   ```

1. Download the configuration file for `clickhouse-client`:

   {% include [ClickHouse client config](../../../_includes/mdb/mch/client-config.md) %}

{% list tabs group=connection %}


- Connecting without SSL {#without-ssl}

   ```bash
   clickhouse-client --host <FQDN_of_any_{{ CH }}_host> \
                     --user <username> \
                     --database <DB_name> \
                     --port 9000 \
                     --ask-password
   ```


- Connecting via SSL {#with-ssl}

   {% include [default-connstring](../../../_includes/mdb/mch/default-connstring.md) %}

{% endlist %}

To learn how to get a host FQDN, see [this guide](fqdn.md).

After running the command, enter the user password to complete the connection process.

Once connected to the DBMS, run `SELECT @@version;`.

### cURL {#curl}

#### Linux (Bash)/macOS (Zsh) {#curl-bash-zsh}

{% list tabs group=connection %}


- Connecting without SSL {#without-ssl}

   ```bash
   curl --header "X-ClickHouse-User: <DB_username>" \
        --header "X-ClickHouse-Key: <DB_user_password>" \
        'http://<Any_{{ CH }}_host_FQDN>:8123/?database=<DB_name>&query=SELECT%20version()'
   ```


- Connecting via SSL {#with-ssl}

   ```bash
   curl --cacert {{ crt-local-dir }}{{ crt-local-file-root }} \
        --header "X-ClickHouse-User: <DB_username>" \
        --header "X-ClickHouse-Key: <DB_user_password>" \
        'https://<FQDN_of_any_{{ CH }}_host>:8443/?database=<DB_name>&query=SELECT%20version()'
   ```

{% endlist %}

To learn how to get a host FQDN, see [this guide](fqdn.md).

#### Windows (PowerShell) {#curl-powershell}

{% list tabs group=connection %}


- Connecting without SSL {#without-ssl}

   ```powershell
   curl.exe `
       -H "X-ClickHouse-User: <DB_user_name>" `
       -H "X-ClickHouse-Key: <DB_user_password>" `
       'http://<FQDN_of_any_{{ CH }}_host>:8123/?database=<DB_name>&query=SELECT+version()'
   ```


- Connecting via SSL {#with-ssl}

   ```powershell
   curl.exe `
       -H "X-ClickHouse-User: <DB_user_name>" `
       -H "X-ClickHouse-Key: <DB_user_password>" `
       'https://<FQDN_of_any_{{ CH }}_host>:8443/?database=<DB_name>&query=SELECT+version()'
   ```

{% endlist %}

To learn how to get a host FQDN, see [this guide](fqdn.md).

## Connecting from graphical IDEs {#ide}

{% include [ide-environments](../../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to public cluster hosts using SSL certificates.

{% include [note-connection-ide](../../../_includes/mdb/note-connection-ide.md) %}

### DataGrip {#datagrip}

1. Create a data source:
   1. Select **File** → **New** → **Data Source** → **{{ CH }}**.
   1. On the **General** tab:
      1. Specify the connection parameters:
         * **Host**: [Any {{ CH }} host FQDN](fqdn.md) or a [special FQDN](fqdn.md#auto).
         * **Port**: `{{ port-mch-http }}`.
         * **User**, **Password**: DB user's name and password.
         * **Database**: Name of the DB to connect to.
      1. Click **Download** to download the connection driver.
   1. On the **SSH/SSL** tab:
      1. Enable the **Use SSL** setting.
      1. Specify the path to the directory that contains the file with the downloaded [SSL certificate for the connection](index.md#get-ssl-cert).
1. Click **Test Connection** to test the connection. If the connection is successful, you will see the connection status and information about the DBMS and driver.
1. Click **OK** to save the data source.

### DBeaver {#dbeaver}

1. Create a new DB connection:
   1. In the **Database** menu, select **New connection**.
   1. Select **{{ CH }}** from the DB list.
   1. Click **Next**.
   1. Specify the connection parameters on the **Main** tab:
      * **Host**: [FQDN of any {{ CH }} host](fqdn.md) or a [special FQDN](fqdn.md#auto).
      * **Port**: `{{ port-mch-http }}`.
      * **DB/Schema**: Name of the DB to connect to.
      * Under **Authentication**, specify the DB user's name and password.
   1. On the **Driver properties** tab:
      1. Click **Download** in a new window with an invitation to download the driver files.
      1. Specify the [SSL connection](index.md#get-ssl-cert) parameters in the driver property list:
         * `ssl:true`
         * `sslrootcert:<path_to_SSL_certificate_file_saved>`
1. Click **Test connection ...** to test the connection. If the connection is successful, you will see the connection status and information about the DBMS and driver.
1. Click **Ready** to save the database connection settings.

{% endlist %}

## Connecting to a cluster from your browser {#browser}

To run SQL queries from your browser, use:

* [{{ yandex-cloud }} management console](#console)

* [{{ CH }} built-in SQL editor](#inline-editor)


* [{{ websql-full-name }} service](#websql)


When connecting from the browser, SQL queries are executed separately without creating a shared session with the {{ CH }} server. Therefore, queries running within the session (for example, `USE` or `SET`) will have no effect.

### {{ yandex-cloud }} management console {#console}

{% include [web-sql-warning](../../../_includes/mdb/mch/note-web-sql-console.md) %}

To connect to a {{ mch-name }} cluster, log in to the [management console]({{ link-console-main }}), open the cluster page you need, and go to the **{{ ui-key.yacloud.clickhouse.cluster.switch_explore }}** tab.

To allow connections, activate the **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}** option when [creating a cluster](../cluster-create.md) or [changing its settings](../update.md#change-additional-settings).

For more information, see [SQL queries](../web-sql-query.md).

### {{ CH }} built-in SQL editor {#inline-editor}

To connect to a cluster host from the built-in SQL editor, specify the following in the browser address bar:

```text
https://<FQDN_of_any_{{ CH }}_host>:8443/play
```

You can only connect to public cluster hosts. To learn how to get a host FQDN, see [this guide](fqdn.md).

To connect to a cluster by [selecting an available host automatically](fqdn.md#auto), use the following URL:

* `https://c-<cluster_ID>.rw.{{ dns-zone }}:8443/play` to connect to the available cluster host.
* `https://<shard_name>.c-<cluster_ID>.rw.{{ dns-zone }}:8443/play` to connect to the available [shard](../../concepts/sharding.md) host.

To make a query to the database, specify the username and password in the upper-right corner.


### {{ websql-full-name }} service {#websql}

{% include notitle [preview](../../../_includes/note-preview.md) %}

Use [{{ websql-full-name }}](../../websql) to connect to a {{ CH }} cluster in {{ yandex-cloud }}.

{% include notitle [connect-to-cluster](../../../_includes/websql/connect-to-cluster.md) %}

{% include notitle [execute-sql](../../../_includes/websql/execute-sql.md) %}


## Before you connect from a Docker container {#docker}

To connect to a {{ mch-name }} cluster from a Docker container, add the following lines to the Dockerfile:

{% list tabs group=connection %}


- Connecting without SSL {#without-ssl}

   ```bash
   # Connect the DEB repository.
   RUN apt-get update && \
       apt-get install wget --yes apt-transport-https ca-certificates dirmngr && \
       apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD2B48D754 && \
       echo "deb https://packages.{{ ch-domain }}/deb stable main" | tee \
       /etc/apt/sources.list.d/clickhouse.list && \
       # Install dependencies.
       apt-get update && \
       apt-get install wget clickhouse-client --yes && \
       # Upload a configuration file for clickhouse-client.
       mkdir --parents ~/.clickhouse-client && \
       wget "https://{{ s3-storage-host-doc-files }}/clickhouse-client.conf.example" \
            --output-document ~/.clickhouse-client/config.xml
   ```


- Connecting via SSL {#with-ssl}

   
   ```bash
   # Connect the DEB repository.
   RUN apt-get update && \
       apt-get install wget --yes apt-transport-https ca-certificates dirmngr && \
       apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD2B48D754 && \
       echo "deb https://packages.{{ ch-domain }}/deb stable main" | tee \
       /etc/apt/sources.list.d/clickhouse.list && \
       # Install dependencies.
       apt-get update && \
       apt-get install wget clickhouse-client --yes && \
       # Upload a configuration file for clickhouse-client.
       mkdir --parents ~/.clickhouse-client && \
       wget "https://{{ s3-storage-host-doc-files }}/clickhouse-client.conf.example" \
            --output-document ~/.clickhouse-client/config.xml && \
       # Get SSL certificates.
       mkdir --parents {{ crt-local-dir }} && \
       wget "{{ crt-web-path-root }}" \
            --output-document {{ crt-local-dir }}{{ crt-local-file-root }} && \
       wget "{{ crt-web-path-int }}" \
            --output-document {{ crt-local-dir }}{{ crt-local-file-int }} && \
       chmod 655 \
            {{ crt-local-dir }}{{ crt-local-file-root }} \
            {{ crt-local-dir }}{{ crt-local-file-int }} && \
       update-ca-certificates
   ```


{% endlist %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
