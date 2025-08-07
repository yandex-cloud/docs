---
title: Creating a {{ TR }} catalog
description: Follow this guide to create a catalog in a {{ mtr-name }} cluster.
---

# Creating a {{ TR }} catalog

## Roles for creating a {{ TR }} catalog {#roles}

To create a [{{ TR }} catalog](../concepts/index.md#catalog) with the [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) connection type, your {{ yandex-cloud }} account needs an additional role, [{{ roles-connection-manager-user }}](../../metadata-hub/security/connection-manager-roles.md#connection-manager-user), to use connections from {{ connection-manager-name }}.

Make sure you assign the [{{ roles-connection-manager-user }}](../../metadata-hub/security/connection-manager-roles.md#connection-manager-user) and [{{ roles-lockbox-payloadviewer }}](../../lockbox/security/index.md#lockbox-payloadViewer) roles to the cluster [service account](../../iam/concepts/users/service-accounts.md). The cluster will thus get the permissions it needs to work with connections from {{ connection-manager-name }}. For more information, see [Impersonation](../concepts/impersonation.md).

For more information about assigning roles, see the [{{ iam-full-name }}](../../iam/operations/roles/grant.md) documentation.

## Creating a {{ TR }} catalog {#create-catalog}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [resource folder]({{ link-console-main }}) page, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the cluster name.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
  1. Click **{{ ui-key.yacloud.trino.catalogs.create_action }}**.
  1. In the **{{ ui-key.yacloud.trino.catalogs.field_catalog-name }}** field, enter a name for the {{ TR }} catalog.
  1. In the **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}** field, select the [connector](../concepts/index.md#connector) type.
  1. Configure [{{ TR }} catalog settings](#catalog-settings).
  1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. Add the `yandex_trino_catalog` resource:

        ```hcl
        resource "yandex_trino_catalog" "<folder_name>" {
          name        = "<folder_name>"
          cluster_id  = yandex_trino_cluster.mytr.id
          <connector_type> = {
            <{{ TR }}_catalog_settings>
          }
        }
        ```

        [Learn more about the {{ TR }} catalog settings](#catalog-settings) for various connector types.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

## {{ TR }} catalog settings {#catalog-settings}

{{ TR }} catalog settings depend on the connector you select.

{% note info %}

Connectors marked with {{ preview-stage }} are at the preview stage. Their stability is not guaranteed.

{% endnote %}

### {{ CH }} connector {#ch}

Adjust the settings according to your connection type: [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) or On-premise (custom installation).

#### {{ connection-manager-name }} {#ch-connection-manager}

{% list tabs group=instructions %}

- Management console {#console}

    * **Connection ID**: Connection ID in {{ connection-manager-name }} for connection to the {{ CH }} cluster.

        To find out the connection ID:
        1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
        1. Click the cluster name and go to the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab.

    * **Database**: DB name in the {{ CH }} cluster.
    * **Client parameters**: {{ CH }} client parameters in `key: value` format.

        {% include [client-parameters-ch](../../_includes/managed-trino/client-parameters-ch.md) %}

    * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/clickhouse.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<folder_name>" {
      ...
      clickhouse = {
        connection_manager = {
          connection_id = "<connection_ID>"
          database      = "<DB_name>"
          connection_properties = {
            <list_of_{{ CH }}_client_settings>
          }
        }
        additional_properties = {
          <list_of_additional_settings>
        }
      }
    }
    ```

    Where:

    * `connection_manager`: {{ connection-manager-name }} settings:

        * `connection_id`: Connection ID in {{ connection-manager-name }} for connecting to the {{ CH }} cluster.

            To find out the connection ID:
            1. In the management console, navigate to the [folder]({{ link-console-main }}) page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
            1. Click the cluster name and go to the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab.

        * `database`: DB name in the {{ CH }} cluster.
        * `connection_properties`: List of {{ CH }} client settings in `"key" = "value"` format.

            {% include [client-parameters-ch](../../_includes/managed-trino/client-parameters-ch.md) %}

    * `additional_properties`: List of additional settings in `"key" = "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/clickhouse.html).

{% endlist %}

#### On-premise connection {#ch-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

    * **URL**: URL for connecting to the {{ CH }} DB, in `jdbc:clickhouse://<host_address>:<port>/<DB_name>` format.
    * **Username**: Username for connecting to the {{ CH }} DB.
    * **Password**: User password for connecting to the {{ CH }} DB.
    * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/clickhouse.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<folder_name>" {
      ...
      clickhouse = {
        on_premise = {
          connection_url = "<URL_for_connection>"
          user_name      = "<user_name>"
          password       = "<user_password>"
        }
        additional_properties = {
          <list_of_additional_settings>
        }
      }
    }
    ```

    Where:

    * `on_premise`: Settings for connecting to the custom installation:

        * `connection_url`: URL for connection to the {{ CH }} DB, in `jdbc:clickhouse://<host_address>:<port>/<DB_name>` format.
        * `user_name`: Username for connection to the {{ CH }} DB.
        * `password`: User password for connection to the {{ CH }} DB.

    * `additional_properties`: List of additional settings in `"key" = "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/clickhouse.html).

{% endlist %}

### Delta Lake connector {#delta-lake}

{% list tabs group=instructions %}

- Management console {#console}

    {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

    * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/delta-lake.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<folder_name>" {
      ...
      delta_lake = {
        file_system = {
          s3 = {}
        }
        metastore = {
          uri = "<URI_for_connection>"
        }
        additional_properties = {
          <list_of_additional_settings>
        }
      }
    }
    ```

    Where:

    {% include [connector-settings-terraform](../../_includes/managed-trino/terraform/connector-settings.md) %}

    * `additional_properties`: List of additional settings in `"key" = "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/delta-lake.html).

{% endlist %}

### Hive connector {#hive}

{% list tabs group=instructions %}

- Management console {#console}

    {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

    * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/hive.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<folder_name>" {
      ...
      hive = {
        file_system = {
          s3 = {}
        }
        metastore = {
          uri = "<URI_for_connection>"
        }
        additional_properties = {
          <list_of_additional_settings>
        }
      }
    }
    ```

    Where:

    {% include [connector-settings-terraform](../../_includes/managed-trino/terraform/connector-settings.md) %}

    * `additional_properties`: List of additional settings in `"key" = "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/hive.html).

{% endlist %}

### Iceberg connector {#iceberg}

{% list tabs group=instructions %}

- Management console {#console}

    {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

    * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/iceberg.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<folder_name>" {
      ...
      iceberg = {
        file_system = {
          s3 = {}
        }
        metastore = {
          uri = "<URI_for_connection>"
        }
        additional_properties = {
          <list_of_additional_settings>
        }
      }
    }
    ```

    Where:

    {% include [connector-settings-terraform](../../_includes/managed-trino/terraform/connector-settings.md) %}

    * `additional_properties`: List of additional settings in `"key" = "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/iceberg.html).

{% endlist %}

### Oracle {{ preview-stage }} connector {#oracle}

{% list tabs group=instructions %}

- Management console {#console}

    * **Connection type**: On-premise.
    * **URL**: URL for connecting to the Oracle DB, in `jdbc:oracle:thin:@<host_address>:<port>:<SID>`. `SID` format, Oracle system ID.
    * **Username**: Username for connecting to the Oracle DB.
    * **Password**: User password for connecting to the Oracle DB.
    * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/oracle.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<folder_name>" {
      ...
      oracle = {
        on_premise = {
          connection_url = "<URL_for_connection>"
          user_name      = "<user_name>"
          password       = "<user_password>"
        }
        additional_properties = {
          <list_of_additional_settings>
        }
      }
    }
    ```

    Where:

    * `on_premise`: Settings for connecting to the custom installation:

        * `connection_url`: URL for connecting to the Oracle DB, in `jdbc:oracle:thin:@<host_address>:<port>:<SID>` format, where `SID` is the Oracle system ID.
        * `user_name`: Username for connection to the Oracle DB.
        * `password`: User password for connection to the Oracle DB.

    * `additional_properties`: List of additional settings in `"key" = "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/oracle.html).

{% endlist %}

### {{ PG }} connector {#pg}

Adjust the settings according to your connection type: [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) or On-premise (custom installation).

#### {{ connection-manager-name }} {#pg-connection-manager}

{% list tabs group=instructions %}

- Management console {#console}

    * **Connection ID**: Connection ID in {{ connection-manager-name }} for connection to the {{ PG }} cluster.

        To find out the connection ID:
        1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
        1. Click the cluster name and go to the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab.

    * **Database**: DB name in the {{ PG }} cluster.
    * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/postgresql.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<folder_name>" {
      ...
      postgresql = {
        connection_manager = {
          connection_id = "<connection_ID>"
          database      = "<DB_name>"
          connection_properties = {
            <list_of_{{ PG }}_client_settings>
          }
        }
        additional_properties = {
          <list_of_additional_settings>
        }
      }
    }
    ```

    Where:

    * `connection_manager`: {{ connection-manager-name }} settings:

        * `connection_id`: Connection ID in {{ connection-manager-name }} for connecting to the {{ PG }} cluster.

            To find out the connection ID:
            1. In the management console, navigate to the [folder]({{ link-console-main }}) page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
            1. Click the cluster name and go to the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab.

        * `database`: DB name in the {{ PG }} cluster.
        * `connection_properties`: List of {{ PG }} client settings in `"key" = "value"` format.

            {% include [client-parameters-pg](../../_includes/managed-trino/client-parameters-pg.md) %}

    * `additional_properties`: List of additional settings in `"key" = "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/postgresql.html).

{% endlist %}

#### On-premise connection {#pg-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

    * **URL**: URL for connecting to the {{ PG }} DB, in `jdbc:postgresql://<host_address>:<port>/<DB_name>` format.
    * **Username**: Username for connecting to the {{ PG }} DB.
    * **Password**: User password for connecting to the {{ PG }} DB.
    * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/postgresql.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<folder_name>" {
      ...
      postgresql = {
        on_premise = {
          connection_url = "<URL_for_connection>"
          user_name      = "<user_name>"
          password       = "<user_password>"
        }
        additional_properties = {
          <list_of_additional_settings>
        }
      }
    }
    ```

    Where:

    * `on_premise`: Settings for connecting to the custom installation:

        * `connection_url`: URL for connecting to the {{ PG }} DB, in `jdbc:postgresql://<host_address>:<port>/<DB_name>` format.
        * `user_name`: Username for connecting to the {{ PG }} DB.
        * `password`: User password for connecting to the {{ PG }} DB.

    * `additional_properties`: List of additional settings in `"key" = "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/postgresql.html).

{% endlist %}

### MS SQL Server connector {{ preview-stage }} {#ms-sql}

{% list tabs group=instructions %}

- Management console {#console}

    * **Connection type**: On-premise.
    * **URL**: URL for connecting to the Microsoft SQL Server DB, in `jdbc:sqlserver://<host_address>:<port>;databaseName=<DB_name>` format.
    * **Username**: Username for connecting to the Microsoft SQL Server DB.
    * **Password**: User password for connecting to the Microsoft SQL Server DB.
    * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/sqlserver.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<folder_name>" {
      ...
      sqlserver = {
        on_premise = {
          connection_url = "<URL_for_connection>"
          user_name      = "<user_name>"
          password       = "<user_password>"
        }
        additional_properties = {
          <list_of_additional_settings>
        }
      }
    }
    ```

    Where:

    * `on_premise`: Settings for connecting to the custom installation:

        * `connection_url`: URL for connecting to the Microsoft SQL Server DB, in `jdbc:sqlserver://<host_address>:<port>;databaseName=<DB_name>` format.
        * `user_name`: Username for connecting to the Microsoft SQL Server DB.
        * `password`: User password for connecting to the Microsoft SQL Server DB.

    * `additional_properties`: List of additional settings in `"key" = "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/sqlserver.html).

{% endlist %}

### TPC-DS connector {#tpc-ds}

The TPC-DS connector has no required settings. Optionally, you can configure advanced settings.

{% list tabs group=instructions %}

- Management console {#console}

    You can specify additional settings in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/tpcds.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<folder_name>" {
      ...
      tpcds = {
        additional_properties = {
          <list_of_additional_settings>
        }
      }
    }
    ```

    Where `additional_properties` is a list of advanced settings in `"key" = "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/tpcds.html).

{% endlist %}

### TPC-H connector {#tpc-h}

The TPC-H connector has no required settings. Optionally, you can configure advanced settings.

{% list tabs group=instructions %}

- Management console {#console}

    You can specify additional settings in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/tpch.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<folder_name>" {
      ...
      tpch = {
        additional_properties = {
          <list_of_additional_settings>
        }
      }
    }
    ```

    Where `additional_properties` is a list of advanced settings in `"key" = "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/tpch.html).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}