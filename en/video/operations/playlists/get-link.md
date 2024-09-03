---
title: "How to get an embed code or link to a playlist in {{ video-full-name }}"
description: "Follow this guide to get an embed code or link to a playlist in {{ video-name }}."
---

# Getting an embed code or link to a playlist

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   1. Open the {{ video-name }} [home page]({{ link-video-main }}).
   1. Select a channel.
   1. On the ![image](../../../_assets/console-icons/bars-play.svg) **Playlists** tab, select the playlist you want.
   1. Under **{{ ui-key.yacloud_video.videos.title_past-code }}**:

      1. Setup the playback parameters for the videos and broadcasts:

         * `{{ ui-key.yacloud_video.streams.label_episode-mute }}`​
         * `{{ ui-key.yacloud_video.streams.label_episode-autoplay }}`​
         * `{{ ui-key.yacloud_video.streams.label_episode-hidden }}`​

            {% note info %}

            Viewers can see the full list of videos and broadcasts inside the playlist in the player, even with `{{ ui-key.yacloud_video.streams.label_episode-hidden }}` enabled.

            {% endnote %}

         {% include [iframe-settings](../../../_includes/video/iframe-settings.md) %}

      1. Select the preferred playlist link format:

         * `html`: HTML embed code in Iframe format.
         * `link`: Direct link to the video.

      1. Click ![copy](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.

{% endlist %}

#### See also {#see-also}

* [Playlists in {{ video-name }}](../../concepts/playlists.md)
* [{#T}](update.md)
* [{#T}](delete.md)