
#### Quotas {#speechkit-quotas}

| Type of limit | Value |
----- | -----
| [**Streaming recognition mode**](../{{ speechkit-slug }}/stt/streaming.md) |
| Requests per second | 40 |
| [**Synchronous recognition**](../{{ speechkit-slug }}/stt/request.md) |
| Requests per second | 20 |
| [**Asynchronous recognition**](../{{ speechkit-slug }}/stt/transcribation.md) |
| Recognition requests per hour | 500 |
| Operation status check requests per hour | 2,500 |
| Billable hours of audio per day | 10,000 |
| [**Speech synthesis**](../{{ speechkit-slug }}/tts/request.md) |
| Requests per second | 40 |


#### Limits {#speechkit-limits}


| Type of limit | Value |
----- | -----
| [**Streaming recognition mode**](../{{ speechkit-slug }}/stt/streaming.md) |
| Maximum duration of transmitted audio for entire session | {{ stt-streaming-audioLength }} |
| Maximum size of transmitted audio data | {{ stt-streaming-fileSize }} |
| Maximum number of audio channels | {{ stt-short-channelsCount }} |
| [**Synchronous recognition**](../{{ speechkit-slug }}/stt/request.md) | |
| Maximum file size | {{ stt-short-fileSize }} |
| Maximum duration of audio | {{ stt-short-audioLength }} |
| Maximum number of audio channels | {{ stt-short-channelsCount }} |
| [**Asynchronous recognition**](../{{ speechkit-slug }}/stt/transcribation.md) |
| Maximum file size | {{ stt-long-fileSize }} |
| Maximum duration of audio | {{ stt-long-audioLength }} |
| Period for storing recognition results on the server | {{ stt-long-resultsStorageTime }} |
| [**Speech synthesis**](../{{ speechkit-slug }}/tts/index.md) |
| Minimum duration of a pattern for synthesis | 1 second |
| Maximum REST request size | 5,000 characters |
| Maximum gRPC request size | {{ tts-v3-count }} and {{ tts-v3-time }} |
| Maximum gRPC request size in [unsafe](../{{ speechkit-slug }}/tts-v3/api-ref/grpc/tts_service#UtteranceSynthesisRequest) mode | 5,000 characters |
