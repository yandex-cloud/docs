---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/index.md
---

# Video API: REST reference

This API reference is organized by resource. Actions are performed by sending HTTP requests to resource URLs or making RPC calls. For more information about API architecture, see [API Concepts]({{ api-url-prefix }}/api-design-guide/).

**Interface definitions** available at [GitHub](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/video/v1).

**Service URL**: `https://video.{{ api-host }}`

#|
||Service | Description ||
|| [Channel](Channel/index.md) | Channel management service.
Provides methods for creating, retrieving, updating, and deleting channels,
as well as managing channel-related operations such as access control.
Channels serve as containers for videos and streams in an organization. ||
|| [Episode](Episode/index.md) | Episode management service.
Provides methods for creating, retrieving, updating, and deleting episodes,
which represent specific time segments of streams
that can be individually accessed, managed, and published. ||
|| [Operation](Operation/index.md) | A set of methods for managing operations for asynchronous API requests. ||
|| [Playlist](Playlist/index.md) | Playlist management service.
Provides methods for creating, retrieving, updating, and deleting playlists,
which are collections of videos or episodes that can be played sequentially. ||
|| [StreamLine](StreamLine/index.md) | Stream line management service.
Provides methods for creating, retrieving, updating, and deleting stream lines,
which define the technical configuration for receiving and processing video signals. ||
|| [Stream](Stream/index.md) | Stream management service.
Provides methods for creating, retrieving, updating, and deleting live streams,
as well as managing stream-related operations
such as publishing, stopping, and generating playback URLs. ||
|| [StylePreset](StylePreset/index.md) | StylePreset management service.
Provides methods for creating, retrieving, updating, and deleting style presets,
which define the visual appearance and layout of video players and associated widgets. ||
|| [Subtitle](Subtitle/index.md) | Subtitle management service.
Provides methods for creating, retrieving, updating, and deleting subtitles,
which provide text translations or transcriptions of video content in various languages. ||
|| [Thumbnail](Thumbnail/index.md) | Thumbnail management service.
Provides methods for creating, retrieving, and managing thumbnail images
that can be associated with various resources such as videos, streams, episodes, and channels. ||
|| [Video](Video/index.md) | Video management service.
Provides methods for creating, retrieving, updating, and deleting videos,
as well as managing video-related operations such as transcoding, publishing,
and generating playback URLs. ||
|#