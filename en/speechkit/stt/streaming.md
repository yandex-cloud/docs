# Streaming speech recognition

Data streaming mode allows you to simultaneously send audio for recognition and get recognition results over the same connection.

Unlike [other recognition methods](./index.md#stt-ways), you can get intermediate results while speech is in progress. After a pause, the service returns final results and starts recognizing the next utterance.

> For example, as soon as the user starts talking to [Yandex.Station](https://station.yandex.ru/), the speaker begins transmitting the speech to the server for recognition. The server processes the data and returns the intermediate and final results of each utterance recognition. The intermediate results are used for showing the user the progress of speech recognition. Once the final results are available, Yandex.Station performs the requested action, such as playing a movie.

To use the service, create an app that will perform speech recognition in data streaming mode: send audio fragments and process responses with recognition results.

{% note warning %}

Streaming mode is designed for real-time audio recognition. To recognize a recorded audio file, use [synchronous](request.md) or [asynchronous](transcribation.md) audio recognition.

{% endnote %}

## Using the service {#service-use}

### Creating a client app {#create-client-app}

For speech recognition, the app should first send a [message with recognition settings](api/streaming-api.md#specification-msg) and then send [messages with audio fragments](api/streaming-api.md#audio-msg).

{{ speechkit-name }} returns [intermediate results](api/streaming-api.md#response) of speech recognition before a message stream with audio fragments has finished.

To enable the app to access the service, you need to generate the client interface code for the programming language you use from the [stt_service.proto](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/ai/stt/v2/stt_service.proto) file of the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi/) repository.

See examples of client applications on [{#T}](api/streaming-examples.md). See the [gRPC documentation](https://grpc.io/docs/tutorials/) for detailed instructions on how to generate interfaces and deploy client apps for various programming languages.

### Authorization in the service {#auth}

In each request, the application must transmit the [ID of the folder](../../resource-manager/operations/folder/get-id.md) for which you are granted the `editor` role or higher. For more information about permissions, see [Access management](../security/index.md).

The application must also be authenticated for each request, such as with an IAM token. [Learn more about service authentication](../concepts/auth.md).

### Recognition result {#results}

In each [recognition result message](api/streaming-api.md#response), the server returns one or more speech fragments that it managed to recognize during this period (`chunks`). A list of recognized text alternatives is specified for each speech fragment (`alternatives`).

During the recognition process, speech is split into utterances and the end of the utterance is marked with the `endOfUtterance` flag. By default, the server returns a response only after an utterance is fully recognized. You can use the `partialResults` flag to make the server return intermediate recognition results as well. Intermediate results let you quickly respond to the recognized speech without waiting for the end of the utterance.

### Limitations of a speech recognition session {#session-restrictions}

After receiving the message with the recognition settings, the service starts a recognition session. The following limitations apply to each session:

* You can't send audio fragments too often or too rarely. The time between messages to the service should be approximately the same as the duration of the audio fragments you send, but no more than 5 seconds.

   For example, send 400 ms of audio for recognition every 400 ms.
* Maximum duration of transmitted audio for the entire session: {{ stt-streaming-audioLength }}.
* Maximum size of transmitted audio data: {{ stt-streaming-fileSize }}.

If messages aren't sent to the service within 5 seconds or the data duration or size limit is reached, the session is terminated. To continue speech recognition, reconnect and send a new message with the speech recognition settings.


