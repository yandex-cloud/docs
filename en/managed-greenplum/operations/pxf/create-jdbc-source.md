# Creating an external JDBC data source

In {{ mgp-name }}, as an [external data source](../../concepts/external-tables.md#pxf-data-sources) with the JDBC connection type, you can use the following:

* {{ CH }}.
* HBase
* {{ MY }}.
* Oracle
* {{ PG }}.
* {{ MS }}.

This list contains managed {{ yandex-cloud }} DBs and third-party DBs.

## Create an external data source {#create-external-source}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Open the page of the {{ mgp-name }} cluster you need.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.greenplum.label_pxf }}**.
   1. Click **{{ ui-key.yacloud.greenplum.cluster.pxf.action_create-datasource }}**.
   1. Select the `{{ ui-key.yacloud.greenplum.cluster.pxf.value_jdbc }}` connection type.
   1. Enter a source name.
   1. Configure at least one [optional setting](../../concepts/settings-list.md#jdbc-settings).
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create an external JDBC data source:

   1. View the description of the CLI command to create a data source:

      ```bash
      {{ yc-mdb-gp }} pxf-datasource create jdbc --help
      ```

   1. Configure the data source:

      ```bash
      {{ yc-mdb-gp }} pxf-datasource create jdbc <external_data_source_name> \
         --cluster-id=<cluster_ID> \
         --driver=<driver_address> \
         --url=<database_URL> \
         --user=<username> \
         --password=<password>
      ```

      Where:

      * `cluster-id`: Cluster ID. You can get it with a [list of clusters in the folder](../cluster-list.md#list-cluster).
      * `driver`: JDBC driver class in Java. The possible values are:

         {% include [JBDC driver](../../../_includes/mdb/mgp/jdbc-driver.md) %}

      * `url`: Database URL. Examples:

         {% include [URL examples](../../../_includes/mdb/mgp/url-examples.md) %}

      * `user`: DB owner username.
      * `password`: DB user password.

      You can also configure [advanced settings](../../concepts/settings-list.md#jdbc-settings).

- API {#api}

   To add a JDBC data source to a {{ mgp-name }} cluster, use the [create](../../api-ref/PXFDatasource/create.md) REST API method for the [PXFDatasource](../../api-ref/PXFDatasource/index.md) resource or the [PXFDatasourceService/Create](../../api-ref/grpc/pxf_service.md#Create) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](../cluster-list.md#list-clusters).
   * Source name in the `name` parameter.
   * External source settings in the `jdbc` parameter.

{% endlist %}

## Sample REST API request {#example}

The example below shows how to create an external data source for a {{ mpg-name }} cluster using the {{ mgp-name }} REST API. To create a source:

1. [Get an IAM token](../../../iam/operations/index.md#iam-tokens). It is used for authentication in the API.
1. Add the IAM token to the following environment variable:

   ```bash
   export IAM_TOKEN=<token>
   ```

1. Send a request using [cURL](https://curl.haxx.se):

   ```bash
   curl --location "https://mdb.{{ api-host }}/managed-greenplum/v1/clusters/<cluster_ID>/pxf_datasources" \
        --header "Content-Type: text/plain" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data "{
            \"datasource\": {
                \"name\": \"jdbc\",
                \"jdbc\": {
                    \"driver\": \"org.postgresql.Driver\",
                    \"url\": \"jdbc:postgresql://c-<cluster_ID>.rw.{{ dns-zone }}:{{ port-mpg }}/<DB_name>\",
                    \"user\": \"<username>\",
                    \"password\": \"<user_password>\"
                }
            }
        }"
   ```

   In the request body, specify the following parameters:

   * `name`: Source name, e.g., `jdbc`.
   * `driver`: DB driver address.
   * `url`: Database URL. It contains a [special FQDN of the current master host](../../../managed-postgresql/operations/connect.md#fqdn-master).

      You can get the cluster ID with a [list of clusters](../../../managed-postgresql/operations/cluster-list.md#list-clusters) in the folder.

   * `user`: DB owner username.
   * `password`: User password.

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
