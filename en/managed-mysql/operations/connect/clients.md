---
title: Connecting to an {{ MY }} cluster in {{ mmy-full-name }}
description: Follow this guide to connect to a {{ MY }} cluster database with the help of command line tools, {{ websql-full-name }}, graphical IDEs, or a Docker container.
---

# Connecting to an {{ MY }} cluster from applications

This section provides settings for connection to {{ mmy-name }} cluster hosts with the help of [command line tools](#command-line-tools), [graphical IDEs](#connection-ide), [{{ websql-full-name }}](#websql), or a [Docker container](#connection-docker). To learn how to connect from your application code, see [Code examples](./code-examples.md).

## Command line tools {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

### Linux (Bash)/macOS (Zsh) {#bash-zsh}

Before connecting, install the `mysql` utility:

```bash
sudo apt update && sudo apt install --yes mysql-client
```

{% list tabs group=connection %}

- Connecting with SSL {#with-ssl}

  {% include [default-connstring](../../../_includes/mdb/mmy/default-connstring.md) %}

- Connecting without SSL {#without-ssl}

  ```bash
  mysql --host=<FQDN_of_any_{{ MY }}_host> \
        --port={{ port-mmy }} \
        --ssl-mode=DISABLED \
        --user=<username> \
        --password \
        <DB_name>
  ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mmy/fqdn-host.md) %}

When running any command, enter the database user password.

Once connected to the DBMS, run the `SELECT version();` command.

{% include [Successful connection](../../../_includes/mdb/mmy/successful-connect.md) %}

### Windows (PowerShell) {#powershell}

Before connecting, [download](https://dev.mysql.com/downloads/shell/) and install `MySQL Shell`.

{% list tabs group=connection %}

- Connecting with SSL {#with-ssl}

  ```PowerShell
  mysqlsh --host=<FQDN_of_any_{{ MY }}_host> `
          --port={{ port-mmy }} `
          --ssl-ca=<absolute_path_to_certificate_file> `
          --ssl-mode=VERIFY_IDENTITY `
          --user=<username> `
          --password `
          --database=<DB_name> `
          --sql
  ```

- Connecting without SSL {#without-ssl}

  ```PowerShell
  mysqlsh --host=<FQDN_of_any_{{ MY }}_host> `
          --port={{ port-mmy }} `
          --ssl-mode=DISABLED `
          --user=<username> `
          --password `
          --database=<DB_name>
  ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mmy/fqdn-host.md) %}

When running any command, enter the database user password.

Once connected to the DBMS, run the `SELECT version();` command.

{% include [Successful connection](../../../_includes/mdb/mmy/successful-connect.md) %}


### Connecting with IAM authentication {#iam}

You can connect to a {{ mmy-name }} database via the [{{ yandex-cloud }} CLI](../../../cli/quickstart.md#install) using IAM authentication. This method is available to [Yandex accounts](../../../iam/concepts/users/accounts.md#passport), [federated accounts](../../../iam/concepts/users/accounts.md#saml-federation), and [local users](../../../iam/concepts/users/accounts.md#local). When connecting with IAM authentication, you do not need to obtain an SSL certificate or specify the cluster hosts’ FQDNs.

Before connecting, install the {{ MY }} client:

```bash
sudo apt update && sudo apt install --yes mysql-client
```

Set up your {{ mmy-name }} cluster for connection:

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate to](../../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}** service.
  1. Click the name of your cluster.
  1. Enable public access for the cluster hosts:
     1. Select the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
     1. Click ![image](../../../_assets/console-icons/ellipsis.svg) in the first host's row and select **{{ ui-key.yacloud.common.edit }}**.
     1. Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
     1. Repeat the same for the remaining hosts in the cluster.
  1. Assign the following role to the service account of the user that will connect to the database:
     1. Select the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
     1. Enter the user's email the service account is associated with.
     1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role}}** and select the `managed-mysql.clusters.connector` role.
     1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.
  1. Create a user named {{ MY }}:
     1. Select the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab.
     1. Click **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
     1. Select **{{ ui-key.yacloud.mysql.cluster.label_iam_dgBhy }}** as the authentication method.
     1. Select the account with the `managed-mysql.clusters.connector` role.
     1. Click **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}** and select the database from the drop-down list.
     1. Click ![image](../../../_assets/console-icons/plus.svg) in the **{{ ui-key.yacloud.mdb.dialogs.popup_field_roles }}** column and select the privilege from the drop-down list.
     1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

{% endlist %}

To connect to the {{ mmy-name }} database, run this command:

```bash
{{ yc-mdb-my }} connect <cluster_name_or_ID> --db <DB_name>
```


## Connecting from graphical IDEs {#connection-ide}

{% include [ide-environments](../../../_includes/mdb/mdb-ide-envs.md) %}

From graphical IDEs, you can only connect to public cluster hosts using an SSL certificate.

{% include [note-connection-ide](../../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DataGrip {#datagrip}

  1. Create a data source:
     1. Select **File** → **New** → **Data Source** → **{{ MY }}**.
     1. On the **General** tab:
        1. Configure the connection as follows:
           * **Host**: [FQDN of any {{ MY }} host](./fqdn.md) or a [special FQDN](./fqdn.md#fqdn-master).
           * **Port**: `{{ port-mmy }}`.
           * **User**, **Password**: Database user name and password.
           * **Database**: Name of the database to connect to.
        1. Click **Download** to download the connection driver.
     1. On the **SSH/SSL** tab:
         1. Enable **Use SSL**.
         1. In the **CA file** field, specify the path to the [SSL certificate file for your connection](./fqdn.md#get-ssl-cert).
  1. Click **Test Connection**. If the connection is successful, you will see the connection status, DBMS information, and driver details.
  1. Click **OK** to save the data source.

- DBeaver {#dbeaver}

  1. Create a new DB connection:
     1. In the **Database** menu, select **New connection**.
     1. Select **{{ MY }}** from the DB list.
     1. Click **Next**.
     1. Specify the connection settings on the **Main** tab:
        * **Server host**: [FQDN of any {{ MY }} host](./fqdn.md#fqdn) or a [special FQDN](./fqdn.md#fqdn-master).
        * **Port**: `{{ port-mmy }}`.
        * **Database**: Target database name.
        * **Username**, **Password**: Database user name and password.
     1. On the **SSL** tab:
         1. Enable **Use SSL**.
         1. In the **CA certificate** field, specify the path to the [SSL certificate](./index.md#get-ssl-cert) file you previously saved.
         1. Under **Advanced**:
            1. Enable **Require SSL**.
            1. Enable **Verify server certificate**.
  1. Click **Test Connection ...**. If the connection is successful, you will see the connection status and information about the DBMS and driver.
  1. Click **Done** to save the database connection settings.

{% endlist %}


## Connecting from {{ websql-full-name }} {#websql}

{% include [WebSQL](../../../_includes/mdb/mmy/websql.md) %}


## Before you connect from a Docker container {#connection-docker}

To connect to a {{ mmy-name }} cluster from a Docker container, add the following lines to the Dockerfile:

{% list tabs group=connection %}


- Connecting without SSL {#without-ssl}

  ```bash
  RUN apt-get update && \
      apt-get install mysql-client --yes
  ```


- Connecting with SSL {#with-ssl}

  ```bash
  RUN apt-get update && \
      apt-get install wget mysql-client --yes && \
      mkdir --parents ~/.mysql && \
      wget "{{ crt-web-path }}" \
           --output-document ~/.mysql/root.crt && \
      chmod 0600 ~/.mysql/root.crt
  ```

{% endlist %}
