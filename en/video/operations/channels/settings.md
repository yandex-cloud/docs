---
title: How to set up a channel in {{ video-full-name }}
description: Follow this guide to set up a {{ video-full-name }} channel and manage advertising.
---

# Setting up a channel and advertising

## Setting up a channel {#channel-settings}

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select a channel.
  1. In the right-hand panel, select **Channel settings**.
  1. Under **Advertising**, specify the ad settings for all videos on your channel.
  1. Under **Allowed domains**, add the addresses of websites where videos from this channel can be played. Videos will not be played on other websites.
     1. Enable **Check status**.
     1. Click ![plus-sign](../../../_assets/console-icons/plus.svg) **Add domain**.
     1. Enter the address of a website or group of websites.
     1. Click **{{ ui-key.yacloud_video.common.action_create }}**
     1. Add other domains if required.
  1. To display videos on all websites, disable **Check status**. The domains you added will be saved.
  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Use the [create](../../api-ref/Channel/create.md) or [update](../../api-ref/Channel/update.md) REST API method for the [Channel](../../api-ref/Channel/index.md) resource, [ChannelService/Create](../../api-ref/grpc/Channel/create.md) or [ChannelService/Update](../../api-ref/grpc/Channel/update.md) gRPC API call. Provide your settings in the `settings` parameter.

{% endlist %}

## Configuring ads {#ad-settings}

You can monetize your video content using the Yandex Advertising Network.

To configure ads:

1. Review the [requirements for placing video blocks](https://yandex.ru/support2/partner/ru/yan-rules/video).
1. [Sign up](http://partner.yandex.ru/form/) for the Yandex Advertising Network (YAN).
1. Submit a request to [support](https://yandex.ru/support2/partner/ru/support) to add your video resource.

    For more details, see the Yandex documentation: [New partners](https://yandex.ru/support2/partner/ru/joining/) and [Creating a video resource](https://yandex.ru/support2/partner/ru/video/resource).

    After creating a video resource, the **Video advertising** section will appear in the Yandex Advertising Network interface, and the video resource itself will appear in the **Video advertising → Video resources** tab. It will be assigned a unique `Page ID` and get the **New** status.

1. [Add](#add-page-id) the `Page ID` to the {{ video-name }} channel settings.
1. Wait until the moderation process is completed: the video resource status in YAN will change to **Active. No statistics**.
1. [Configure](https://yandex.ru/support2/partner/ru/video/create-instream) the display of ad blocks for your videos.
1. [View statistics](https://yandex.ru/support2/partner/ru/statistics/working-with-reports) on advertising and learn about [technologies for increasing advertising efficiency](https://yandex.ru/support2/partner/ru/efficiency/site-quality).

### Adding Page ID {#add-page-id}

{% list tabs group=instructions %}

- {{ video-name }} UI {#console}

  1. Open **Channel settings**.
  1. Under **Advertising**, specify:
     * **Provider**: `Yandex Direct`.
     * **Page ID** you got after creating your video resource.
     * **Category** (topic) of the videos on your channel.
  1. Click **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Use the [create](../../api-ref/Channel/create.md) or [update](../../api-ref/Channel/update.md) REST API method for the [Channel](../../api-ref/Channel/index.md) resource, [ChannelService/Create](../../api-ref/grpc/Channel/create.md) or [ChannelService/Update](../../api-ref/grpc/Channel/update.md) gRPC API call.
  
  Provide your advertising settings using the `settings` > `advertisement` parameter.

{% endlist %}

#### See also {#see-also}

[{#T}](../../concepts/index.md#channels)
