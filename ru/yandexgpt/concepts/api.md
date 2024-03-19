# Особенности реализация API в сервисе {{ yagpt-full-name }}

С помощью {{ yagpt-full-name }} можно выполнять задачи, связанные с генерацией текстового контента. Например, вы можете выбрать [режим взаимодействия с пользователем](../concepts/index.md#working-modes) или оценить размер текстового поля в [токенах](../concepts/tokens.md). Справочники методов и вызовом API см. в разделах [gRPC](../text-generation/api-ref/grpc/) и [REST](../text-generation/api-ref/).

API {{ yagpt-name }} спроектирован на основе механизма gRPC. Для описания методов и структур данных в API используется Protocol Buffers (proto 3).

{{ yagpt-full-name }} не поддерживает ресурсо-ориентированный подход, так как не оперирует ресурсами {{ yandex-cloud }}. Запросы {{ yagpt-full-name }} не идемпотентны.

#### Читайте также {#see-also}

* [Документация gRPC](https://grpc.io/docs/).
* [Документация Protocol Buffers](https://developers.google.com/protocol-buffers/docs/proto3).
* [Концепции API {{ yandex-cloud }}](../../api-design-guide/concepts/general.md#resource-oriented-design).
