# Specifics of API implementation in {{ yagpt-full-name }}

Use {{ yagpt-full-name }} to perform tasks related to generating text content. For instance, you can select [user interaction mode](../concepts/index.md#working-modes) or estimate the size of a text field in [tokens](../concepts/tokens.md). For API method and call references, see [gRPC](../text-generation/api-ref/grpc/) and [REST](../text-generation/api-ref/).

The {{ yagpt-name }} API is based on the gRPC mechanism. API methods and data structures are described using Protocol Buffers (proto 3).

{{ yagpt-full-name }} does not support a resource-based approach, since it does not use {{ yandex-cloud }} resources. {{ yagpt-full-name }} requests are not idempotent.

#### See also {#see-also}

* [gRPC documentation](https://grpc.io/docs/)
* [Protocol Buffers documentation](https://developers.google.com/protocol-buffers/docs/proto3)
* [{{ yandex-cloud }} API concepts](../../api-design-guide/concepts/general.md#resource-oriented-design)
* [{#T}](../api-ref/migration-to-v1.md)
