# Endpoint management

The source [endpoint](../../concepts/index.md#endpoint) describes the settings of the database that information will be transferred from using {{ data-transfer-name }} and the target endpoint the database you are going to transfer the data to. You can [create](#create), [edit](#update), or [delete](#delete) such endpoints.

## Creating an endpoint {#create}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. Click **Create endpoint**.
   1. In the **Direction** field, select **Source** or **Target**.
   1. Enter a name for the endpoint. Use lowercase Latin letters and numbers.
   1. (optional) Enter a description of the endpoint.
   1. In the **Database** type field, select the appropriate value. An endpoint of the corresponding type will be created.
   1. Set the endpoint parameters:
      * Sources:
         * Airbyte®:
            * [AWS CloudTrail](source/aws-cloudtrail.md)
            * [BigQuery](source/bigquery.md)
            * [S3](source/s3.md)
         * [{{ KF }}](source/kafka.md)
         * [{{ CH }}](source/clickhouse.md)
         * [{{ eventhub-name }}](source/eventhub.md)
         * [{{ GP }}](source/greenplum.md)
         * [{{ MG }}](source/mongodb.md)
         * [{{ MY }}](source/mysql.md)
         * [Oracle](source/oracle.md)
         * [{{ PG }}](source/postgresql.md)
         * [{{ yds-full-name }}](source/data-streams.md)
         * [{{ ydb-full-name }}](source/ydb.md)
      * Targets:
         * [{{ KF }}](target/kafka.md)
         * [{{ CH }}](target/clickhouse.md)
         * [{{ GP }}](target/greenplum.md)
         * [{{ MG }}](target/mongodb.md)
         * [{{ MY }}](target/mysql.md)
         * [{{ objstorage-name }}](target/object-storage.md)
         * [{{ PG }}](target/postgresql.md)
         * [{{ ydb-name }}](target/yandex-database.md)
   1. Click **Create**.

- CLI

   {% note info %}

   You can create endpoints using the CLI commands only for {{ MY }} and {{ PG }} sources and targets.

   {% endnote %}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create an endpoint:

   1. View a description of the CLI create endpoint command:

      ```bash
      {{ yc-dt }} endpoint create --help
      ```

   1. Specify the endpoint parameters in the create command (only some of the supported parameters are given in the example):

      ```bash
      {{ yc-dt }} endpoint create <endpoint type> \
         --name <endpoint name> \
         --description <endpoint description> \
         <endpoint parameters>
      ```

      You can view the endpoint type and parameters in the settings section for the appropriate data source or target.

- {{ TF }}
      {% note info %}

   You can create endpoints with {{ TF }} only for {{ MY }}, {{ PG }}, {{ MG }}, and {{ CH }} sources and targets.

   {% endnote %}

   
   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   To create an endpoint:

   1. Using the command line, navigate to the folder that will contain the {{ TF }} configuration files with an infrastructure plan. Create the directory if it doesn't exist.
      1. If you don't have {{ TF }} yet, [install it and create a configuration file with provider settings](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Create a configuration file with a description of your endpoint.

      Example configuration file structure:

      ```hcl
      resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
        name = "<endpoint name>"
        settings {
          <endpoint type> {
            <endpoint parameters>
          }
        }
      }
      ```

   1. You can view the endpoint type and parameters in the settings section for the appropriate data source or target.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      
   1. For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).


- API

   {% note info %}

   You can create endpoints with the API only for {{ MY }} and {{ PG }} sources and targets.

   {% endnote %}

   Use the [create](../../api-ref/Endpoint/create) API method and pass the following information in the request:

   * ID of the folder to host the endpoint, in the `folderId` parameter.
   * The endpoint name in the `name` parameter.
   * The endpoint description in the `description` parameter.
   * The endpoint parameters in the `settings` parameter.

   You can view the endpoint parameters in the settings section for the appropriate data source or target.

{% endlist %}

## Updating the endpoint {#update}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. Select an endpoint and click ![pencil](../../../_assets/pencil.svg) **Edit** on the top panel.
   1. Edit the endpoint parameters:
      * Sources:
         * Airbyte®:
            * [AWS CloudTrail](source/aws-cloudtrail.md)
            * [BigQuery](source/bigquery.md)
            * [S3](source/s3.md)
         * [{{ KF }}](source/kafka.md)
         * [{{ CH }}](source/clickhouse.md)
         * [{{ eventhub-name }}](source/eventhub.md)
         * [{{ GP }}](source/greenplum.md)
         * [{{ MG }}](source/mongodb.md)
         * [{{ MY }}](source/mysql.md)
         * [Oracle](source/oracle.md)
         * [{{ PG }}](source/postgresql.md)
         * [{{ yds-full-name }}](source/data-streams.md)
         * [{{ ydb-full-name }}](source/ydb.md)
      * Targets:
         * [{{ KF }}](target/kafka.md)
         * [{{ CH }}](target/clickhouse.md)
         * [{{ GP }}](target/greenplum.md)
         * [{{ MG }}](target/mongodb.md)
         * [{{ MY }}](target/mysql.md)
         * [{{ objstorage-name }}](target/object-storage.md)
         * [{{ PG }}](target/postgresql.md)
         * [{{ ydb-name }}](target/yandex-database.md)
   1. Click **Apply**.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with the endpoint description.

      For more detail on creating a file like that, please review [Create endpoint](#create).

   1. Edit the value in the `name` field (endpoint name) and the endpoint parameters under `settings`.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API

   {% note info %}

   You can edit endpoints using the API only for {{ MY }} and {{ PG }} sources and targets.

   {% endnote %}

   Use the [update](../../api-ref/Endpoint/update) API method and pass the following in the request:

   * The endpoint ID in the `endpointId` parameters.
   * The endpoint name in the `name` parameter.
   * The endpoint description in the `description` parameter.
   * The endpoint parameters in the `settings` parameter.

   To get the endpoint ID:

   1. Go to the [folder page]({{ link-console-main }}) in the management console and select **{{ data-transfer-full-name }}**.
   1. Click the desired endpoint.

   You can view the endpoint parameters in the settings section for the appropriate data source or target.

{% endlist %}

## Deleting an endpoint {#delete}

{% note warning %}

Before you [delete](../transfer.md#delete) an endpoint, delete all the transfers it's included in.

{% endnote %}

To delete an endpoint:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. Select the endpoint to delete.
   1. Click **Delete** on the panel above.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To delete an endpoint, run the command:

   ```bash
   {{ yc-dt }} endpoint delete <endpoint ID>
   ```

   To get the endpoint ID:

   1. Go to the [folder page]({{ link-console-main }}) in the management console and select **{{ data-transfer-full-name }}**.
   1. Click the desired endpoint.

- {{ TF }}

   {% include [terraform-delete](../../../_includes/data-transfer/terraform-delete-endpoint.md) %}

- API

   Use the [delete](../../api-ref/Endpoint/delete) API method and pass the ID of the required endpoint in the `endpointID` request parameter:

   To get the endpoint ID:
   1. Go to the [folder page]({{ link-console-main }}) in the management console and select **{{ data-transfer-full-name }}**.
   1. Click the desired endpoint.

{% endlist %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
