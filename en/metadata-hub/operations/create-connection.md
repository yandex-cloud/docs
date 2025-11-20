---
title: How to create a {{ metadata-hub-name }} connection. Step-by-step guides
description: Step-by-step guides on using {{ connection-manager-name }} in {{ yandex-cloud }}. In this tutorial, you will learn how to create connections.
---

# Creating a connection


You can create connections of the following types:
* [To a cluster with a managed database](#mdb-connection):
  * [{{ mpg-name }}](#mdb-postgresql)
  * [{{ mch-name }}](#mdb-clickhouse)
  * [{{ mmy-name }}](#mdb-mysql)
  * [{{ mrd-name }}](#mdb-redis)
  * [{{ mos-name }}](#mdb-opensearch)
  * [{{ mmg-name }}](#mdb-mongodb)
  * [{{ mkf-name }}](#mdb-kafka)
  * [{{ mgp-name }}](#mdb-greenplum)
* [To a custom database installation](#on-premise-connection):
  * [{{ PG }}](#postgresql-on-premise)
  * [{{ CH }}](#clickhouse-on-premise)
  * [{{ MY }}](#mysql-on-premise)
  * [{{ RD }}](#redis-on-premise)
  * [{{ VLK }}](#valkey-on-premise)
  * [{{ TR }}](#trino-on-premise)
  * [{{ OS }}](#opensearch-on-premise)
  * [{{ MG }}](#mongodb-on-premise)
  * [{{ KF }}](#kafka-on-premise)
  * [{{ GP }}](#greenplum-on-premise)

## Connecting to a cluster with a managed database {#mdb-connection}

### {{ mpg-name }} {#mdb-postgresql}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Specify the connection name.
  1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
  1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
  1. Under **Connection to {{ PG }}**, select **{{ mpg-short-name }}** cluster as the connection type and specify the cluster you need.
  1. Under **Authentication**:
      1. Specify the **Username** you will use to connect to the cluster.
      1. Select the password setting method:
          * **Enter manually**: You set the password manually.
          * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
  1. Optionally, list the databases whose connections you want to manage. You can connect only to the databases that exist in the cluster. You must have [access to them configured](../../managed-postgresql/security/index.md).
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a {{ mpg-name }} cluster, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create postgresql --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create postgresql \
        --name <connection_name> \
        --description "<connection_description>" \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --managed-cluster-id <cluster_ID> \
        --databases <database_list>
      ```

      Where:

      * `--name`: Connection name.

      * `--description`: Connection description.

      * `--labels`: Comma-separated list of labels in `"<key>":"<value>"` format.

      * `--user`: Username to connect to the cluster.

      * `--password`: Password.
      
      * `--managed-cluster-id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](../../managed-postgresql/operations/cluster-list.md#list-clusters) in the folder.
      
      * `--databases`: Comma-separated list of databases. Make sure the user has the [required access permissions](../../managed-postgresql/security/index.md).


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a {{ mpg-name }} cluster, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          postgresql = {
            managed_cluster_id = "<cluster_ID>"
            
            databases = [
              "<database_1>",
              "<database_2>",
              ...
              "<database_N>"
            ]

            auth = {
              user_password = {
                user     = "<username>"
                password = {
                  raw = "<password>"
                }
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.postgresql`: Parameters for connecting to the {{ mpg-name }} cluster:

        * `managed_cluster_id`: Cluster ID.

          You can get the cluster ID with the [list of clusters](../../managed-postgresql/operations/cluster-list.md#list-clusters) in the folder.

        * `databases`: List of databases. Make sure the user has the [required access permissions](../../managed-postgresql/security/index.md).

        * `auth.user_password.user`: Username to connect to the cluster.

        * `auth.user_password.password.raw`: Password.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ mpg-name }} cluster, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method on the [Connection](../connection-manager/api-ref/grpc/Connection/) resource.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.PostgreSQLConnection) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.PostgreSQLConnection) reference.

{% endlist %}

### {{ mch-name }} {#mdb-clickhouse}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
    1. Select **{{ metadata-hub-full-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Specify the connection name.
    1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
    1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
    1. Under **Connection to {{ CH }}**, select **{{ mch-short-name }}** cluster as the connection type and specify the cluster you need.
    1. Under **Authentication**:
        1. Specify the **Username** you will use to connect to the cluster.
        1. Select the password setting method:
            * **Enter manually**: You set the password manually.
            * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
    1. Optionally, list the databases whose connections you want to manage. You must have access to them configured.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a {{ mch-name }} cluster, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create clickhouse --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create clickhouse \
        --name <connection_name> \
        --description "<connection_description>" \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --managed-cluster-id <cluster_ID> \
        --databases <database_list>
      ```

      Where:

      * `--name`: Connection name.

      * `--description`: Connection description.

      * `--labels`: Comma-separated list of labels in `"<key>":"<value>"` format.

      * `--user`: Username to connect to the cluster.

      * `--password`: Password.
      
      * `--managed-cluster-id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](../../managed-clickhouse/operations/cluster-list.md#list-clusters) in the folder.
      
      * `--databases`: Comma-separated list of databases. Make sure the user has the [required access permissions](../../managed-clickhouse/security.md).


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a {{ mch-name }} cluster, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          clickhouse = {
            managed_cluster_id = "<cluster_ID>"
            
            databases = [
              "<database_1>",
              "<database_2>",
              ...
              "<database_N>"
            ]

            auth = {
              user_password = {
                user     = "<username>"
                password = {
                  raw = "<password>"
                }
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.clickhouse`: Parameters for connecting to the {{ mch-name }} cluster:

        * `managed_cluster_id`: Cluster ID.

          You can get the cluster ID with the [list of clusters](../../managed-clickhouse/operations/cluster-list.md#list-clusters) in the folder.

        * `databases`: List of databases. Make sure the user has the [required access permissions](../../managed-clickhouse/security.md).

        * `auth.user_password.user`: Username to connect to the cluster.

        * `auth.user_password.password.raw`: Password.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ mch-name }} cluster, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.ClickHouseConnection) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.ClickHouseConnection) reference.

{% endlist %}

### {{ mmy-name }} {#mdb-mysql}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Specify the connection name.
   1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. Under **Connection to {{ MY }}**, select **{{ mmy-short-name }}** cluster as the connection type and specify the cluster you need.
   1. Under **Authentication**:
        1. Specify the **Username** you will use to connect to the cluster.
        1. Select the password setting method:
            * **Enter manually**: You set the password manually.
            * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. Optionally, list the databases whose connections you want to manage. You can connect only to the databases that exist in the cluster. You must have [access to them configured](../../managed-mysql/security/index.md).
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a {{ mmy-name }} cluster, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create mysql --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create mysql \
        --name <connection_name> \
        --description "<connection_description>" \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --managed-cluster-id <cluster_ID> \
        --databases <database_list>
      ```

      Where:

      * `--name`: Connection name.

      * `--description`: Connection description.

      * `--labels`: Comma-separated list of labels in `"<key>":"<value>"` format.

      * `--user`: Username to connect to the cluster.

      * `--password`: Password.
      
      * `--managed-cluster-id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](../../managed-mysql/operations/cluster-list.md#list-clusters) in the folder.
      
      * `--databases`: Comma-separated list of databases. Make sure the user has the [required access permissions](../../managed-mysql/security/index.md).


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a {{ mmy-name }} cluster, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          mysql = {
            managed_cluster_id = "<cluster_ID>"
            
            databases = [
              "<database_1>",
              "<database_2>",
              ...
              "<database_N>"
            ]

            auth = {
              user_password = {
                user     = "<username>"
                password = {
                  raw = "<password>"
                }
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.mysql`: Parameters for connecting to the {{ mmy-name }} cluster:

        * `managed_cluster_id`: Cluster ID.

          You can get the cluster ID with the [list of clusters](../../managed-mysql/operations/cluster-list.md#list-clusters) in the folder.

        * `databases`: List of databases. Make sure the user has the [required access permissions](../../managed-mysql/security/index.md).

        * `auth.user_password.user`: Username to connect to the cluster.

        * `auth.user_password.password.raw`: Password.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ mmy-name }} cluster, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.MySQLConnection) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.MySQLConnection) reference.

{% endlist %}

### {{ mrd-name }} {#mdb-redis}

{% list tabs group=instructions %}

- Management console {#console}
    
    1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
    1. Select **{{ metadata-hub-full-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Specify the connection name.
    1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
    1. From the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** list, select **{{ VLK }}**.
    1. Under **Connection to {{ VLK }}**, select **{{ mrd-short-name }}** cluster as the connection type and specify the cluster you need.
    1. Under **Authentication**, select how to set the password:
         * **Enter manually**: Enter the password manually.
         * **Generate**: Specify the options to generate a [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password automatically.
    1. Optionally, list the databases whose connections you want to manage. You must have access to them configured.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a {{ mrd-name }} cluster, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create valkey --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create valkey \
        --name <connection_name> \
        --description "<connection_description>" \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --managed-cluster-id <cluster_ID> \
        --databases <database_list>
      ```

      Where:

      * `--name`: Connection name.

      * `--description`: Connection description.

      * `--labels`: Comma-separated list of labels in `"<key>":"<value>"` format.

      * `--user`: Username to connect to the cluster.

      * `--password`: Password.
      
      * `--managed-cluster-id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](../../managed-redis/operations/cluster-list.md#list-clusters) in the folder.
      
      * `--databases`: Comma-separated list of databases. Make sure the user has the [required access permissions](../../managed-redis/security/index.md).


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a {{ mrd-name }} cluster, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          valkey = {
            managed_cluster_id = "<cluster_ID>"
            
            databases = [
              "<database_1>",
              "<database_2>",
              ...
              "<database_N>"
            ]

            auth = {
              user_password = {
                user     = "<username>"
                password = {
                  raw = "<password>"
                }
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.valkey`: Parameters for connecting to the {{ mrd-name }} cluster:

        * `managed_cluster_id`: Cluster ID.

          You can get the cluster ID with the [list of clusters](../../managed-redis/operations/cluster-list.md#list-clusters) in the folder.

        * `databases`: List of databases. Make sure the user has the [required access permissions](../../managed-redis/security/index.md).

        * `auth.user_password.user`: Username to connect to the cluster.

        * `auth.user_password.password.raw`: Password.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ mrd-name }} cluster, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.ValkeyConnection) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.ValkeyConnection) reference.

{% endlist %}

### {{ mos-name }} {#mdb-opensearch}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Specify the connection name.
   1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. Under **Connection to {{ OS }}**, select **{{ mos-short-name }}** cluster as the connection type and specify the cluster you need.
   1. Under **Authentication**:
        1. Specify the **Username** you will use to connect to the cluster.
        1. Select the password setting method:
            * **Enter manually**: You set the password manually.
            * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. Optionally, list the databases whose connections you want to manage. You can connect only to the databases that exist in the cluster. You must have [access to them configured](../../managed-opensearch/security/index.md).
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a {{ mos-name }} cluster, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create opensearch --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create opensearch \
        --name <connection_name> \
        --description "<connection_description>" \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --managed-cluster-id <cluster_ID>
      ```

      Where:

      * `--name`: Connection name.

      * `--description`: Connection description.

      * `--labels`: Comma-separated list of labels in `"<key>":"<value>"` format.

      * `--user`: Username to connect to the cluster.

      * `--password`: Password.
      
      * `--managed-cluster-id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](../../managed-opensearch/operations/cluster-list.md#list-clusters) in the folder.


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a {{ mos-name }} cluster, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          opensearch = {
            managed_cluster_id = "<cluster_ID>"

            auth = {
              user_password = {
                user     = "<username>"
                password = {
                  raw = "<password>"
                }
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.opensearch`: Parameters for connecting to the {{ mos-name }} cluster:

        * `managed_cluster_id`: Cluster ID.

          You can get the cluster ID with the [list of clusters](../../managed-opensearch/operations/cluster-list.md#list-clusters) in the folder.

        * `auth.user_password.user`: Username to connect to the cluster.

        * `auth.user_password.password.raw`: Password.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ mos-name }} cluster, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.OpenSearchConnection) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.OpenSearchConnection) reference.

{% endlist %}

### {{ mmg-name }} {#mdb-mongodb}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Specify the connection name.
   1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. Under **Connection to {{ MG }}**, select **{{ mmg-short-name }}** cluster as the connection type and specify the cluster you need.
   1. Under **Authentication**:
        1. Specify the **Username** you will use to connect to the cluster.
        1. Select the password setting method:
            * **Enter manually**: You set the password manually.
            * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. Optionally, list the databases whose connections you want to manage. You can connect only to the databases that exist in the cluster. You must have [access to them configured](../../storedoc/security/index.md).
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a {{ mmg-name }} cluster, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create mongodb --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create mongodb \
        --name <connection_name> \
        --description "<connection_description>" \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --managed-cluster-id <cluster_ID> \
        --databases <database_list>
      ```

      Where:

      * `--name`: Connection name.

      * `--description`: Connection description.

      * `--labels`: Comma-separated list of labels in `"<key>":"<value>"` format.

      * `--user`: Username to connect to the cluster.

      * `--password`: Password.
      
      * `--managed-cluster-id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](../../storedoc/operations/cluster-list.md#list-clusters) in the folder.
      
      * `--databases`: Comma-separated list of databases. Make sure the user has the [required access permissions](../../storedoc/security/index.md).


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a {{ mmg-name }} cluster, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          mongodb = {
            managed_cluster_id = "<cluster_ID>"
            
            databases = [
              "<database_1>",
              "<database_2>",
              ...
              "<database_N>"
            ]

            auth = {
              user_password = {
                user     = "<username>"
                password = {
                  raw = "<password>"
                }
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.mongodb`: Parameters for connecting to the {{ mmg-name }} cluster:

        * `managed_cluster_id`: Cluster ID.

          You can get the cluster ID with the [list of clusters](../../storedoc/operations/cluster-list.md#list-clusters) in the folder.

        * `databases`: List of databases. Make sure the user has the [required access permissions](../../storedoc/security/index.md).

        * `auth.user_password.user`: Username to connect to the cluster.

        * `auth.user_password.password.raw`: Password.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ mmg-name }} cluster, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.MongoDBConnection) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.MongoDBConnection) reference.

{% endlist %}

### {{ mkf-name }} {#mdb-kafka}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Specify the connection name.
   1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. Under **Connection to {{ KF }}**, select **Managed Service for Kafka cluster** as the connection type and specify the cluster you need.
   1. When using authentication:

       * Specify the **Username** for the connection.
       * Set a password in one of the following ways:
         
         * **Enter manually**: Enter the password in the input field.
         * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
       
       * Optionally, in the **Authentication mechanisms** list, select the required options:
         
         * `PLAIN`: Authentication with login and password provided as plain unencrypted text.
         * `SCRAM_SHA256`: Authentication with SHA-256 hashing.
         * `SCRAM_SHA512`: Authentication with SHA-512 hashing.


   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a {{ mkf-name }} cluster, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create kafka --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create kafka \
        --name <connection_name> \
        --description "<connection_description>" \
        --supported-mechanisms <list_of_authentication_mechanisms> \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --managed-cluster-id <cluster_ID>
      ```

      Where:

      * `--name`: Connection name.

      * `--description`: Connection description.

      * `--supported-mechanisms`: List of authentication mechanisms. The possible values are:
        
        * `PLAIN`: Authentication with login and password provided as plain unencrypted text.
        * `SCRAM_SHA256`: Authentication with SHA-256 hashing.
        * `SCRAM_SHA512`: Authentication with SHA-512 hashing.


      * `--labels`: Comma-separated list of labels in `"<key>":"<value>"` format.

      * `--user`: Username to connect to the cluster.

      * `--password`: Password.
      
      * `--managed-cluster-id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](../../managed-kafka/operations/cluster-list.md#list-clusters) in the folder.


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a {{ mkf-name }} cluster, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          kafka = {
            managed_cluster_id = "<cluster_ID>"

            auth = {
              sasl = {
                user     = "<username>"
                password = { 
                  raw = "<password>"
                }
                supported_mechanisms = [
                  <list_of_authentication_mechanisms>
                ]
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.kafka`: Parameters for connecting to the {{ mkf-name }} cluster:

        * `managed_cluster_id`: Cluster ID.

          You can get the cluster ID with the list of clusters in the folder.

        * `auth`: Authentication parameters. Select one of the sections:

          * `sasl`: SASL authentication parameters.
            
            * `user`: Username to connect to the cluster.
            * `password.raw`: Password.
            * `supported_mechanisms`: List of authentication mechanisms. The possible values are:
              
              * `PLAIN`: Authentication with login and password provided as plain unencrypted text.
              * `SCRAM_SHA256`: Authentication with SHA-256 hashing.
              * `SCRAM_SHA512`: Authentication with SHA-512 hashing.

          
          * `disabled`: Disables authentication.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ mkf-name }} cluster, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method on the [Connection](../connection-manager/api-ref/grpc/Connection/) resource.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.KafkaConnection) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.KafkaConnection) reference.

{% endlist %}

{% endlist %}

### {{ mgp-name }} {#mdb-greenplum}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Specify the connection name.
  1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
  1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
  1. Under **Connection to Greenplum**, select **Yandex MPP Analytics for PostgreSQL cluster** as the connection type and specify the cluster you need.
  1. Under **Authentication**:
      1. Specify the **Username** for the connection.
      1. Select the password setting method:
          * **Enter manually**: Enter the password in the input field.
          * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
  1. List the databases whose connections you want to manage. You can connect only to the databases that exist in the cluster. Make sure the user has the [required access permissions](../../managed-greenplum/security/index.md).
  
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a {{ mgp-name }} cluster, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create greenplum --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create greenplum \
        --name <connection_name> \
        --description "<connection_description>" \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --managed-cluster-id <cluster_ID> \
        --databases <database_list>
      ```

      Where:

      * `--name`: Connection name.

      * `--description`: Connection description.

      * `--labels`: Comma-separated list of labels in `"<key>":"<value>"` format.

      * `--user`: Username to connect to the cluster.

      * `--password`: Password.
      
      * `--managed-cluster-id`: Cluster ID.

        You can get the cluster ID with the [list of clusters](../../managed-greenplum/operations/cluster-list.md#list-clusters) in the folder.
      
      * `--databases`: Comma-separated list of databases. Make sure the user has the [required access permissions](../../managed-greenplum/security/index.md).


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a {{ mgp-name }} cluster, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          greenplum = {
            managed_cluster_id = "<cluster_ID>"
            
            databases = [
              "<database_1>",
              "<database_2>",
              ...
              "<database_N>"
            ]

            auth = {
              user_password = {
                user     = "<username>"
                password = {
                  raw = "<password>"
                }
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.greenplum`: Parameters for connecting to the {{ mgp-name }} cluster:

        * `managed_cluster_id`: Cluster ID.

          You can get the cluster ID with the [list of clusters](../../managed-greenplum/operations/cluster-list.md#list-clusters) in the folder.

        * `databases`: List of databases. Make sure the user has the [required access permissions](../../managed-greenplum/security/index.md).

        * `auth.user_password.user`: Username to connect to the cluster.

        * `auth.user_password.password.raw`: Password.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ mgp-name }} cluster, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method on the [Connection](../connection-manager/api-ref/grpc/Connection/) resource.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.GreenplumConnection) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.GreenplumConnection) reference.

{% endlist %}

## Connecting to a custom database installation {#on-premise-connection}

### {{ PG }} {#postgresql-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Specify the connection name.
  1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
  1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
  1. Under **Connection to {{ PG }}**, specify the connection parameters:
      1. In the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** field, select **Custom installation**.
      1. In the **Hosts** field, specify the database host address and port number for the connection.

          When creating a connection to a custom database installation intended for [{{ datalens-full-name }}](../../datalens/concepts/index.md), specify the host's external address.

      1. Optionally, enable TLS.
          If your company has a certification authority (CA), the certificate issued by that CA will be used by default. If the company has no CA, upload the server's TLS certificate.
          
  1. Under **Authentication**:
      1. Specify the **Username** you will use to connect to the database.
      1. Select the password setting method:
          * **Enter manually**: You set the password manually.
          * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
  1. Optionally, list the databases whose connections you want to manage. You must have access to them configured.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a custom {{ PG }} installation, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create postgresql --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create postgresql \
        --name <connection_name> \
        --description "<connection_description>" \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --hosts <list_of_hosts> \
        --databases <database_list> \
        --ca-certificate <path_to_certificate>
      ```

      Where:

      {% include [connection-create-onpremise-cli](../../_includes/metadata-hub/connection-create-onpremise-cli.md) %}


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a custom {{ PG }} installation, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          postgresql = {
            cluster = {
              hosts = [
                {
                  host = "<host_1>"
                  port = <port_1>
                },
                {
                  host = "<host_2>"
                  port = <port_2>
                },
                ...
                {
                  host = "<host_N>"
                  port = <port_N>
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<path_to_certificate>"
                }
              }
            }

            databases = [
              "<database_1>",
              "<database_2>",
              ...
              "<database_N>"
            ]

            auth = {
              user_password = {
                user     = "<username>"
                password = {
                  raw = "<password>"
                }
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.postgresql`: Parameters for connecting to the custom {{ PG }} installation.
        
        * `cluster.hosts`: Host list. For each host, specify `host` and `port`.

        * `cluster.tls_params`: TLS parameters. Select one of the sections:
        
          * `tls.ca_certificate`: Path to your TLS CA certificate file.
          * `disabled`: Disables TLS. TLS is enabled by default.

        * `databases`: List of databases. Make sure the user has the required access permissions.

        * `auth.user_password.user`: User name for connection to the database.

        * `auth.user_password.password.raw`: Password.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ PG }} custom installation, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.PostgreSQLCluster) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.PostgreSQLCluster) reference.

{% endlist %}

### {{ CH }} {#clickhouse-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
    1. Select **{{ metadata-hub-full-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Specify the connection name.
    1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
    1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
    1. Under **Connection to {{ CH }}**, specify the connection parameters:
        1. In the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** field, select **Custom installation**.
        1. In the **Hosts** field, specify the [FQDNs](../../managed-clickhouse/operations/connect/fqdn.md) or IP addresses of the hosts in the shard, HTTP or TCP port for connection, and the [shard](../../managed-clickhouse/operations/shards.md#list-shards) name.

            When creating a connection to a custom database installation intended for [{{ datalens-full-name }}](../../datalens/concepts/index.md), specify the hosts’ external IP addresses.

        1. Optionally, enable TLS.
            If your company has a certification authority (CA), the certificate issued by that CA will be used by default. If the company has no CA, upload the server's TLS certificate.
    1. Under **Authentication**:
        1. Specify the **Username** you will use to connect to the database.
        1. Select the password setting method:
            * **Enter manually**: You set the password manually.
            * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
    1. Optionally, list the databases whose connections you want to manage. You must have access to them configured.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a custom {{ CH }} installation, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create clickhouse --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create clickhouse \
        --name <connection_name> \
        --description "<connection_description>" \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --hosts <list_of_hosts> \
        --databases <database_list> \
        --ca-certificate <path_to_certificate>
      ```

      Where:

      * `--name`: Connection name.
      
      * `--description`: Connection description.
      
      * `--labels`: Comma-separated list of labels in `"<key>":"<value>"` format.
      
      * `--user`: User name for connection to the database.
      
      * `--password`: Password.
      
      * `--hosts`: Comma-separated list of hosts in `<host>:<http_port>:<tcp_port>:<shard_name>` format.
      
      * `--databases`: Comma-separated list of databases.
      
        Make sure the user has the required access permissions.
        
      * `--ca-certificate`: Path to your TLS CA certificate file.
        
        TLS is enabled by default; to disable it, use the `--tls-disabled` flag.


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a custom {{ CH }} installation, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          clickhouse = {
            cluster = {
              hosts = [
                {
                  host       = "<host_1>"
                  http_port  = <http_port_1>
                  shard_name = "<shard_1_name>"
                  tcp_port   = <tcp_port_2>
                },
                {
                  host       = "<host_2>"
                  http_port  = <http_port_2>
                  shard_name = "<shard_2_name>"
                  tcp_port   = <tcp_port_2>
                },
                ...
                {
                  host       = "<host_N>"
                  http_port  = <http_port_N>
                  shard_name = "<shard_N_name>"
                  tcp_port   = <tcp_port_N>
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<path_to_certificate>"
                }
              }
            }

            databases = [
              "<database_1>",
              "<database_2>",
              ...
              "<database_N>"
            ]

            auth = {
              user_password = {
                user     = "<username>"
                password = {
                  raw = "<password>"
                }
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.clickhouse`: Parameters for connecting to the custom {{ CH }} installation:
        
        * `cluster.hosts`: Host list. For each host, specify `host`, `http_port`, `shard_name`, and `tcp_port`.

        * `cluster.tls_params`: TLS parameters. Select one of the sections:
        
          * `tls.ca_certificate`: Path to your TLS CA certificate file.
          * `disabled`: Disables TLS. TLS is enabled by default.

        * `databases`: List of databases. Make sure the user has the required access permissions.

        * `auth.user_password.user`: User name for connection to the database.

        * `auth.user_password.password.raw`: Password.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ CH }} custom installation, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.ClickHouseCluster) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.ClickHouseCluster) reference.

{% endlist %}

### {{ MY }} {#mysql-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Specify the connection name.
   1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. Under **Connection to {{ MY }}**, specify the connection parameters:
       1. In the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** field, select **Custom installation**.
       1. In the **Hosts** field, specify the database host address and port number for the connection.

           When creating a connection to a custom database installation intended for [{{ datalens-full-name }}](../../datalens/concepts/index.md), specify the host's external address.

       1. Optionally, enable TLS.
           If your company has a certification authority (CA), the certificate issued by that CA will be used by default. If the company has no CA, upload the server's TLS certificate.
           
   1. Under **Authentication**:
       1. Specify the **Username** you will use to connect to the database.
       1. Select the password setting method:
           * **Enter manually**: You set the password manually.
           * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. Optionally, list the databases whose connections you want to manage. You must have access to them configured.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a custom {{ MY }} installation, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create mysql --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create mysql \
        --name <connection_name> \
        --description "<connection_description>" \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --hosts <list_of_hosts> \
        --databases <database_list> \
        --ca-certificate <path_to_certificate>
      ```

      Where:

      {% include [connection-create-onpremise-cli](../../_includes/metadata-hub/connection-create-onpremise-cli.md) %}


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a custom {{ MY }} installation, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          mysql = {
            cluster = {
              hosts = [
                {
                  host = "<host_1>"
                  port = <port_1>
                },
                {
                  host = "<host_2>"
                  port = <port_2>
                },
                ...
                {
                  host = "<host_N>"
                  port = <port_N>
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<path_to_certificate>"
                }
              }
            }

            databases = [
              "<database_1>",
              "<database_2>",
              ...
              "<database_N>"
            ]

            auth = {
              user_password = {
                user     = "<username>"
                password = {
                  raw = "<password>"
                }
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.mysql`: Parameters for connecting to the custom {{ MY }} installation:
        
        * `cluster.hosts`: Host list. For each host, specify `host` and `port`.

        * `cluster.tls_params`: TLS parameters. Select one of the sections:
        
          * `tls.ca_certificate`: Path to your TLS CA certificate file.
          * `disabled`: Disables TLS. TLS is enabled by default.

        * `databases`: List of databases. Make sure the user has the required access permissions.

        * `auth.user_password.user`: User name for connection to the database.

        * `auth.user_password.password.raw`: Password.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ MY }} custom installation, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.MySQLCluster) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.MySQLCluster) reference.

{% endlist %}

### {{ RD }} {#redis-on-premise}

{% list tabs group=instructions %}

- Management console {#console}
    
    1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
    1. Select **{{ metadata-hub-full-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Specify the connection name.
    1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
    1. From the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** list, select **{{ RD }}**.
    1. Under **Connection to {{ RD }}**, specify the connection parameters:
       1. In the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** field, select **Custom installation**.
       1. In the **Hosts** field, specify the [FQDNs](../../managed-redis/operations/connect/index.md#fqdn) or IP addresses of the hosts in the shard, HTTP or TCP port for connection, and the shard name.
       1. Optionally, enable TLS.
    1. Under **Authentication**, specify a username and select how you want to set the password: 
        * **Enter manually**: Enter the password manually.
        * **Generate**: Specify the options to generate a [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password automatically.
    1. Optionally, list the databases whose connections you want to manage. You must have access to them configured.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a custom {{ RD }} installation, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create redis --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create redis \
        --name <connection_name> \
        --description "<connection_description>" \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --hosts <list_of_hosts> \
        --databases <database_list> \
        --ca-certificate <path_to_certificate>
      ```

      Where:

      * `--name`: Connection name.
      
      * `--description`: Connection description.
      
      * `--labels`: Comma-separated list of labels in `"<key>":"<value>"` format.
      
      * `--user`: User name for connection to the database.
      
      * `--password`: Password.
      
      * `--hosts`: Comma-separated list of hosts in `<host>:<port>:<shard_name>` format.
      
      * `--databases`: Comma-separated list of databases.
      
        Make sure the user has the required access permissions.
        
      * `--ca-certificate`: Path to your TLS CA certificate file.
      
        TLS is enabled by default; to disable it, use the `--tls-disabled` flag.


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a custom {{ RD }} installation, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          redis = {
            cluster = {
              hosts = [
                {
                  host       = "<host_1>"
                  port       = <port_1>
                  shard_name = "<shard_1_name>"
                },
                {
                  host       = "<host_2>"
                  port       = <port_2>
                  shard_name = "<shard_2_name>"
                },
                ...
                {
                  host       = "<host_N>"
                  port       = <port_N>
                  shard_name = "<shard_N_name>"
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<path_to_certificate>"
                }
              }
            }

            databases = [
              "<database_1>",
              "<database_2>",
              ...
              "<database_N>"
            ]

            auth = {
              user_password = {
                user     = "<username>"
                password = {
                  raw = "<password>"
                }
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.redis`: Parameters for connecting to the custom {{ RD }} installation:
        
        * `cluster.hosts`: Host list. For each host, specify `host`, `port`, and `shard_name`.

        * `cluster.tls_params`: TLS parameters. Select one of the sections:
        
          * `tls.ca_certificate`: Path to your TLS CA certificate file.
          * `disabled`: Disables TLS. TLS is enabled by default.

        * `databases`: List of databases. Make sure the user has the required access permissions.

        * `auth.user_password.user`: User name for connection to the database.

        * `auth.user_password.password.raw`: Password.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ RD }} custom installation, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.RedisCluster) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.RedisCluster) reference.

{% endlist %}

### {{ VLK }} {#valkey-on-premise}

{% list tabs group=instructions %}

- Management console {#console}
    
    1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
    1. Select **{{ metadata-hub-full-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Specify the connection name.
    1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
    1. From the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** list, select **{{ VLK }}**.
    1. Under **Connection to {{ VLK }}**, specify the connection parameters:
       1. In the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** field, select **Custom installation**.
       1. In the **Hosts** field, specify the [FQDNs](../../managed-redis/operations/connect/index.md#fqdn) or IP addresses of the hosts in the shard, HTTP or TCP port for connection, and the [shard](../../managed-redis/operations/connect/sharded.md) name.

           When creating a connection to a custom database installation intended for [{{ datalens-full-name }}](../../datalens/concepts/index.md), specify the hosts’ external IP addresses.

       1. Optionally, enable TLS.
    1. Under **Authentication**, specify a username and select how you want to set the password: 
        * **Enter manually**: Enter the password manually.
        * **Generate**: Specify the options to generate a [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password automatically.
    1. Optionally, list the databases whose connections you want to manage. You must have access to them configured.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a custom {{ VLK }} installation, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create valkey --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create valkey \
        --name <connection_name> \
        --description "<connection_description>" \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --hosts <list_of_hosts> \
        --databases <database_list> \
        --ca-certificate <path_to_certificate>
      ```

      Where:

      {% include [connection-create-onpremise-cli](../../_includes/metadata-hub/connection-create-onpremise-cli.md) %}


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a custom {{ VLK }} installation, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          valkey = {
            cluster = {
              hosts = [
                {
                  host = "<host_1>"
                  port = <port_1>
                },
                {
                  host = "<host_2>"
                  port = <port_2>
                },
                ...
                {
                  host = "<host_N>"
                  port = <port_N>
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<path_to_certificate>"
                }
              }
            }

            databases = [
              "<database_1>",
              "<database_2>",
              ...
              "<database_N>"
            ]

            auth = {
              user_password = {
                user     = "<username>"
                password = {
                  raw = "<password>"
                }
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.valkey`: Parameters for connecting to the custom {{ VLK }} installation:
        
        * `cluster.hosts`: Host list. For each host, specify `host` and `port`.

        * `cluster.tls_params`: TLS parameters. Select one of the sections:
        
          * `tls.ca_certificate`: Path to your TLS CA certificate file.
          * `disabled`: Disables TLS. TLS is enabled by default.

        * `databases`: List of databases. Make sure the user has the required access permissions.

        * `auth.user_password.user`: User name for connection to the database.

        * `auth.user_password.password.raw`: Password.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ VLK }} custom installation, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.ValkeyCluster) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.ValkeyCluster) reference.

{% endlist %}

### {{ TR }} {#trino-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Specify the connection name.
  1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
  1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
  1. Under **Connection to {{ TR }}**, specify the connection parameters:
      1. In the **Coordinator** field, specify the [coordinator](https://trino.io/docs/current/overview/concepts.html#coordinator) host address and port number for the connection. 
      1. Optionally, enable TLS.
          If your company has a certification authority (CA), the certificate issued by that CA will be used by default. If the company has no CA, upload the server's TLS certificate.
  1. Under **Authentication**:
      1. Specify the **Username** you will use to connect to the database.
      1. Select the password setting method:
          * **Enter manually**: You set the password manually.
          * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a custom {{ TR }} installation, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create trino --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create trino \
        --name <connection_name> \
        --description "<connection_description>" \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --coordinator <coordinator_parameters> \
        --ca-certificate <path_to_certificate>
      ```

      Where:

      * `--name`: Connection name.
      
      * `--description`: Connection description.
      
      * `--labels`: Comma-separated list of labels in `"<key>":"<value>"` format.
      
      * `--user`: User name for connection to the database.
      
      * `--password`: Password.
      
      * `--coordinator`: Coordinator parameters in `<host>:<port>` format.
      
      * `--ca-certificate`: Path to your TLS CA certificate file.
      
        TLS is enabled by default; to disable it, use the `--tls-disabled` flag.


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a custom {{ TR }} installation, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          trino = {
            cluster = {
              coordinator = {
                  host = "<host>"
                  port = <port>
              }
              
              tls_params = {
                tls {
                  ca_certificate = "<path_to_certificate>"
                }
              }
            }

            auth = {
              user_password = {
                user     = "<username>"
                password = {
                  raw = "<password>"
                }
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.trino`: Parameters for connecting to the custom {{ TR }} installation:
        
        * `cluster.coordinator`: Coordinator parameters, `host` and `port`.

        * `cluster.tls_params`: TLS parameters. Select one of the sections:
        
          * `tls.ca_certificate`: Path to your TLS CA certificate file.
          * `disabled`: Disables TLS. TLS is enabled by default.

        * `auth.user_password.user`: User name for connection to the database.

        * `auth.user_password.password.raw`: Password.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ TR }} custom installation, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.TrinoCluster) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.TrinoCluster) reference.

{% endlist %}

### {{ OS }} {#opensearch-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Specify the connection name.
   1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. Under **Connection to {{ OS }}**, specify the connection parameters:
       1. In the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** field, select **Custom installation**.
       1. In the **Hosts** field, specify the database host address and port number for the connection.
       1. Optionally, enable TLS.
           If your company has a certification authority (CA), the certificate issued by that CA will be used by default. If the company has no CA, upload the server's TLS certificate.
   1. Under **Authentication**:
       1. Specify the **Username** you will use to connect to the database.
       1. Select the password setting method:
           * **Enter manually**: You set the password manually.
           * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. Optionally, list the databases whose connections you want to manage. You must have access to them configured.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a custom {{ OS }} installation, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create opensearch --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create opensearch \
        --name <connection_name> \
        --description "<connection_description>" \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --hosts <list_of_hosts> \
        --ca-certificate <path_to_certificate>
      ```

      Where:

      * `--name`: Connection name.
      
      * `--description`: Connection description.
      
      * `--labels`: Comma-separated list of labels in `"<key>":"<value>"` format.
      
      * `--user`: User name for connection to the database.
      
      * `--password`: Password.
      
      * `--hosts`: Comma-separated list of hosts in `<host>:<port>` format.
      
      * `--ca-certificate`: Path to your TLS CA certificate file.
      
        TLS is enabled by default; to disable it, use the `--tls-disabled` flag.


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a custom {{ OS }} installation, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          opensearch = {
            cluster = {
              hosts = [
                {
                  host = "<host_1>"
                  port = <port_1>
                },
                {
                  host = "<host_2>"
                  port = <port_2>
                },
                ...
                {
                  host = "<host_N>"
                  port = <port_N>
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<path_to_certificate>"
                }
              }
            }

            auth = {
              user_password = {
                user     = "<username>"
                password = {
                  raw = "<password>"
                }
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.opensearch`: Parameters for connecting to the custom {{ OS }} installation:
        
        * `cluster.hosts`: Host list. For each host, specify `host` and `port`.

        * `cluster.tls_params`: TLS parameters. Select one of the sections:
        
          * `tls.ca_certificate`: Path to your TLS CA certificate file.
          * `disabled`: Disables TLS. TLS is enabled by default.

        * `auth.user_password.user`: User name for connection to the database.

        * `auth.user_password.password.raw`: Password.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to an {{ OS }} custom installation, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.OpenSearchCluster) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.OpenSearchCluster) reference.

{% endlist %}

### {{ MG }} {#mongodb-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Specify the connection name.
   1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. Under **Connection to {{ MG }}**, specify the connection parameters:
       1. In the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** field, select **Custom installation**.
       1. In the **Hosts** field, specify the database host address and port number for the connection.
       1. Optionally, enable TLS. 
           If your company has a certification authority (CA), the certificate issued by that CA will be used by default. If the company has no CA, upload the server's TLS certificate.
   1. Under **Authentication**:
       1. Specify the **Username** you will use to connect to the database.
       1. Select the password setting method:
           * **Enter manually**: You set the password manually.
           * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. Optionally, list the databases whose connections you want to manage. You must have access to them configured.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a custom {{ MG }} installation, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create mongodb --help
      ```
      
  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create mongodb \
        --name <connection_name> \
        --description "<connection_description>" \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --hosts <list_of_hosts> \
        --databases <database_list> \
        --ca-certificate <path_to_certificate>
      ```

      Where:

      {% include [connection-create-onpremise-cli](../../_includes/metadata-hub/connection-create-onpremise-cli.md) %}


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a custom {{ MG }} installation, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          mongodb = {
            cluster = {
              hosts = [
                {
                  host = "<host_1>"
                  port = <port_1>
                },
                {
                  host = "<host_2>"
                  port = <port_2>
                },
                ...
                {
                  host = "<host_N>"
                  port = <port_N>
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<path_to_certificate>"
                }
              }
            }

            databases = [
              "<database_1>",
              "<database_2>",
              ...
              "<database_N>"
            ]

            auth = {
              user_password = {
                user     = "<username>"
                password = {
                  raw = "<password>"
                }
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.mongodb`: Parameters for connecting to the custom {{ MG }} installation:
        
        * `cluster.hosts`: Host list. For each host, specify `host` and `port`.

        * `cluster.tls_params`: TLS parameters. Select one of the sections:
        
          * `tls.ca_certificate`: Path to your TLS CA certificate file.
          * `disabled`: Disables TLS. TLS is enabled by default.

        * `databases`: List of databases. Make sure the user has the required access permissions.

        * `auth.user_password.user`: User name for connection to the database.

        * `auth.user_password.password.raw`: Password.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ MG }} custom installation, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.MongoDBCluster) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.MongoDBCluste) reference.

{% endlist %}

### {{ KF }} {#kafka-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Specify the connection name.
   1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. Under **Connection to {{ KF }}**, specify the connection parameters:
       
       * In the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** list, select **Custom installation**.
       * In the **Hosts** field, specify the host address and port for the connection.
       * Optionally, enable TLS.
           
           If your company has a certification authority (CA), the certificate issued by that CA will be used by default. If the company has no CA, upload the server's TLS certificate.
   
   1. When using authentication:

       * Specify the **Username** for the connection.
       * Set a password in one of the following ways:
         
         * **Enter manually**: Enter the password in the input field.
         * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
       
       * Optionally, in the **Authentication mechanisms** list, select the required options:
         
         * `PLAIN`: Authentication with login and password provided as plain unencrypted text.
         * `SCRAM_SHA256`: Authentication with SHA-256 hashing.
         * `SCRAM_SHA512`: Authentication with SHA-512 hashing.


   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a custom {{ KF }} installation, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create kafka --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create kafka \
        --name <connection_name> \
        --description "<connection_description>" \
        --supported-mechanisms <list_of_authentication_mechanisms> \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --hosts <list_of_hosts> \
        --ca-certificate <path_to_certificate>
      ```

      Where:

      * `--name`: Connection name.

      * `--description`: Connection description.

      * `--supported-mechanisms`: List of authentication mechanisms. The possible values are:
        
        * `PLAIN`: Authentication with login and password provided as plain unencrypted text.
        * `SCRAM_SHA256`: Authentication with SHA-256 hashing.
        * `SCRAM_SHA512`: Authentication with SHA-512 hashing.


      * `--labels`: Comma-separated list of labels in `"<key>":"<value>"` format.

      * `--user`: Username to connect to the cluster.

      * `--password`: Password.
      
      * `--hosts`: Comma-separated list of hosts in `<host>:<port>` format.
      
      * `--ca-certificate`: Path to your TLS CA certificate file.
        
        TLS is enabled by default; to disable it, use the `--tls-disabled` flag.


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a custom {{ KF }} installation, do the following:

  1. In the configuration file, describe the resource you are creating:
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          kafka = {
            cluster = {
              hosts = [
                {
                  host = "<host_1>"
                  port = <port_1>
                },
                {
                  host = "<host_2>"
                  port = <port_2>
                },
                ...
                {
                  host = "<host_N>"
                  port = <port_N>
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<path_to_certificate>"
                }
              }
            }

            auth = {
              sasl = {
                user     = "<username>"
                password = { 
                  raw = "<password>"
                }
                supported_mechanisms = [
                  <list_of_authentication_mechanisms>
                ]
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.kafka`: Parameters for connecting to the custom {{ KF }} installation:
        
        * `cluster.hosts`: Host list. For each host, specify `host` and `port`.

        * `cluster.tls_params`: TLS parameters. Select one of the sections:
        
          * `tls.ca_certificate`: Path to your TLS CA certificate file.
          * `disabled`: Disables TLS. TLS is enabled by default.

        * `auth`: Authentication parameters. Select one of the sections:

          * `sasl`: SASL authentication parameters.
            
            * `user`: Username to connect to the cluster.
            * `password.raw`: Password.
            * `supported_mechanisms`: List of authentication mechanisms. The possible values are:
              
              * `PLAIN`: Authentication with login and password provided as plain unencrypted text.
              * `SCRAM_SHA256`: Authentication with SHA-256 hashing.
              * `SCRAM_SHA512`: Authentication with SHA-512 hashing.

          
          * `disabled`: Disables authentication.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ KF }} custom installation, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.KafkaCluster) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.KafkaCluster) reference.

{% endlist %}

### {{ GP }} {#greenplum-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Specify the connection name.
  1. Optionally, add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
  1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
  1. Under **Connection to Greenplum**, specify the connection parameters:
      1. In the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** field, select **Custom installation**.
      1. In the **Hosts** field, specify the database host address and port number for the connection.

          When creating a connection to a custom database installation intended for [{{ datalens-full-name }}](../../datalens/concepts/index.md), specify the host's external address.

      1. Optionally, enable TLS.
          
          If your company has a certification authority (CA), the certificate issued by that CA will be used by default. If the company has no CA, upload the server's TLS certificate.
          
  1. Under **Authentication**:
      1. Specify the **Username** for the connection.
      1. Select the password setting method:
          * **Enter manually**: Enter the password in the input field.
          * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
  1. List the databases whose connections you want to manage. Make sure the user has the required access permissions.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a connection to a custom {{ GP }} installation, do the following:

  1. See the description of the CLI command for creating a connection:

      ```bash
      yc metadata-hub connection-manager connection create greenplum --help
      ```

  1. Create your connection by running this command:
      
      ```bash
      yc metadata-hub connection-manager connection create greenplum \
        --name <connection_name> \
        --description "<connection_description>" \
        --labels <label_list> \
        --user <username> \
        --password <password> \
        --hosts <list_of_hosts> \
        --databases <database_list> \
        --ca-certificate <path_to_certificate>
      ```

      Where:

      {% include [connection-create-onpremise-cli](../../_includes/metadata-hub/connection-create-onpremise-cli.md) %}


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a connection to a custom {{ GP }} installation, do the following:

  1. In the configuration file, describe the resource you are creating.
  
      Here is an example of the configuration file structure:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<local_connection_name>" {
        name        = "<connection_name>"
        description = "<connection_description>"
        
        labels = {
          "<key_1>" = "<value_1>"
          "<key_2>" = "<value_2>"
          ...
          "<key_N>" = "<value_N>"
        }
        
        params = {
          greenplum = {
            cluster = {
              hosts = [
                {
                  host = "<host_1>"
                  port = <port_1>
                },
                {
                  host = "<host_2>"
                  port = <port_2>
                },
                ...
                {
                  host = "<host_N>"
                  port = <port_N>
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<path_to_certificate>"
                }
              }
            }

            databases = [
              "<database_1>",
              "<database_2>",
              ...
              "<database_N>"
            ]

            auth = {
              user_password = {
                user     = "<username>"
                password = {
                  raw = "<password>"
                }
              }
            }
          }
        }
      }
      ```

      Where:

      * `name`: Connection name.

      * `description`: Connection description.

      * `--labels`: Labels in `"<key>" = "<value>"` format.

      * `params.greenplum`: Parameters for connecting to the custom {{ GP }} installation:
        
        * `cluster.hosts`: Host list. For each host, specify `host` and `port`.

        * `cluster.tls_params`: TLS parameters. Select one of the sections:
        
          * `tls.ca_certificate`: Path to your TLS CA certificate file.
          * `disabled`: Disables TLS. TLS is enabled by default.

        * `databases`: List of databases. Make sure the user has the required access permissions.

        * `auth.user_password.user`: User name for connection to the database.

        * `auth.user_password.password.raw`: Password.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  To create a connection to a {{ MG }} custom installation, use the [Connection.Create](../connection-manager/api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.GreenplumCluster) and [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.GreenplumCluster) reference.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
