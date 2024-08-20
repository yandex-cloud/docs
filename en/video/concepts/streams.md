# Broadcasts in {{ video-name }}

With {{ video-name }}, you can stream [live broadcasts](#streams) in the integrated [video player](./player.md). Use [lines](#lines) and [episodes](#episodes) to customize your broadcast settings.

## Broadcasts {#streams}

A _broadcast_ is the main {{ video-name }} resource for live video streaming.

A broadcast is a one-time event implemented via a preset [line](#lines). To repeat your broadcast with the same signal source, create another broadcast on the same line.

Types of broadcast streams include:
* On demand: A broadcast is started and finished manually from the {{ video-name }} interface.
* On schedule: A broadcast is started and finished automatically at the specified time.

You can upload custom covers for your broadcasts. A cover will be displayed in the {{ video-name }} interface and the player on the broadcast hosting site.

{% include [image-characteristic](../../_includes/video/image-characteristic.md) %}

You can publish a broadcast via a direct link or post it on a site.

Once your broadcast is over, you can keep its video recording available or remove it.

## Lines {#lines}

In {{ video-name }}, you use _lines_ to configure the source of your video signal for [broadcasts](#streams).

You can set up multiple lines in advance and use them for different broadcasts.

The following stream input protocols are supported: [RTMP](https://en.wikipedia.org/wiki/Real-Time_Messaging_Protocol) and [SRT](https://en.wikipedia.org/wiki/Secure_Reliable_Transport).

Types of line input streams include:

{% include [push-pull](../../_includes/video/push-pull.md) %}

You can upload custom covers for your lines. A cover will be displayed in the {{ video-name }} interface. For cover parameters, see the [Broadcasts](#streams) section.

## Episodes {#episodes}

To split a broadcast into multiple parts, use _episodes_ that are broadcast time intervals. For example, to only embed a part of your broadcast in a site, select it as an episode. The default episode is the entire broadcast.