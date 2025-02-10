# Streaming speech recognition

Streaming mode allows you to simultaneously send audio for recognition and get recognition results over the same connection. You can also get intermediate recognition results when the speaker has not yet finished the utterance. After a pause, {{ speechkit-name }} returns the final results and starts recognizing the next utterance.

> Voice assistants and smart speakers work using this recognition mode. When you activate the assistant, it starts transmitting speech to the server for recognition. The server processes the data and returns the intermediate and final recognition results of each utterance. The intermediate results are used to show the recognition progress. After the final results, the assistant performs an action, such as playing music or calling another person.


{% note warning %}

Streaming mode is designed for real-time audio recognition. To recognize a recorded audio file, use [synchronous](request.md) or [asynchronous](transcribation.md) audio recognition.

{% endnote %}


## Streaming recognition restrictions {#session-restrictions}


{{ speechkit-name }} streaming recognition has a number of restrictions that need to be taken into account when creating an application. For a full list of {{ speechkit-name }} restrictions, see [{#T}](../concepts/limits.md).

|  | Streaming recognition |
|---|---------|
| **Use cases** | Telephone assistants and robots </br> Virtual assistants |
| **Input data** | Real-time voice |
| **How it works** | Exchanging messages with the server over a single connection |
| **Supported APIs** | [gRPC v2](api/streaming-api.md) </br> [gRPC v3](../stt-v3/api-ref/grpc/index.md) |
| **Maximum duration of audio data** | {{ stt-streaming-audioLength }} |
| **Maximum amount of transmitted data** | {{ stt-streaming-fileSize }} |
| **Number of recognition channels** | 1 |

## Using the service {#service-use}

To use the service, create an application that will send audio fragments and process responses with recognition results.

### Client application interface code {#create-client-app}

{{ speechkit-name }} has two streaming recognition API versions: [API v3](../stt-v3/api-ref/grpc/) and [API v2](api/streaming-api.md). We recommend using the API v3 for new projects.

For the application to access the service, clone the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi/) repository and generate the client interface code for the used programming language from the [API v2](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/ai/stt/v2/stt_service.proto) or [API v3](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/ai/stt/v3/stt_service.proto) specification file.

Client application examples:

* [{#T}](api/streaming-examples-v3.md).
* [{#T}](api/microphone-streaming.md).
* [{#T}](api/streaming-examples.md).

See also the [gRPC documentation](https://grpc.io/docs/tutorials/) for detailed instructions on how to generate interfaces and implement client apps in various programming languages.

{% note warning %}

When requesting the results of an operation, gRPC clients by default limit the maximum message size that they can accept as a response to no more than 4 MB. If a response with recognition results exceeds this amount, an error is returned.

{% endnote %}

To get the entire response, increase the maximum message size limit:
* For Go, use the [MaxCallRecvMsgSize](https://pkg.go.dev/google.golang.org/grpc#MaxCallRecvMsgSize) function.
* For C++, in the [`call` method](https://grpc.github.io/grpc/cpp/classgrpc_1_1internal_1_1_call.html#af04fabbdb53dea98da54c387364faf63), set the `max_receive_message_size` value.

### Authentication with the service {#auth}

In each request, the application must pass an IAM token or API key for authentication in the service and the [ID of the folder](../../resource-manager/operations/folder/get-id.md) for which the account has the `{{ roles-speechkit-stt }}` role or higher. For more information about permissions, see [Access management](../security/index.md).

The most straightforward way to authenticate an application is to use a service account. When authenticating as a service account, do not indicate the folder ID in your requests: {{ speechkit-name }} will use the same folder where the service account was created.

[Learn more about authentication in {{ speechkit-name }}](../concepts/auth.md).

### Recognition request {#requests}

For speech recognition, the application must first send a recognition settings message:

* For the API v3, the [RecognizeStreaming](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming) message of the `session_options` type.
* For the API v2, the `StreamingRecognitionRequest` message of the [RecognitionConfig](api/streaming-api#specification-msg) type.

When the session is set up, the server will wait for messages with audio fragments (chunks). Send the `RecognizeStreaming` message of the [session_options](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming) type or the `StreamingRecognitionRequest` message of the [audio_content](api/streaming-api#audio-msg) type to the API v2. Take the following recommendations into account when sending messages:

* Do not send audio fragments too often or infrequently. The time between messages to the service should be approximately the same as the duration of the audio fragments you send, but no more than 5 seconds. For example, send 400 ms of audio for recognition every 400 ms.
* Maximum duration of transmitted audio for the entire session: {{ stt-streaming-audioLength }}.
* Maximum size of transmitted audio data: {{ stt-streaming-fileSize }}.

If messages aren't sent to the service within 5 seconds or the data duration or size limit is reached, the session is terminated. To continue speech recognition, reconnect and send a new message with the speech recognition settings.

{{ speechkit-name }} returns intermediate speech recognition results before a message stream with audio fragments has finished.

### Recognition result {#results}

In each recognition result message ([StreamingResponse](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming#speechkit.stt.v3.StreamingResponse) or [StreamingRecognitionResponse](api/streaming-api.md#response)), the {{ speechkit-name }} server returns one or more speech chunks it was able to recognize during this period (`chunks`). A list of recognized text variants is specified for each chunk (`alternatives`).

The {{ speechkit-name }} server returns recognition results stating their type:

* `partial`: For intermediate results.
* `final`: For final results.
* `final_refinement`: For [normalized](normalization.md) final results.

   With normalization enabled, you will get the `final` and `final_refinement` results.

In the API v2, if recognition is not yet complete, the results will contain the `final` parameter set to `False`.

Speech recognition completes and delivers final results upon [EOU (End-of-Utterance)](eou.md). It is a marker of where an utterance ends. EOU occurs in the following cases:

* The gRPC session is terminated.
* Silence has been recognized in the last speech fragment. Silence can be represented by one of these [two parameters](../stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.StreamingRequest):

   * `chunk`: Sound recognized as silence.
   * `silence_chunk`: Silence duration in milliseconds. This parameter allows you to reduce the audio packet size by excluding silence that does not require recognition.

#### See also {#see-also}

* [{#T}](../formats.md)
* [{#T}](models.md)
* [{#T}](../concepts/auth.md)
* [API v3 reference](../stt-v3/api-ref/grpc/stt_service)
* [{#T}](api/streaming-examples-v3.md)
* [{#T}](api/streaming-api.md)
* [{#T}](api/streaming-examples.md)
