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

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. View the description of the CLI command for creating {{ TR }} catalog:

        ```bash
        {{ yc-mdb-tr }} catalog create --help
        ```

    1. View the description of the CLI command for creating a {{ TR }} catalog with a specific connector:

        ```bash
        {{ yc-mdb-tr }} catalog create <connector_type> --help
        ```

    1. To create a {{ TR }} catalog, run this command:

        ```bash
        {{ yc-mdb-tr }} catalog create <connector_type> <{{ TR }}_catalog_name>
        ```

        In the command, you also need to provide {{ TR }} catalog settings depending on the connector type. [Learn more about settings for various connector types](#catalog-settings).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. Add the `yandex_trino_catalog` resource:

        ```hcl
        resource "yandex_trino_catalog" "<{{ TR }}_catalog_name>" {
          name        = "<{{ TR }}_catalog_name>"
          cluster_id  = yandex_trino_cluster.<cluster_name>.id
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

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Catalog.Create](../api-ref/Catalog/create.md) method and run the request, e.g., using {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/catalogs' \
            --data '{
                      "catalog": {
                        "name": "<{{ TR }}_catalog_name>",
                        "connector": {
                          "<connector_type>": {
                            <{{ TR }}_catalog_settings>
                          }
                        }
                      }
                    }'
        ```

        [Learn more about the {{ TR }}](#catalog-settings) catalog settings for various connector types.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Catalog/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [CatalogService.Create](../api-ref/grpc/Catalog/create.md) call and run the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "catalog": {
                    "name": "<{{ TR }}_catalog_name>",
                    "connector": {
                      "<connector_type>": {
                            <{{ TR }}_catalog_settings>
                      }
                    }
                  }
                }' \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.CatalogService.Create
        ```

        [Learn more about the {{ TR }}](#catalog-settings) catalog settings for various connector types.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Catalog/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

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

- CLI {#cli}

    Example command:

    ```bash
    {{ yc-mdb-tr }} catalog create clickhouse <{{ TR }}_catalog_name> \
      --cluster-id <cluster_ID> \
      --connection-manager-connection-id <connection_ID> \
      --connection-manager-database <DB_name> \
      --connection-manager-connection-properties <list_of_{{ CH }}_client_parameters> \
      --additional-properties <list_of_additional_settings>
    ```

    Where:

    * `--cluster-id`: ID of the cluster you are creating the {{ TR }} catalog in. You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).
    * `--connection-manager-connection-id`: Connection ID in {{ connection-manager-name }} for connecting to the {{ CH }} cluster.

      To find out the connection ID:
        1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
        1. Click the cluster name and go to the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab.   

    * `--connection-manager-database`: DB name in the {{ CH }} cluster.
    * `--connection-manager-connection-properties`: {{ CH }} client parameters in `key=value` format.

        {% include [client-parameters-ch](../../_includes/managed-trino/client-parameters-ch.md) %}

    * `additional-properties`: Additional settings in `key=value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/clickhouse.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<{{ TR }}_catalog_name>" {
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

