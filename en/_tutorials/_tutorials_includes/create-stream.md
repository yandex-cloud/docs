## Create a data stream {#create-stream}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create a data stream in.
   1. Select **{{ yds-name }}**.
   1. Click **Create stream**.
   1. Specify an existing [serverless](../../ydb/concepts/serverless-and-dedicated.md#serverless) {{ ydb-short-name }} database or [create](../../ydb/quickstart.md#serverless) a new one. If you have created a new database, click ![refresh-button](../../_assets/data-streams/refresh-button.svg) **Update** to update the database list.
   1. Enter the data stream name: `logs-stream`.
   1. Click **Create**.

   Wait for the stream to start. Once the stream is ready for use, its status will change from `Creating` to `Active`.

{% endlist %}