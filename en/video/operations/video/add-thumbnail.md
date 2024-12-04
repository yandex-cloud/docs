---
title: How to add a thumbnail for a video in {{ video-full-name }}
description: Follow this guide to add a thumbnail for a video in {{ video-name }}.
---

# Adding a thumbnail for a video

To add a thumbnail for a video:

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. On the ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, in the row with the video you need, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. If the video already has a thumbnail, delete it. To do this, hover over the thumbnail preview and click ![image](../../../_assets/console-icons/circle-xmark.svg).
  1. Click ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Select file** and select a new image for your thumbnail.

      {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- REST API {#api}

  1. Getting started:
  
      * [Get](../../../organization/operations/organization-get-id.md) the ID of the organization your {{ video-name }} [channel](../../concepts/index.md#channels) is in.
      * [Get](../../api-ref/authentication.md) an IAM token required for authentication in the {{ video-name }} API.
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

  1. Get a list of videos on the channel:

      ```bash
      curl \
        --request GET \
        --url 'https://video.{{ api-host }}/video/v1/videos?channelId=<channel_ID>' \
        --header 'Authorization: Bearer <IAM_token>'
      ```

      Where:
      * `<channel_ID>`: ID of the channel with the video you want to add a thumbnail for.
      * `<IAM_token>`: IAM token you got before you started.

      Result:

      ```text
      {
       "videos": [
        {
         "tusd": {
          "url": "https://tusd.video.cloud.yandex.net/files/75925d89ddc05c0d5ca3282781f13c6f+00062241********"
         },
         "publicAccess": {},
         "id": "vplvh4wvqimx********",
         "channelId": "vplcdyphvqik********",
         "title": "my-very-first-video",
         "status": "READY",
         "duration": "39.981s",
         "visibilityStatus": "PUBLISHED",
         "createdAt": "2024-09-16T19:18:08.384540Z",
         "updatedAt": "2024-11-03T12:53:07.769557Z"
        },
        {
         "tusd": {
          "url": "https://tusd.video.cloud.yandex.net/files/a95b9affc003bfb23708ca989e88f6b0+00062602********"
         },
         "id": "vplvm7wbmkon********",
         "channelId": "vplcdyphvqik********",
         "title": "my-second-video",
         "status": "PROCESSING",
         "visibilityStatus": "PUBLISHED",
         "createdAt": "2024-11-03T13:54:54.248715Z",
         "updatedAt": "2024-11-03T13:55:17.112515Z"
        }
       ]
      }
      ```

      Save the `id` of the video you want to add a thumbnail for.

  1. Add the created thumbnail to the selected video:

      {% include [assign-thumbnail-to-video-rest](../../../_includes/video/assign-thumbnail-to-video-rest.md) %}

- gRPC API {#grpc-api}

  1. Getting started:
  
      * [Get](../../../organization/operations/organization-get-id.md) the ID of the organization your {{ video-name }} [channel](../../concepts/index.md#channels) is in.
      * [Get](../../api-ref/authentication.md) an IAM token required for authentication in the {{ video-name }} API.
      * To use the examples, install [cURL](https://curl.haxx.se), [gRPCurl](https://github.com/fullstorydev/grpcurl), and [jq](https://stedolan.github.io/jq).
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

  1. Get a list of videos on the channel:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM_token>" \
        -d '{
          "channelId": "<channel_ID>"
        }' \
        video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/List
      ```

      Where:
      * `<IAM_token>`: IAM token you got before you started.
      * `<channel_ID>`: ID of the channel with the video you want to add a thumbnail for.

      Result:

      ```text
      {
        "videos": [
          {
            "id": "vplvh4wvqimx********",
            "channelId": "vplcdyphvqik********",
            "title": "my-very-first-video",
            "status": "READY",
            "duration": "39.981s",
            "visibilityStatus": "PUBLISHED",
            "createdAt": "2024-09-16T19:18:08.384540Z",
            "updatedAt": "2024-11-03T12:53:07.769557Z",
            "tusd": {
              "url": "https://tusd.video.cloud.yandex.net/files/75925d89ddc05c0d5ca3282781f13c6f+00062241********"
            },
            "publicAccess": {}
          },
          {
            "id": "vplvm7wbmkon********",
            "channelId": "vplcdyphvqik********",
            "title": "my-second-video",
            "status": "PROCESSING",
            "visibilityStatus": "PUBLISHED",
            "createdAt": "2024-11-03T13:54:54.248715Z",
            "updatedAt": "2024-11-03T14:05:52.004442Z",
            "tusd": {
              "url": "https://tusd.video.cloud.yandex.net/files/a95b9affc003bfb23708ca989e88f6b0+00062602********"
            }
          }
        ]
      }
      ```

      Save the `id` of the video you want to add a thumbnail for.

  1. Add the created thumbnail to the selected video:

      {% include [assign-thumbnail-to-video-grpc](../../../_includes/video/assign-thumbnail-to-video-grpc.md) %}

{% endlist %}