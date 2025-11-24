Create a [data stream](../../../data-streams/concepts/glossary.md#stream-concepts) to log {{ postbox-name }} events:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}** and click **{{ ui-key.yacloud.data-streams.button_create-stream }}**.
  1. In the **{{ ui-key.yacloud.data-streams.label_database }}** field, select the `postbox-events-ydb` database you created earlier.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter the stream name: `postbox-events-stream`.
  1. In the **{{ ui-key.yacloud.data-streams.label_meter-mode }}** field, select `{{ ui-key.yacloud.data-streams.label_request-units }}`.
  1. Do not edit the other data stream settings. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

Wait for the stream to start. Once the stream is ready for use, its status will change from `Creating` to `Active`.