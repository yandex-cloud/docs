---
title: How to edit a broadcast in {{ video-full-name }}
description: Follow this guide to edit a {{ video-full-name }} broadcast.
---

# Editing a broadcast

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab, in the row with the broadcast you need, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Rename the broadcast.
  1. In the **{{ ui-key.yacloud_video.stream-lines.label_input-stream-protocol }}** field, select the [required protocol](../../concepts/streams.md), `RTMP` or `SRT`.
  1. In the **{{ ui-key.yacloud_video.stream-lines.label_input-stream-type }}** field, select:

      {% include [push-pull](../../../_includes/video/push-pull.md) %}

  1. If you selected the `Pull` stream type, enter the address of your broadcast server in the **{{ ui-key.yacloud_video.stream-lines.label_url }}** field.
  1. Select **{{ ui-key.yacloud_video.streams.field_segment-duration }}**, which sets the time between video capture at the source and its playback for viewers:
     
     * **{{ ui-key.yacloud_video.streams.option_segment-duration-standart }}** (15-20 seconds): Ensures high image quality and resilience to unstable connections. Suitable for broadcasts without active real-time viewer interaction.
     * **{{ ui-key.yacloud_video.streams.option_segment-duration-low }}** (4-5 seconds): Suitable for scenarios with active viewer interaction but more sensitive to network quality.
  1. Enable **{{ ui-key.yacloud_video.streams.label_auto-publish-streams }}** to publish episodes automatically upon receiving an input signal.
  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Use the [update](../../api-ref/Stream/update.md) REST API method for the [Stream](../../api-ref/Stream/index.md) resource or the [StreamService/Update](../../api-ref/grpc/Stream/update.md) gRPC API call.

{% endlist %}
  
## Updating an episode {#update-episode}

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Under {{ ui-key.yacloud_video.streams.title_stream-episodes }}, click ![image](../../../_assets/console-icons/ellipsis.svg) next to the episode in question and select **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. In the **{{ ui-key.yacloud_video.streams.label_episode-type }}** field, select a mode:

     * `{{ ui-key.yacloud_video.streams.label_episode-type-live }}`: Real-time playback with rewind support.
     * `{{ ui-key.yacloud_video.streams.label_episode-type-broadcast }}`: Scheduled playback with recording.

  1. Edit the episode name and description.
  1. In the **Access** list, edit the episode access type:

     * `All users`: Anyone with the link will have unlimited access to the episode.
     * `By temporary link`: Access to the episode will be provided through a special link.

      {% include [video-temporary-links](../../../_includes/video/video-temporary-links.md) %}

  1. When selecting `{{ ui-key.yacloud_video.streams.label_episode-type-live }}` as the episode type, specify the **{{ ui-key.yacloud_video.streams.label_rewind-buffer }}** field to set the number of seconds the player buffers around the current position for smooth navigation.
  1. When selecting **{{ ui-key.yacloud_video.streams.label_episode-type-broadcast }}** as the episode type, specify the broadcast start and end date and time in the **{{ ui-key.yacloud_video.streams.label_stream-episode-start }}** and **{{ ui-key.yacloud_video.streams.label_stream-episode-end }}** fields.
  
      {% note tip %}

      To embed part of a broadcast on a website, specify an episode time range. [Get](get-link.md) an embed code or link to the broadcast. You can also add part of a broadcast to a [playlist](add-to-playlist.md).

      {% endnote %}

  1. Enable or disable ads. To enable it, [configure](../../operations/channels/settings.md#ad-settings) ad display in advance.
  1. To change a [player preset](../../concepts/player.md#player-presets), in the **{{ ui-key.yacloud_video.streams.label_player-template }}** list, select the one you need from those available in the channel or create a new preset.
  1. To change the thumbnail, click ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Select file** and select a new thumbnail image.

      {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

  You can add any number of episodes. To delete an episode you do not need, click ![image](../../../_assets/console-icons/ellipsis.svg) next to it and select ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

- API {#api}

  Use the [update](../../api-ref/Episode/update.md) REST API method for the [Episode](../../api-ref/Episode/index.md) resource or the [EpisodeService/Update](../../api-ref/grpc/Episode/update.md) gRPC API call.

{% endlist %}