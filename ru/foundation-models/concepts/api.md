# Особенности реализация API в сервисе {{ foundation-models-full-name }}

Сервис {{ foundation-models-full-name }} предоставляет доступ к различным [фундаментальными моделями](../../glossary/ml-models.md#foundation). Каждая модель имеет свой API.

С помощью {{ yagpt-full-name }} можно выполнять задачи, связанные с генерацией текстового контента. Например, вы можете выбрать [режим взаимодействия с пользователем](../concepts/index.md#working-modes) или оценить размер текстового поля в [токенах](../concepts/yandexgpt/tokens.md). Справочники методов и вызовом API см. в разделах [gRPC](../text-generation/api-ref/grpc/) и [REST](../text-generation/api-ref/).

API {{ foundation-models-name }} спроектированы на основе [механизма gRPC](../../glossary/grpc.md). Для описания методов и структур данных в API используется Protocol Buffers (proto 3).

{{ foundation-models-name }} не поддерживает ресурсо-ориентированный подход, так как не оперирует ресурсами {{ yandex-cloud }}. Запросы к {{ yagpt-full-name }} не идемпотентны.

#### Читайте также {#see-also}

* [Документация gRPC](https://grpc.io/docs/).
* [Документация Protocol Buffers](https://developers.google.com/protocol-buffers/docs/proto3).
* [Концепции API {{ yandex-cloud }}](../../api-design-guide/concepts/general.md#resource-oriented-design).
* [{#T}](../api-ref/migration-to-v1.md).
