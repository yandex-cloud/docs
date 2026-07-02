[Документация Yandex Cloud](../../index.md) > [Концепции API Yandex Cloud](../index.md) > Основные принципы

# Основные принципы

API Yandex Cloud спроектированы на основе механизма [gRPC](https://grpc.io/docs/). Для описания методов и структур данных в API используется [Protocol Buffers](https://developers.google.com/protocol-buffers/docs/proto3) (proto 3).

Сервисы Yandex Cloud предоставляют JSON REST интерфейс, к которому можно обращаться напрямую. Поддержка REST осуществляется посредством механизма [gRPC-JSON transcoder](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/grpc_json_transcoder_filter). С его помощью сервисы Yandex Cloud преобразуют входящие HTTP-запросы в gRPC-вызовы. Результаты обработки запроса сервис преобразует в HTTP-ответ и отправляет его клиенту.

#### Ресурсо-ориентированный подход {#resource-oriented-design}

Для большинства сервисов Yandex Cloud в API используется ресурсо-ориентированный подход. Принципы такого подхода:

- В качестве ресурсов в API выступают [виртуальные машины](../../glossary/vm.md), диски, образы и т. д. Каждый ресурс имеет [уникальный идентификатор](resources-identification.md).

- Для управления ресурсами в API определены два набора методов:

   * [Стандартные методы API](standard-methods.md) позволяют выполнять CRUD-операции: создавать, получать, изменять и удалять ресурсы. Стандартные методы имеют одинаковую сигнатуру и работают одинаково для всех API, где они используются.
   * [Дополнительные методы API](custom-methods.md) расширяют функциональность стандартных методов. С их помощью можно выполнить такие операции, как подключить диск, перезапустить виртуальную машину и др. Сигнатура дополнительных методов отличается от сигнатуры стандартных методов.

- Все операции, изменяющие состояние ресурса, имеют асинхронную сигнатуру. При вызове таких операций сервер возвращает объект [Operation](operation.md). Этот объект будет содержать состояние операции, а также идентификатор ресурса, над которым производится операция.

- Операции на создание, изменение и удаление ресурсов поддерживают механизм [идемпотентности](idempotency.md).


#### Исключения для ресурсо-ориентированного подхода {#exceptions}

- [API Yandex Object Storage](../../storage/s3/index.md). Его архитектура обеспечивает совместимость с Amazon S3 API, поэтому принципы API Object Storage не всегда совпадают с принципами ресурсо-ориентированного подхода. Подробнее читайте в документации к сервису.
- API сервисов искусственного интеллекта [Yandex AI Studio](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/api), [Yandex SpeechKit](https://aistudio.yandex.ru/docs/ru/speechkit/concepts/api), [Yandex Translate](https://aistudio.yandex.ru/docs/ru/translate/api-ref/grpc/) и [Yandex Vision OCR](https://aistudio.yandex.ru/docs/ru/vision/ocr/api-ref/grpc/). Их API не оперирует ресурсами Yandex Cloud, запросы не идемпотентны.


#### Полезные ссылки {#see-also}
- [Ссылка на .proto-спецификации API Yandex Cloud](https://github.com/yandex-cloud/cloudapi)