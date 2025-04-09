---
title: Getting started with the {{ video-full-name }} API
description: In this section, you will learn how to work with the {{ video-name }} API to create a channel, upload a video, and get a link to the video player.
---

# How to get started with the {{ video-full-name }} API

In this section, you will learn how to create [channels](../concepts/index.md#channels), upload [videos](../concepts/videos.md), and get links to the [video player](../concepts/player.md) for the uploaded videos using the {{ video-name }} [REST API](../api-ref/) and [gRPC API](../api-ref/grpc/).

To get started with the {{ video-name }} API:

1. [Create a channel](create-channel).
1. [Create a video](create-video).
1. [Add a thumbnail to your video](add-thumbnail).
1. [Get a link to the video player](get-link).

## Getting started {#before-begin}

1. In [{{ billing-name }}]({{ link-console-billing }}), make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and its [status](../../billing/concepts/billing-account-statuses.md) is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. [Get](../../organization/operations/organization-get-id.md) the ID of the [organization](../../organization/quickstart.md) you are going to create a channel in.

To use the examples, install these utilities:
* [cURL](https://curl.haxx.se) (if using the [REST API](../api-ref/))
* [cURL](https://curl.haxx.se), [gRPCurl](https://github.com/fullstorydev/grpcurl) and [jq](https://stedolan.github.io/jq) (if using the [gRPC API](../api-ref/grpc/))

### Set up a service account {#configure-account}

To access your organization and work with the {{ video-name }} API, you will need a [service account](../../iam/concepts/users/service-accounts.md) with the `video.admin` or `video.editor` [role](../../iam/concepts/access-control/roles.md) and an [IAM token](../../iam/concepts/authorization/iam-token.md).

#### Create a service account {#create-account}

Create a service account you will use to authenticate in the {{ video-name }} API.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are going to use to work with the {{ video-name }} API.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for the service account, e.g., `sa-video-api`.

      Follow these naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run the following command to create a service account:

  ```bash
  yc iam service-account create --name sa-video-api
  ```

  Where `--name` is the service account name in the following format:

  {% include [name-format](../../_includes/name-format.md) %}

  Result:

  ```text
  id: ajehr0to1g8b********
  folder_id: b1gv87ssvu49********
  created_at: "2024-03-04T09:03:11.665153755Z"
  name: sa-video-api
  ```

  Save the `id` of the service account: you will need it to [assign a role](#assign-role).

- API {#api}

  To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC call.

{% endlist %}

#### Assign a role to the service account {#assign-role}

Assign the service account the `video.admin` or `video.editor` role for the organization. To learn more, see [{#T}](../security/index.md).

To grant a service account permissions to access an organization, you need the `{{ roles-organization-admin }}` role or higher.

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, select ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.
  1. In the **{{ ui-key.yacloud.common.resource-acl.placeholder_filter-by-type }}** filter, select `{{ ui-key.yacloud_components.acl.label.service-accounts}}`.
  1. Click **{{ ui-key.yacloud_org.entity.user.action.acl }}** in the top-right corner of the page.
  1. In the window that opens, go to **{{ ui-key.yacloud_components.acl.label.service-accounts}}** and select the previously created service account from the list or use the search bar to locate it.
  1. Click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** and select the `video.admin` or `video.editor` role.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Run this command:

  ```bash
  yc organization-manager organization add-access-binding \
    --id <organization_ID> \
    --role <role> \
    --service-account-id <service_account_ID>
  ```

  Where `--role` is `video.admin` or `video.editor`.

- API {#api}

  To assign a service account a role for an organization, use the [updateAccessBindings](../../organization/api-ref/Organization/updateAccessBindings.md) REST API method for the [Organization](../../organization/api-ref/Organization/index.md) resource or the [OrganizationService/UpdateAccessBindings](../../organization/api-ref/grpc/Organization/updateAccessBindings.md) gRPC API call.

{% endlist %}

#### Get an IAM token {#get-iam}

To get an IAM token for a previously created service account, see [{#T}](../../iam/operations/iam-token/create-for-sa.md).

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

To create a {{ video-name }} video using the API, [register](#register-video) the video on the channel and then [upload](#upload-video) the video file into it via the [tus](https://tus.io/protocols/resumable-upload) protocol. If the upload fails, [resume](#continue-if-interrupted) it from the same position in the file it was interrupted at.

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

Video file uploads use the `tus` protocol which allows resuming the upload from where it was interrupted in the event of connection failure. You can code the upload yourself in your preferred programming language or use [ready-made](https://tus.io/implementations) libraries for the same purpose.

To upload a video file using `curl`, run this command:

{% include [create-video-upload-file-curl](../../_includes/video/create-video-upload-file-curl.md) %}

### Make sure the video file has been uploaded {#verify-upload}

Make sure the video file has been fully uploaded. To do this, run the following command by specifying the video ID (`videoId`) you saved earlier:

{% list tabs group=instructions %}

- REST API {#api}

  {% include [verify-video-upload-rest](../../_includes/video/verify-video-upload-rest.md) %}

- gRPC API {#grpc-api}

  {% include [verify-video-upload-grpc](../../_includes/video/verify-video-upload-grpc.md) %}

{% endlist %}

If you see `PROCESSING` or `READY` in the `status` field, the video file was fully uploaded. Proceed to [add a thumbnail for the video](#add-thumbnail).

If you see `WAIT_UPLOADING` in the `status` field, the video file upload was interrupted. In which case you need to resume the upload.

### Resume the interrupted upload {#continue-if-interrupted}

To resume an upload, you need to know the `offset` position the previous upload attempt was interrupted at.

{% include [resume-video-upload-curl](../../_includes/video/resume-video-upload-curl.md) %}

[Check](#verify-upload) once again that the video file has been fully uploaded. If the upload was interrupted again, repeat the steps described in this subsection.

## Add a thumbnail to your video {#add-thumbnail}

To add a thumbnail to your {{ video-name }} video using the API, [register](#register-thumbnail) the thumbnail on the channel, [get an upload link](#get-thumbnail-upload-link), [upload](#upload-thumbnail-image) an image file using that link, and [add](#assign-thumbnail) the new thumbnail to your video.

### Register the thumbnail {#register-thumbnail}

To register a thumbnail, run this command:

{% list tabs group=instructions %}

- REST API {#api}

  {% include [register-thumbnail-rest-api](../../_includes/video/register-thumbnail-rest-api.md) %}

- gRPC API {#grpc-api}

  {% include [register-thumbnail-grpc-api](../../_includes/video/register-thumbnail-grpc-api.md) %}

{% endlist %}

Save the `thumbnailId` value: you will need it later.

### Get a thumbnail upload link {#get-thumbnail-upload-link}

To get a thumbnail upload link, run this command:

{% list tabs group=instructions %}

- REST API {#api}

  {% include [get-thumbnail-uplink-rest-command](../../_includes/video/get-thumbnail-uplink-rest-command.md) %}

- gRPC API {#grpc-api}

  {% include [get-thumbnail-uplink-grpc-command](../../_includes/video/get-thumbnail-uplink-grpc-command.md) %}

{% endlist %}

{% include [get-thumbnail-uplink-api-output](../../_includes/video/get-thumbnail-uplink-api-output.md) %}

### Upload an image file to the thumbnail {#upload-thumbnail-image}

To upload your image to the thumbnail, run this command:

{% include [upload-thumbnail-curl](../../_includes/video/upload-thumbnail-curl.md) %}

### Add the thumbnail to your video {#assign-thumbnail}

To add the new thumbnail to your video, run this command:

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