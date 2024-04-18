# Specifics of API implementation in {{ foundation-models-full-name }}

{{ foundation-models-full-name }} provides access to various fundamental models. Each model has its own API.

Use {{ yagpt-full-name }} to perform tasks related to generating text content. For instance, you can select [user interaction mode](../concepts/index.md#working-modes) or estimate the size of a text field in [tokens](../concepts/yandexgpt/tokens.md). For API method and call references, see [gRPC](../text-generation/api-ref/grpc/) and [REST](../text-generation/api-ref/).

{{ foundation-models-name }} APIs are designed based on gRPC. API methods and data structures are described using Protocol Buffers (proto 3).

{{ foundation-models-name }} does not support a resource-based approach, since it does not use {{ yandex-cloud }} resources. Requests to {{ yagpt-full-name }} are not idempotent.

#### See also {#see-also}

* [gRPC documentation](https://grpc.io/docs/)
* [Protocol Buffers documentation](https://developers.google.com/protocol-buffers/docs/proto3)
* [{{ yandex-cloud }} API concepts](../../api-design-guide/concepts/general.md#resource-oriented-design)
* [{#T}](../api-ref/migration-to-v1.md)
