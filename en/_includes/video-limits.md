#### Quotas {#quotas}

#|
|| Type of limit | Value ||
|| Maximum number of [channels](../video/concepts/index.md#channels) per [organization](../organization/quickstart.md)
`video.channels.count` | 25 ||
|| Total number of [videos](../video/concepts/videos.md) in all channels
`video.videos.count` | 5,000 ||
|| Number of [playlists](../video/concepts/playlists.md) in all channels
`video.playlists.count` | 500 ||
|| Number of simultaneous video transcoding processes with neural functions, such as [summarization](../video/concepts/videos.md#summarization), [neural translation](../video/concepts/videos.md#stranslation), and [subtitle generation](../video/concepts/videos.md#subtitles)
`video.transcodingsWithNeuroFeatures.rate` | 1 ||
|| Number of streaming [lines](../video/concepts/streams.md#lines) per organization
`video.streamLines.count` | 50 ||
|| Number of [broadcasts](../video/concepts/streams.md) per organization
`video.streams.count` | 500 ||
|| Number of simultaneous broadcasts per organization
`video.parallelStreams.count` | 1 ||
|| Number of [episodes](../video/concepts/streams.md#episodes) in all broadcasts
`video.episodes.count` | 500 ||
|| Total number of video [thumbnails](../video/operations/video/add-thumbnail.md) in all channels
`video.thumbnails.count` | 20,000 ||
|#

#### Limits {#limits}

**Type of limit** | **Value**
----- | -----
Maximum resolution of videos and broadcasts | [1080p](https://en.wikipedia.org/wiki/1080p)
Maximum broadcast duration | 24 hours
Maximum video duration required for summarization, neural translation, and subtitle generation | 4 hours