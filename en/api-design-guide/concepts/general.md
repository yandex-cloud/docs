# Basic principles

{{ yandex-cloud }} APIs are based on the [gRPC](https://grpc.io/docs/) mechanism. The API methods and data structures are described using [Protocol Buffers](https://developers.google.com/protocol-buffers/docs/proto3) (proto 3).

{{ yandex-cloud }} services provide a JSON REST interface that you can access directly. REST is supported via the [gRPC-JSON transcoder](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/grpc_json_transcoder_filter). {{ yandex-cloud }} services use this mechanism to translate incoming HTTP requests into gRPC calls. The service translates the results of request handling into an HTTP response and returns it to the client.

#### Resource-based approach {#resource-oriented-design}

APIs of most {{ yandex-cloud }} services use a resource-based approach. How it works:

- In APIs, resources are VMs, disks, images, etc. Each resource has a [unique ID](resources-identification.md).

- Two sets of methods are defined for managing resources in APIs:

   {% include [method-sets](../_includes/method-sets.md) %}

- All operations that change the state of a resource are asynchronous signature operations. When these operations are called, the server returns the [Operation](operation.md) object. This object contains the state of the operation and the ID of the resource the operation is being performed on.

- Operations for creating, updating, and deleting resources support [idempotency](idempotency.md).


#### Exceptions for the resource-based approach {#exceptions}

- [{{ objstorage-full-name }} API](../../storage/s3/index.md). Its architecture is compatible with the Amazon S3 API, so the {{ objstorage-name }} API operating principles do not always match those of the resource-based approach. For more information, see the documentation on the service.
- [{{ foundation-models-full-name }}](../../foundation-models/concepts/api.md), [{{ speechkit-full-name }}](../../speechkit/concepts/api.md), [{{ translate-full-name }}](../../translate/api-ref/grpc/), and [{{ vision-full-name }}](../../vision/vision/api-ref/grpc/) AI service API. The API of these services does not use {{ yandex-cloud }} resources and API requests are not idempotent.


#### See also {#see-also}
- [Link to the .proto specifications of the {{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi)


