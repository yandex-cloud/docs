---
title: Getting started with the {{ video-full-name }} API
description: In this section, you will learn how to work with the {{ video-name }} API to create a channel, upload a video, and get a link to the video player.
---

# How to get started with the {{ video-full-name }} API

In this section, you will learn how to create [channels](../concepts/index.md#channels), upload [videos](../concepts/videos.md), and get links to the [video player](../concepts/player.md) for the uploaded videos using the {{ video-name }} [REST API](../api-ref/) and [gRPC API](../api-ref/grpc/).

## Getting started {#before-begin}

To get started with the {{ video-name }} API:

1. In [{{ billing-name }}]({{ link-console-billing }}), make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and its [status](../../billing/concepts/billing-account-statuses.md) is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. Get the ID of the organization to create a channel in.
1. [Assign](../../organization/operations/add-role.md) the `video.admin` or `video.editor` [role](../../iam/concepts/access-control/roles.md) to the user or [service account](../../iam/concepts/users/service-accounts.md) you will use to authenticate with the {{ video-name }} API. For more information, see [{#T}](../security/index.md).
1. [Get](./authentication.md) an IAM token for the user or service account you will use to authenticate with the {{ video-name }} API.

To use the examples, install [cURL](https://curl.haxx.se) and [gRPCurl](https://github.com/fullstorydev/grpcurl) (when using the [gRPC API](../api-ref/grpc/)).

## Create a channel {#create-channel}

To create a channel, run this command:

{% list tabs group=api_type %}

- REST API {#rest-api}

  ```bash
  curl \
    --request POST \
    --url 'https://video.{{ api-host }}/video/v1/channels' \
    --header 'Authorization: Bearer <IAM_token>' \
    --header 'Content-Type: application/json' \
    --data '{
      "organization_id": "<organization_ID>",
      "title": "<channel_name>"
    }'
  ```

  Where:
  * `<IAM_token>`: IAM token you got before you started.
  * `<organization_ID>`: Organization ID you got before you started.
  * `<channel_name>`: Name of the channel you are creating in {{ video-name }}.

  Result:

  ```json
  {
   "done": true,
   "metadata": {
    "@type": "type.googleapis.com/yandex.cloud.video.v1.CreateChannelMetadata",
    "channelId": "vplcdyphvqik********"
   },
   "response": {
    "@type": "type.googleapis.com/yandex.cloud.video.v1.Channel",
    "id": "vplcdyphvqik********",
    "organizationId": "bpfaidqca8vd********",
    "title": "my-very-first-channel",
    "createdAt": "2024-09-16T19:01:10.591128Z",
    "updatedAt": "2024-09-16T19:01:10.591128Z"
   },
   "id": "vplp4vofhojp********",
   "description": "Channel create",
   "createdAt": "2024-09-16T19:01:10.596734Z",
   "createdBy": "ajeol2afu1js********",
   "modifiedAt": "2024-09-16T19:01:10.596734Z"
  }
  ```

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM_token>" \
    -d '{
      "organization_id": "<organization_ID>",
      "title": "<channel_name>"
    }' \
    video.{{ api-host }}:443 yandex.cloud.video.v1.ChannelService/Create
  ```

  Where:
  * `<IAM_token>`: IAM token you got before you started.
  * `<organization_ID>`: Organization ID you got before you started.
  * `<channel_name>`: Name of the channel you are creating in {{ video-name }}.

  Result:

  ```json
  {
    "id": "vplpvkqo2uyv********",
    "description": "Channel create",
    "createdAt": "2024-09-16T10:36:56.973051Z",
    "createdBy": "ajeol2afu1js********",
    "modifiedAt": "2024-09-16T10:36:56.973051Z",
    "done": true,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.video.v1.CreateChannelMetadata",
      "channelId": "vplcqy2qxkjy********"
    },
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.video.v1.Channel",
      "createdAt": "2024-09-16T10:36:56.968240Z",
      "id": "vplcqy2qxkjy********",
      "organizationId": "bpfaidqca8vd********",
      "title": "my-very-first-channel",
      "updatedAt": "2024-09-16T10:36:56.968240Z"
    }
  }
  ```

{% endlist %}

Save the new channel's ID (`channelId` value) as you will need it later.

## Create a video {#create-video}

1. Get the exact size of the video file in bytes:

    {% list tabs group=operating_system %}

    - Linux/macOS {#linux-macos}

      In the terminal, run this command by specifying the video file path:

      ```bash
      ls -l /Users/myuser/Downloads/sample-video.MOV
      ```

      Result:

      ```text
      ...  100100627 ... /Users/myuser/Downloads/sample-video.MOV
      ```

    - Windows {#windows}

      In PowerShell, run this command by specifying the video file path:

      ```powershell
      (Get-Item "C:\Users\myuser\Downloads\sample-video.MOV").Length
      ```

      Result:

      ```text
      100100627
      ```

    {% endlist %}

1. To create a video, run this command:

    {% list tabs group=api_type %}

    - REST API {#rest-api}

      ```bash
      curl \
        --request POST \
        --url 'https://video.{{ api-host }}/video/v1/videos' \
        --header 'Authorization: Bearer <IAM_token>' \
        --header 'Content-Type: application/json' \
        --data '{
          "channel_id": "<channel_ID>",
          "title": "<video_name>",
          "tusd": {
            "file_size": <video_file_size>,
            "file_name": "<video_file_name>"
          },
          "public_access": {}
        }'
      ```

      Where:
      * `<IAM_token>`: IAM token you got before you started.
      * `<channel_ID>`: New channel's ID you saved at the previous step.
      * `<video_name>`: Name the video will get when uploaded to the channel.
      * `<video_file_size>`: Video file size you got earlier, in bytes.
      * `<video_file_name>`: Name of the video file you are going to upload.

      Result:

      ```json
      {
       "done": true,
       "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.video.v1.CreateVideoMetadata",
        "videoId": "vplvh4wvqimx********"
       },
       "response": {
        "@type": "type.googleapis.com/yandex.cloud.video.v1.Video",
        "tusd": {
         "url": "https://tusd.video.cloud.yandex.net/files/75925d89ddc05c0d5ca3282781f13c6f+00062241********"
        },
        "publicAccess": {},
        "id": "vplvh4wvqimx********",
        "channelId": "vplcdyphvqik********",
        "title": "my-very-first-video",
        "status": "WAIT_UPLOADING",
        "visibilityStatus": "PUBLISHED",
        "createdAt": "2024-09-16T19:18:08.384540Z",
        "updatedAt": "2024-09-16T19:18:08.384540Z"
       },
       "id": "vplpjlgda3c2********",
       "description": "Video create",
       "createdAt": "2024-09-16T19:18:08.393546Z",
       "createdBy": "ajeol2afu1js********",
       "modifiedAt": "2024-09-16T19:18:08.393546Z"
      }
      ```

    - gRPC API {#grpc-api}

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM_token>" \
        -d '{
          "channel_id": "<channel_ID>",
          "title": "<video_name>",
          "tusd": {
            "file_size": <video_file_size>,
            "file_name": "<video_file_name>"
          },
          "public_access": {}
        }' \
        video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/Create
      ```

      Where:
      * `<IAM_token>`: IAM token you got before you started.
      * `<channel_ID>`: New channel's ID you saved at the previous step.
      * `<video_name>`: Name the video will get when uploaded to the channel.
      * `<video_file_size>`: Video file size you got earlier, in bytes.
      * `<video_file_name>`: Name of the video file you are going to upload.

      Result:

      ```json
      {
        "id": "vplpskiedayr********",
        "description": "Video create",
        "createdAt": "2024-09-16T12:16:03.921095Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2024-09-16T12:16:03.921095Z",
        "done": true,
        "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.video.v1.CreateVideoMetadata",
          "videoId": "vplvio5377ux********"
        },
        "response": {
          "@type": "type.googleapis.com/yandex.cloud.video.v1.Video",
          "channelId": "vplcqy2qxkjy********",
          "createdAt": "2024-09-16T12:16:03.905662Z",
          "id": "vplvio5377ux********",
          "publicAccess": {},
          "status": "WAIT_UPLOADING",
          "title": "my-very-first-video",
          "tusd": {
            "url": "https://tusd.video.cloud.yandex.net/files/5e7d6b3b68f9dc0d279ce719144c9caa+0006223B********"
          },
          "updatedAt": "2024-09-16T12:16:03.905662Z",
          "visibilityStatus": "PUBLISHED"
        }
      }
      ```

    {% endlist %}

    Save the video upload link (`url` field value) and video ID (`videoId` field value) as you will need them later.

