# Основные принципы

API {{ yandex-cloud }} спроектированы на основе механизма [gRPC](https://grpc.io/docs/). Для описания методов и структур данных в API используется [Protocol Buffers](https://developers.google.com/protocol-buffers/docs/proto3) (proto 3).

Сервисы {{ yandex-cloud }} предоставляют JSON REST интерфейс, к которому можно обращаться напрямую. Поддержка REST осуществляется посредством механизма [gRPC-JSON transcoder](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/grpc_json_transcoder_filter). С его помощью сервисы {{ yandex-cloud }} преобразуют входящие HTTP-запросы в gRPC-вызовы. Результаты обработки запроса сервис преобразует в HTTP-ответ и отправляет его клиенту.

#### Ресурсо-ориентированный подход {#resource-oriented-design}

В API используется ресурсо-ориентированный подход. Ниже описаны принципы, которые действуют для всех API {{ yandex-cloud }}:

- В качестве ресурсов в API выступают виртуальные машины, диски, образы и т. д. Каждый ресурс имеет [уникальный идентификатор](resources-identification.md).

- Для управления ресурсами в API определены два набора методов:

   {% include [method-sets](../_includes/method-sets.md) %}

- Все операции, изменяющие состояние ресурса, имеют асинхронную сигнатуру. При вызове таких
 операций сервер возвращает объект [Operation](operation.md). Этот объект будет содержать состояние операции, а также идентификатор ресурса, над которым производится операция.

- Операции на создание, изменение и удаление ресурсов поддерживают механизм [идемпотентности](idempotency.md).

{% note info %}

Архитектура [Yandex Object Storage API](../../storage/s3/index.md) обеспечивает совместимость с Amazon S3 API. Поэтому Object Storage API может не соответствовать концепциям, описанным в данном документе. Подробнее читайте в документации к сервису.

{% endnote %}

#### См. также {#see-also}
- [Ссылка на .proto-спецификации API {{ yandex-cloud }}](https://github.com/yandex-cloud/cloudapi)


