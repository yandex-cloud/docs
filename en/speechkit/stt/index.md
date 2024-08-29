# Speech recognition

_Speech recognition_ is speech-to-text (STT) conversion.

{% include [api-concepts](../../_includes/speechkit/api-concepts.md) %}

The service is available at `{{ api-host-sk-stt }}:443`.

You can also work with {{ speechkit-name }} using the [Python SDK](../sdk/python/index.md). It is implemented based on the [{{ speechkit-name }} API v3](../stt-v3/api-ref/grpc/).


{% include [try-speechkit](../../_includes/speechkit/try-speechkit.md) %}


## Recognition methods {#stt-ways}


{{ speechkit-name }} provides two ways of improving the quality of speech recognition:

1. [Streaming recognition](streaming.md) is used for real-time speech recognition. During streaming recognition, {{ speechkit-name }} receives short audio fragments and sends the results, including intermediate ones, over a single connection.
1. Audio file recognition. {{ speechkit-name }} Can recognize audio recordings in [synchronous](request.md) and [asynchronous](transcribation.md) mode.
   * Synchronous mode has strict limitations on the size and duration of a file and is suitable for recognizing single-channel audio fragments of up to {{ stt-short-audioLength }}.
   * Asynchronous mode can process multi-channel audio fragments. Maximum recording duration: {{ stt-long-audioLength }}.



### Which recognition to choose {#choose-stt}

|  | [Streaming recognition](streaming.md) | [Synchronous recognition](request.md) | [Asynchronous recognition](transcribation.md) |
|---|---------|----------------------|----------------------|
| **Use cases** | Telephone assistants and robots </br> Virtual assistants | Virtual assistants </br> Voice control </br> Recognition of short voice messages in messengers | Transcription of audio calls and presentations </br> Subtitling </br> Ensuring script adherence in call centers </br> Identifying successful scripts </br> Evaluating performance of call center operators. |
| **Input data** | Real-time voice | Pre-recorded short single-channel audio files | Pre-recorded multi-channel and long audio files |
| **How it works** | Exchanging messages with the server over a single connection | Request — quick response | Request — delayed response |
| **Supported APIs** | [gRPC v2](api/streaming-api.md) </br> [gRPC v3](../stt-v3/api-ref/grpc/) | [REST v1](api/request-api.md) | [REST v2](api/transcribation-api.md) </br> [gRPC v3](api/transcribation-api-v3.md) |
| **Maximum duration of audio data** | {{ stt-streaming-audioLength }} | {{ stt-short-audioLength }} | {{ stt-long-audioLength }} |
| **Maximum amount of transmitted data** | {{ stt-streaming-fileSize }} | {{ stt-short-fileSize }} | {{ stt-long-fileSize }} |
| **Number of recognition channels** | 1 | 1 | 2 |


## Recognition process {#process}

Audio is recognized in three stages:

1. The acoustic model determines which set of low-level attributes corresponds to the audio signal.
1. The language model uses the acoustic model output to generate the text by words.
1. The service performs text processing: punctuation, converting numerals into numbers, and more.

## Recognition accuracy {#speed_and_accuracy}

Recognition accuracy depends on the recognition model. You can improve recognition accuracy of the model by providing data for tuning of the model. For more information about model tuning, see [{#T}](additional-training.md).

The accuracy of speech recognition is also affected by:

* Original sound quality.
* Audio encoding quality.
* Speech intelligibility and rate.
* Utterance complexity and length.

#### See also {#see-also}

* [{#T}](../formats.md)
* [{#T}](models.md)
* [{#T}](streaming.md)
* [{#T}](eou.md)
* [{#T}](normalization.md)
* [{#T}](request.md)
* [{#T}](transcribation.md)
* [{#T}](additional-training.md)
