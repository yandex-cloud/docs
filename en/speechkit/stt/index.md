# Speech recognition

_Speech recognition (speech-to-text, STT)_ is the process of converting speech to text.

{% include [api-concepts](../../_includes/speechkit/api-concepts.md) %}

## Recognition methods {#stt-ways}

{{ speechkit-name }} provides two ways of improving the quality of speech recognition:

1. [Streaming recognition](streaming.md) is used for real-time speech recognition. During streaming recognition, {{ speechkit-name }} receives short audio fragments and sends the results, including intermediate ones, over a single connection.
1. Audio file recognition. {{ speechkit-name }} Can recognize audio recordings in [synchronous](request.md) and [asynchronous](transcribation.md) mode.
   * Synchronous mode has strict limitations on the size and duration of a file and is suitable for recognizing single-channel audio fragments of up to {{ stt-short-audioLength }}.
   * Asynchronous mode can process multi-channel audio fragments. Maximum recording duration: {{ stt-long-audioLength }}.

### Which recognition to choose {#choose-stt}

|  | [Data streaming recognition](streaming.md) | [Synchronous recognition](request.md) | [Asynchronous recognition](transcribation.md) |
|---|---------|----------------------|----------------------|
| **Use cases** | Telephone assistants and robots </br> Virtual assistants | Virtual assistants </br> Voice control </br> Recognition of short voice messages in messengers | Transcription of audio calls and presentations </br> Subtitling </br> Ensuring script adherence in call centers </br> Identifying successful scripts </br> Evaluating performance of call center operators. |
| **Input data** | Real-time voice | Pre-recorded short single-channel audio files | Pre-recorded multi-channel and long audio files |
| **How it works** | Exchanging messages with the server over a single connection | Request — quick response | Request — delayed response |
| **Supported APIs** | [gRPC v2](api/streaming-api.md) </br> [gRPC v3](../v3/api-ref/grpc/) | [REST v2](api/request-api.md) | [REST v2](api/transcribation-api.md) |
| **Maximum duration of audio data** | {{ stt-streaming-audioLength }} | {{ stt-short-audioLength }} | {{ stt-long-audioLength }} |
| **Maximum amount of transmitted data** | {{ stt-streaming-fileSize }} | {{ stt-short-fileSize }} | {{ stt-long-fileSize }} |
| **Number of recognition channels** | 1 | 1 | 2 |

## Recognition process {#process}

Regardless of the mode, audio is recognized in three stages:

1. Identification of words. For each word, multiple hypotheses are put forward.
1. Recognition of words. The language model checks hypotheses and determines how well a new word fits in with the words recognized earlier.
1. Processing of text. In the recognized text, numbers are converted into digits and some punctuation, such as hyphens, is marked. After that, the result is sent in the response body.

## Recognition accuracy {#speed_and_accuracy}

Recognition accuracy depends on the recognition model. You can improve a model's recognition accuracy by providing data for model retraining. For more information about ways of model retraining, see [{#T}](additional-training.md).

The accuracy of speech recognition is also affected by:

* Original sound quality.
* Audio encoding quality.
* Speech intelligibility and rate.
* Utterance complexity and length.

{% include [accuracy](../../_includes/speechkit/accuracy.md)%}

#### See also {#see-also}

* [{#T}](../formats.md)
* [{#T}](models.md)
* [{#T}](request.md)
* [{#T}](streaming.md)
* [{#T}](transcribation.md)
* [{#T}](additional-training.md)