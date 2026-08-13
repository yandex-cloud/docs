---
title: Connecting to a {{ PG }} cluster in {{ mpg-full-name }}
description: Follow this guide to connect to {{ PG }} cluster hosts with the help of command line tools, graphical IDEs, your browser, {{ pgadmin }}, {{ google-looker }}, and a Docker container.
---

# Connecting to a {{ PG }} cluster from applications

You can connect to a {{ PG }} cluster using [command line tools](#command-line-tools), [graphical IDEs](#connection-ide), [{{ websql-full-name }}](#websql), [{{ pgadmin }}](#connection-pgadmin), [{{ google-looker }}](#connection-google-looker) (formerly Looker Studio), or a [Docker container](#connection-docker). To learn how to connect from the code of your application, see [Code examples](./code-examples.md).

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
      psql "host=<list_of_cluster_hosts> \
            port=6432 \
            sslmode=disable \
            dbname=<DB_name> \
            user=<username> \
            target_session_attrs=read-write"
      ```

      {% include [host lists](../../../_includes/managed-postgresql/host-list.md) %}    

      After you run this command, enter the user password to complete connecting to the database.

  1. To check the connection, run the following query:

      ```bash
      SELECT version();
      ```

- Connecting with SSL {#with-ssl}

  1. Connect to a database:

      {% include [default-connstring](../../../_includes/mdb/mpg/default-connstring.md) %}

      {% include [host lists](../../../_includes/managed-postgresql/host-list.md) %}

      After running this command, enter the user password to complete your connection.

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
           --host=<list_of_hosts> `
           --port={{ port-mpg }} `
           --username=<username> `
           <DB_name>
     ```

     {% include [host lists](../../../_includes/managed-postgresql/host-list.md) %}

     After running this command, enter the user password to complete your connection.

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
        --host=<list_of_hosts> `
        --port={{ port-mpg }} `
        --username<username> `
        <DB_name>
      ```

      {% include [host lists](../../../_includes/managed-postgresql/host-list.md) %}

      After running this command, enter the user password to complete your connection.

  1. To check the connection, run the following query:

     ```sql
     SELECT version();
     ```

{% endlist %}


### Connecting with IAM authentication {#iam}

You can connect to a {{ PG }} database via the [{{ yandex-cloud }} CLI](../../../cli/quickstart.md#install) using IAM authentication. This method is available to [Yandex accounts](../../../iam/concepts/users/accounts.md#passport), [federated accounts](../../../iam/concepts/users/accounts.md#saml-federation), and [local users](../../../iam/concepts/users/accounts.md#local). When connecting with IAM authentication, you do not need to obtain an SSL certificate or specify the cluster hosts’ FQDNs. No public access to hosts is required.

Before connecting, install the {{ PG }} client:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

Set up your {{ PG }} cluster for connection:

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name.
  1. Assign a role to the user account connecting to the database:
     1. Select the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab and click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
     1. Enter the user account’s email.
     1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the `managed-postgresql.clusters.connector` role.
     1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.
  1. Create a user named {{ PG }}:
     1. Select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab.
     1. Click **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
     1. Select **{{ ui-key.yacloud.mdb.AuthMethodColumn.value_iam_boWet }}** as the authentication method.
     1. Select the account with the `managed-postgresql.clusters.connector` role.
     1. In the **{{ ui-key.yacloud.mdb.dialogs.popup_field_permissions }}** field, click ![image](../../../_assets/console-icons/plus.svg).
     1. Select the database from the drop-down list.
     1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Assign a role to the user account connecting to the database:

      * To a Yandex account user or local user:

         ```bash
         {{ yc-mdb-pg }} cluster add-access-binding \
            --id <cluster_ID> \
            --role managed-postgresql.clusters.connector \
            --user-account-id <user_ID>
         ```

      * To a federated user:

         ```bash
         {{ yc-mdb-pg }} cluster add-access-binding \
            --id <cluster_ID> \
            --role managed-postgresql.clusters.connector \
            --subject federatedUser:<user_ID>
         ```

      You can get the cluster ID with the [list of clusters in the folder](../cluster-list.md#list-clusters).

  1. Create a user named {{ PG }}:

     ```bash
     {{ yc-mdb-pg }} user create <user_ID> \
       --cluster-id <cluster_ID> \
       --auth-method auth-method-iam \
       --permissions <DB_name>
     ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. Assign a role to the user account connecting to the database:

      1. Call the [Cluster.UpdateAccessBindings](../../api-ref/Cluster/updateAccessBindings.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

          * For a Yandex account user or local user:

            ```bash
            curl \
              --request PATCH \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>:updateAccessBindings' \
              --data '{
                        "accessBindingDeltas": [
                          { 
                            "action": "ADD",
                            "accessBinding": {
                              "roleId": "managed-postgresql.clusters.connector",
                              "subject": {
                                "id": "<user_ID>",
                                "type": "userAccount"
                              }
                            }
                          }
                        ]
                      }'
            ```

          * For a federated user:

            ```bash
            curl \
              --request PATCH \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>:updateAccessBindings' \
              --data '{
                        "accessBindingDeltas": [
                          { 
                            "action": "ADD",
                            "accessBinding": {
                              "roleId": "managed-postgresql.clusters.connector",
                              "subject": {
                                "id": "<user_ID>",
                                "type": "federatedUser"
                              }
                            }
                          }
                        ]
                      }'
            ```

         You can get the cluster ID with the [list of clusters in the folder](../cluster-list.md#list-clusters).

      1. Check the [server response](../../api-ref/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation) to make sure your request was successful.

  1. Create a user named {{ PG }}:

      1. Call the [User.Create](../../api-ref/User/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

         ```bash
         curl \
           --request POST \
           --header "Authorization: Bearer $IAM_TOKEN" \
           --header "Content-Type: application/json" \
           --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/users' \
           --data '{
                     "userSpec": {
                       "name": "<user_ID>",
                       "permissions": [
                         {
                           "databaseName": "<DB_name>"
                         }
                       ],
                       "authMethod": "AUTH_METHOD_IAM"
                     }
                   }'
         ```

         You can get the cluster ID with the [list of clusters in the folder](../cluster-list.md#list-clusters).

      1. View the [server response](../../api-ref/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Assign a role to the user account connecting to the database:

      1. Call the [ClusterService.UpdateAccessBindings](../../api-ref/grpc/Cluster/updateAccessBindings.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:
          * For a Yandex account user or local user:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d '{
                    "resource_id": "<cluster_ID>",
                    "access_binding_deltas": [
                       { 
                        "action": "ADD",
                        "access_binding": {
                            "role_id": "managed-postgresql.clusters.connector",
                            "subject": {
                                "id": "<user_ID>",
                                "type": "userAccount"
                            }
                        }
                       }
                    ]
                  }' \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.postgresql.v1.ClusterService.UpdateAccessBindings
            ```

          * For a federated user:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d '{
                    "resource_id": "<cluster_ID>",
                    "access_binding_deltas": [
                       { 
                        "action": "ADD",
                        "access_binding": {
                            "role_id": "managed-postgresql.clusters.connector",
                            "subject": {
                                "id": "<user_ID>",
                                "type": "federatedUser"
                            }
                        }
                       }
                    ]
                  }' \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.postgresql.v1.ClusterService.UpdateAccessBindings
            ```

         You can get the cluster ID with the [list of clusters in the folder](../cluster-list.md#list-clusters).

      1. Check the [server response](../../api-ref/grpc/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation) to make sure your request was successful.

  1. Create a user named {{ PG }}:

      1. Call the [UserService.Create](../../api-ref/grpc/User/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

         ```bash
         grpcurl \
           -format json \
           -import-path ~/cloudapi/ \
           -import-path ~/cloudapi/third_party/googleapis/ \
           -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
           -rpc-header "Authorization: Bearer $IAM_TOKEN" \
           -d '{
                 "cluster_id": "<cluster_ID>",
                 "user_spec": {
                   "name": "<user_ID>",
                   "permissions": [
                     {
                       "database_name": "<DB_name>"
                     }
                   ],
                   "auth_method": "AUTH_METHOD_IAM"
                 }
               }' \
           {{ api-host-mdb }}:{{ port-https }} \
           yandex.cloud.mdb.postgresql.v1.UserService.Create
         ```

         You can get the cluster ID with the [list of clusters in the folder](../cluster-list.md#list-clusters).

      1. Check the [server response](../../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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

Connections from [{{ google-looker }}](https://datastudio.google.com/overview) are only permitted to publicly accessible hosts.

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