- REST API {#api}

    Example command:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<{{ TR }}_catalog_name>",
                    "connector": {
                      "clickhouse": {
                        "connection": {
                          "connectionManager": {
                            "connectionId": "<connection_ID>",
                            "database": "<DB_name>",
                            "connectionProperties": {
                              <list_of_{{ CH }}_client_settings>
                            }
                          }
                        },
                        "additionalProperties": {
                          <list_of_additional_settings>
                        }
                      }
                    }
                  }
                }'
    ```

    Where:

    * `connectionManager`: {{ connection-manager-name }} settings:

        * `connectionId`: Connection ID in {{ connection-manager-name }} for connecting to the {{ CH }} cluster.

            To find out the connection ID:
            1. In the management console, navigate to the [folder]({{ link-console-main }}) page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
            1. Click the cluster name and go to the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab.

        * `database`: DB name in the {{ CH }} cluster.
        * `connectionProperties`: List of {{ CH }} client settings in `"key": "value"` format.

            {% include [client-parameters-ch](../../_includes/managed-trino/client-parameters-ch.md) %}

    * `additionalProperties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/clickhouse.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Example command:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>",
              "catalog": {
                "name": "<{{ TR }}_catalog_name>",
                "connector": {
                  "clickhouse": {
                    "connection": {
                      "connection_manager": {
                        "connection_id": "<connection_ID>",
                        "database": "<DB_name>",
                        "connection_properties": {
                          <list_of_{{ CH }}_client_settings>
                        }
                      }
                    },
                    "additional_properties": {
                      <list_of_additional_settings>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Where:

    * `connection_manager`: {{ connection-manager-name }} settings:

        * `connection_id`: Connection ID in {{ connection-manager-name }} for connecting to the {{ CH }} cluster.

            To find out the connection ID:
            1. In the management console, navigate to the [folder]({{ link-console-main }}) page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
            1. Click the cluster name and go to the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab.

        * `database`: DB name in the {{ CH }} cluster.
        * `connection_properties`: List of {{ CH }} client settings in `"key": "value"` format.

            {% include [client-parameters-ch](../../_includes/managed-trino/client-parameters-ch.md) %}

    * `additional_properties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/clickhouse.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

#### On-premise connection {#ch-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

    * **URL**: URL for connecting to the {{ CH }} DB, in `jdbc:clickhouse://<host_address>:<port>/<DB_name>` format.
    * **Username**: Username for connecting to the {{ CH }} DB.
    * **Password**: User password for connecting to the {{ CH }} DB.
    * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/clickhouse.html).

- CLI {#cli}

    Example command:

    ```bash
    {{ yc-mdb-tr }} catalog create clickhouse <{{ TR }}_catalog_name> \
      --cluster-id <cluster_ID> \
      --on-premise-connection-url <URL_for_connection> \
      --on-premise-user-name <username> \
      --on-premise-password <user_password> \
      --additional-properties <list_of_additional_settings>
    ```

    Where:

    * `--cluster-id`: ID of the cluster you are creating the {{ TR }} catalog in. You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).
    * `--on-premise-connection-url`: URL for connection to the {{ CH }} DB, in `jdbc:clickhouse://<host_address>:<port>/<DB_name>` format.
    * `--on-premise-user-name`: Username for connection to the {{ CH }} DB.
    * `--on-premise-password`: User password for connecting to the {{ CH }} DB.
    * `--additional-properties`: Additional settings in `key=value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/clickhouse.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<{{ TR }}_catalog_name>" {
      ...
      clickhouse = {
        on_premise = {
          connection_url = "<URL_for_connection>"
          user_name      = "<username>"
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

- REST API {#api}

    Example command:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<{{ TR }}_catalog_name>",
                    "connector": {
                      "clickhouse": {
                        "connection": {
                          "onPremise": {
                            "connectionUrl": "<URL_for_connection>",
                            "userName": "<username>",
                            "password": "<user_password>"
                          }
                        },
                        "additionalProperties": {
                          <list_of_additional_settings>
                        }
                      }
                    }
                  }
                }'
    ```

    Where:

    * `onPremise`: Settings for connecting to the custom installation:

        * `connectionUrl`: URL for connection to the {{ CH }} DB, in `jdbc:clickhouse://<host_address>:<port>/<DB_name>` format.
        * `userName`: Username for connection to the {{ CH }} DB.
        * `password`: User password for connecting to the {{ CH }} DB.

    * `additionalProperties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/clickhouse.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Example command:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>",
              "catalog": {
                "name": "<{{ TR }}_catalog_name>",
                "connector": {
                  "clickhouse": {
                    "connection": {
                      "on_premise": {
                        "connection_url": "<URL_for_connection>",
                        "user_name": "<username>",
                        "password": "<user_password>"
                      }
                    },
                    "additional_properties": {
                      <list_of_additional_settings>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Where:

    * `on_premise`: Settings for connecting to the custom installation:

        * `connection_url`: URL for connection to the {{ CH }} DB, in `jdbc:clickhouse://<host_address>:<port>/<DB_name>` format.
        * `user_name`: Username for connection to the {{ CH }} DB.
        * `password`: User password for connecting to the {{ CH }} DB.

    * `additional_properties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/clickhouse.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

### Delta Lake connector {#delta-lake}

{% list tabs group=instructions %}

- Management console {#console}

    {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

    * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/delta-lake.html).

- CLI {#cli}

    Example command:

    ```bash
    {{ yc-mdb-tr }} catalog create delta-lake <{{ TR }}_catalog_name> \
      --cluster-id <cluster_ID> \
      --metastore-hive-uri <URI_for_connection> \
      --filesystem-native-s3 \
      --filesystem-external-s3-aws-access-key <access_key_ID> \
      --filesystem-external-s3-aws-secret-key <secret_key> \
      --filesystem-external-s3-aws-endpoint <endpoint> \
      --filesystem-external-s3-aws-region <region> \
      --additional-properties <list_of_additional_settings>
    ```

    Where:

    {% include [cli-connector-settings](../../_includes/managed-trino/cli-connector-settings.md) %}

    * `--additional-properties`: Additional settings in `key=value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/delta-lake.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<{{ TR }}_catalog_name>" {
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

- REST API {#api}

    Example command:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<{{ TR }}_catalog_name>",
                    "connector": {
                      "deltaLake": {
                        "filesystem": {
                          "s3": {}
                        },
                        "metastore": {
                          "hive": {
                            "uri": "<URI_for_connection>"
                          }
                        },
                        "additionalProperties": {
                          <list_of_additional_settings>
                        }
                      }
                    }
                  }
                }'
    ```

    Where:

    {% include [connector-settings-rest-api](../../_includes/managed-trino/api/connector-settings-rest.md) %}

    * `additionalProperties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/delta-lake.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Example command:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>",
              "catalog": {
                "name": "<{{ TR }}_catalog_name>",
                "connector": {
                  "delta_lake": {
                    "filesystem": {
                      "s3": {}
                    },
                    "metastore": {
                      "hive": {
                        "uri": "<URI_for_connection>"
                      }
                    },
                    "additional_properties": {
                      <list_of_additional_settings>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Where:

    {% include [connector-settings-grpc-api](../../_includes/managed-trino/api/connector-settings-grpc.md) %}

    * `additional_properties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/delta-lake.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

### Hive connector {#hive}

{% list tabs group=instructions %}

- Management console {#console}

    {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

    * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/hive.html).

- CLI {#cli}

    Example command:

    ```bash
    {{ yc-mdb-tr }} catalog create hive <{{ TR }}_catalog_name> \
      --cluster-id <cluster_ID> \
      --metastore-hive-uri <URI_for_connection> \
      --filesystem-native-s3 \
      --filesystem-external-s3-aws-access-key <access_key_ID> \
      --filesystem-external-s3-aws-secret-key <secret_key> \
      --filesystem-external-s3-aws-endpoint <endpoint> \
      --filesystem-external-s3-aws-region <region> \
      --additional-properties <list_of_additional_settings>
    ```

    Where:

    {% include [cli-connector-settings](../../_includes/managed-trino/cli-connector-settings.md) %}

    * `--additional-properties`: Additional settings in `key=value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/hive.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<{{ TR }}_catalog_name>" {
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

- REST API {#api}

    Example command:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<{{ TR }}_catalog_name>",
                    "connector": {
                      "hive": {
                        "filesystem": {
                          "s3": {}
                        },
                        "metastore": {
                          "hive": {
                            "uri": "<URI_for_connection>"
                          }
                        },
                        "additionalProperties": {
                          <list_of_additional_settings>
                        }
                      }
                    }
                  }
                }'
    ```

    Where:

    {% include [connector-settings-rest-api](../../_includes/managed-trino/api/connector-settings-rest.md) %}

    * `additionalProperties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/hive.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Example command:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>",
              "catalog": {
                "name": "<{{ TR }}_catalog_name>",
                "connector": {
                  "hive": {
                    "filesystem": {
                      "s3": {}
                    },
                    "metastore": {
                      "hive": {
                        "uri": "<URI_for_connection>"
                      }
                    },
                    "additional_properties": {
                      <list_of_additional_settings>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Where:

    {% include [connector-settings-grpc-api](../../_includes/managed-trino/api/connector-settings-grpc.md) %}

    * `additional_properties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/hive.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

### Iceberg connector {#iceberg}

{% list tabs group=instructions %}

- Management console {#console}

    {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

    * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/iceberg.html).

- CLI {#cli}

    Example command:

    ```bash
    {{ yc-mdb-tr }} catalog create iceberg <{{ TR }}_catalog_name> \
      --cluster-id <cluster_ID> \
      --metastore-hive-uri <URI_for_connection> \
      --filesystem-native-s3 \
      --filesystem-external-s3-aws-access-key <access_key_ID> \
      --filesystem-external-s3-aws-secret-key <secret_key> \
      --filesystem-external-s3-aws-endpoint <endpoint> \
      --filesystem-external-s3-aws-region <region> \
      --additional-properties <list_of_additional_settings>
    ```

    Where:

    {% include [cli-connector-settings](../../_includes/managed-trino/cli-connector-settings.md) %}

    * `--additional-properties`: Additional settings in `key=value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/iceberg.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<{{ TR }}_catalog_name>" {
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

- REST API {#api}

    Example command:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<{{ TR }}_catalog_name>",
                    "connector": {
                      "iceberg": {
                        "filesystem": {
                          "s3": {}
                        },
                        "metastore": {
                          "hive": {
                            "uri": "<URI_for_connection>"
                          }
                        },
                        "additionalProperties": {
                          <list_of_additional_settings>
                        }
                      }
                    }
                  }
                }'
    ```

    Where:

    {% include [connector-settings-rest-api](../../_includes/managed-trino/api/connector-settings-rest.md) %}

    * `additionalProperties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/iceberg.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Example command:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>",
              "catalog": {
                "name": "<{{ TR }}_catalog_name>",
                "connector": {
                  "iceberg": {
                    "filesystem": {
                      "s3": {}
                    },
                    "metastore": {
                      "hive": {
                        "uri": "<URI_for_connection>"
                      }
                    },
                    "additional_properties": {
                      <list_of_additional_settings>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Where:

    {% include [connector-settings-grpc-api](../../_includes/managed-trino/api/connector-settings-grpc.md) %}

    * `additional_properties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/iceberg.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

### Oracle {{ preview-stage }} connector {#oracle}

{% list tabs group=instructions %}

- Management console {#console}

    * **Connection type**: On-premise.
    * **URL**: URL for connecting to the Oracle DB, in `jdbc:oracle:thin:@<host_address>:<port>:<SID>`. `SID` format, Oracle system ID.
    * **Username**: Username for connecting to the Oracle DB.
    * **Password**: User password for connecting to the Oracle DB.
    * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/oracle.html).

- CLI {#cli}

    Example command:

    ```bash
    {{ yc-mdb-tr }} catalog create oracle <{{ TR }}_catalog_name> \
      --cluster-id <cluster_ID> \
      --on-premise-connection-url <URL_for_connection> \
      --on-premise-user-name <username> \
      --on-premise-password <user_password> \
      --additional-properties <list_of_additional_settings>
    ```

    Where:

    * `--cluster-id`: ID of the cluster you are creating the {{ TR }} catalog in. You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).
    * `--on-premise-connection-url`: URL for connecting to the Oracle DB, in `jdbc:oracle:thin:@<host_address>:<port>:<SID>`. `SID` format, Oracle system ID.
    * `--on-premise-user-name`: Username for connection to the Oracle DB.
    * `--on-premise-password`: User password for connection to the Oracle DB.
    * `--additional-properties`: Additional settings in `key=value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/oracle.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<{{ TR }}_catalog_name>" {
      ...
      oracle = {
        on_premise = {
          connection_url = "<URL_for_connection>"
          user_name      = "<username>"
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

- REST API {#api}

    Example command:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<{{ TR }}_catalog_name>",
                    "connector": {
                      "oracle": {
                        "connection": {
                          "onPremise": {
                            "connectionUrl": "<URL_for_connection>",
                            "userName": "<username>",
                            "password": "<user_password>"
                          }
                        },
                        "additionalProperties": {
                          <list_of_additional_settings>
                        }
                      }
                    }
                  }
                }'
    ```

    Where:

    * `onPremise`: Settings for connecting to the custom installation:

        * `connectionUrl`: URL for connecting to the Oracle DB, in `jdbc:oracle:thin:@<host_address>:<port>:<SID>` format, where `SID` is the Oracle system ID.
        * `userName`: Username for connection to the Oracle DB.
        * `password`: User password for connection to the Oracle DB.

    * `additionalProperties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/oracle.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Example command:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>",
              "catalog": {
                "name": "<{{ TR }}_catalog_name>",
                "connector": {
                  "oracle": {
                    "connection": {
                      "on_premise": {
                        "connection_url": "<URL_for_connection>",
                        "user_name": "<username>",
                        "password": "<user_password>"
                      }
                    },
                    "additional_properties": {
                      <list_of_additional_settings>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Where:

    * `on_premise`: Settings for connecting to the custom installation:

        * `connection_url`: URL for connecting to the Oracle DB, in `jdbc:oracle:thin:@<host_address>:<port>:<SID>` format, where `SID` is the Oracle system ID.
        * `user_name`: Username for connection to the Oracle DB.
        * `password`: User password for connection to the Oracle DB.

    * `additional_properties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/oracle.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

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

- CLI {#cli}

    Example command:

    ```bash
    {{ yc-mdb-tr }} catalog create postgresql <{{ TR }}_catalog_name> \
      --cluster-id <cluster_ID> \
      --connection-manager-connection-id <connection_ID> \
      --connection-manager-database <DB_name> \
      --connection-manager-connection-properties <list_of_{{ PG }}_client_parameters> \
      --additional-properties <list_of_additional_settings>
    ```

    Where:

    * `--cluster-id`: ID of the cluster you are creating the {{ TR }} catalog in. You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).
    * `--connection-manager-connection-id`: Connection ID in {{ connection-manager-name }} for connecting to the {{ PG }} cluster.

        To find out the connection ID:
        1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
        1. Click the cluster name and go to the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab.

    * `--connection-manager-database`: DB name in the {{ PG }} cluster.
    * `--connection-manager-connection-properties`: List of {{ PG }} client settings in `key=value` format.

        {% include [client-parameters-pg](../../_includes/managed-trino/client-parameters-pg.md) %}

    * `--additional-properties`: Additional settings in `key=value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/postgresql.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<{{ TR }}_catalog_name>" {
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

- REST API {#api}

    Example command:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<{{ TR }}_catalog_name>",
                    "connector": {
                      "postgresql": {
                        "connection": {
                          "connectionManager": {
                            "connectionId": "<connection_ID>",
                            "database": "<DB_name>",
                            "connectionProperties": {
                              <list_of_{{ PG }}_client_settings>
                            }
                          }
                        },
                        "additionalProperties": {
                          <list_of_additional_settings>
                        }
                      }
                    }
                  }
                }'
    ```

    Where:

    * `connectionManager`: {{ connection-manager-name }} settings:

        * `connectionId`: Connection ID in {{ connection-manager-name }} for connecting to the {{ PG }} cluster.

            To find out the connection ID:
            1. In the management console, navigate to the [folder]({{ link-console-main }}) page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
            1. Click the cluster name and go to the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab.

        * `database`: DB name in the {{ PG }} cluster.
        * `connectionProperties`: List of {{ PG }} client settings in `"key": "value"` format.

            {% include [client-parameters-pg](../../_includes/managed-trino/client-parameters-pg.md) %}

    * `additionalProperties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/postgresql.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Example command:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>",
              "catalog": {
                "name": "<{{ TR }}_catalog_name>",
                "connector": {
                  "postgesql": {
                    "connection": {
                      "connection_manager": {
                        "connection_id": "<connection_ID>",
                        "database": "<DB_name>",
                        "connection_properties": {
                          <list_of_{{ PG }}_client_settings>
                        }
                      }
                    },
                    "additional_properties": {
                      <list_of_additional_settings>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Where:

    * `connection_manager`: {{ connection-manager-name }} settings:

        * `connection_id`: Connection ID in {{ connection-manager-name }} for connecting to the {{ PG }} cluster.

            To find out the connection ID:
            1. In the management console, navigate to the [folder]({{ link-console-main }}) page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
            1. Click the cluster name and go to the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab.

        * `database`: DB name in the {{ PG }} cluster.
        * `connection_properties`: List of {{ PG }} client settings in `"key": "value"` format.

            {% include [client-parameters-pg](../../_includes/managed-trino/client-parameters-pg.md) %}

    * `additional_properties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/postgresql.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

#### On-premise connection {#pg-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

    * **URL**: URL for connecting to the {{ PG }} DB, in `jdbc:postgresql://<host_address>:<port>/<DB_name>` format.
    * **Username**: Username for connecting to the {{ PG }} DB.
    * **Password**: User password for connecting to the {{ PG }} DB.
    * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/postgresql.html).

- CLI {#cli}

    Example command:

    ```bash
    {{ yc-mdb-tr }} catalog create postgresql <{{ TR }}_catalog_name> \
      --cluster-id <cluster_ID> \
      --on-premise-connection-url <URL_for_connection> \
      --on-premise-user-name <username> \
      --on-premise-password <user_password> \
      --additional-properties <list_of_additional_settings>
    ```

    Where:

    * `--cluster-id`: ID of the cluster you are creating the {{ TR }} catalog in. You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).
    * `--on-premise-connection-url`: URL for connecting to the {{ PG }} DB, in `jdbc:postgresql://<host_address>:<port>/<DB_name>` format.
    * `--on-premise-user-name`: Username for connection to the {{ PG }} DB.
    * `--on-premise-password`: User password for connecting to the {{ PG }} DB.
    * `--additional-properties`: Additional settings in `key=value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/postgresql.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<{{ TR }}_catalog_name>" {
      ...
      postgresql = {
        on_premise = {
          connection_url = "<URL_for_connection>"
          user_name      = "<username>"
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
        * `user_name`: Username for connection to the {{ PG }} DB.
        * `password`: User password for connecting to the {{ PG }} DB.

    * `additional_properties`: List of additional settings in `"key" = "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/postgresql.html).

- REST API {#api}

    Example command:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<{{ TR }}_catalog_name>",
                    "connector": {
                      "postgesql": {
                        "connection": {
                          "onPremise": {
                            "connectionUrl": "<URL_for_connection>",
                            "userName": "<username>",
                            "password": "<user_password>"
                          }
                        },
                        "additionalProperties": {
                          <list_of_additional_settings>
                        }
                      }
                    }
                  }
                }'
    ```

    Where:

    * `onPremise`: Settings for connecting to the custom installation:

        * `connectionUrl`: URL for connecting to the {{ PG }} DB, in `jdbc:postgresql://<host_address>:<port>/<DB_name>` format.
        * `userName`: Username for connection to the {{ PG }} DB.
        * `password`: User password for connecting to the {{ PG }} DB.

    * `additionalProperties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/postgresql.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Example command:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>",
              "catalog": {
                "name": "<{{ TR }}_catalog_name>",
                "connector": {
                  "postgresql": {
                    "connection": {
                      "on_premise": {
                        "connection_url": "<URL_for_connection>",
                        "user_name": "<username>",
                        "password": "<user_password>"
                      }
                    },
                    "additional_properties": {
                      <list_of_additional_settings>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Where:

    * `on_premise`: Settings for connecting to the custom installation:

        * `connection_url`: URL for connecting to the {{ PG }} DB, in `jdbc:postgresql://<host_address>:<port>/<DB_name>` format.
        * `user_name`: Username for connection to the {{ PG }} DB.
        * `password`: User password for connecting to the {{ PG }} DB.

    * `additional_properties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/postgresql.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

### MS SQL Server {{ preview-stage }} connector {#ms-sql}

{% list tabs group=instructions %}

- Management console {#console}

    * **Connection type**: On-premise.
    * **URL**: URL for connecting to the Microsoft SQL Server DB, in `jdbc:sqlserver://<host_address>:<port>;databaseName=<DB_name>` format.
    * **Username**: Username for connecting to the Microsoft SQL Server DB.
    * **Password**: User password for connecting to the Microsoft SQL Server DB.
    * **Additional settings**: Provide in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/sqlserver.html).

- CLI {#cli}

    Example command:

    ```bash
    {{ yc-mdb-tr }} catalog create sqlserver <{{ TR }}_catalog_name> \
      --cluster-id <cluster_ID> \
      --on-premise-connection-url <URL_for_connection> \
      --on-premise-user-name <username> \
      --on-premise-password <user_password> \
      --additional-properties <list_of_additional_settings>
    ```

    Where:

    * `--cluster-id`: ID of the cluster you are creating the {{ TR }} catalog in. You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).
    * `--on-premise-connection-url`: URL for connecting to the Microsoft SQL Server DB, in `jdbc:sqlserver://<host_address>:<port>;databaseName=<DB_name>` format.
    * `--on-premise-user-name`: Username for connecting to the Microsoft SQL Server DB.
    * `--on-premise-password`: User password for connecting to the Microsoft SQL Server DB.
    * `--additional-properties`: Additional settings in `key=value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/sqlserver.html).

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<{{ TR }}_catalog_name>" {
      ...
      sqlserver = {
        on_premise = {
          connection_url = "<URL_for_connection>"
          user_name      = "<username>"
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

- REST API {#api}

    Example command:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<{{ TR }}_catalog_name>",
                    "connector": {
                      "sqlserver": {
                        "connection": {
                          "onPremise": {
                            "connectionUrl": "<URL_for_connection>",
                            "userName": "<username>",
                            "password": "<user_password>"
                          }
                        },
                        "additionalProperties": {
                          <list_of_additional_settings>
                        }
                      }
                    }
                  }
                }'
    ```

    Where:

    * `onPremise`: Settings for connecting to the custom installation:

        * `connectionUrl`: URL for connecting to the Microsoft SQL Server DB, in `jdbc:sqlserver://<host_address>:<port>;databaseName=<DB_name>` format.
        * `userName`: Username for connecting to the Microsoft SQL Server DB.
        * `password`: User password for connecting to the Microsoft SQL Server DB.

    * `additionalProperties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/sqlserver.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Example command:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>",
              "catalog": {
                "name": "<{{ TR }}_catalog_name>",
                "connector": {
                  "sqlserver": {
                    "connection": {
                      "on_premise": {
                        "connection_url": "<URL_for_connection>",
                        "user_name": "<username>",
                        "password": "<user_password>"
                      }
                    },
                    "additional_properties": {
                      <list_of_additional_settings>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Where:

    * `on_premise`: Settings for connecting to the custom installation:

        * `connection_url`: URL for connecting to the Microsoft SQL Server DB, in `jdbc:sqlserver://<host_address>:<port>;databaseName=<DB_name>` format.
        * `user_name`: Username for connecting to the Microsoft SQL Server DB.
        * `password`: User password for connecting to the Microsoft SQL Server DB.

    * `additional_properties`: List of additional settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/sqlserver.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

### TPC-DS connector {#tpc-ds}

The TPC-DS connector has no required settings. Optionally, you can configure advanced settings.

{% list tabs group=instructions %}

- Management console {#console}

    You can specify additional settings in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/tpcds.html).

- CLI {#cli}

    Example command:

    ```bash
    {{ yc-mdb-tr }} catalog create tpcds <{{ TR }}_catalog_name> \
      --cluster-id <cluster_ID> \
      --additional-properties <list_of_additional_settings>
    ```  

    Where:

    * `--cluster-id`: ID of the cluster you are creating the {{ TR }} catalog in. You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).
    * `--additional-properties`: Additional settings in `key=value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/tpcds.html).  

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<{{ TR }}_catalog_name>" {
      ...
      tpcds = {
        additional_properties = {
          <list_of_additional_settings>
        }
      }
    }
    ```

    Where `additional_properties` is a list of advanced settings in `"key" = "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/tpcds.html).

- REST API {#api}

    Example command:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<{{ TR }}_catalog_name>",
                    "connector": {
                      "tpcds": {
                        "additionalProperties": {
                          <list_of_additional_settings>
                        }
                      }
                    }
                  }
                }'
    ```

    Where `additionalProperties` is a list of advanced settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/tpcds.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Example command:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>",
              "catalog": {
                "name": "<{{ TR }}_catalog_name>",
                "connector": {
                  "tpcds": {
                    "additional_properties": {
                      <list_of_additional_settings>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Where `additional_properties` is a list of advanced settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/tpcds.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

### TPC-H connector {#tpc-h}

The TPC-H connector has no required settings. Optionally, you can configure advanced settings.

{% list tabs group=instructions %}

- Management console {#console}

    You can specify additional settings in `key: value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/tpch.html).

- CLI {#cli}

    Example command:

    ```bash
    {{ yc-mdb-tr }} catalog create tpch <{{ TR }}_catalog_name> \
      --cluster-id <cluster_ID> \
      --additional-properties <list_of_additional_settings>
    ```  

    Where:

    * `--cluster-id`: ID of the cluster you are creating the {{ TR }} catalog in. You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).
    * `--additional-properties`: Additional settings in `key=value` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/tpch.html).      

- {{ TF }} {#tf}

    Configuration example:

    ```hcl
    resource "yandex_trino_catalog" "<{{ TR }}_catalog_name>" {
      ...
      tpch = {
        additional_properties = {
          <list_of_additional_settings>
        }
      }
    }
    ```

    Where `additional_properties` is a list of advanced settings in `"key" = "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/tpch.html).

- REST API {#api}

    Example command:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<{{ TR }}_catalog_name>",
                    "connector": {
                      "tpch": {
                        "additionalProperties": {
                          <list_of_additional_settings>
                        }
                      }
                    }
                  }
                }'
    ```

    Where `additionalProperties` is a list of advanced settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/tpch.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Example command:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>",
              "catalog": {
                "name": "<{{ TR }}_catalog_name>",
                "connector": {
                  "tpch": {
                    "additional_properties": {
                      <list_of_additional_settings>
                    }
                  }
                }
              }
            }' \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Where `additional_properties` is a list of advanced settings in `"key": "value"` format. For a list of available settings, see the [official documentation]({{ tr.docs}}/connector/tpch.html).

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}