---
title: Как начать работать с {{ search-api-full-name }}
description: Следуя данной инструкции, вы сможете настроить ваше рабочее пространство {{ yandex-cloud }} и начать работать с {{ search-api-name }} с помощью интерфейса API v2.
---

# Как начать работать с {{ search-api-name }} через интерфейс API v2

[API v2](../concepts/index.md#api-v2) – рекомендованный интерфейс для работы с {{ search-api-name }}. API v2 полностью интегрирован в [экосистему {{ yandex-cloud }}](../../overview/concepts/services.md) и одновременно с аутентификацией по [API-ключу](../../iam/concepts/authorization/api-key.md) поддерживает более безопасную [аутентификацию](../api-ref/authentication.md) с помощью короткоживущих [IAM-токенов](../../iam/concepts/authorization/iam-token.md).

Стоимость использования {{ search-api-name }} см. в разделе [{#T}](../pricing.md)

## Перед началом работы {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Подготовьте облако к работе {#initial-setup}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого будут выполняться запросы к {{ search-api-name }}.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) созданному сервисному аккаунту [роль](../../search-api/security/index.md#search-api-webSearch-user) `search-api.webSearch.user`.
1. [Создайте](../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), указав для него [область действия](../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.search-api.execute`.
1. Чтобы воспользоваться примерами, установите утилиты [cURL](https://curl.haxx.se) и [jq](https://stedolan.github.io/jq).

В приведенных примерах используется аутентификация с помощью [API-ключа](../../iam/concepts/authorization/api-key.md). Чтобы использовать для аутентификации [IAM-токен](../../iam/concepts/authorization/iam-token.md), измените в примерах запросов заголовок `Authorization`. Подробнее см. в разделе [{#T}](../../search-api/api-ref/authentication.md).

В приведенных примерах запросы к {{ search-api-name }} выполняются с помощью [REST API](../api-ref/). Примеры выполнения запросов с помощью [gPRC API](../api-ref/grpc/) см. в разделе [{#T}](../operations/web-search.md).

## Сформируйте поисковый запрос {#form-request}

Приведенный в примере запрос возвращает страницу с результатами поиска по запросу `кофемашина` в форматах [HTML](../concepts/html-response.md) и [XML](../concepts/response.md).

1. Создайте файл с [телом запроса](../concepts/web-search.md#parameters) (например, `body.json`), указав в поле `folderId` [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором вы будете работать с {{ search-api-name }}:

    {% list tabs group=search_api_request %}

    - HTML {#html}

      **body.json**

      ```json
      {
          "query": {
            "searchType": "SEARCH_TYPE_RU",
            "queryText": "кофемашина"
          },
          "folderId": "<идентификатор_каталога>",
          "responseFormat": "FORMAT_HTML",
          "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 YaBrowser/25.2.0.0 Safari/537.36"
      }
      ```

    - XML {#xml}

      **body.json**

      ```json
      {
          "query": {
            "searchType": "SEARCH_TYPE_RU",
            "queryText": "кофемашина"
          },
          "folderId": "<идентификатор_каталога>",
          "responseFormat": "FORMAT_XML",
          "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 YaBrowser/25.2.0.0 Safari/537.36"
      }
      ```

    {% endlist %}

    Подробнее о параметрах тела запроса см. в разделе [{#T}](../concepts/web-search.md#parameters).
1. Выполните HTTP-запрос к сервису, указав созданный ранее API-ключ и путь к файлу с телом запроса:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Api-Key <API-ключ>" \
        --data "@body.json" \
        "https://searchapi.{{ api-host }}/v2/web/searchAsync"
      ```

      Результат:

      ```text
      {
      "done": false,
      "id": "sprqjo0kf40j********",
      "description": "WEB search async",
      "createdAt": "2025-05-05T18:10:44Z",
      "createdBy": "ajegtlf2q28a********",
      "modifiedAt": "2025-05-05T18:10:44Z"
      }
      ```

      В результате сервис вернет идентификатор [объекта Operation](../../api-design-guide/concepts/operation.md) (значение `id`), по которому можно будет получить результат операции. Сохраните полученный идентификатор – он понадобится позднее.

## Убедитесь в успешном выполнении запроса и получите результат {#verify-operation}

Дождитесь, пока {{ search-api-name }} выполнит запрос и сформирует ответ. На это может потребоваться от нескольких минут до нескольких часов.

Чтобы убедиться в успешном выполнении поискового запроса, выполните HTTP-запрос:

  ```bash
  curl \
    --request GET \
    --header "Authorization: Api-Key <API-ключ>" \
    https://operation.{{ api-host }}/operations/<идентификатор_запроса> \
    > result.json
  ```

  Где:

  * `<API-ключ>` — созданный ранее API-ключ.
  * `<идентификатор_запроса>` — сохраненный на предыдущем шаге идентификатор объекта Operation.

  В файл `result.json` будет сохранен ответ сервиса. Откройте полученный файл, чтобы убедиться, что он содержит поле `done` в значении `true` и поле `response` с результатом выполнения поискового запроса.

## Декодируйте полученный результат {#decode}

Результат выполнения поискового запроса сохранен в поле `response` файла `result.json` в кодировке [Base64](https://ru.wikipedia.org/wiki/Base64). Чтобы декодировать полученный результат, выполните команду:

{% list tabs group=search_api_request %}

- HTML {#html}

  ```bash
  echo "$(< result.json)" | \
    jq -r .response.rawData | \
    base64 --decode > result.html
  ```

  В результате в файл `result.html` будет сохранен HTML-ответ по запросу.

- XML {#xml}

  ```bash
  echo "$(< result.json)" | \
    jq -r .response.rawData | \
    base64 --decode > result.xml
  ```

  В результате в файл `result.xml` будет сохранен XML-ответ по запросу.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../api-ref/authentication.md)
* [{#T}](../operations/web-search.md)
* [{#T}](../operations/web-search-sync.md)
* [{#T}](../concepts/web-search.md)
* [{#T}](../pricing.md)
