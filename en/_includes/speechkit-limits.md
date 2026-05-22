#### Quotas {#speechkit-quotas}


Type of limit | Value
----- | -----
**Streaming speech recognition** |
Requests per second | 40
**Synchronous recognition** |
Requests per second | 20
**Asynchronous recognition** |
Recognition requests per hour | 500
Operation status check requests via API v2 per hour | 2,500
Operation status check requests via API v3 per second | 5
Billable hours of audio per day^1^ | 10,000
**Queries accessing an LLM** |
Concurrent queries accessing generative text models | 2
**Speech synthesis** |
Requests per second | 40



^1^ The first recognition request triggers the start of the time count.


#### Limits {#speechkit-limits}

Type of limit | Value
----- | -----
**Streaming speech recognition** |
Maximum duration of transmitted audio for entire session | {{ stt-streaming-audioLength }}
Maximum size of transmitted audio data | {{ stt-streaming-fileSize }}
Maximum number of audio channels | {{ stt-short-channelsCount }}
**Synchronous recognition** | |
Maximum file size | {{ stt-short-fileSize }}
Maximum duration of audio | {{ stt-short-audioLength }}
Maximum number of audio channels | {{ stt-short-channelsCount }}
**Asynchronous recognition** |
Maximum file size when uploading to a bucket | {{ stt-long-fileSize }}
Maximum file size when uploading in an API v3 request body | 60 MB
Maximum duration of audio | {{ stt-long-audioLength }}
Period for storing recognition results on the server | {{ stt-long-resultsStorageTime }}
**Speech synthesis** |
Minimum duration of a pattern for synthesis | 1 second
Maximum request size for the API v1 | 5,000 characters
Maximum request size for the API v3 | {{ tts-v3-count }} and {{ tts-v3-time }}
Maximum request size for the API v3 in unsafe mode | 5,000 characters
Maximum request size for the API v3 in streaming mode | 5,000 characters
**Queries accessing an LLM** |
Number of instructions for the generative text model per session | 16