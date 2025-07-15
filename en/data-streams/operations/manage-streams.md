# Managing data streams

You can [view](#list-data-streams) a list of [streams](../concepts/glossary.md#stream-concepts), [edit](#edit-data-stream) their settings, [create](#create-data-stream) a new stream, or [delete](#delete-data-stream) an existing one.

## Creating a data stream {#create-data-stream}

{% include [create-stream-via-console](../../_includes/data-streams/create-stream-via-console.md) %}

## Viewing a list of streams {#list-data-streams}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) for which to get the list of data streams.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**. A list of streams will open.

{% endlist %}

## Changing stream settings {#edit-data-stream}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to change the stream settings.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
  1. Click ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) in the stream row and select **{{ ui-key.yacloud.common.edit }}**.
  1. Configure the data stream:
     1. Select the required number of shards.
     1. Set the maximum shard throughput per second.
     1. Select a [pricing plan](../../data-streams/pricing.md).
     1. Select data storage settings:
        * `{{ ui-key.yacloud.data-streams.label_data-storage-size-limit }}`: Specify the maximum data storage size.
        * `{{ ui-key.yacloud.data-streams.label_data-storage-time-limit }}`: Specify the maximum [data retention period](../../data-streams/concepts/glossary.md#retention-time) for the stream.
  1. Click **{{ ui-key.yacloud.data-streams.button_update-stream }}**.

{% endlist %}

## Deleting a stream {#delete-data-stream}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to delete a stream from.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
  1. Click ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) in the stream row and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

{% endlist %}