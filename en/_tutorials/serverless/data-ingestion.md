# Ingesting data into storage systems


Data from mobile phones, various smart devices, or external services can come in massive numbers of small batches. The communication circuits used for transmission are often slow, and the communication time, limited. {{ yds-full-name }} receives data arriving at high frequency and speed and forms outbound data batches for the target systems, thus maintaining optimal operating modes for sources and targets. Using an API gateway to receive messages enables you to implement a custom data transmission protocol.

In this use case, the [API gateway](../../api-gateway/concepts/index.md) receives incoming data and sends it to the [data stream](../../data-streams/concepts/index.md). The stream buffers the data and sends it to the [{{ CH }}](../../managed-clickhouse/concepts/index.md) database cluster through a [transfer](../../data-transfer/concepts/index.md).

To set up data ingestion:

1. [Get your cloud ready](#before-you-begin).
1. [Set up your environment](#setup).
1. [Create a {{ CH }} cluster](#create-cluster).
1. [Create a data stream](#create-stream).
1. [Create an API gateway](#create-api-gw).
1. [Create a transfer](#create-transfer).
1. [Test sending and receiving data](#test-ingestion).

If you no longer need to ingest data, [delete the associated resources](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of supporting data ingestion into storage systems includes:

* Fee for API gateway requests (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).
* Data stream maintenance fee (see [{{ yds-full-name }} pricing](../../data-streams/pricing.md)).
* Fee for transferring data between sources and targets (see [{{ data-transfer-full-name }} pricing](../../data-transfer/pricing.md)).
* Fee for a continuously running {{ mch-name }} cluster (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).


## Set up your environment {#setup}

[Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `editor` role for your folder.

## Create a {{ CH }} cluster {#create-cluster}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a DB cluster.
1. Select **{{ mch-name }}**.
1. Click **Create cluster**.
1. Configure your {{ CH }} cluster:
    1. Under **Basic parameters**:
      * Enter a name for the cluster.
      * Select the service account you created earlier.
    1. Under **Database**, specify the DВ name, username, and password.
    1. Under **Hosts**, click ![pencil](../../_assets/pencil.svg). Enable **Public access** and click **Save**.
    1. Under **Additional settings**, enable the following options:
      * Access from {{ data-transfer-short-name }}.
      * Access from the management console.
    1. Specify the remaining cluster settings by following [this guide](../../managed-clickhouse/operations/cluster-create.md).
1. Click **Create cluster**.

Wait for the cluster to start. When the cluster is ready for use, its status will change to `Alive`.

## Create a data stream {#create-stream}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a data stream.
1. Select **{{ yds-name }}**.
1. Click **Create stream**.
1. Specify an existing [serverless](../../ydb/concepts/serverless-and-dedicated.md#serverless) database in {{ ydb-short-name }} or [create](../../ydb/quickstart.md#serverless) a new one. If you chose to create a new database, click ![refresh-button](../../_assets/data-streams/refresh-button.svg) **Refresh** after creating it to refresh the list of databases.
1. Enter a name for the stream.
1. Click **Create**.

Wait for the stream to start. When the stream is ready for use, its status will change from `CREATING` to `ACTIVE`.

## Create an API gateway {#create-api-gw}

1. On the page of the created stream, click **Actions** and select **API Gateway**.
1. Name your API gateway.
1. Under **Specification**, replace the `service_account_id` key value with the ID of the service account you created earlier.

    Save the values of the **Name** and **Service domain** fields, as you will need them later.
1. Click **Create**.

Wait for the API gateway to start. When the API gateway is ready for use, its status will change from `CREATING` to `ACTIVE`.

## Create a transfer {#create-transfer}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a transfer.
1. Select **{{ data-transfer-full-name }}**.
1. Click **Create data transfer**.
1. Name the transfer.
1. Create a source endpoint:
    1. Next to **Source**, click **Create new**.
    1. Name the endpoint.
    1. In the **Database type** list, select `{{ yds-full-name }}`.
    1. Select a database for the source.
    1. Enter the name of the stream you created earlier.
    1. Select the service account you created earlier.
    1. Click **Create**.
1. Create a target endpoint:
    1. Next to **Target**, click **Create new**.
    1. Name the endpoint.
    1. In the **Database type** list, select `ClickHouse`.
    1. Select the MDB cluster you created earlier.
    1. Enter the DB name, username, and password of the cluster you created earlier.
    1. Click **Create**.
1. Click **Create**.
1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the created transfer and select **Activate**.

Wait until the transfer gets activated. Once the transfer is ready for use, its status will change from {{ dt-status-creation }} to {{ dt-status-repl }}.

## Test sending and receiving data {#test-ingestion}

1. Send data to the storage system:

    ```bash
    curl --request POST --data 'test massage' https://<url>/<paths>
    ```

    Where:

    * `<url>`: API gateway **Service domain** you saved earlier.
    * `<paths>`: API gateway **Name** you saved earlier.
1. In the [management console]({{ link-console-main }}), select the {{ mch-name }} cluster you created earlier.
1. On the left-hand panel, select **SQL**.
1. Enter the username and password and click **Connect**.
1. In the list, select select the previously created database.
1. Select a DB table.

If everything is set up properly, the table will show a new entry containing system data and the sent message.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you used in this scenario:

1. [Delete the API gateway](../../api-gateway/operations/api-gw-delete.md).
1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the endpoints](../../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the data stream](../../data-streams/operations/manage-streams.md#delete-data-stream).
1. [Delete the {{ CH }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
