---
title: How to add a thumbnail for a broadcast in {{ video-full-name }}
description: Follow this guide to add a thumbnail for a broadcast in {{ video-name }}.
---

# Adding a thumbnail for a broadcast

To add a thumbnail for a broadcast:

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** tab, in the row with the broadcast you need, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. If the broadcast already has a thumbnail, delete it. To do this, hover over the thumbnail preview and click ![image](../../../_assets/console-icons/circle-xmark.svg).
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

  1. Register your thumbnail in {{ video-name }}:

      {% include [register-thumbnail-rest-api](../../../_includes/video/register-thumbnail-rest-api.md) %}

      Save the `thumbnailId` value: you will need it later.

  1. Get a link to upload the image to your thumbnail:

      {% include [get-thumbnail-uplink-rest-command](../../../_includes/video/get-thumbnail-uplink-rest-command.md) %}

      {% include [get-thumbnail-uplink-api-output](../../../_includes/video/get-thumbnail-uplink-api-output.md) %}

  1. Upload the image file to the thumbnail:

      {% include [upload-thumbnail-curl](../../../_includes/video/upload-thumbnail-curl.md) %}

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

  1. Add the created thumbnail to the selected broadcast:

      ```bash
      curl \
        --request PATCH \
        --url 'https://video.{{ api-host }}/video/v1/streams/<broadcast_ID>' \
        --header 'Authorization: Bearer <IAM_token>' \
        --header 'Content-Type: application/json' \
        --data '{
          "fieldMask": "thumbnailId",
          "thumbnailId": "<thumbnail_ID>"
        }'
      ```

      Where:
      * `<broadcast_ID>`: Previously saved ID of the broadcast you want to add a thumbnail for.
      * `<IAM_token>`: IAM token you got before you started.
      * `<thumbnail_ID>`: Previously saved thumbnail ID.

      Result:

      ```text
      {
       "done": true,
       "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.video.v1.UpdateStreamMetadata",
        "streamId": "vplsfj23t7tf********"
       },
       "response": {
        "@type": "type.googleapis.com/yandex.cloud.video.v1.Stream",
        "onDemand": {},
        "id": "vplsfj23t7tf********",
        "channelId": "vplcdyphvqik********",
        "lineId": "vplldrpqy42y********",
        "title": "my-new-stream",
        "thumbnailId": "vpltxnjvjyzy********",
        "status": "OFFLINE",
        "createdAt": "2024-11-03T16:55:32.976950Z",
        "updatedAt": "2024-11-03T17:21:31.672357Z"
       },
       "id": "vplpgadtyvhm********",
       "description": "Stream update",
       "createdAt": "2024-11-03T17:21:31.680037Z",
       "createdBy": "ajeol2afu1js********",
       "modifiedAt": "2024-11-03T17:21:31.680037Z"
      }
      ```

- gRPC API {#grpc-api}

  1. Getting started:
  
      * [Get](../../../organization/operations/organization-get-id.md) the ID of the organization your {{ video-name }} [channel](../../concepts/index.md#channels) belongs to.
      * [Get](../../api-ref/authentication.md) an IAM token, which is required for authentication in the {{ video-name }} API.
      * To use the examples, install [cURL](https://curl.haxx.se) and [gRPCurl](https://github.com/fullstorydev/grpcurl).
  1. Get a list of {{ video-name }} channels in your organization:

      {% include [list-channels-grpc-api](../../../_includes/video/list-channels-grpc-api.md) %}

  1. Register your thumbnail in {{ video-name }}:

      {% include [register-thumbnail-grpc-api](../../../_includes/video/register-thumbnail-grpc-api.md) %}

      Save the `thumbnailId` value: you will need it later.

  1. Get a link to upload the image to your thumbnail:

      {% include [get-thumbnail-uplink-grpc-command](../../../_includes/video/get-thumbnail-uplink-grpc-command.md) %}

      {% include [get-thumbnail-uplink-api-output](../../../_includes/video/get-thumbnail-uplink-api-output.md) %}

  1. Upload the image file to the thumbnail:

      {% include [upload-thumbnail-curl](../../../_includes/video/upload-thumbnail-curl.md) %}

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

  1. Add the created thumbnail to the selected broadcast:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM_token>" \
        -rpc-header "Content-Type: application/json" \
        -d '{
          "streamId": "<broadcast_ID>",
          "fieldMask": {"paths": ["thumbnail_id"]},
          "thumbnailId": "<thumbnail_ID>"
        }' \
        video.{{ api-host }}:443 yandex.cloud.video.v1.StreamService/Update
      ```

      Where:
      * `<IAM_token>`: IAM token you got before you started.
      * `<broadcast_ID>`: Previously saved ID of the broadcast you want to add a thumbnail for.
      * `<thumbnail_ID>`: Previously saved thumbnail ID.

      Result:

      ```text
      {
        "id": "vplpl2wqhe62********",
        "description": "Stream update",
        "createdAt": "2024-11-03T17:29:26.987297Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2024-11-03T17:29:26.987297Z",
        "done": true,
        "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.video.v1.UpdateStreamMetadata",
          "streamId": "vplsfj23t7tf********"
        },
        "response": {
          "@type": "type.googleapis.com/yandex.cloud.video.v1.Stream",
          "channelId": "vplcdyphvqik********",
          "createdAt": "2024-11-03T16:55:32.976950Z",
          "id": "vplsfj23t7tf********",
          "lineId": "vplldrpqy42y********",
          "onDemand": {},
          "status": "OFFLINE",
          "thumbnailId": "vpltxnjvjyzy********",
          "title": "my-new-stream",
          "updatedAt": "2024-11-03T17:29:26.986096Z"
        }
      }
      ```

{% endlist %}