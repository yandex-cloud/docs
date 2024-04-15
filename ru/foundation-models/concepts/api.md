# Особенности реализации API в сервисе {{ foundation-models-full-name }}

Сервис {{ foundation-models-full-name }} предоставляет доступ к различным [фундаментальными моделями](../../glossary/ml-models.md#foundation). Каждая модель имеет свой API.

API {{ foundation-models-name }} спроектированы на основе [механизма gRPC](../../glossary/grpc.md). Для описания методов и структур данных в API используется Protocol Buffers (proto 3).

Сервис {{ foundation-models-name }} не поддерживает ресурсо-ориентированный подход, так как не оперирует ресурсами {{ yandex-cloud }}. Запросы к {{ yagpt-full-name }} не идемпотентны.

#### Читайте также {#see-also}

* [Документация gRPC](https://grpc.io/docs/).
* [Документация Protocol Buffers](https://developers.google.com/protocol-buffers/docs/proto3).
* [Концепции API {{ yandex-cloud }}](../../api-design-guide/concepts/general.md#resource-oriented-design).
* [{#T}](../api-ref/migration-to-v1.md).
