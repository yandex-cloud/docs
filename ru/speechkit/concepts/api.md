# API {{ speechkit-name }}

С помощью API {{ speechkit-name }} можно [распознать](../stt-v3/api-ref/grpc/) и [синтезировать](../tts-v3/api-ref/grpc/) речь. Примеры использования API приведены в [практических руководствах](../tutorials/index.md).

API {{ speechkit-name }} спроектирован на основе механизма gRPC. Для описания методов и структур данных в API используется Protocol Buffers (proto 3).

API {{ speechkit-name }} не поддерживает ресурсо-ориентированный подход, так как не оперирует ресурсами {{ yandex-cloud }}. Запросы API {{ speechkit-name }} не идемпотентны.

## Примеры использования {#examples}

* [{#T}](../tutorials/recognizer-bot.md)
* [{#T}](../tutorials/speechkit-integrarion-via-agi-gw.md)
* [{#T}](../tutorials/batch-recognition-stt.md)

#### Читайте также {#see-also}

* [Документация gRPC](https://grpc.io/docs/).
* [Документация Protocol Buffers](https://developers.google.com/protocol-buffers/docs/proto3).
* [Концепции API {{ yandex-cloud }}](../../api-design-guide/concepts/general.md#resource-oriented-design).
