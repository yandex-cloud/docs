# Videos in {{ video-name }}

With {{ video-name }}, you can upload _videos_ to your [channel](index.md#channels) for subsequent publication on external resources.

{% include [video-characteristic](../../_includes/video/video-characteristic-multiple.md) %}

By default, video playback starts only after processing if the browser supports the source file. You can change this in the channel settings. Then the source file will be played immediately, without changes, and will contain the original metadata.

{% include [video-multi-soundtracks](../../_includes/video/video-multi-soundtracks.md) %}

{% include [video-resolution-limits](../../_includes/video/video-resolution-limits.md) %}

You can upload custom covers for your videos. The cover will appear in the {{ video-name }} interface and the [player](./player.md) on the website hosting the video.

{% include [image-characteristic](../../_includes/video/image-characteristic.md) %}

You can [publish](../operations/video/get-link.md) a video and select its access type:

* **{{ ui-key.yacloud_video.videos.label_access_rights-sign-url-access }}**: Available via a dedicated link. {#temporary-link}

    {% include [video-temporary-links](../../_includes/video/video-temporary-links.md) %}

* **{{ ui-key.yacloud_video.videos.label_access_rights-public }}**: Available indefinitely to anyone with a link to it. {#permanent-link}

On the website, you can post both single videos and [playlists](playlists.md) with videos in a particular order. In playlists, only videos with permanent links will be available for viewing. For details on publishing playlists, see [{#T}](../operations/playlists/get-link.md).

## Statuses {#statuses}

### Video statuses {#video-statuses}

* `{{ ui-key.yacloud_video.videos.status_wait-uploading }}`: Original video file is being uploaded to a {{ yandex-cloud }} storage.
* `{{ ui-key.yacloud_video.videos.status_processing }}`: Original video file is transcoded into several video versions with different bitrates and resolutions. When viewing the video on client devices, the video player selects the best version for smooth playback at a given internet connection speed.
* `{{ ui-key.yacloud_video.videos.status_ready }}`: Transcoding is complete. The video is ready for viewing.
* `{{ ui-key.yacloud_video.videos.status_error }}`: Error uploading a file or transcoding a video. Check the stability of your internet connection, the integrity and format of the file and try again.

### Publication statuses {#publication-statuses}

* `{{ ui-key.yacloud_video.videos.status_published }}`: Video is [published](../operations/video/publish.md).
* `{{ ui-key.yacloud_video.videos.status_unpublished }}`: Video is not published.

## Video publishing parameters {#video-parameters}

You can change the following basic video playback settings when [generating](../operations/video/get-link.md) a direct link or website embed code:

{% include [publication-parameters](../_includes/video/publication-parameters.md) %}

{% include [iframe-settings](../../_includes/video/iframe-settings.md) %}

Also, you can use [presets](presets.md) to configure some of the player settings, e.g., widget color palette and layout.

## Video viewing statistics {#video-statistics}

You can [view statistics](../operations/video/get-statistics.md) for each video. To customize the statistics, select the calculation period and time interval. The difference from the previous period will help you estimate the growth or decline of interest in the video.

{% include [statistics-description](../_includes/video/statistics-description.md) %}

To estimate engagement, use a line chart with data on the number of views of fragments of the video.

## AI features {#ai-capabilities}

To provide users with more options and expand your video audience, enable AI features built on Yandex ML models. For more information about AI features, see [this article](https://habr.com/ru/companies/yandex/articles/792608/) in the Yandex blog.

### Summarization {#summarization}

[Summarization](../operations/video/summarization.md#enable) automatically creates a short summary of your video conveying its main points and key message. Summarization is available for videos with duration of no longer than four hours. With summarization enabled, the system automatically adds timecodes to videos. You can adjust the suggested timecodes or [add custom ones manually](#timecodes).

### Neural translation {#stranslation}

[Neural translation](../operations/video/translation.md) enables the automatic translation of video content into multiple languages and voiceover with [diverse voice options](https://habr.com/ru/news/905118/). View the list of supported languages in the [{{ video-name }} UI]({{ link-video-main }}).

### Subtitles {#subtitles}

Neural [subtitles](../operations/video/subtitles.md) not only include spoken text but also provide speaker differentiation. Each speaker switch is indicated by a dash and new line, making the dialogue easier to follow. View the list of supported languages in the [{{ video-name }} UI]({{ link-video-main }}).

You can also upload custom subtitles in SRT and VTT formats. The maximum subtitle file size is 500 MB. You can load several subtitle files in one or more languages for one video.

## Timecodes {#timecodes}

[Timecodes](../operations/video/add-timecodes.md) allow you to break the video into chapters that you can navigate while watching. The time and chapter name formats are as follows:

{% include [video-timecodes](../../_includes/video/video-timecodes.md) %}

You can also generate timecodes automatically by enabling video [summarization](#summarization).

#### Useful links {#see-also}

* [Getting started with video hosting](../hosting.md)
* [Getting started with API](../api-ref/quickstart.md)
* [How to enable monetization](../operations/channels/settings.md#ad-settings)
