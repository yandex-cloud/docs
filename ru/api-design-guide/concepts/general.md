---
title: Основные принципы API {{ yandex-cloud }}
description: Из статьи вы узнаете про основные принципы API {{ yandex-cloud }}, а также ознакомитесь с ресурсо-ориентированным подходом.
---

# Основные принципы

API {{ yandex-cloud }} спроектированы на основе механизма [gRPC](https://grpc.io/docs/). Для описания методов и структур данных в API используется [Protocol Buffers](https://developers.google.com/protocol-buffers/docs/proto3) (proto 3).

Сервисы {{ yandex-cloud }} предоставляют JSON REST интерфейс, к которому можно обращаться напрямую. Поддержка REST осуществляется посредством механизма [gRPC-JSON transcoder](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/grpc_json_transcoder_filter). С его помощью сервисы {{ yandex-cloud }} преобразуют входящие HTTP-запросы в gRPC-вызовы. Результаты обработки запроса сервис преобразует в HTTP-ответ и отправляет его клиенту.

#### Ресурсо-ориентированный подход {#resource-oriented-design}

Для большинства сервисов {{ yandex-cloud }} в API используется ресурсо-ориентированный подход. Принципы такого подхода:

- В качестве ресурсов в API выступают [виртуальные машины](../../glossary/vm.md), диски, образы и т. д. Каждый ресурс имеет [уникальный идентификатор](resources-identification.md).

- Для управления ресурсами в API определены два набора методов:

   {% include [method-sets](../_includes/method-sets.md) %}

- Все операции, изменяющие состояние ресурса, имеют асинхронную сигнатуру. При вызове таких операций сервер возвращает объект [Operation](operation.md). Этот объект будет содержать состояние операции, а также идентификатор ресурса, над которым производится операция.

- Операции на создание, изменение и удаление ресурсов поддерживают механизм [идемпотентности](idempotency.md).


#### Исключения для ресурсо-ориентированного подхода {#exceptions}

- [API {{ objstorage-full-name }}](../../storage/s3/index.md). Его архитектура обеспечивает совместимость с Amazon S3 API, поэтому принципы API {{ objstorage-name }} не всегда совпадают с принципами ресурсо-ориентированного подхода. Подробнее читайте в документации к сервису.
- API сервисов искусственного интеллекта [{{ foundation-models-full-name }}](../../foundation-models/concepts/api.md), [{{ speechkit-full-name }}](../../speechkit/concepts/api.md), [{{ translate-full-name }}](../../translate/api-ref/grpc/) и [{{ vision-full-name }}](../../vision/vision/api-ref/grpc/). Их API не оперирует ресурсами {{ yandex-cloud }}, запросы не идемпотентны.


#### См. также {#see-also}
- [Ссылка на .proto-спецификации API {{ yandex-cloud }}](https://github.com/yandex-cloud/cloudapi)


