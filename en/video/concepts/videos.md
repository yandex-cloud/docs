# Videos in {{ video-name }}

With {{ video-name }}, you can upload _videos_ to your [channel](index.md#channels) for subsequent publication on external resources.

{% include [video-characteristic](../../_includes/video/video-characteristic-multiple.md) %}

{{ video-name }} [limits](limits.md) the resolution of the videos you are publishing.

You can upload custom covers for your videos. The cover will appear in the {{ video-name }} interface and the [player](./player.md) on the website hosting the video.

{% include [image-characteristic](../../_includes/video/image-characteristic.md) %}

You can [publish](../operations/video/get-link.md) via a direct link or post to a website either single videos or videos grouped into [playlists](playlists.md) in desired order. For more information on publishing playlists, see [{#T}](../operations/playlists/get-link.md).

## Statuses {#statuses}

### Video statuses {#video-statuses}

* `{{ ui-key.yacloud_video.videos.status_wait-uploading }}`: Original video file is being uploaded to a {{ yandex-cloud }} storage.
* `{{ ui-key.yacloud_video.videos.status_processing }}`: Original video file is being transcoded into several versions with different bitrates and resolutions. When viewing the video on client devices, the video player selects the best version for smooth playback at a given internet connection speed.
* `{{ ui-key.yacloud_video.videos.status_ready }}`: Transcoding is complete. The video is ready for viewing.
* `{{ ui-key.yacloud_video.videos.status_error }}`: Error uploading a file or transcoding a video. Check the stability of your internet connection, the integrity and format of the file and try again.

### Publication statuses {#publication-statuses}

* `{{ ui-key.yacloud_video.videos.status_published }}`: The video is [published](../operations/video/publish.md).
* `{{ ui-key.yacloud_video.videos.status_unpublished }}`: The video is not published.

## Video publishing parameters {#video-parameters}

You can change the following basic video playback settings when [generating](../operations/video/get-link.md) a direct link or website embed code:

* Default sound setting for video playback.
* Automatic start of playback when opened.
* Displaying video controls in the player.

{% include [iframe-settings](../../_includes/video/iframe-settings.md) %}

## Video viewing statistics {#video-statistics}

For each video, you can [look up the viewing statistics](../operations/video/get-statistics.md) and flexibly customize the statistics period.

The following viewing statistics are currently available:

* Number of views: Integer.
* Share of viewed content: Percentage ratio of average viewing time to video duration.
* Total viewing time: Total viewing time in hours and minutes.
* Average viewing time: Average viewing time in hours and minutes.
* Linear chart with distribution of the number of views per unit of time with the following discretization levels:

    * `5 minutes`
    * `1 hour`
    * `1 day`
* Pie chart with distribution of views by device OS type.
* Pie chart with distribution of views by device type.
* [Heat map](https://en.wikipedia.org/wiki/Heat_map) with data on video fragment views.

    Each point on the heat map corresponds to a 30-second video fragment.

    On the heat map, the fact of video fragment playback is counted as a view regardless of playback duration. For example, if you start a video and stop it right away, a view will be counted for the first fragment of the video.

## See also {#see-also}

* [Getting started with video hosting](../hosting.md)
* [Getting started with API](../api-ref/quickstart.md)