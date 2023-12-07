# API {{ translate-full-name }}

С помощью API {{ translate-name }} можно реализовать машинный перевод текста. О том, как использовать API, читайте в [инструкциях](../operations/index.md).

API {{ translate-name }} спроектирован на основе механизма gRPC. Для описания методов и структур данных в API используется Protocol Buffers (proto 3).

API {{ translate-name }} не поддерживает ресурсо-ориентированный подход, так как не оперирует ресурсами {{ yandex-cloud }}. Запросы API {{ translate-name }} не идемпотентны.

#### Читайте также {#see-also}

* [Документация gRPC](https://grpc.io/docs/).
* [Документация Protocol Buffers](https://developers.google.com/protocol-buffers/docs/proto3).
* [Концепции API {{ yandex-cloud }}](../../api-design-guide/concepts/general.md#resource-oriented-design).