## Upload your video {#upload-video}

Video file uploads use the [tus](https://tus.io/protocols/resumable-upload) protocol which allows resuming the upload from where it stopped in case of a connection failure. You can either code the upload yourself in any programming language or use [ready-made](https://tus.io/implementations) libraries for this purpose.

To upload a video file using `curl`, run this command:

```bash
curl \
  --location \
  --request PATCH '<video_upload_link>' \
  --header 'Content-Type: application/offset+octet-stream' \
  --header 'Upload-Offset: 0' \
  --header 'Tus-Resumable: 1.0.0' \
  --data-binary '@<video_file_path>'
```

Where:
* `<video_upload_link>`: Previously saved upload link you got when creating the video.
* `<video_file_path>`: Full video file path preceded with `@`,

    e.g., `@/Users/myuser/Downloads/sample-video.MOV`.

    Do not use any shortcuts, including `~`, in the file path.

## Check that the video has been uploaded {#verify-upload}

Check that the video has been fully uploaded. To do this, run the following command by specifying the video ID (`videoId`) you saved earlier:

{% list tabs group=api_type %}

- REST API {#rest-api}

  ```bash
  curl \
    --request GET \
    --url 'https://video.{{ api-host }}/video/v1/videos/<video_ID>' \
    --header 'Authorization: Bearer <IAM_token>'
  ```

  Result:
  
  ```json
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
   "updatedAt": "2024-09-16T19:31:31.471857Z"
  }
  ```

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM_token>" \
    -d '{"video_id": "<video_ID>"}' \
    video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/Get
  ```

  Result:
  
  ```json
  {
    "id": "vplva3626rvh********",
    "channelId": "vplcqy2qxkjy********",
    "title": "my-very-first-video",
    "status": "READY",
    "duration": "39.981s",
    "visibilityStatus": "PUBLISHED",
    "createdAt": "2024-09-16T14:11:04.803285Z",
    "updatedAt": "2024-09-16T14:14:36.467614Z",
    "tusd": {
      "url": "https://tusd.video.cloud.yandex.net/files/55994a57bd30b2161399ccab7eb5f2de+0006223D********"
    },
    "publicAccess": {}
  }
  ```

{% endlist %}

If the video has `PROCESSING` or `READY` in the `status` field, the video file has been fully uploaded. Proceed to [getting a link to the video player](#get-link).

If the video has `WAIT_UPLOADING` in the `status` field, the video file upload was interrupted. In which case you need to complete the upload.

## Resume the interrupted upload {#continue-if-interrupted}

To complete the upload, you need to know the `offset` position the previous upload attempt was interrupted at. 

1. Get the `offset` position of the interrupted upload using the previously saved video upload link:

    ```bash
    curl \
      --head '<video_upload_link>' \
      --header 'Host: tusd.video.cloud.yandex.net' \
      --header 'Tus-Resumable: 1.0.0'
    ```

    Result:

    ```text
    HTTP/1.1 200 OK
    Server: nginx/1.18.0
    Date: Mon, 16 Sep 2024 15:21:52 GMT
    Connection: keep-alive
    Cache-Control: no-cache
    Tus-Resumable: 1.0.0
    Upload-Length: 100100627
    Upload-Metadata: filename c2FtcGxlLXZpZGVv********,video_id dnBsdjVpeWh2M2F6ZnYz********
    Upload-Offset: 28231123
    X-Content-Type-Options: nosniff
    X-Request-Id: 3b775c2a********
    X-Trace-Id: 95ab2f994557ce1b1ee9dd09********
    X_h: edge-5b647c8d67-*****
    Access-Control-Allow-Origin: *
    Access-Control-Allow-Headers: *
    Access-Control-Expose-Headers: *
    Expires: Thu, 01 Jan 1970 00:00:01 GMT
    ```

    Save the `Upload-Offset` field value as you will need it to complete the video file upload.

1. Complete the file upload by running this command:

    ```bash
    curl \
      --location \
      --request PATCH '<video_upload_link>' \
      --header 'Content-Type: application/offset+octet-stream' \
      --header 'Upload-Offset: <offset_value>' \
      --header 'Tus-Resumable: 1.0.0' \
      --data-binary '@<video_file_path>'
    ```

    Where:
    * `<video_upload_link>`: Previously saved upload link you got when creating the video.
    * `<offset_value>`: Previously saved `offset` value indicating the position in the file the previous upload attempt was interrupted at.
    * `<video_file_path>`: Full video file path preceded with `@`,
    
        e.g., `@/Users/myuser/Downloads/sample-video.MOV`.

        Do not use any shortcuts, including `~`, in the file path.

    [Check](#verify-upload) once again that the video file has been fully uploaded. If the upload was interrupted again, repeat the steps described in this subsection.

## Get a link to the video player {#get-link}

To get a link to the video player, run this command:

{% list tabs group=api_type %}

- REST API {#rest-api}

  ```bash
  curl \ 
    --request GET \
    --header 'Authorization: Bearer <IAM_token>' \
    --url 'https://video.api.cloud.yandex.net/video/v1/videos/<video_ID>:getPlayerURL'
  ```

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM_token>" \ 
    -d '{
      "video_id": "<video_ID>"
    }' \
    video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/GetPlayerURL
  ```
{% endlist %}

Where:
* `<IAM_token>`: IAM token you got before you started.
* `<video_ID>`: Previously saved ID of the video uploaded to the channel.

Result:

```json
{
  "playerUrl": "https://runtime.video.cloud.yandex.net/player/video/vplva3626rvh********?autoplay=0\u0026mute=0",
  "html": "\u003ciframe width=\"560\" height=\"315\" src=\"https://runtime.video.cloud.yandex.net/player/video/vplva3626rvh********?autoplay=0\u0026mute=0\" allow=\"autoplay; fullscreen; accelerometer; gyroscope; picture-in-picture; encrypted-media\" frameborder=\"0\" scrolling=\"no\"\u003e\u003c/iframe\u003e"
}
```

Where:
* `playerUrl`: Direct link to the video.
* `html`: HTML embed code in Iframe format.