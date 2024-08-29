# {{ speechkit-full-name }} technology overview

{{ speechkit-full-name }} voice technologies help handle any task related to human speech. {{ speechkit-name }} can recognize speech in real time and using pre-recorded audio files, automatically detecting the speaker's language. It can also vocalize pattern phrases and long texts using {{ speechkit-name }} standard voices.

{{ speechkit-name }} runs using the API interfaces. Depending on the task, you can use the gRPC or REST interfaces. For more information about API implementations in {{ yandex-cloud }}, see [{{ yandex-cloud }} API concepts](../api-design-guide/).

The table provides the most common {{ speechkit-name }} use cases so that you can choose the appropriate technologies and configure them to meet your needs.

| Description | Recommended technologies | Features and settings |
|---|---|---|
| **Voice robot** | | |
| Full or partial automation of telephone communications with customers. | To input a user's request: [Streaming recognition](stt/streaming.md). </br>For a system response: [Speech synthesis](tts/index.md) using [standard voices](tts/voices.md) and a [Brand Voice](tts/brand-voice/index.md) specifically designed for you. | <ul><li>You can get both intermediate and final [recognition results](stt/streaming.md#results})</li><li>Controlling pronunciation with [synthesized text markup](tts/index.md#markup)</li><li>[Pattern-based speech synthesis](tts/templates.md)</li></ul> |
| **Voice analysis</br>Operator performance quality control** |
| Transcribing and further analysis of audio recordings of dialogs between customers and call center operators or robots. | To recognize pre-recorded audio files: [Asynchronous recognition of audio files](stt/transcribation.md). | <ul><li>Timestamps of the start and end of a word in the [recognition results](stt/api/transcribation-api.md#get-result-response) </li><li>[Recognition result normalization](stt/api/transcribation-api.md#sendfile-params) </li><li>[Deferred mode](stt/transcribation.md#modes) for asynchronous recognition of audio files </li><li>[{#T}](concepts/limits.md)</li></ul> |
| **Voice control in apps and smart devices </br> Voice assistant** |
| The user requests an action or search using voice and the service responds with an action with a voice comment or an image. | To input a user's request: [Streaming recognition](stt/streaming.md). </br>For a system response: [Speech synthesis](tts/index.md) using [standard voices](tts/voices.md) and a [Brand Voice](tts/brand-voice/index.md). | <ul><li>You can get both intermediate and final [recognition results](stt/streaming.md#results})</li><li>Controlling pronunciation with [synthesized text markup](tts/index.md#markup)</li><li>[Recognition result normalization](stt-v3/api-ref/grpc/stt_service#TextNormalizationOptions)</li></ul> |
| **Service adaptation to people with visual impairments** |
| Voice control, voice hints and comments for visually impaired users. | To input a user's request: [Streaming recognition](stt/streaming.md). </br>For a system response: [Speech synthesis](tts/index.md) using [standard voices](tts/voices.md) and a [Brand Voice](tts/brand-voice/index.md). | <ul><li>You can get both intermediate and final [recognition results](stt/streaming.md#results})</li><li>Controlling pronunciation with [synthesized text markup](tts/index.md#markup)</li></ul> |
| **Recognizing audio recordings made during a meeting** | | |
| Transcribing the audio recordings after the meeting is completed. | To recognize pre-recorded audio files: [Asynchronous recognition of audio files](stt/transcribation.md). | <ul><li>[Deferred mode](stt/transcribation.md#modes) for asynchronous recognition of audio files </li><li>[{#T}](concepts/limits.md) </li><li>Timestamps of the start and end of a word in the [recognition results](stt/api/transcribation-api.md#get-result-response) </li><li>[Recognition result normalization](stt/api/transcribation-api.md#sendfile-params)</li></ul> |
| **Voicing books and videos** | | |
| Voicing a book or video with no human speaker involved. | [Speech synthesis](tts/index.md) using [standard voices](tts/voices.md) and a [Brand Voice](tts/brand-voice/index.md). | <ul><li>Controlling pronunciation with [synthesized text markup](tts/index.md#markup)</li><li>[{#T}](concepts/limits.md)</li></ul> |
| **Recording the minutes of a meeting** | | |
| Transcribing the meeting minutes in real time | To recognize the participants' speech: [Streaming recognition](stt/streaming.md). | <ul><li>You can get both intermediate and final [recognition results](stt/streaming.md#results})</li><li>[Recognition result normalization](stt/api/transcribation-api.md#sendfile-params)</li></ul> |
| **Video subtitles** | | |
| Creating subtitles for recorded videos | To recognize an audio track: [Asynchronous recognition of audio files](stt/transcribation.md). | <ul><li>[Deferred mode](stt/transcribation.md#modes) for asynchronous recognition of audio files </li><li>Timestamps of the start and end of a word in the [recognition results](stt/api/transcribation-api.md#get-result-response) </li><li>[Recognition result normalization](stt/api/transcribation-api.md#sendfile-params) </li><li>[{#T}](concepts/limits.md)</li></ul> |
| **Broadcast subtitles** | | |
| Transcribing broadcasts in real time. | To recognize the broadcast speech: [Streaming recognition](stt/streaming.md). | <ul><li>You can get both intermediate and final [recognition results](stt/streaming.md#results})</li><li>[Recognition result normalization](stt/api/transcribation-api.md#sendfile-params)</li></ul> |
| **Transcribing voice messages** | | |
| Converting short voice messages to text in messengers | To recognize audio files: [Synchronous recognition](stt/request.md). | [Recognition result settings](stt/api/request-api.md#query_params). |
