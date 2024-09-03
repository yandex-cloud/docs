---
title: "Getting started with {{ video-full-name }} video broadcasts"
description: "To start a {{ video-name }} video broadcast, create a line and configure OBS."
---

# Getting started with video streaming in {{ video-full-name }}

{% include [preview-stage](../_includes/video/preview-stage.md) %}

To [stream a video](./concepts/index.md#streams) to a service [channel](./concepts/index.md#channels):
1. [Prepare your cloud](#before-you-begin).
1. [Create a channel](#create-channel).
1. [Create a line](#create-line).
1. [Create a broadcast](#create-stream).
1. [Set up OBS](#configure-obs).
1. [Start your broadcast](#start-stream).
1. [Check if the broadcast is available](#test).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_includes/video/before-you-begin.md) %}

## Create a channel {#create-channel}

{% include [create-channel](../_includes/video/create-channel.md) %}

## Create a line {#create-line}

1. In the ![lines](../_assets/console-icons/branches-right-arrow-right.svg) **{{ ui-key.yacloud_video.stream-lines.title_lines }}** tab, click **{{ ui-key.yacloud_video.stream-lines.action_create-line }}**.
1. Enter a name for the line.
1. In the **{{ ui-key.yacloud_video.stream-lines.label_input-stream-protocol }}** field, select `RTMP`.
1. In the **{{ ui-key.yacloud_video.stream-lines.label_input-stream-type }}** field, select `Push`.
1. In the **{{ ui-key.yacloud_video.thumbnails.label_thumbnail }}** field, click ![upload](../_assets/console-icons/cloud-arrow-up-in.svg) **Select file** and choose a cover image.

   {% include [image-characteristic](../_includes/video/image-characteristic.md) %}

1. Click **{{ ui-key.yacloud_video.common.action_create }}**.

[Learn more about lines](./concepts/index.md#lines)

## Create a broadcast {#create-stream}

1. In the ![streams](../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab, click **{{ ui-key.yacloud_video.streams.action_create-stream }}**.
1. Enter a name for the broadcast.
1. Select the previously created line.
1. In the **{{ ui-key.yacloud_video.thumbnails.label_thumbnail }}** field, click ![upload](../_assets/console-icons/cloud-arrow-up-in.svg) **Select file** and choose a cover image.

   {% include [image-characteristic](../_includes/video/image-characteristic.md) %}

1. In the **{{ ui-key.yacloud_video.streams.label_stream-type }}** field, select `{{ ui-key.yacloud_video.streams.label_type-on-demand }}`.
1. Click **{{ ui-key.yacloud_video.common.action_create }}**.
1. In the broadcast settings window that opens, copy the following data:
   * **{{ ui-key.yacloud_video.stream-lines.label_stream-key }}**​
   * **{{ ui-key.yacloud_video.stream-lines.label_server-address }}**​.

[Learn more about broadcasts](./concepts/index.md#streams)

## Set up OBS {#configure-obs}

1. [Download](https://obsproject.com/download) Open Broadcaster Software (OBS).
1. [Install and set up](https://obsproject.com/kb/category/1) OBS.
1. Under **Controls**, click **Settings**.
1. In the **Stream** tab, set up the broadcast server:
   * In the **Service** field, select **Custom...**
   * In the **Server** field, specify the previously obtained server address.
   * In the **Stream Key** field, specify the previously obtained broadcast key.
1. Click **OK**.
1. Under **Sources**, click ![plus-sign](../_assets/console-icons/plus.svg), choose what you want to broadcast, e.g., **Video Capture Device**, and click **OK**.
1. Select the video stream's source device, e.g., a webcam, and click **OK**.
1. Under **Controls**, click **Start Streaming**.

## Start your broadcast {#start-stream}

1. Go back to the ![streams](../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab in {{ video-name }}.
1. Select the broadcast you created earlier.
1. Click ![video](../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.streams.action_start-stream }}**.

{% include [streams-limits-notice](../_includes/video/streams-limits-notice.md) %}

## Check if the broadcast is available {#test}

1. On the broadcast settings page, under **{{ ui-key.yacloud_video.streams.title_stream-episodes }}**, click code ![code](../_assets/console-icons/code.svg) **{{ ui-key.yacloud_video.streams.title_past-code }}** and select the `link` tab.
1. Click ![copy](../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.

   {% include [iframe-settings](../_includes/video/iframe-settings.md) %}

1. Open a new browser page and paste the obtained URL to the address bar.
1. Click the Play button.

### See also {#see-also}

* [{#T}](hosting.md)
* [{{ video-full-name }} overview](./concepts/index.md)
* [{#T}](troubleshooting.md)