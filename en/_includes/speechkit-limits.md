{% if product == "yandex-cloud" %}

#### Quotas {#speechkit-quotas}

| Type of limit | Value |
----- | -----
| [**Streaming recognition mode**](../speechkit/stt/streaming.md) API v2 |
| Requests per second | 40 |
| Number of concurrently running streams | 60 |
| [**Synchronous recognition**](../speechkit/stt/request.md) |
| Requests per second | 20 |
| [**Asynchronous recognition**](../speechkit/stt/transcribation.md) |
| Recognition requests per hour | 500 |
| Operation status check requests per hour | 2500 |
| Billable hours of audio per day | 10,000 |
| [**Speech synthesis**](../speechkit/tts/request.md) |
| Requests per second | 40 |

{% endif %}

#### Limits {#speechkit-limits}

{% if product == "yandex-cloud" %}

| Type of limit | Value |
----- | -----
| [**Streaming recognition mode**](../speechkit/stt/streaming.md) |
| Maximum duration of transmitted audio for the entire session | {{ stt-streaming-audioLength }} |
| Maximum size of transmitted audio data | {{ stt-streaming-fileSize }} |
| Maximum number of audio channels | {{ stt-short-channelsCount }} |
| [**Synchronous recognition**](../speechkit/stt/request.md) | |
| Maximum file size | {{ stt-short-fileSize }} |
| Maximum duration of audio | {{ stt-short-audioLength }} |
| Maximum number of audio channels | {{ stt-short-channelsCount }} |
| [**Asynchronous recognition**](../speechkit/stt/transcribation.md) |
| Maximum file size | {{ stt-long-fileSize }} |
| Maximum duration of audio | {{ stt-long-audioLength }} |
| Period for storing recognition results on the server | {{ stt-long-resultsStorageTime }} |
| [**Speech synthesis**](../speechkit/tts/index.md) |
| Maximum REST request size | 5000 characters |
| Maximum gRPC request size | {{ tts-v3-count }} and {{ tts-v3-time }} |

{% endif %}
{% if product == "cloud-il" %}

| Type of limit | Value |
----- | -----
| [**Speech recognition**](../speechkit/stt/streaming.md) |
| Maximum duration of transmitted audio for the entire session | {{ stt-streaming-audioLength }} |
| Maximum size of transmitted audio data | {{ stt-streaming-fileSize }} |
| Maximum number of audio channels | {{ stt-short-channelsCount }} |
| Maximum interval between audio fragments before the connection is broken | 5 seconds |
| [**Speech synthesis**](../speechkit/tts/index.md) |
| Maximum gRPC request size | {{ tts-v3-count }} and {{ tts-v3-time }} |

{% endif %}