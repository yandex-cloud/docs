---
title: "How to add a broadcast to a playlist in {{ video-full-name }}"
description: "Follow this guide to add a broadcast to a playlist in {{ video-name }}."
---

# Adding a completed broadcast to a playlist

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

   1. Open the {{ video-name }} [home page]({{ link-video-main }}).
   1. Select a channel.
   1. On the ![image](../../../_assets/console-icons/bars-play.svg) **Playlists** tab, click ![image](../../../_assets/console-icons/ellipsis.svg) in the row with the playlist you want to add a broadcast to and select **{{ ui-key.yacloud_video.common.action_edit }}**.

      If the list does not contain the playlist you need, [create](../playlists/create.md) it.

   1. In the **Playback order** section, click **Add video**.
   1. In the window that opens, click the `Broadcasts` tab and select the completed broadcasts you need. To create a new broadcast, click **Create broadcast**.
   1. Click **{{ ui-key.yacloud_video.common.action_add }}**

{% endlist %}

#### See also {#see-also}

* [Playlists in {{ video-name }}](../../concepts/playlists.md)
* [Broadcasts in {{ video-name }}](../../concepts/streams.md)
* [{#T}](../playlists/get-link.md)