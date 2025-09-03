---
title: Поисковые запросы через API v2 сервиса {{ search-api-full-name }}
description: В данном разделе вы узнаете об особенностях использования и формате поисковых запросов при обращении к сервису {{ search-api-name }} через интерфейс API v2.
---

# Текстовый поиск

Интерфейс API v2 сервиса {{ search-api-name }} позволяет выполнять запросы к поисковой базе Яндекса с получением ответа в [синхронном](#sync-mode) или [отложенном](#async-mode) режиме. Поисковая выдача зависит от заданных в запросе [параметров](#parameters).

Выполнять запросы может пользователь или [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которому назначена [роль](../security/index.md#search-api-webSearch-user) `search-api.webSearch.user`.

В зависимости от заданных параметров запроса, результат возвращается в формате [XML](./response.md) или [HTML](./html-response.md).

## Формат тела запроса {#parameters}

{% include [rest-grpc-fields-differ](../../_includes/search-api/rest-grpc-fields-differ.md) %}

{% list tabs group=instructions %}

- REST API {#api}

  {% include [http-body-v2](../../_includes/search-api/http-body-v2.md) %}

  Где:

  {% include [http-v2-body-params](../../_includes/search-api/http-v2-body-params.md) %}

- gRPC API {#grpc-api}

  {% include [grpc-body-v2](../../_includes/search-api/grpc-body-v2.md) %}

  Где:

  {% include [grpc-v2-body-params](../../_includes/search-api/grpc-v2-body-params.md) %}

{% endlist %}

## Синхронный режим поиска {#sync-mode}

В синхронном режиме запросы можно [выполнять](../operations/web-search-sync.md) с помощью [REST API](../api-ref/) и [gRPC API](../api-ref/grpc/).

В ответ на запрос в синхронном режиме сервис {{ search-api-name }} в зависимости от заданных [параметров](#parameters) запроса возвращает результат в формате [XML](./response.md) или [HTML](./html-response.md). Результат возвращается в поле `rawData` ответа в кодировке [Base64](https://ru.wikipedia.org/wiki/Base64).

{% include [empty-response-notice](../../_includes/search-api/empty-response-notice.md) %}

## Отложенный (асинхронный) режим поиска {#async-mode}

В отложенном режиме запросы можно [выполнять](../operations/web-search.md) с помощью [REST API](../api-ref/) и [gRPC API](../api-ref/grpc/). 

В ответ на отложенный запрос {{ search-api-name }} возвращает [объект Operation](#response-format), содержащий информацию об операции: статус, идентификатор, время вызова и т.д. 

Зная идентификатор объекта Operation, вы можете [отследить](../operations/web-search.md#verify-operation) статус обработки запроса, а также [получить результат](../operations/web-search.md#get-response) по завершении обработки.

В зависимости от заданных [параметров](#parameters) запроса [результат](#response-format) возвращается в поле `response.rawData` ответа в формате [XML](./response.md) или [HTML](./html-response.md).

### Формат ответа при асинхронном поиске {#response-format}

В ответ на отложенный запрос {{ search-api-name }} возвращает [объект Operation](../../api-design-guide/concepts/operation.md) в следующем формате:

{% include [empty-response-notice](../../_includes/search-api/empty-response-notice.md) %}

{% list tabs group=instructions %}

- REST API {#api}

  ```json
  {
   "done": true,
   "response": {
    "@type": "type.googleapis.com/yandex.cloud.searchapi.v2.WebSearchResponse",
    "rawData": "<тело_XML_ответа_в_кодировке_Base64>"
   },
   "id": "<идентификатор_объекта_operation>",
   "description": "WEB search async",
   "createdAt": "2024-10-03T08:07:07Z",
   "createdBy": "<идентификатор_субъекта>",
   "modifiedAt": "2024-10-03T08:12:09Z"
  }
  ```

- gRPC API {#grpc-api}

  ```json
  {
    "id": "<идентификатор_объекта_operation>",
    "description": "WEB search async",
    "createdAt": "2024-10-03T08:07:07Z",
    "createdBy": "<идентификатор_субъекта>",
    "modifiedAt": "2024-10-03T08:12:09Z",
    "done": true,
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.searchapi.v2.WebSearchResponse",
      "rawData": "<тело_XML_ответа_в_кодировке_Base64>"
    }
  }
  ```

{% endlist %}

Объект `response` внутри [объекта Operation](../../api-design-guide/concepts/operation.md) становится доступен только после того, как запрос был выполнен на стороне {{ search-api-name }}, а значение поля `done` (статус операции) изменилось на `true`.

Значение поля `rawData` объекта `response` в зависимости от параметров запроса содержит [XML](./response.md) или [HTML](./html-response.md) ответ в кодировке [Base64](https://ru.wikipedia.org/wiki/Base64).

Подробнее об объекте Operation и его полях см. в разделе [{#T}](../../api-design-guide/concepts/operation.md).

#### См. также {#see-also}

* [{#T}](../operations/web-search-sync.md)
* [{#T}](../operations/web-search.md)
* [{#T}](./response.md)
* [{#T}](../api-ref/authentication.md)
* [{#T}](../security/index.md)