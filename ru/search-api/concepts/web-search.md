---
title: Отложенный режим выполнения поисковых запросов в {{ search-api-full-name }}
description: В данном разделе вы узнаете об отложенных поисковых запросах в сервисе {{ search-api-name }}.
---

# Отложенный режим выполнения поисковых запросов в {{ search-api-name }}

_Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md)._

{{ search-api-name }} позволяет выполнять запросы к поисковой базе Яндекса с получением ответа в отложенном режиме. Выполнять запросы можно с помощью [REST API](../api-ref/) и [gPRC API](../api-ref/grpc/) сервиса {{ search-api-name }}. Поисковая выдача зависит от заданных в запросе [параметров](#parameters).

[Выполнять запросы](../operations/web-search.md) может пользователь или [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которому назначена [роль](../../iam/concepts/access-control/roles.md) `search-api.webSearch.user`.

В ответ на отложенный запрос {{ search-api-name }} возвращает [объект Operation](#response-format), содержащий информацию об операции: статус, идентификатор, время вызова и т.д. 

Зная идентификатор объекта Operation, вы можете [отследить](../operations/web-search.md#verify-operation) статус обработки запроса, а также [получить результат](../operations/web-search.md#get-response) по завершении обработки.

## Формат тела запроса {#parameters}

Имена полей тела запроса различаются в [REST API](../api-ref/) и [gPRC API](../api-ref/grpc/): в REST API используется [CamelCase](https://ru.wikipedia.org/wiki/CamelCase), в gPRC API — [snake_case](https://ru.wikipedia.org/wiki/Snake_case).

{% list tabs group=api_type %}

- REST API {#rest-api}

  {% include [http-body-v2](../../_includes/search-api/http-body-v2.md) %}

  Где:

  {% include [http-v2-body-params](../../_includes/search-api/http-v2-body-params.md) %}

- gRPC API {#grpc-api}

  {% include [grpc-body-v2](../../_includes/search-api/grpc-body-v2.md) %}

  Где:

  {% include [grpc-v2-body-params](../../_includes/search-api/grpc-v2-body-params.md) %}

{% endlist %}

## Формат ответа {#response-format}

В ответ на отложенный запрос {{ search-api-name }} возвращает [объект Operation](../../api-design-guide/concepts/operation.md) в следующем формате:

{% list tabs group=api_type %}

- REST API {#rest-api}

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

Значение поля `rawData` объекта `response` содержит [XML-ответ](./response.md) в кодировке [Base64](https://ru.wikipedia.org/wiki/Base64).

Подробнее об объекте Operation и его полях см. в разделе [{#T}](../../api-design-guide/concepts/operation.md).

#### См. также {#see-also}

* [{#T}](../operations/web-search.md)
* [{#T}](./response.md)
* [{#T}](../api-ref/authentication.md)
* [{#T}](../security/index.md)