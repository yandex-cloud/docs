# Creating an external HDFS data source

In {{ mgp-name }}, as an [external data source](../../concepts/external-tables.md#pxf-data-sources) with the HDFS connection type, you can use HDFS as part of [{{ dataproc-full-name }}](../../../data-proc/index.yaml) or other third-party HDFS services.

## Create an external data source {#create-external-source}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **Yandex MPP Analytics for PostgreSQL**.
    1. Open the page of the {{ mgp-name }} cluster you need.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.greenplum.label_pxf }}**.
    1. Click **{{ ui-key.yacloud.greenplum.cluster.pxf.action_create-datasource }}**.
    1. Select the `{{ ui-key.yacloud.greenplum.cluster.pxf.value_hdfs }}` connection type.
    1. Enter a source name.
    1. Configure at least one [optional setting](../../concepts/settings-list.md#hdfs-settings).
    1. Click **{{ ui-key.yacloud.common.create }}**.

- REST API {#api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Use the [PXFDatasource.Create](../../api-ref/PXFDatasource/create.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>/pxf_datasources' \
            --data '{
                      "datasource": {
                        "name": "<external_data_source_name>",
                        "hdfs": {
                          "core": {
                            "defaultFs": "<storage_type>"
                          },
                          ...
                        }
                      }
                    }'
        ```

        Where:

        * `name`: External data source name.
        * `hdfs`: External data source settings. Configure at least one [optional setting](../../concepts/settings-list.md#hdfs-settings).

        You can get the cluster ID with a [list of clusters in the folder](../cluster-list.md#list-clusters).

    1. View the [server response](../../api-ref/PXFDatasource/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [PXFDatasourceService.Create](../../api-ref/grpc/PXFDatasource/create.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/pxf_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                  "datasource": {
                    "name": "<external_data_source_name>",
                    "hdfs": {
                      "core": {
                        "default_fs": "<storage_type>"
                      },
                      ...
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.PXFDatasourceService.Create
        ```

        Where:

        * `name`: External data source name.
        * `hdfs`: External data source settings. Configure at least one [optional setting](../../concepts/settings-list.md#hdfs-settings).

        You can get the cluster ID with a [list of clusters in the folder](../cluster-list.md#list-clusters).

    1. View the [server response](../../api-ref/grpc/PXFDatasource/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
