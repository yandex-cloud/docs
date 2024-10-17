# Creating an external S3 data source

In {{ mgp-name }}, you can use [{{ objstorage-full-name }}](../../../storage/index.yaml) or other third-party S3 services as an [external data source](../../concepts/external-tables.md#pxf-data-sources) with the S3 connection type.

To get started, [create a static access key](../../../iam/operations/sa/create-access-key.md). You will need to specify its data in the source parameters.

## Create an external data source

{% list tabs group=instructions %}

- Management console {#console}

   To create an external S3 data source:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Open the page of the {{ mgp-name }} cluster you need.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.greenplum.label_pxf }}**.
   1. Click **{{ ui-key.yacloud.greenplum.cluster.pxf.action_create-datasource }}**.
   1. Select the `{{ ui-key.yacloud.greenplum.cluster.pxf.value_s3 }}` connection type.
   1. Enter a source name.
   1. Configure at least one [optional setting](../../concepts/settings-list.md#s3-settings).
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create an external S3 data source:

   1. View the description of the CLI command to create a data source:

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

      * `cluster-id`: Cluster ID. You can get it with a [list of clusters in the folder](../cluster-list.md#list-cluster).
      * `access-key`, `secret-key`: [ID and contents of the static access key](../../../iam/concepts/authorization/access-key.md).
      * `endpoint`: S3 storage address. {{ objstorage-name }} is set to `{{ s3-storage-host }}`. This is a default value.
      * `fast-upload`: Fast upload of large files to S3 storage. The possible values are:
         * `true` (default): PXF generates files on the disk before sending them to S3 storage.
         * `false`: PXF generates files in RAM (if RAM capacity is reached, it writes them to disk).

- API {#api}

   To add an S3 data source to a {{ mgp-name }} cluster, use the [create](../../api-ref/PXFDatasource/create.md) REST API method for the [PXFDatasource](../../api-ref/PXFDatasource/index.md) resource or the [PXFDatasourceService/Create](../../api-ref/grpc/PXFDatasource/create.md) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](../cluster-list.md#list-clusters).
   * Source name in the `name` parameter.
   * External source settings in the `s3` parameter.

{% endlist %}

## Sample REST API request {#example}

The example below shows how to create an external data source for an {{ objstorage-name }} bucket using the {{ mgp-name }} REST API. To create a source:

1. [Get an IAM token](../../../iam/operations/index.md#iam-tokens). It is used for authentication in the API.
1. Add the IAM token to the following environment variable:

   ```bash
   export IAM_TOKEN=<token>
   ```

1. Create a static access key.
1. Send a request using [cURL](https://curl.haxx.se):

   ```bash
   curl --location "https://mdb.{{ api-host }}/managed-greenplum/v1/clusters/<cluster_ID>/pxf_datasources" \
        --header "Content-Type: text/plain" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data "{
            \"datasource\": {
                \"name\": \"s3:csv\",
                \"s3\": {
                    \"accessKey\": \"<key_ID>\",
                    \"secretKey\": \"<secret_key>\",
                    \"endpoint\": \"{{ s3-storage-host }}\"
                }
            }
       }"
   ```

   In the request body, specify the following parameters:

   * `name`: Source name, e.g., `s3:csv`.
   * `accessKey`: Static access key ID.
   * `secretKey`: Secret key. It is part of the static key.
   * `endpoint`: {{ objstorage-name }} address.

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
