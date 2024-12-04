# Specifics of API implementation in {{ foundation-models-full-name }}

{{ foundation-models-full-name }} provides access to various foundation models. Each model has its own API.

{{ foundation-models-name }} APIs are designed based on gRPC. The API methods and data structures are described using Protocol Buffers (proto 3).

{{ foundation-models-name }} does not support the resource-based approach, as it does not use {{ yandex-cloud }} resources. Requests to {{ foundation-models-name }} models are not idempotent.

#### See also {#see-also}

* [gRPC documentation](https://grpc.io/docs/)
* [Protocol Buffers documentation](https://developers.google.com/protocol-buffers/docs/proto3)
* [{{ yandex-cloud }} API concepts](../../api-design-guide/concepts/general.md#resource-oriented-design)
