---
title: Connecting to a {{ PG }} cluster in {{ mpg-full-name }}
description: Follow this guide to connect to {{ PG }} cluster hosts with the help of command line tools, graphical IDEs, your browser, {{ pgadmin }}, {{ google-looker }}, and a Docker container.
---

# Connecting to a {{ PG }} cluster from applications

You can connect to a {{ PG }} cluster using [command line tools](#command-line-tools), [graphical IDEs](#connection-ide), [{{ websql-full-name }}](#websql), [{{ pgadmin }}](#connection-pgadmin), [{{ google-looker }}](#connection-google-looker), or a [Docker container](#connection-docker). To learn how to connect from your application code, see [Code examples](./code-examples.md).

You can connect to {{ CH }} cluster hosts using [SSL certificates](index.md#get-ssl-cert). The examples below assume that the `root.crt` certificate is located in this directory:

* `/home/<home_directory>/.postgresql/` for Ubuntu.
* `$HOME\AppData\Roaming\postgresql` for Windows

Before connecting, [configure security groups](index.md#configuring-security-groups) for the cluster, if required.

## Command line tools {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

### Linux (Bash) {#bash}

Before connecting, install the required dependencies:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

  1. Connect to a database:

      ```bash
      psql "host=c-<cluster_ID>.rw.{{ dns-zone }} \
            port=6432 \
            sslmode=disable \
            dbname=<DB_name> \
            user=<username> \
            target_session_attrs=read-write"
      ```

      After you run this command, enter the user password to complete connecting to the database.

  1. To check the connection, run the following query:

      ```bash
      SELECT version();
      ```

- Connecting with SSL {#with-ssl}

  1. Connect to a database:

      {% include [default-connstring](../../../_includes/mdb/mpg/default-connstring.md) %}

      After you run this command, enter the user password to complete connecting to the database.

  1. To check the connection, run the following query:

      ```bash
      SELECT version();
      ```

{% endlist %}

### Windows (PowerShell) {#powershell}

Before connecting, install [{{ PG }} for Windows](https://www.postgresql.org/download/windows/) using the same version that is installed in the cluster. Install only the *Command Line Tools*.

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

  1. Set the environment variables for the connection:

     ```powershell
     $Env:PGSSLMODE="disable"; $Env:PGTARGETSESSIONATTRS="read-write"
     ```

  1. Connect to a database:

     ```powershell
     & "C:\Program Files\PostgreSQL\<version>\bin\psql.exe" `
           --host=c-<cluster_ID>.rw.{{ dns-zone }} `
           --port={{ port-mpg }} `
           --username=<username> `
           <DB_name>
     ```

     After you run this command, enter the user password to complete connecting to the database.

  1. To check the connection, run the following query:

     ```sql
     SELECT version();
     ```

- Connecting with SSL {#with-ssl}

  1. Set the environment variables for the connection:

      ```powershell
      $Env:PGSSLMODE="verify-full"; $Env:PGTARGETSESSIONATTRS="read-write"
      ```

  1. Connect to a database:

      ```powershell
      & "C:\Program Files\PostgreSQL\<version>\bin\psql.exe" `
        --host=c-<cluster_ID>.rw.{{ dns-zone }} `
        --port={{ port-mpg }} `
        --username<username> `
        <DB_name>
      ```

      After you run this command, enter the user password to complete connecting to the database.

  1. To check the connection, run the following query:

     ```sql
     SELECT version();
     ```

{% endlist %}


### Connecting with IAM authentication {#iam}

You can connect to a {{ PG }} database via the [{{ yandex-cloud }} CLI](../../../cli/quickstart.md#install) using IAM authentication. This method is available to [Yandex accounts](../../../iam/concepts/users/accounts.md#passport), [federated accounts](../../../iam/concepts/users/accounts.md#saml-federation), and [local users](../../../iam/concepts/users/accounts.md#local). When connecting with IAM authentication, you do not need to obtain an SSL certificate or specify the cluster hosts’ FQDNs.

Before connecting, install the {{ PG }} client:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

Set up your {{ PG }} cluster for connection:

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate to](../../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}** service.
  1. Click the cluster name.
  1. Enable public access for the cluster hosts:
     1. Select the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.
     1. Click ![image](../../../_assets/console-icons/ellipsis.svg) in the first host's row and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
     1. Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
     1. Repeat the same for the remaining hosts in the cluster.
  1. Assign a role to the user account connecting to the database:
     1. Select the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab and click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
     1. Enter the user account’s email.
     1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role}}** and select the `managed-postgresql.clusters.connector` role.
     1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.
  1. Create a user named {{ PG }}:
     1. Select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
     1. Click **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
     1. Select **{{ ui-key.yacloud.mdb.AuthMethodColumn.value_iam_boWet }}** as the authentication method.
     1. Select the account with the `managed-postgresql.clusters.connector` role.
     1. In the **{{ ui-key.yacloud.mdb.dialogs.popup_field_permissions }}** field, click ![image](../../../_assets/console-icons/plus.svg).
     1. Select the database from the drop-down list.
     1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

{% endlist %}

To connect to the {{ PG }} database, run this command:

```bash
{{ yc-mdb-pg }} connect <cluster_name_or_ID> --db <DB_name>
```



## Connecting from graphical IDEs {#connection-ide}

{% include [ide-environments](../../../_includes/mdb/mdb-ide-envs.md) %}

From graphical IDEs, you can only connect to public cluster hosts using an SSL certificate.

{% include [note-connection-ide](../../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DataGrip {#datagrip}

  1. Create a data source:
     1. Select **File** → **New** → **Data Source** → **{{ PG }}**.
     1. Specify the connection settings on the **General** tab:
        * **User**, **Password**: Database user name and password.
        * **URL**: Connection string:

          ```http
          jdbc:postgresql://<special_FQDN>:{{ port-mpg }}/<DB_name>
          ```

          You can also use a list of all cluster host [FQDNs](./fqdn.md) in the connection string:

          ```http
          jdbc:postgresql://<{{ PG }}_host_1>:{{ port-mpg }},...,<{{ PG }}_host_N>:{{ port-mpg }}/<DB_name>
          ```

        * Click **Download** to download the connection driver.
     1. On the **SSH/SSL** tab:
         1. Enable **Use SSL**.
         1. In the **CA file** field, specify the path to the [SSL certificate for your connection](./index.md#get-ssl-cert).
  1. Click **Test Connection**. If the connection is successful, you will see the connection status and information about the DBMS and driver.
  1. Click **OK** to save the data source.

- DBeaver {#dbeaver}

  1. Create a new DB connection:
     1. In the **Database** menu, select **New connection**.
     1. Select **{{ PG }}** from the DB list.
     1. Click **Next**.
     1. Specify the connection settings on the **Main** tab:
        * **Host**: [Master FQDN](./fqdn.md#fqdn-master) or [regular host FQDN](./fqdn.md).
        * **Port**: `{{ port-mpg }}`.
        * **Database**: Target database name.
        * Under **Authentication**, specify the DB user name and password.
     1. On the **SSL** tab:
         1. Enable **Use SSL**.
         1. In the **Root certificate** field, specify the path to the saved [SSL certificate](./index.md#get-ssl-cert) file.
  1. Click **Test Connection ...**. If the connection is successful, you will see the connection status and information about the DBMS and driver.
  1. Click **Done** to save the database connection settings.

{% endlist %}




## Connecting from {{ websql-full-name }} {#websql}

{% include [WebSQL](../../../_includes/mdb/mpg/websql.md) %}




## Connecting from {{ pgadmin }} {#connection-pgadmin}

Connection testing was performed for [{{ pgadmin }}](https://www.pgadmin.org) version 7.0 on Ubuntu 20.04.

Connections from {{ pgadmin }} are only permitted to publicly accessible cluster hosts and require an [SSL certificate](./index.md#get-ssl-cert).

Create a new server connection:

1. Select **Object** → **Register** → **Server...**.
1. On the **General** tab, in the **Name** field, specify the cluster name to be shown in the {{ pgadmin }} interface. You can set any name.
1. In the **Connection** tab, specify the connection settings:

    * **Host name/address**: [Master FQDN](./fqdn.md#fqdn-master) or regular host [FQDN](../../concepts/network.md#hostname).
    * **Port**: `{{ port-mpg }}`.
    * **Maintenance database**: Target database name.
    * **Username**: Username used to establish the connection.
    * **Password**: User password.

1. In the **Parameters** tab:

    * Set the **SSL mode** parameter to `verify-full`.
    * Add a new **Root certificate** parameter and specify the path to the saved SSL certificate file in it.

1. Click **Save** to save the server connection settings.

Your cluster will appear in the server list located in the navigation menu.


## Connecting from {{ google-looker }} {#connection-google-looker}

Connections from [{{ google-looker }}](https://lookerstudio.google.com/overview) are only permitted to publicly accessible hosts.

1. Save the `CA.pem` [server certificate]({{ crt-web-path }}) to a local directory.
1. In the same directory, generate a client certificate with a private key:

    ```bash
    openssl req -newkey rsa:2048 -nodes -keyout private.pem -out cert.pem
    ```

    During certificate creation, the program will ask you to modify several settings. Press **Enter** to keep the default values.

    You will see two files in your local directory: `cert.pem` and `private.pem`.

1. On the [{{ google-looker }}](https://lookerstudio.google.com/navigation/reporting) navigation page, select **Create** → **Data source**.
1. Select {{ PG }}.
1. Fill out the fields as follows:

    * **Host name or IP address**: [Master FQDN](./fqdn.md#fqdn-master) or regular host [FQDN](../../concepts/network.md#hostname).
    * **Port**: `{{ port-mpg }}`.
    * **Database**: DB to connect to.
    * **Username**: Username used to establish the connection.
    * **Password**: User password.

1. Check **Enable SSL** and **Enable client authentication**.
1. Specify the certificate files and the client private key in the appropriate fields:

    * **Server certificate**: Select the `CA.pem` file.
    * **Client certificate**: Select the `cert.pem` file.
    * **Client private key**: Select the `private.pem` file.

1. Click **Authenticate**.

## Before you connect from a Docker container {#connection-docker}

To connect to a {{ mpg-name }} cluster from a Docker container, add the following lines to the Dockerfile:


{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install postgresql-client --yes
    ```

    See the {{ serverless-containers-full-name }} connection example in [this tutorial](../../../serverless-containers/tutorials/pg-connect.md).

- Connecting with SSL {#with-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install wget postgresql-client --yes && \
        mkdir --parents ~/.postgresql && \
        wget "{{ crt-web-path }}" \
             --output-document ~/.postgresql/root.crt && \
        chmod 0655 ~/.postgresql/root.crt
    ```

{% endlist %}

