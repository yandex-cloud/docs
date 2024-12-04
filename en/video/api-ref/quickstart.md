---
title: Getting started with the {{ video-full-name }} API
description: In this section, you will learn how to work with the {{ video-name }} API to create a channel, upload a video, and get a link to the video player.
---

# How to get started with the {{ video-full-name }} API

In this section, you will learn how to create [channels](../concepts/index.md#channels), upload [videos](../concepts/videos.md), and get links to the [video player](../concepts/player.md) for the uploaded videos using the {{ video-name }} [REST API](../api-ref/) and [gRPC API](../api-ref/grpc/).

## Getting started {#before-begin}

To get started with the {{ video-name }} API:

1. In [{{ billing-name }}]({{ link-console-billing }}), make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and its [status](../../billing/concepts/billing-account-statuses.md) is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. [Get](../../organization/operations/organization-get-id.md) the ID of the organization to create a channel in.
1. [Assign](../../organization/operations/add-role.md) the `video.admin` or `video.editor` [role](../../iam/concepts/access-control/roles.md) to the user or [service account](../../iam/concepts/users/service-accounts.md) you will use to authenticate with the {{ video-name }} API. For more information, see [{#T}](../security/index.md).
1. [Get](./authentication.md) an IAM token for the user or service account you will use to authenticate with the {{ video-name }} API.

To use the examples, install these utilities:
* [cURL](https://curl.haxx.se) (if using the [REST API](../api-ref/))
* [cURL](https://curl.haxx.se), [gRPCurl](https://github.com/fullstorydev/grpcurl) and [jq](https://stedolan.github.io/jq) (if using the [gRPC API](../api-ref/grpc/))

## Create a channel {#create-channel}

To create a channel, run this command:

{% list tabs group=instructions %}

- REST API {#api}

  {% include [create-channel-rest-api-command](../../_includes/video/create-channel-rest-api-command.md) %}

  Where:
  * `<IAM_token>`: IAM token you got before you started.
  * `<organization_ID>`: Organization ID you got before you started.
  * `<channel_name>`: Name of the channel you are creating in {{ video-name }}.

  {% include [create-channel-rest-api-output](../../_includes/video/create-channel-rest-api-output.md) %}

- gRPC API {#grpc-api}

  {% include [create-channel-grpc-api-command](../../_includes/video/create-channel-grpc-api-command.md) %}

  Where:
  * `<IAM_token>`: IAM token you got before you started.
  * `<organization_ID>`: Organization ID you got before you started.
  * `<channel_name>`: Name of the channel you are creating in {{ video-name }}.

  {% include [create-channel-grpc-api-output](../../_includes/video/create-channel-grpc-api-output.md) %}

{% endlist %}

Save the new channel's ID (`channelId` value) as you will need it later.

## Create a video {#create-video}

To create a {{ video-name }} video using the API, [register](#register-video) the video on the channel and then [upload](#upload-video) the video file to it using the [tus](https://tus.io/protocols/resumable-upload) protocol. If the upload fails, [resume](#continue-if-interrupted) it from the position in the file where the interruption occurred.

### Register your video on the channel {#register-video}

To register a video on the channel, follow these steps:

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

1. Run this command:

    {% list tabs group=instructions %}

    - REST API {#api}

      {% include [register-video-rest-api-command](../../_includes/video/register-video-rest-api-command.md) %}

      Where:
      * `<IAM_token>`: IAM token you got before you started.
      * `<channel_ID>`: New channel's ID saved in the previous step.
      * `<video_name>`: Name the video will get when uploaded to the channel.
      * `<video_file_size>`: Video file size you got earlier, in bytes.
      * `<video_file_name>`: Name of the video file you are going to upload.

      {% include [register-video-rest-api-output](../../_includes/video/register-video-rest-api-output.md) %}

    - gRPC API {#grpc-api}

      {% include [register-video-grpc-api-command](../../_includes/video/register-video-grpc-api-command.md) %}

      Where:
      * `<IAM_token>`: IAM token you got before you started.
      * `<channel_ID>`: New channel's ID saved in the previous step.
      * `<video_name>`: Name the video will get when uploaded to the channel.
      * `<video_file_size>`: Video file size you got earlier, in bytes.
      * `<video_file_name>`: Name of the video file you are going to upload.

      {% include [register-video-grpc-api-output](../../_includes/video/register-video-grpc-api-output.md) %}

    {% endlist %}

    Save the video upload link (`url` field value) and video ID (`videoId` field value) as you will need them later.

### Upload a video file {#upload-video}

Video file uploads use the `tus` protocol which allows resuming the upload from where it stopped in case of a connection failure. You can either code the upload yourself in any programming language or use [ready-made](https://tus.io/implementations) libraries for this purpose.

To upload a video file using `curl`, run this command:

{% include [create-video-upload-file-curl](../../_includes/video/create-video-upload-file-curl.md) %}

### Check that the video file was uploaded {#verify-upload}

Check that your video file was fully uploaded. To do this, run the following command by specifying the video ID (`videoId`) you saved earlier:

{% list tabs group=instructions %}

- REST API {#api}

  {% include [verify-video-upload-rest](../../_includes/video/verify-video-upload-rest.md) %}

- gRPC API {#grpc-api}

  {% include [verify-video-upload-grpc](../../_includes/video/verify-video-upload-grpc.md) %}

{% endlist %}

If you see `PROCESSING` or `READY` in the `status` field, the video file was fully uploaded. Now it is time to [add a video thumbnail](#add-thumbnail).

If you see `WAIT_UPLOADING` in the `status` field, the video file upload was interrupted. In which case you need to complete the upload.

### Resume the interrupted upload {#continue-if-interrupted}

To complete the upload, you need to know the `offset` position the previous upload attempt was interrupted at.

{% include [resume-video-upload-curl](../../_includes/video/resume-video-upload-curl.md) %}

[Check](#verify-upload) once again that the video file has been fully uploaded. If the upload was interrupted again, repeat the steps described in this subsection.

## Add a thumbnail for your video {#add-thumbnail}

To add a thumbnail to your {{ video-name }} video using the API, [register](#register-thumbnail) the thumbnail on your channel, [get a link](#get-thumbnail-upload-link) to upload your image to that thumbnail, [upload](#upload-thumbnail-image) the image file using that link, and [assign](#assign-thumbnail) the created thumbnail to your video.

### Register the thumbnail {#register-thumbnail}

To register a thumbnail, run this command:

{% list tabs group=instructions %}

- REST API {#api}

  {% include [register-thumbnail-rest-api](../../_includes/video/register-thumbnail-rest-api.md) %}

- gRPC API {#grpc-api}

  {% include [register-thumbnail-grpc-api](../../_includes/video/register-thumbnail-grpc-api.md) %}

{% endlist %}

Save the `thumbnailId` value: you will need it later.

### Get a link to upload the image to your thumbnail {#get-thumbnail-upload-link}

To get a link to upload a thumbnail image, run this command:

{% list tabs group=instructions %}

- REST API {#api}

  {% include [get-thumbnail-uplink-rest-command](../../_includes/video/get-thumbnail-uplink-rest-command.md) %}

- gRPC API {#grpc-api}

  {% include [get-thumbnail-uplink-grpc-command](../../_includes/video/get-thumbnail-uplink-grpc-command.md) %}

{% endlist %}

{% include [get-thumbnail-uplink-api-output](../../_includes/video/get-thumbnail-uplink-api-output.md) %}

### Upload the image file to the thumbnail {#upload-thumbnail-image}

To upload your image to the thumbnail, run this command:

{% include [upload-thumbnail-curl](../../_includes/video/upload-thumbnail-curl.md) %}

### Assign a thumbnail to your video {#assign-thumbnail}

To assign the created thumbnail to your video, run this command:

{% list tabs group=instructions %}

- REST API {#api}

  {% include [assign-thumbnail-to-video-rest](../../_includes/video/assign-thumbnail-to-video-rest.md) %}

- gRPC API {#grpc-api}

  {% include [assign-thumbnail-to-video-grpc](../../_includes/video/assign-thumbnail-to-video-grpc.md) %}

{% endlist %}

## Get a link to the video player {#get-link}

To get a link to the video player, run this command:

{% list tabs group=instructions %}

- REST API {#api}

  {% include [get-video-link-rest](../../_includes/video/get-video-link-rest.md) %}

- gRPC API {#grpc-api}

  {% include [get-video-link-grpc](../../_includes/video/get-video-link-grpc.md) %}

{% endlist %}

Where:
* `<IAM_token>`: IAM token you got before you started.
* `<video_ID>`: Previously saved ID of the video uploaded to the channel.

{% include [get-video-link-output](../../_includes/video/get-video-link-output.md) %}