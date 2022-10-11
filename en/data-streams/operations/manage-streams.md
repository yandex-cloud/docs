# Managing streams

You can [view](#list-data-streams) a list of streams, [edit](#edit-data-stream) their settings, [create](#create-data-stream) a new stream, or [delete](#delete-data-stream) an existing one.

## Creating a stream {#create-data-stream}

{% include [create-stream-via-console](../../_includes/data-streams/create-stream-via-console.md) %}

## Viewing a list of streams {#list-data-streams}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to get the list of streams for.
   1. Select **{{ yds-full-name }}**.
   1. Go to the **Streams** tab.

{% endlist %}

## Change stream settings {#edit-data-stream}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to update the stream settings.
   1. Select **{{ yds-full-name }}**.
   1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) in the line with the desired stream and select **Change**.
   1. Configure the stream settings:
      1. Select the required number of shards.
      1. Set the maximum shard throughput per second.
      1. Select a [pricing plan](../../data-streams/pricing.md).
      1. Select data storage settings:
         * Size limit: Specify the maximum data storage size.
         * Time limit: Specify the maximum [data retention time](../../data-streams/concepts/glossary.md#retention-time) for a stream.
   1. Click **Edit**.

{% endlist %}

## Deleting a stream {#delete-data-stream}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to delete a stream from.
   1. Select **{{ yds-full-name }}**.
   1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) in the line with the stream and select **Delete**.
   1. In the window that opens, click **Delete**.

{% endlist %}
