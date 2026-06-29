# Creating an external S3 data source

In {{ mgp-name }}, you can use [{{ objstorage-full-name }}](../../../storage/index.yaml) as an [external data source](../../concepts/external-tables.md#pxf-data-sources) with the S3 connection type, including by connecting to {{ objstorage-full-name }} via [Private Endpoint](../../../storage/operations/buckets/access-via-vpc.md). You can also use other third-party S3 services.

To get started, [create a static access key](../../../iam/operations/authentication/manage-access-keys.md#create-access-key). You will need to specify its data in the source properties.

## Create an external data source

{% list tabs group=instructions %}

- Management console {#console}

    To create an external S3 data source:

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Open the page of the {{ mgp-name }} cluster in question.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.greenplum.label_pxf }}**.
    1. Click **{{ ui-key.yacloud.greenplum.cluster.pxf.action_create-datasource }}**.
    1. Select the `{{ ui-key.yacloud.greenplum.cluster.pxf.value_s3 }}` connection type.
    1. Enter a source name.
    1. Configure at least one [optional setting](../../concepts/settings-list.md#s3-settings):

        * Specify the static access key ID in the **Access Key** field, and its contents, in the **Secret Key** field.
        
                    
          [Learn more about static access keys](../../../iam/concepts/authorization/access-key.md).
          
        
        * Select **Fast Upload** to enable fast upload of large files to S3 storage.
    
            This option is enabled by default.
               
            When using fast upload, PXF generates files in RAM (if out of RAM, it writes them to disk). If fast upload is disabled, PXF generates files on disk.
        
        * In the **Endpoint** field, enter the S3 storage address.
            
            The default value is `{{ s3-storage-host }}` for {{ objstorage-name }}.

    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create an external S3 data source:

    1. View the description of the CLI command for creating a data source:

        ```bash
        {{ yc-mdb-gp }} pxf-datasource create s3 --help
        ```

    1. Configure the data source:

        ```bash
        {{ yc-mdb-gp }} pxf-datasource create s3 <external_data_source_name> \
           --cluster-id=<cluster_ID> \
           --access-key=<static_key_ID> \
           --secret-key=<secret_part_of_static_key> \
           --endpoint=<S3_storage_address> \
           --fast-upload=<fast_upload>
        ```

        Where:

        * `cluster-id`: Cluster ID. You can get it with the [list of clusters in the folder](../cluster-list.md#list-cluster).
        * `access-key`, `secret-key`: [ID and contents of the static access key](../../../iam/concepts/authorization/access-key.md).
        * `endpoint`: S3 storage address. The value for {{ objstorage-name }} is `{{ s3-storage-host }}`. This is the default value.
        * `fast-upload`: Fast upload of large files to S3 storage. The possible values are:
            * `true`: Default value. PXF generates files in RAM (if out of RAM, it writes them to disk).
            * `false`: PXF generates files on disk.

- REST API {#api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Call the [PXFDatasource.Create](../../api-ref/PXFDatasource/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>/pxf_datasources' \
            --data '{
                      "datasource": {
                        "name": "<external_data_source_name>",
                        "s3": {
                          "accessKey": "<static_key_ID>",
                          "secretKey": "<secret_part_of_static_key>",
                          "fastUpload": "<fast_upload>",
                          "endpoint": "<S3_storage_address>"
                        }
                      }
                    }'
        ```

        Where:

        * `name`: External data source name.
        * `s3`: External data source settings:

            * `accessKey`, `secretKey`: [ID and contents of the static access key](../../../iam/concepts/authorization/access-key.md).
            * `fastUpload`: Fast upload of large files to S3 storage. The possible values are:
                * `true`: Default value. PXF generates files in RAM (if out of RAM, it writes them to disk).
                * `false`: PXF generates files on disk.

            * `endpoint`: S3 storage address. The value for {{ objstorage-name }} is `{{ s3-storage-host }}`. This is the default value.

        You can get the cluster ID with the [list of clusters in the folder](../cluster-list.md#list-clusters).

    1. View the [server response](../../api-ref/PXFDatasource/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [PXFDatasourceService.Create](../../api-ref/grpc/PXFDatasource/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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
                    "s3": {
                      "access_key": "<static_key_ID>",
                      "secret_key": "<secret_part_of_static_key>",
                      "fast_upload": <fast_upload>,
                      "endpoint": "<S3_storage_address>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.PXFDatasourceService.Create
        ```

        Where:

        * `name`: External data source name.
        * `s3`: External data source settings:

            * `access_key`, `secret_key`: [ID and contents of the static access key](../../../iam/concepts/authorization/access-key.md).
            * `fast_upload`: Fast upload of large files to S3 storage. The possible values are:
                * `true`: Default value. PXF generates files in RAM (if out of RAM, it writes them to disk).
                * `false`: PXF generates files on disk.

            * `endpoint`: S3 storage address. The value for {{ objstorage-name }} is `{{ s3-storage-host }}`. This is the default value.

        You can get the cluster ID with the [list of clusters in the folder](../cluster-list.md#list-clusters).

    1. Check the [server response](../../api-ref/grpc/PXFDatasource/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

After you create an external data source, [create an external table](create-table.md).
