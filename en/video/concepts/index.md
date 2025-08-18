# {{ video-full-name }} overview

{% include [about-service](../../_includes/video/about-service.md) %}

High-quality raw original video content (video file or broadcast) is not well suited for embedding on a website or app as it requires a stable, high-speed internet connection on the client side.

{{ video-name }} prepares video content for posting on the internet:
* Transcodes the original video file or broadcast into multiple versions with different bitrates and resolutions. When viewing content on client devices, the [video player](player.md) selects the best version for smooth playback at a given internet connection speed.
* Divides content into small parts for efficient delivery, caching, and smooth playback in the video players on user devices.
* Distributes content using the CDN technology.
* Provides a fault-tolerant infrastructure for transcoding, storing, and broadcasting video content.

You can also monetize your video content using the [Yandex Advertising Network](https://yandex.ru/support2/partner/ru/yan-rules/video).

To learn more about advertising, see [{#T}](../operations/channels/settings.md).

Also, in {{ video-name }}, you can use Yandex tools for summarization, neural translation, and subtitle generation.

## Channels {#channels}

A _channel_ is a way to arrange content in {{ video-name }}. For example, you can use channels to distribute your video content by user, project, or timeline. Channels contain your uploaded [videos](videos.md) as well as the parameters of upcoming, ongoing, and completed [broadcasts](streams.md).

### See also {#see-also}

* [{#T}](../security/index.md)
* [{#T}](../hosting.md)
* [{#T}](../streaming.md)
