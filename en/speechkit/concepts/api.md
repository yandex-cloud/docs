# {{ speechkit-name }} API

You can use the {{ speechkit-name }} API for [speech recognition](../stt-v3/api-ref/grpc/) and [synthesis](../tts-v3/api-ref/grpc/). For API use cases, see our [tutorials](../tutorials/index.md).

The {{ speechkit-name }} API is based on the gRPC mechanism. API methods and data structures are described using Protocol Buffers (proto 3).

The {{ speechkit-name }} API does not support a resource-based approach, since it does not use {{ yandex-cloud }} resources. {{ speechkit-name }} API requests are not idempotent.

#### See also {#see-also}

* [gRPC documentation](https://grpc.io/docs/).
* [Protocol Buffers documentation](https://developers.google.com/protocol-buffers/docs/proto3).
* [{{ yandex-cloud }} API concepts](../../api-design-guide/concepts/general.md#resource-oriented-design).
