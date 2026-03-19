---
title: Connecting to an {{ GP }} cluster in {{ mgp-full-name }}
description: Follow this guide to connect to a {{ GP }} cluster database with the help of command line tools, graphical IDEs, {{ pgadmin }}, or a Docker container.
---

# Connecting to an {{ GP }} cluster from applications

This section provides settings for connecting to {{ mgp-name }} cluster hosts using [command line tools](#command-line-tools), [graphical IDEs](#connection-ide), [{{ pgadmin }}](#connection-pgadmin), or a [Docker container](#connection-docker). To learn how to connect from your application code, see [Code examples](code-examples.md).

Creating a {{ GP }} cluster does not entail creating a user database. To test the connection, use the `postgres` service database.

To connect to a publicly accessible cluster, prepare an [SSL certificate](index.md#get-ssl-cert). In these examples, the `root.crt` SSL certificate is located in the following directory:

* `/home/<home_directory>/.postgresql/` for Ubuntu.
* `$HOME\AppData\Roaming\postgresql` for Windows.

You can connect to a cluster using either a master host's regular FQDN or a primary master host's [special FQDN](fqdn.md#fqdn-master). To learn how to get a host's FQDN, see [this guide](fqdn.md).


## Command line tools {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

### Linux (Bash) {#bash}

Before connecting, install the required dependencies:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

Connect to a database:

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

  ```bash
  psql "host=c-<cluster_ID>.rw.{{ dns-zone }} \
        port={{ port-mgp }} \
        sslmode=disable \
        dbname=postgres \
        user=<username> \
        target_session_attrs=read-write"
  ```

- Connecting with SSL {#with-ssl}

  {% include [default-connstring](../../../_includes/mdb/mgp/default-connstring.md) %}

{% endlist %}

After you run this command, enter the user password to complete the connection procedure.

To check the connection, run the following query:

```sql
SELECT version();
```

### Windows (PowerShell) {#powershell}

Before connecting, install the current version of [{{ PG }} for Windows](https://www.postgresql.org/download/windows/). Install only the *Command Line Tools*.

Connect to a database:

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

  ```powershell
  & "C:\Program Files\PostgreSQL\<version>\bin\psql.exe" "`
      host=c-<cluster_ID>.rw.{{ dns-zone }} `
      port={{ port-mgp }} `
      sslmode=disable `
      dbname=postgres `
      user=<username>"
  ```

- Connecting with SSL {#with-ssl}

  ```powershell
  & "C:\Program Files\PostgreSQL\<version>\bin\psql.exe" "`
      host=c-<cluster_ID>.rw.{{ dns-zone }} `
      port={{ port-mgp }} `
      sslmode=verify-full `
      dbname=postgres `
      user=<username>"
  ```

{% endlist %}

After you run this command, enter the user password to complete the connection procedure.

To check the connection, run the following query:

```sql
SELECT version();
```


### Connecting with IAM authentication {#iam}

You can connect to a {{ GP }} database from the [{{ yandex-cloud }} CLI](../../../cli/quickstart.md#install) using IAM authentication. To do this, associate a [Yandex account](../../../iam/concepts/users/accounts.md#passport) or [federated account](../../../iam/concepts/users/accounts.md#saml-federation) with the {{ GP }} user. You can only use IAM authentication to connect to a public cluster, in which case you do not need an SSL certificate.

Before connecting, install the {{ PG }} client:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

Set up your {{ mgp-name }} cluster for connection:

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.

  1. Click the cluster name.

  1. [Enable public access to the cluster](../update.md#change-public-access).
 
  1. Assign a role to the user account connecting to the database:
     1. Select the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab and click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
     1. Enter the user account’s email.
     1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role}}** and select the `managed-greenplum.clusters.connector` role.
     1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

  1. Create a {{ GP }} user and grant them access to the database:
     1. Connect to the {{ mgp-name }} cluster using any method of your choice.
     1. Create a {{ GP }} user, specifying their account’s email as their username.

        ```sql
        CREATE ROLE "<account_email>"
            LOGIN
            ENCRYPTED PASSWORD '<password>';
        ```
     1. If required, [configure privileges](../roles-and-users.md#privileges) and attributes of the {{ GP }} user you created.

  1. Add the authentication rule for the user you created:
     1. Select the **{{ ui-key.yacloud.greenplum.label_user-auth }}** tab.
     1. Click **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}**.
     1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_add-rule }}** and specify its settings:

        * **{{ ui-key.yacloud.greenplum.cluster.user-auth.title_column-type }}**: Interconnect type.
        * **{{ ui-key.yacloud.greenplum.cluster.user-auth.title_column-databases }}**: Database name.
        * **{{ ui-key.yacloud.greenplum.cluster.user-auth.title_column-user }}**: User account's email.
        * **{{ ui-key.yacloud.greenplum.cluster.user-auth.title_column-address }}**: IP range to connect to the database from.
        * **{{ ui-key.yacloud.greenplum.cluster.user-auth.title_column-method }}**: `iam`.

     1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

To connect to the {{ GP }} database, run this command:

```bash
{{ yc-mdb-gp }} connect <cluster_name_or_ID> --db <DB_name>
```


## Connecting from graphical IDEs {#connection-ide}

{% include [ide-environments](../../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to a public cluster using SSL certificates.

{% include [note-connection-ide](../../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DataGrip {#datagrip}

    1. Create a data source:

        1. Select **File** → **New** → **Data Source** → **{{ GP }}**.
        1. On the **General** tab:

            1. Configure the connection as follows:

                * **User**, **Password**: DB user name and password.
                * **URL**: Connection string. Use the [special primary master FQDN](./fqdn.md#fqdn-master):

                    ```http
                    jdbc:postgresql://c-<cluster_ID>.rw.{{ dns-zone }}:{{ port-mgp }}/<DB_name>
                    ```

            1. Click **Download** to download the connection driver.
        1. On the **SSH/SSL** tab:
            1. Enable **Use SSL**.
            1. In the **CA file** field, specify the path to the [SSL certificate for your connection](#get-ssl-cert).
    1. Click **Test Connection**. If the connection is successful, you will see the connection status and information about the DBMS and driver.
    1. Click **OK** to save the data source.

- DBeaver {#dbeaver}

    1. Create a new DB connection:
        1. In the **Database** menu, select **New connection**.
        1. Select **{{ GP }}** from the DB list.
        1. Click **Next**.
        1. Specify the connection settings on the **Main** tab:
            * **Host**: [Special FQDN of the primary master](./fqdn.md#fqdn-master), `c-<cluster_ID>.rw.{{ dns-zone }}`.
            * **Port**: `{{ port-mgp }}`.
            * **Database**: DB to connect to.
            * Under **Authentication**, specify the DB user name and password.
        1. On the **SSL** tab:
            1. Enable **Use SSL**.
            1. In the **Root certificate** field, specify the path to the saved [SSL certificate](#get-ssl-cert) file.
    1. Click **Test Connection ...**. If the connection is successful, you will see the connection status and information about the DBMS and driver.
    1. Click **Done** to save the database connection settings.

{% endlist %}

## Connecting from {{ pgadmin }} {#connection-pgadmin}

The connection has been checked for [{{ pgadmin }}](https://www.pgadmin.org) ver. 7.1 on macOS Ventura 13.0 and Microsoft Windows 10 Pro 21H1.

You can only use {{ pgadmin }} to connect to public cluster hosts [using an SSL certificate](#get-ssl-cert).

Create a new server connection:

1. Select **Object** → **Register** → **Server...**.
1. On the **General** tab, in the **Name** field, specify the cluster name to be shown in the {{ pgadmin }} interface. You can set any name.
1. In the **Connection** tab, specify the connection settings:

    * **Host name/address**: [Special master host FQDN](./fqdn.md#fqdn-master) or regular host FQDN.
    * **Port**: `{{ port-mgp }}`.
    * **Maintenance database**: Name of the `postgres` maintenance database.
    * **Username**: Username for connection.
    * **Password**: User password.

1. In the **Parameters** tab:

    * Set the **SSL mode** parameter to `verify-full`.
    * Add a new **Root certificate** parameter and specify the path to the saved SSL certificate file in it.

1. Click **Save** to save the server connection settings.

As a result, the cluster appears in the server list in the navigation menu.

To monitor the cluster status, use [{{ monitoring-full-name }}](../monitoring.md) rather than the **Dashboard** tab in {{ pgadmin }}, since the latter might generate an error:

```text
column "wait_event_type" does not exist LINE 10: wait_event_type || ': ' || wait_event AS wait_event, ^
```

This error does not occur in other {{ pgadmin }} tabs.

## Before you connect from a Docker container {#connection-docker}

To connect to a {{ GP }} cluster from a Docker container, add the following lines to the Dockerfile:

{% list tabs group=connection %}


- Connecting without SSL {#without-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install postgresql-client --yes
    ```


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

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
