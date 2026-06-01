---
title: How to revoke access to a broadcast in {{ video-full-name }}
description: Follow this guide to revoke access to a broadcast in {{ video-full-name }}.
---

# Revoking access to a broadcast

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab, select the broadcast you need.
  1. Under **{{ ui-key.yacloud_video.streams.title_stream-episodes }}**, select an episode.
  1. In the episode settings, under **{{ ui-key.yacloud_video.videos.label_accessRights }}**, disable the **{{ ui-key.yacloud_video.episodes.label_allow-access }}** option.
  
  The episode will become unavailable via links.

- API {#api}

  Use the [performAction](../../api-ref/Episode/create.md) REST API method for the [Episode](../../api-ref/Video/index.md) resource or the [Episode/PerformAction](../../api-ref/grpc/Episode/performAction.md) gRPC API call.

{% endlist %}

If you allow access again, the episode will become available again via the same links.