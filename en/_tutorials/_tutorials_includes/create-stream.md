## Create a data stream {#create-stream}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to create a data stream in.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
   1. Click **{{ ui-key.yacloud.data-streams.button_create-stream }}**.
   1. Specify an existing [serverless](../../ydb/concepts/serverless-and-dedicated.md#serverless) {{ ydb-short-name }} database or [create](../../ydb/quickstart.md#serverless) a new one. If you chose to create a new database, click ![refresh-button](../../_assets/data-streams/refresh-button.svg) to update the database list.
   1. Enter the data stream name: `logs-stream`.
   1. Click **{{ ui-key.yacloud.common.create }}**.

   Wait for the stream to start. Once the stream is ready for use, its status will change from `Creating` to `Active`.

{% endlist %}