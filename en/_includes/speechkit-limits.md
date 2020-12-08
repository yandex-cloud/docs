#### Quotas {#speechkit-quotas}

| Type of limit | Value |
| ----- | ----- |
| [**Short audio recognition**](../speechkit/stt/request.md) |
| Requests per second | 20 |
| [**Streaming mode of short audio recognition**](../speechkit/stt/streaming.md) |
| Requests per second | 40 |
| Number of streams running simultaneously | 60 |
| [**Long audio recognition**](../speechkit/stt/streaming.md) |
| Recognition requests per hour | 500 |
| Operation status check requests per hour | 2500 |
| Billable hours of audio per day | 10,000 |
| [**Speech synthesis**](../speechkit/tts/request.md) |
| Requests per second | 40 |

#### Limits {#speechkit-limits}

| Type of limit | Value |
| ----- | ----- |
| [**Short audio recognition**](../speechkit/stt/request.md) |  |
| Maximum file size | {{ stt-short-fileSize }} |
| Maximum duration of audio | {{ stt-short-audioLength }} |
| Maximum number of audio channels | {{ stt-short-channelsCount }} |
| [**Streaming mode of short audio recognition**](../speechkit/stt/streaming.md) |
| Maximum duration of transmitted audio for the entire session | {{ stt-streaming-audioLength }} |
| Maximum size of transmitted audio data | {{ stt-streaming-fileSize }} |
| Maximum number of audio channels | {{ stt-short-channelsCount }} |
| [**Long audio recognition**](../speechkit/stt/streaming.md) |
| Maximum file size | {{ stt-long-fileSize }} |
| Maximum duration of audio | {{ stt-long-audioLength }} |
| Period for storing recognition results on the server | {{ stt-long-resultsStorageTime }} |
| [**Speech synthesis**](../speechkit/tts/request.md) |
| Maximum request size | 5000 characters |
