---
title: Как выполнять поиск в {{ search-api-full-name }} с помощью API v2 в отложенном режиме
description: Следуя данной инструкции, вы научитесь использовать интерфейс API v2 сервиса {{ search-api-name }} для отправки поисковых запросов и получения поисковой выдачи в формате XML или HTML в отложенном (асинхронном) режиме.
---

# Выполнение поисковых запросов с помощью API v2 в отложенном режиме

[API v2](../concepts/index.md#api-v2) сервиса {{ search-api-name }} позволяет выполнять текстовый поиск в поисковой базе Яндекса и получать результат поиска в формате [XML](../concepts/response.md) или [HTML](../concepts/html-response.md) в отложенном (асинхронном) режиме. Выполнять запросы можно с помощью [REST API](../api-ref/) и [gPRC API](../api-ref/grpc/). Поисковая выдача зависит от заданных в запросе параметров.

## Перед началом работы {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

Чтобы воспользоваться примерами, установите утилиты [cURL](https://curl.haxx.se) и [jq](https://stedolan.github.io/jq), а также [gRPCurl](https://github.com/fullstorydev/grpcurl) (если будете использовать [gRPC API](../api-ref/grpc/)).

## Подготовьте облако к работе {#initial-setup}

{% include [prepare-cloud-v2](../../_includes/search-api/prepare-cloud-v2.md) %}

## Сформируйте поисковый запрос {#form-request}

{% list tabs group=instructions %}

- REST API {#api}

  1. Создайте файл с телом запроса (например, `body.json`):

      **body.json**

      {% include [http-body-v2](../../_includes/search-api/http-body-v2.md) %}

      {% cut "Описание полей" %}

      {% include [http-v2-body-params](../../_includes/search-api/http-v2-body-params.md) %}

      {% endcut %}

  1. Выполните HTTP-запрос, указав полученный ранее IAM-токен:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer <IAM-токен>" \
        --data "@body.json" \
        "https://searchapi.{{ api-host }}/v2/web/searchAsync"
      ```

      Результат:

      ```text
      {
       "done": false,
       "id": "sppger465oq1********",
       "description": "WEB search async",
       "createdAt": "2024-10-02T19:51:02Z",
       "createdBy": "bfbud0oddqp4********",
       "modifiedAt": "2024-10-02T19:51:03Z"
      }
      ```

- gRPC API {#grpc-api}

  1. Создайте файл с телом запроса (например, `body.json`):

      **body.json**

      {% include [grpc-body-v2](../../_includes/search-api/grpc-body-v2.md) %}

      {% cut "Описание полей" %}

      {% include [grpc-v2-body-params](../../_includes/search-api/grpc-v2-body-params.md) %}

      {% endcut %}

  1. Выполните gRPC-вызов, указав полученный ранее IAM-токен:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM-токен>" \
        -d @ < body.json \
        searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WebSearchAsyncService/Search
      ```

      Результат:

      ```text
      {
        "id": "spp3gp3vhna6********",
        "description": "WEB search async",
        "createdAt": "2024-10-02T19:14:41Z",
        "createdBy": "bfbud0oddqp4********",
        "modifiedAt": "2024-10-02T19:14:42Z"
      }
      ```

{% endlist %}

Сохраните идентификатор полученного [объекта Operation](../../api-design-guide/concepts/operation.md) (значение `id`) — он понадобится позднее.

## Убедитесь в успешном выполнении запроса {#verify-operation}

Дождитесь, пока {{ search-api-name }} выполнит запрос и сформирует ответ. На это может потребоваться от пяти минут до нескольких часов.

Чтобы убедиться в успешном выполнении запроса:

{% list tabs group=instructions %}

- REST API {#api}

  Выполните HTTP-запрос:

  ```bash
  curl \
    --request GET \
    --header "Authorization: Bearer <IAM-токен>" \
    https://operation.{{ api-host }}/operations/<идентификатор_запроса>
  ```

  Где:

  * `<IAM-токен>` — полученный ранее IAM-токен.
  * `<идентификатор_запроса>` — сохраненный на предыдущем шаге идентификатор объекта Operation.

  Результат:

  ```text
  {
   "done": true,
   "response": {
    "@type": "type.googleapis.com/yandex.cloud.searchapi.v2.WebSearchResponse",
    "rawData": "<тело_XML_ответа_в_кодировке_Base64>"
   },
   "id": "spp82pc07ebl********",
   "description": "WEB search async",
   "createdAt": "2024-10-03T08:07:07Z",
   "createdBy": "bfbud0oddqp4********",
   "modifiedAt": "2024-10-03T08:12:09Z"
  }
  ```

- gRPC API {#grpc-api}

  Выполните gRPC-вызов:

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM-токен>" \
    -d '{"operation_id": "<идентификатор_запроса>"}' \
    operation.{{ api-host }}:443 yandex.cloud.operation.OperationService/Get
  ```

  Где:

  * `<IAM-токен>` — полученный ранее IAM-токен.
  * `<идентификатор_запроса>` — сохраненный на предыдущем шаге идентификатор объекта Operation.

  Результат:

  ```text
  {
    "id": "spp82pc07ebl********",
    "description": "WEB search async",
    "createdAt": "2024-10-03T08:07:07Z",
    "createdBy": "bfbud0oddqp4********",
    "modifiedAt": "2024-10-03T08:12:09Z",
    "done": true,
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.searchapi.v2.WebSearchResponse",
      "rawData": "<тело_XML_ответа_в_кодировке_Base64>"
    }
  }
  ```

{% endlist %}

Если поле `done` имеет значение `true`, и в выводе присутствует объект `response`, значит, запрос выполнен, и вы можете переходить к следующему шагу. В противном случае, повторите проверку через некоторое время.

## Получите ответ {#get-response}

После того как сервис {{ search-api-name }} успешно обработал запрос:

1. Получите результат:

    {% list tabs group=instructions %}

    - REST API {#api}

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer <IAM-токен>" \
        https://operation.{{ api-host }}/operations/<идентификатор_запроса> \
        > result.json
      ```

    - gRPC API {#grpc-api}

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM-токен>" \
        -d '{"operation_id": "<идентификатор_запроса>"}' \
        operation.{{ api-host }}:443 yandex.cloud.operation.OperationService/Get \
        > result.json
      ```

    {% endlist %}

    В итоге в файл `result.json` будет сохранен результат выполнения поискового запроса, содержащий в поле `response.rawData` [XML](../concepts/response.md) или [HTML](../concepts/html-response.md) ответ в кодировке [Base64](https://ru.wikipedia.org/wiki/Base64).

1. В зависимости от запрошенного формата ответа, декодируйте результат из формата `Base64`:

    {% list tabs group=search_api_request %}

    - XML {#xml}

      ```bash
      echo "$(< result.json)" | \
        jq -r .response.rawData | \
        base64 --decode > result.xml
      ```

      В результате в файл `result.xml` будет сохранен XML-ответ по запросу.

    - HTML {#html}

      ```bash
      echo "$(< result.json)" | \
        jq -r .response.rawData | \
        base64 --decode > result.html
      ```

      В результате в файл `result.html` будет сохранен HTML-ответ по запросу.

    {% endlist %}

#### См. также {#see-also}

* [{#T}](./web-search-sync.md)
* [{#T}](../concepts/web-search.md)
* [{#T}](../api-ref/authentication.md)
* [{#T}](../concepts/response.md)
* [{#T}](../concepts/html-response.md)