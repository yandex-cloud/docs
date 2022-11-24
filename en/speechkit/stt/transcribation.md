# Asynchronous recognition

Asynchronous recognition helps convert multi-channel audio files with the following properties into text:
* Maximum recording duration: {{ stt-long-audioLength }}.
* Maximum file size: {{ stt-long-fileSize }}.

Recognition results are saved on the {{ stt-long-resultsStorageTime }} server, after which you can't get them.

Asynchronous recognition can't be used for real-time dialog recognition. If you need intermediate results and minimum response time, use [streaming recognition](streaming.md).

View the list of supported languages in [{#T}](models.md#languages).

## Asynchronous recognition modes {#modes}

{% include [async-stt-modes](../../_includes/speechkit/async-modes.md) %}

## How can I recognize long audio fragments {#long-audio-recognition}

To recognize long audio fragments, you need to execute 2 requests:
1. Send a file for recognition.
1. Get recognition results.

See examples of requests in [{#T}](api/transcribation-api.md).

### Using gRPC {#grpc}

To use the service, create an app that will send audio fragments and process responses with recognition results.

To enable the app to send requests and get results, you need to generate the client interface code for the programming language you use. Generate this code from the [stt_service.proto](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/ai/stt/v2/stt_service.proto) and [operation_service.proto](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/operation/operation_service.proto) files from the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) repository.

See the [gRPC documentation](https://grpc.io/docs/tutorials/) for detailed instructions on how to generate interfaces and deploy client apps for various programming languages.

{% note warning %}

When requesting the results of an operation, gRPC clients by default limit the maximum message size that they can accept as a response to no more than 4 MB. If a response with recognition results exceeds this amount, an error is returned.

{% endnote %}

To get the entire response, increase the maximum message size limit:
* For Go, use the [MaxCallRecvMsgSize](https://pkg.go.dev/google.golang.org/grpc#MaxCallRecvMsgSize) function.
* For C++, in the [call](https://grpc.github.io/grpc/cpp/classgrpc_1_1internal_1_1_call.html#af04fabbdb53dea98da54c387364faf63) method, set the `max_receive_message_size` value.


