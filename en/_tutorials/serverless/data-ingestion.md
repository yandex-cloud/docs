# Entering data into storage systems

Data from mobile phones, various smart devices, or external services can be received in a great number of small batches. Slow communication channels are often used for data transmission, while the communication time is limited. {{ yds-full-name }} receives data incoming at a high frequency and speed. It also generates data batches to be sent to target systems by providing optimal operation modes for sources and targets. Using an API gateway to receive messages enables you to implement a custom data transmission protocol.

In this use case, the [API gateway](../../api-gateway/concepts/index.md) accepts incoming data and sends it to the [data stream](../../data-streams/concepts/index.md). Data is buffered in the stream and transmitted using a [transfer](../../data-transfer/concepts/index.md) to a cluster of [{{ CH }}](../../managed-clickhouse/concepts/index.md) databases.

To set up data input:

1. [Before you start](#before-you-begin).
1. [Configure the environment](#setup).
1. [Create a {{ CH }} cluster](#create-cluster).
1. [Create a data stream](#create-stream).
1. [Create an API gateway](#create-api-gw).
1. [Create a transfer](#create-transfer).
1. [Test sending and receiving data](#test-ingestion).

If you no longer need data input, [delete the resources used](#clear-out).

## Before you start {#before-you-begin}

{% include [prepare-register-billing](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of supporting data input into storage systems includes:

* Fees for requests to the API gateway (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).
* Data stream maintenance fees (see [{{ yds-full-name }} pricing](../../data-streams/pricing.md)).
* Fees for transmitting data between sources and targets (see [{{ data-transfer-full-name }} pricing](../../data-transfer/pricing.md)).
* Fees for the continuously running {{ mch-name }} cluster (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).

## Configure the environment {#setup}

[Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `editor` role for your folder.

## Create a {{ CH }} cluster {#create-cluster}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a DB cluster.
1. Select **{{ mch-name }}**.
1. Click **Create cluster**.
1. Specify the settings for a {{ CH }} cluster:
   1. Under **Basic parameters**:
      * Enter a name for the cluster.
      * Select the service account you created earlier.
   1. Under **Database**, specify the DB name, username, and password.
   1. Under **Hosts**, click ![pencil](../../_assets/pencil.svg). Enable **Public access** and click **Save**.
   1. Under **Additional settings**, enable the following options:
      * Access from {{ data-transfer-short-name }}.
      * Access from management console.
   1. Specify the remaining cluster parameters according to the [instructions](../../managed-clickhouse/operations/cluster-create.md).
1. Click **Create cluster**.

Wait for the cluster to start. When the cluster is ready for use, its status changes to `Alive`.

## Create a data stream {#create-stream}

1. In the [management console]({{ link-console-main }}), select the folder to create a data stream in.
1. Select **{{ yds-name }}**.
1. Click **Create stream**.
1. Specify an existing [serverless](../../ydb/concepts/serverless-and-dedicated.md#serverless) {{ ydb-short-name }} database or [create](../../ydb/quickstart.md#serverless) a new one. If you chose to create a new database, click ![refresh-button](../../_assets/data-streams/refresh-button.svg) **Update** after creating it to update the list of databases.
1. Enter the name of the stream.
1. Click **Create**.

Wait for the stream to start. When the stream is ready for use, its status changes from `CREATING` to `ACTIVE`.

## Create an API gateway {#create-api-gw}

1. On the page of the created stream, click **Actions** and select **API Gateway**.
1. Enter the name of the API gateway.
1. Under **Specification**, replace the `service_account_id` key value with the ID of the service account you created earlier.

   Save the values of the **Name** and **Service domain** fields, you will need them later.
1. Click **Create**.

Wait for the API gateway to start. When the API gateway is ready for use, its status changes from `CREATING` to `ACTIVE`.

## Create a transfer {#create-transfer}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a transfer.
1. Select **{{ data-transfer-full-name }}**.
1. Click **Create data transfer**.
1. Name the transfer.
1. Create a source endpoint:
   1. In the **Source** line, click **Create new**.
   1. Enter a name for the endpoint.
   1. In the **Database type** list, select `{{ yds-full-name }}`.
   1. Select a database for the source.
   1. Enter the name of the previously created stream.
   1. Select the service account you created earlier.
   1. Click **Create**.
1. Create a target endpoint:
   1. In the **Target** line, click **Create new**.
   1. Enter a name for the endpoint.
   1. In the **Database type** list, select `ClickHouse`.
   1. Select the MDB cluster you created earlier.
   1. Enter the DB name, username, and password of the cluster you created earlier.
   1. Click **Create**.
1. Click **Create**.
1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the created transfer and select **Activate**.

Wait until the transfer is activated. When the transfer is ready for use, its status changes from {{ dt-status-creation }} to {{ dt-status-repl }}.

## Test sending and receiving data {#test-ingestion}

1. Send data to the storage system:

   ```bash
   curl -X POST -d 'test massage' https://<url>/<paths>
   ```

   Where:

   * `<url>`: The earlier saved **Service domain** value of the API gateway.
   * `<paths>`: The earlier saved **Name** value of the API gateway.
1. In the [management console]({{ link-console-main }}), select the {{ mch-name }} cluster you created earlier.
1. On the left-hand panel, select **SQL**.
1. Enter the username and password and click **Connect**.
1. In the list, select the database you created earlier.
1. Select the DB table.

If the configuration process is successful, a record containing service data and the sent message appears in the table.

## How to delete created resources {#clear-out}

To stop paying for the resources you used:

1. [Delete the API gateway](../../api-gateway/operations/api-gw-delete.md).
1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the endpoints](../../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the data stream](../../data-streams/operations/manage-streams.md#delete-data-stream).
1. [Delete a {{ CH }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
