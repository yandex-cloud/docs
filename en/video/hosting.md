---
title: "Getting started with video hosting in {{ video-full-name }}"
description: "Follow this guide to upload your video to the {{ video-full-name }} service and publish it."
---

# Getting started with video hosting in {{ video-full-name }}

{% include [preview-stage](../_includes/video/preview-stage.md) %}

{% include [ask-for-turning-on](../_includes/video/ask-for-turning-on.md) %}

To upload a [video](./concepts/index.md#videos) to a service [channel](./concepts/index.md#channels):
1. [Prepare your cloud](#before-you-begin).
1. [Create a channel](#create-channel).
1. [Upload your video](#upload-video).
1. [Publish your video](#publish-video).
1. [Check if the video is available](#test).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_includes/video/before-you-begin.md) %}

## Create a channel {#create-channel}

{% include [create-channel](../_includes/video/create-channel.md) %}

## Upload your video {#upload-video}

1. In the ![video](../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** tab, click **{{ ui-key.yacloud_video.videos.action_create-video }}**.
1. Click **Select file** on the upload page and choose the video to upload.

    {% include [video-characteristic](../_includes/video/video-characteristic.md) %}

1. **{{ ui-key.yacloud_video.videos.label_title }}** your video. The title will be displayed on all the resources hosting the video.
1. In the **{{ ui-key.yacloud_video.thumbnails.label_thumbnail }}** field, click ![upload](../_assets/console-icons/cloud-arrow-up-in.svg) **Select file** and choose a cover image.

    {% include [image-characteristic](../_includes/video/image-characteristic.md) %}

1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

[Learn more about videos](./concepts/index.md#videos)

## Publish your video {#publish-video}

In the video settings window that opens:
1. Wait until the video is completely uploaded, processed, and gets the `{{ ui-key.yacloud_video.videos.status_ready }}` status.
1. Enable **{{ ui-key.yacloud_video.videos.label_allow-access }}**.

    The `{{ ui-key.yacloud_video.videos.label_visibility-status }}` parameter will change to `{{ ui-key.yacloud_video.videos.status_published }}`.

## Check if the video is available {#test}

1. On the video settings page, select the `link` tab under **{{ ui-key.yacloud_video.videos.title_past-code }}**.
1. Click ![copy](../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.
1. Open a new browser page and paste the obtained URL to the address bar.
1. Click the Play button.

### See also {#see-also}

* [{#T}](streaming.md)
* [{{ video-full-name }} overview](./concepts/index.md)
