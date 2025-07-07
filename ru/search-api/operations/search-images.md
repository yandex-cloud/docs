---
title: Как искать изображения в {{ search-api-name }} по текстовому описанию с помощью интерфейса API v2
description: Следуя данной инструкции, вы научитесь использовать интерфейс API v2 сервиса {{ search-api-full-name }} для отправки текстовых поисковых запросов и получения поисковой выдачи в формате XML или HTML в отложенном (асинхронном) режиме.
---

# Поиск изображений по текстовому описанию с помощью API v2

[API v2](../concepts/index.md#api-v2) сервиса {{ search-api-name }} позволяет искать изображения по текстовым описаниям в индексе [Яндекс Картинок](https://yandex.ru/images) и получать результат поиска в [формате XML](../concepts/image-search.md#xml-response-format). Выполнять запросы можно с помощью [REST API](../api-ref/) и [gPRC API](../api-ref/grpc/). Поисковая выдача зависит от заданных в запросе параметров.

## Перед началом работы {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

Чтобы воспользоваться примерами, установите утилиты [cURL](https://curl.haxx.se) и [jq](https://stedolan.github.io/jq), а также [gRPCurl](https://github.com/fullstorydev/grpcurl) (если будете использовать [gRPC API](../api-ref/grpc/)).

## Подготовьте облако к работе {#initial-setup}

{% include [prepare-cloud-v2](../../_includes/search-api/prepare-cloud-v2.md) %}

## Выполните поисковый запрос {#execute-request}

1. Отправьте запрос и получите результат в кодировке [Base64](https://ru.wikipedia.org/wiki/Base64):

    {% list tabs group=instructions %}

    - REST API {#api}

      1. Создайте файл с телом запроса (например, `body.json`):

          **body.json**

          {% include [http-body-imagesearch](../../_includes/search-api/http-body-imagesearch.md) %}

          {% cut "Описание полей" %}

          {% include [http-body-params-imagesearch](../../_includes/search-api/http-body-params-imagesearch.md) %}

          {% endcut %}

          {% cut "Пример тела запроса" %}

          **body.json**

          ```json
          {
            "query": {
              "searchType": "SEARCH_TYPE_RU",
              "queryText": "котики"
            },
            "folderId": "b1gt6g8ht345********"
          }
          ```

          {% endcut %}

      1. Выполните HTTP-запрос, указав полученный ранее IAM-токен и путь к файлу с телом запроса:

          ```bash
          curl \
            --request POST \
            --header "Authorization: Bearer <IAM-токен>" \
            --data "@body.json" \
            "https://searchapi.{{ api-host }}/v2/image/search" \
            > result.json
          ```

    - gRPC API {#grpc-api}

      1. Создайте файл с телом запроса (например, `body.json`):

          **body.json**

          {% include [grpc-body-imagesearch](../../_includes/search-api/grpc-body-imagesearch.md) %}

          {% cut "Описание полей" %}

          {% include [grpc-body-params-imagesearch](../../_includes/search-api/grpc-body-params-imagesearch.md) %}

          {% endcut %}

          {% cut "Пример тела запроса" %}

          **body.json**

          ```json
          {
            "query": {
              "search_type": "SEARCH_TYPE_RU",
              "query_text": "котики"
            },
            "folder_id": "b1gt6g8ht345********"
          }
          ```

          {% endcut %}

      1. Выполните gRPC-вызов, указав полученный ранее IAM-токен и путь к файлу с телом запроса:

          ```bash
          grpcurl \
            -rpc-header "Authorization: Bearer <IAM-токен>" \
            -d @ < body.json \
            searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.ImageSearchService/Search \
            > result.json
          ```

    {% endlist %}

    В файл `result.json` будет сохранен результат выполнения поискового запроса, в поле `rawData` содержащий [XML-ответ](../concepts/image-search.md#xml-response-format) в кодировке Base64.

1. Декодируйте результат из формата `Base64`:

    ```bash
    echo "$(< result.json)" | \
      jq -r .rawData | \
      base64 --decode > result.xml
    ```

    В результате в файл `result.xml` будет сохранен [XML-ответ](../concepts/image-search.md#xml-response-format) по запросу.

#### См. также {#see-also}

* [{#T}](./search-images-by-pic.md)
* [{#T}](../concepts/image-search.md)
* [{#T}](../api-ref/authentication.md)