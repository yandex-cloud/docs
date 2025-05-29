---
title: Как выполнять поиск в {{ search-api-full-name }} с помощью API v2 в синхронном режиме
description: Следуя данной инструкции, вы научитесь использовать интерфейс API v2 сервиса {{ search-api-name }} для отправки поисковых запросов и получения поисковой выдачи в формате XML или HTML в синхронном режиме.
---

# Выполнение поисковых запросов с помощью API v2 в синхронном режиме

[API v2](../concepts/index.md#api-v2) сервиса {{ search-api-name }} позволяет выполнять текстовый поиск в поисковой базе Яндекса и получать результат поиска в формате [XML](../concepts/response.md) или [HTML](../concepts/html-response.md) в синхронном режиме. Выполнять запросы можно с помощью [REST API](../api-ref/) и [gPRC API](../api-ref/grpc/). Поисковая выдача зависит от заданных в запросе параметров.

## Перед началом работы {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

Чтобы воспользоваться примерами, установите утилиты [cURL](https://curl.haxx.se) и [jq](https://stedolan.github.io/jq), а также [gRPCurl](https://github.com/fullstorydev/grpcurl) (если будете использовать [gRPC API](../api-ref/grpc/)).


## Подготовьте облако к работе {#initial-setup}

{% include [prepare-cloud-v2](../../_includes/search-api/prepare-cloud-v2.md) %}

## Выполните поисковый запрос {#execute-request}

1. Отправьте запрос и получите результат в кодировке Base64:

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
        "https://searchapi.{{ api-host }}/v2/web/search" \
        > result.json
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
            searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WebSearchService/Search \
            > result.json
          ```

    {% endlist %}

    В результате в файл `result.json` будет сохранен результат выполнения поискового запроса, содержащий в поле `rawData` [XML](../concepts/response.md) или [HTML](../concepts/html-response.md) ответ в кодировке [Base64](https://ru.wikipedia.org/wiki/Base64).

1. В зависимости от запрошенного формата ответа, декодируйте результат из формата `Base64`:

    {% list tabs group=search_api_request %}

    - XML {#xml}

      ```bash
      echo "$(< result.json)" | \
        jq -r .rawData | \
        base64 --decode > result.xml
      ```

      В результате в файл `result.xml` будет сохранен XML-ответ по запросу.

    - HTML {#html}

      ```bash
      echo "$(< result.json)" | \
        jq -r .rawData | \
        base64 --decode > result.html
      ```

      В результате в файл `result.html` будет сохранен HTML-ответ по запросу.

    {% endlist %}

#### См. также {#see-also}

* [{#T}](./web-search.md)
* [{#T}](../concepts/web-search.md)
* [{#T}](../api-ref/authentication.md)
* [{#T}](../concepts/response.md)
* [{#T}](../concepts/html-response.md)