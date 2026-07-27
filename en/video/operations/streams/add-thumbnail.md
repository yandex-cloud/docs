---
title: How to add a thumbnail for a broadcast in {{ video-full-name }}
description: Follow this guide to add a thumbnail for a broadcast in {{ video-name }}.
---

# Adding a thumbnail for a broadcast

To add a thumbnail for a broadcast:

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab, select the broadcast you need.
  1. Under **{{ ui-key.yacloud_video.streams.title_stream-episodes }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_video.common.action_edit }}** in the episode line.
  1. If the episode already has a thumbnail, delete it. To do this, hover over the thumbnail preview and click ![image](../../../_assets/console-icons/circle-xmark.svg).
  1. Click ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Select file** and select a new thumbnail image.

      {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- REST API {#api}

  1. Getting started:
  
      * [Get](../../../organization/operations/organization-get-id.md) the ID of the organization your {{ video-name }} [channel](../../concepts/index.md#channels) belongs to.
      * [Get](../../api-ref/authentication.md) an IAM token, which is required for authentication in the {{ video-name }} API.
      * To use the examples, install [cURL](https://curl.haxx.se).
  1. Get a list of {{ video-name }} channels in your organization:

      {% include [list-channels-rest-api](../../../_includes/video/list-channels-rest-api.md) %}

  1. Get a list of broadcasts on the channel:

      ```bash
      curl \
        --request GET \
        --url 'https://video.{{ api-host }}/video/v1/streams?channelId=<channel_ID>' \
        --header 'Authorization: Bearer <IAM_token>'
      ```

      Where:
      * `<channel_ID>`: ID of the channel with the broadcast you want to add a thumbnail for.
      * `<IAM_token>`: IAM token you got before you started.

      Result:

      ```text
      {
       "streams": [
        {
         "onDemand": {},
         "id": "vplsfj23t7tf********",
         "channelId": "vplcdyphvqik********",
         "lineId": "vplldrpqy42y********",
         "title": "my-first-stream",
         "status": "OFFLINE",
         "createdAt": "2024-11-03T16:55:32.976950Z",
         "updatedAt": "2024-11-03T16:55:33.091744Z"
        },
        {
         "onDemand": {},
         "id": "vplsgchsr5gi********",
         "channelId": "vplcdyphvqik********",
         "lineId": "vpllxc2mfleb********",
         "title": "my-new-stream",
         "thumbnailId": "vpltznjxpnyj********",
         "status": "OFFLINE",
         "createdAt": "2024-11-03T16:34:10.617101Z",
         "updatedAt": "2024-11-03T16:35:06.601920Z"
        }
       ]
      }
      ```

      Save the `id` of the broadcast you want to add a thumbnail for.

  1. Get the list of broadcast episodes:

      ```bash
      curl \
        --request GET \
        --url 'https://video.{{ api-host }}/video/v1/episodes?streamId=<broadcast_ID>' \
        --header 'Authorization: Bearer <IAM_token>'
      ```

      Where:
      * `<broadcast_ID>`: Previously saved broadcast ID.
      * `<IAM_token>`: IAM token you got before you started.

      Result:

      ```text
      {
       "episodes": [
        {
         "id": "vpleof6lm40k********",
         "streamId": "vplsfj23t7tf********",
         "lineId": "vplldrpqy42y********",
         "title": "my-first-episode",
         "visibilityStatus": "PUBLISHED",
         "createdAt": "2024-11-03T16:55:32.976950Z",
         "updatedAt": "2024-11-03T16:55:33.091744Z"
        }
       ]
      }
      ```

      Save the `id` of the episode you want to add a thumbnail for.

  1. Register your thumbnail in {{ video-name }}:

      ```bash
      curl \
        --request POST \
        --url 'https://video.{{ api-host }}/video/v1/thumbnails' \
        --header 'Authorization: Bearer <IAM_token>' \
        --header 'Content-Type: application/json' \
        --data '{
          "episodeId": "<episode_ID>"
        }'
      ```

      Where:
      * `<IAM_token>`: IAM token you got before you started.
      * `episodeId`: Previously saved episode ID.

      Result:

      ```text
      {
       "done": true,
       "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.video.v1.CreateThumbnailMetadata",
        "thumbnailId": "vpltaurfr4pr********"
       },
       "response": {
        "@type": "type.googleapis.com/yandex.cloud.video.v1.Thumbnail",
        "id": "vpltaurfr4pr********",
        "channelId": "vplcdyphvqik********",
        "episodeId": "vpleof6lm40k********",
        "createdAt": "2024-11-02T16:56:19.296797Z"
       },
       "id": "vplpgbyqopdr********",
       "description": "Thumbnail create",
       "createdAt": "2024-11-02T16:56:19.301776Z",
       "createdBy": "ajeol2afu1js********",
       "modifiedAt": "2024-11-02T16:56:19.301776Z"
      }
      ```

      Save the `thumbnailId` value: you will need it later.

  1. Get a thumbnail upload link:

      {% include [get-thumbnail-uplink-rest-command](../../../_includes/video/get-thumbnail-uplink-rest-command.md) %}

      {% include [get-thumbnail-uplink-api-output](../../../_includes/video/get-thumbnail-uplink-api-output.md) %}

  1. Upload an image file to the thumbnail:

      {% include [upload-thumbnail-curl](../../../_includes/video/upload-thumbnail-curl.md) %}

  1. Add the thumbnail to your episode:

      ```bash
      curl \
        --request PATCH \
        --url 'https://video.{{ api-host }}/video/v1/episodes/<episode_ID>' \
        --header 'Authorization: Bearer <IAM_token>' \
        --header 'Content-Type: application/json' \
        --data '{
          "fieldMask": "thumbnailId",
          "thumbnailId": "<thumbnail_ID>"
        }'
      ```

      Where:
      * `<episode_ID>`: Previously saved episode ID you want to add a thumbnail for.
      * `<IAM_token>`: IAM token you got before you started.
      * `<thumbnail_ID>`: Previously saved thumbnail ID.

      Result:

      ```text
      {
       "done": true,
       "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.video.v1.UpdateEpisodeMetadata",
        "episodeId": "vpleof6lm40k********"
       },
       "response": {
        "@type": "type.googleapis.com/yandex.cloud.video.v1.Episode",
        "id": "vpleof6lm40k********",
        "streamId": "vplsfj23t7tf********",
        "lineId": "vplldrpqy42y********",
        "title": "my-first-episode",
        "thumbnailId": "vpltxnjvjyzy********",
        "visibilityStatus": "PUBLISHED",
        "createdAt": "2024-11-03T16:55:32.976950Z",
        "updatedAt": "2024-11-03T17:21:31.672357Z"
       },
       "id": "vplpgadtyvhm********",
       "description": "Episode update",
       "createdAt": "2024-11-03T17:21:31.680037Z",
       "createdBy": "ajeol2afu1js********",
       "modifiedAt": "2024-11-03T17:21:31.680037Z"
      }
      ```

- gRPC API {#grpc-api}

  1. Getting started:
  
      * [Get](../../../organization/operations/organization-get-id.md) the ID of the organization your {{ video-name }} [channel](../../concepts/index.md#channels) belongs to.
      * [Get](../../api-ref/authentication.md) an IAM token, which is required for authentication in the {{ video-name }} API.
      * To use the examples, install [cURL](https://curl.haxx.se), [gRPCurl](https://github.com/fullstorydev/grpcurl), and [jq](https://stedolan.github.io/jq).
  1. Get a list of {{ video-name }} channels in your organization:

      {% include [list-channels-grpc-api](../../../_includes/video/list-channels-grpc-api.md) %}

  1. Get a list of broadcasts on the channel:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM_token>" \
        -d '{
          "channelId": "<channel_ID>"
        }' \
        video.{{ api-host }}:443 yandex.cloud.video.v1.StreamService/List
      ```

      Where:
      * `<IAM_token>`: IAM token you got before you started.
      * `<channel_ID>`: ID of the channel with the broadcast you want to add a thumbnail for.

      Result:

      ```text
      {
        "streams": [
          {
            "id": "vplsfj23t7tf********",
            "channelId": "vplcdyphvqik********",
            "lineId": "vplldrpqy42y********",
            "title": "my-first-stream",
            "status": "OFFLINE",
            "createdAt": "2024-11-03T16:55:32.976950Z",
            "updatedAt": "2024-11-03T16:55:33.091744Z",
            "onDemand": {}
          },
          {
            "id": "vplsgchsr5gi********",
            "channelId": "vplcdyphvqik********",
            "lineId": "vpllxc2mfleb********",
            "title": "my-new-stream",
            "thumbnailId": "vpltznjxpnyj********",
            "status": "OFFLINE",
            "createdAt": "2024-11-03T16:34:10.617101Z",
            "updatedAt": "2024-11-03T16:35:06.601920Z",
            "onDemand": {}
          }
        ]
      }
      ```

      Save the `id` of the broadcast you want to add a thumbnail for.

  1. Get the list of broadcast episodes:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM_token>" \
        -d '{
          "stream_id": "<broadcast_ID>"
        }' \
        video.{{ api-host }}:443 yandex.cloud.video.v1.EpisodeService/List
      ```

      Where:
      * `<IAM_token>`: IAM token you got before you started.
      * `<broadcast_ID>`: Previously saved broadcast ID.

      Result:

      ```text
      {
        "episodes": [
          {
            "id": "vpleof6lm40k********",
            "streamId": "vplsfj23t7tf********",
            "lineId": "vplldrpqy42y********",
            "title": "my-first-episode",
            "visibilityStatus": "PUBLISHED",
            "createdAt": "2024-11-03T16:55:32.976950Z",
            "updatedAt": "2024-11-03T16:55:33.091744Z"
          }
        ]
      }
      ```

      Save the `id` of the episode you want to add a thumbnail for.

  1. Register your thumbnail in {{ video-name }}:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM_token>" \
        -rpc-header 'Content-Type: application/json' \
        -d '{
          "episode_id": "<episode_ID>"
        }' \
        video.{{ api-host }}:443 yandex.cloud.video.v1.ThumbnailService/Create
      ```

      Where:
      * `<IAM_token>`: IAM token you got before you started.
      * `episode_id`: Previously saved episode ID.

      Result:

      ```text
      {
        "id": "vplpoqhxep6q********",
        "description": "Thumbnail create",
        "createdAt": "2024-11-02T19:04:28.412672Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2024-11-02T19:04:28.412672Z",
        "done": true,
        "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.video.v1.CreateThumbnailMetadata",
          "thumbnailId": "vpltleyrfnjh********"
        },
        "response": {
          "@type": "type.googleapis.com/yandex.cloud.video.v1.Thumbnail",
          "channelId": "vplcdyphvqik********",
          "createdAt": "2024-11-02T19:04:28.402787Z",
          "episodeId": "vpleof6lm40k********",
          "id": "vpltleyrfnjh********"
        }
      }
      ```

      Save the `thumbnailId` value: you will need it later.

  1. Get a thumbnail upload link:

      {% include [get-thumbnail-uplink-grpc-command](../../../_includes/video/get-thumbnail-uplink-grpc-command.md) %}

      {% include [get-thumbnail-uplink-api-output](../../../_includes/video/get-thumbnail-uplink-api-output.md) %}

  1. Upload an image file to the thumbnail:

      {% include [upload-thumbnail-curl](../../../_includes/video/upload-thumbnail-curl.md) %}

  1. Add the thumbnail to your episode:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM_token>" \
        -rpc-header "Content-Type: application/json" \
        -d '{
          "episode_id": "<episode_ID>",
          "field_mask": {"paths": ["thumbnail_id"]},
          "thumbnail_id": "<thumbnail_ID>"
        }' \
        video.{{ api-host }}:443 yandex.cloud.video.v1.EpisodeService/Update
      ```

      Where:
      * `<IAM_token>`: IAM token you got before you started.
      * `<episode_ID>`: Previously saved episode ID you want to add a thumbnail for.
      * `<thumbnail_ID>`: Previously saved thumbnail ID.

      Result:

      ```text
      {
        "id": "vplpl2wqhe62********",
        "description": "Episode update",
        "createdAt": "2024-11-03T17:29:26.987297Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2024-11-03T17:29:26.987297Z",
        "done": true,
        "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.video.v1.UpdateEpisodeMetadata",
          "episodeId": "vpleof6lm40k********"
        },
        "response": {
          "@type": "type.googleapis.com/yandex.cloud.video.v1.Episode",
          "createdAt": "2024-11-03T16:55:32.976950Z",
          "id": "vpleof6lm40k********",
          "lineId": "vplldrpqy42y********",
          "streamId": "vplsfj23t7tf********",
          "thumbnailId": "vpltxnjvjyzy********",
          "title": "my-first-episode",
          "updatedAt": "2024-11-03T17:29:26.986096Z",
          "visibilityStatus": "PUBLISHED"
        }
      }
      ```

{% endlist %}