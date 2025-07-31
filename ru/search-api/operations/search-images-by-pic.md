---
title: Как искать изображения в {{ search-api-name }} по изображению с помощью интерфейса API v2
description: Следуя данной инструкции, вы научитесь использовать интерфейс API v2 сервиса {{ search-api-full-name }} для отправки поисковых запросов на поиск изображений по исходному изображению.
---

# Поиск изображений по заданному изображению с помощью API v2

[API v2](../concepts/index.md#api-v2) сервиса {{ search-api-name }} позволяет искать изображения по заданному изображению в индексе [Яндекс Картинок](https://yandex.ru/images) и получать результат поиска в [формате JSON](../concepts/image-search.md#json-response-format). Выполнять запросы можно с помощью [REST API](../api-ref/) и [gRPC API](../api-ref/grpc/). Поисковая выдача зависит от заданных в [запросе](../concepts/image-search.md#request-body-by-pic) параметров.

## Перед началом работы {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

Чтобы воспользоваться примерами, установите утилиты [cURL](https://curl.haxx.se) и [gRPCurl](https://github.com/fullstorydev/grpcurl) (если будете использовать [gRPC API](../api-ref/grpc/)).

## Подготовьте облако к работе {#initial-setup}

{% include [prepare-cloud-v2](../../_includes/search-api/prepare-cloud-v2.md) %}

## Выполните поисковый запрос {#execute-request}

{% list tabs group=instructions %}

- REST API {#api}

  1. Создайте файл с телом запроса (например, `body.json`):

      **body.json**

      {% include [http-body-image-bypic-search](../../_includes/search-api/http-body-image-bypic-search.md) %}

      {% cut "Описание полей" %}

      {% include [http-body-params-image-bypic-search](../../_includes/search-api/http-body-params-image-bypic-search.md) %}

      {% endcut %}

      {% cut "Пример тела запроса" %}

      **body.json**

      ```json
      {
        "folderId": "b1gt6g8ht345********",
        "data": "<закодированное_в_base64_изображение>",
        "page": "1"
      }
      ```

      {% endcut %}

  1. Выполните HTTP-запрос, указав полученный ранее IAM-токен и путь к файлу с телом запроса:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer <IAM-токен>" \
        --data "@body.json" \
        "https://searchapi.{{ api-host }}/v2/image/search_by_image" \
        > result.json
      ```

- gRPC API {#grpc-api}

  1. Создайте файл с телом запроса (например, `body.json`):

      **body.json**

      {% include [grpc-body-image-bypic-search](../../_includes/search-api/grpc-body-image-bypic-search.md) %}

      {% cut "Описание полей" %}

      {% include [grpc-body-params-image-bypic-search](../../_includes/search-api/grpc-body-params-image-bypic-search.md) %}

      {% endcut %}

      {% cut "Пример тела запроса" %}

      **body.json**

      ```json
      {
        "folder_id": "b1gt6g8ht345********",
        "data": "<закодированное_в_base64_изображение>",
        "page": "1"
      }
      ```

      {% endcut %}

  1. Выполните gRPC-вызов, указав полученный ранее IAM-токен и путь к файлу с телом запроса:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM-токен>" \
        -d @ < body.json \
        searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.ImageSearchService/SearchByImage \
        > result.json
      ```

{% endlist %}

В файл `result.json` будут сохранены результаты поиска в [формате JSON](../concepts/image-search.md#json-response-format).

#### См. также {#see-also}

* [{#T}](./search-images.md)
* [{#T}](../concepts/image-search.md)
* [{#T}](../api-ref/authentication.md)