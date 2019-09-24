# Basic principles

Yandex.Cloud APIs are based on the [gRPC](https://grpc.io/docs/) mechanism. Methods and data structures in APIs are described using [Protocol Buffers](https://developers.google.com/protocol-buffers/docs/proto3) (proto 3).

Yandex.Cloud services provide a JSON REST interface that you can access directly. REST is supported via the [gRPC-JSON transcoder](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/grpc_json_transcoder_filter). Yandex.Cloud services use this mechanism to translate incoming HTTP requests into gRPC calls. The service translates the results of request handling into an HTTP response and returns it to the client.

#### Resource-based approach {#resource-oriented-design}

APIs use a resource-based approach. The principles that apply to all Yandex.Cloud APIs are described below:

- Resources in APIs are VM instances, disks, images, and so on. Each resource has a [unique ID](resources-identification.md).

- Two sets of methods are defined for managing resources in APIs:

   {% include [method-sets](../_includes/method-sets.md) %}

- Any operations that change the state of a resource are asynchronous operations. When such operations are called, the server returns the [Operation](operation.md) object. This object contains the state of the operation and the ID of the resource the operation is being performed on.

- Operations for creating, updating, and deleting resources support [idempotence](idempotency.md).

{% note info %}

The [Yandex Object Storage API](../../storage/s3/index.md) architecture provides compatibility with the Amazon S3 API. The Object Storage API may therefore not conform to the concepts described in this document. For more information, see the documentation on the service.

{% endnote %}

