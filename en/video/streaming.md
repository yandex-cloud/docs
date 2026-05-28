---
title: Getting started with {{ video-full-name }} video broadcasts
description: To start a {{ video-name }} video broadcast, create a line and configure OBS.
---

# Getting started with a video broadcast in {{ video-full-name }}

To [stream a video](./concepts/index.md#streams) on the service's [channel](./concepts/index.md#channels):
1. [Get your cloud ready](#before-you-begin).
1. [Create a channel](#create-channel).
1. [Create a broadcast](#create-stream).
1. [Create an episode](#create-episode).
1. [Set up OBS Studio](#configure-obs).
1. [Start your broadcast](#start-stream).
1. [Check if the broadcast is available](#test).

{% include [link-to-api-quickstart](../_includes/video/link-to-api-quickstart.md) %}

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_includes/video/before-you-begin-variants.md) %}

## Create a channel {#create-channel}

{% include [create-channel](../_includes/video/create-channel.md) %}

## Create a broadcast {#create-stream}

1. In the ![streams](../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab, click **{{ ui-key.yacloud_video.streams.action_create-stream }}**.
1. Enter a name for the broadcast.
1. In the **{{ ui-key.yacloud_video.stream-lines.label_input-stream-protocol }}** field, select `RTMP`.
1. In the **{{ ui-key.yacloud_video.stream-lines.label_input-stream-type }}** field, select `Push`.
1. Enable the **{{ ui-key.yacloud_video.streams.label_auto-publish-streams }}** option.
1. Click **{{ ui-key.yacloud_video.common.action_create }}**.

## Create an episode {#create-episode}

1. Under **{{ ui-key.yacloud_video.streams.title_stream-episodes }}**, click ![image](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_video.streams.action_add-stream-episode }}**.
1. In the **{{ ui-key.yacloud_video.streams.label_episode-type }}** field, select the **{{ ui-key.yacloud_video.streams.label_episode-type-live }}** mode.
1. Enter a name for the episode.
1. Select `All Users` in the **Access** list.
1. In the **{{ ui-key.yacloud_video.thumbnails.label_thumbnail }}** field, click ![upload](../_assets/console-icons/cloud-arrow-up-in.svg) **Select file** and choose a cover image.
      
   {% include [image-characteristic](../_includes/video/image-characteristic.md) %}

1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.
1. In the broadcast window that opens, copy the following data:
    * **{{ ui-key.yacloud_video.stream-lines.label_server-address }}**
    * **{{ ui-key.yacloud_video.stream-lines.label_stream-key }}**.

To learn more about streams, see [{#T}](./concepts/streams.md#streams).

## Set up OBS Studio {#configure-obs}

1. To install [Open Broadcaster Software](https://en.wikipedia.org/wiki/OBS_Studio) (OBS Studio or OBS), the video recording and live streaming software:

    {% list tabs group=operating_system %}
    
    - Linux {#linux}
    
      Run this command:
    
      ```bash
      sudo add-apt-repository ppa:obsproject/obs-studio \
      sudo apt install obs-studio
      ```
    
    - Windows {#windows}
    
      [Download](https://obsproject.com/download) and install OBS Studio from the project’s website or use the [Chocolatey](https://chocolatey.org/install) package manager. In PowerShell, run this command as an administrator:
    
      ```powershell
      choco install obs-studio
      ```
    
    {% endlist %}

1. Set up OBS Studio:

    1. In the right-hand panel, go to **Controls** → **Settings** → **Stream**.
    1. In the **Destination** section:

       * In the **Service** field, select **Custom...**.
       * In the **Server** field, specify the server address you [got](#create-episode) earlier.
       * In the **Stream key** field, specify the broadcast key you got earlier.
    
    1. In the left-hand panel, select **Output** → **Stream**.
    
       * Under **Video bitrate**, set a value based on screen resolution and internet speed. You can measure your internet speed using [Yandex.Internetometer](https://yandex.ru/internet). Your stream bitrate must not exceed the **Outgoing connection** value.
       * In the **Video encoder** field, select the video encoding format.
    
    1. In the **Recording** section:
    
       * In the **Recording path** field, specify the path to save your stream to.
       * In the **Recording format** field, select the video file format.
    
    1. Click **OK**.
    1. In the **Sources** panel at the bottom left, click ![plus-sign](../_assets/console-icons/plus.svg) to add a source.
    
       * In the window that opens, select a source, e.g., **Video Capture Device**.
       * In the window that opens, specify the source name and click **OK**.
       * Select the video streaming device, e.g., a webcam, and click **OK**.
    
    1. In the center of the window, you can set the size and position of the video stream.

For more information, see [{#T}](operations/streams/obs-config-help.md).

## Start your broadcast {#start-stream}

1. Go back to the ![streams](../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab in {{ video-name }}.
1. Select the broadcast you created earlier.
1. Enable **Accept signal**.
1. In OBS Studio, click **Start broadcast** in the bottom-right **Controls** panel.
1. Wait for the broadcast to start.

{% include [streams-limits-notice](../_includes/video/streams-limits-notice.md) %}

## Check if the broadcast is available {#test}

1. Under **{{ ui-key.yacloud_video.streams.title_stream-episodes }}**, select the [previously created](#create-episode) episode.
1. Select the `link` tab.
1. Click ![image](../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.
1. Open a new browser page and paste the obtained URL to the address bar.
1. Click the play button to make sure the broadcast is available.

#### See also {#see-also}

* [{#T}](hosting.md)
* [{{ video-full-name }} overview](./concepts/index.md)
* [Configuring ads](operations/channels/settings.md#ad-settings)
* [{#T}](troubleshooting/index.md)
