---
title: Как начать работать с {{ search-api-full-name }}
description: Следуя данной инструкции, вы сможете настроить ваше рабочее пространство {{ yandex-cloud }} и начать работать с {{ search-api-full-name }}.
---

# Как начать работать с {{ search-api-name }}

Сервис [{{ search-api-full-name }}](../concepts/index.md) полностью интегрирован в [экосистему {{ yandex-cloud }}](../../overview/concepts/services.md) и одновременно с аутентификацией по [API-ключу](../../iam/concepts/authorization/api-key.md) поддерживает более безопасную [аутентификацию](../api-ref/authentication.md) с помощью короткоживущих [IAM-токенов](../../iam/concepts/authorization/iam-token.md).

Выполнять запросы к {{ search-api-name }} вы можете с помощью [{{ ml-sdk-full-name }}](../../ai-studio/sdk/index.md), [REST API](../api-ref/index.md) и [gRPC API](../api-ref/grpc/index.md). Поисковая выдача зависит от заданных в запросе параметров.

Стоимость использования {{ search-api-name }} см. в разделе [{#T}](../pricing.md).

## Перед началом работы {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Подготовьте облако к работе {#initial-setup}

Чтобы воспользоваться примерами:

{% list tabs group=instructions %}

- SDK {#sdk}

  1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../security/index.md#search-api-webSearch-user) `search-api.webSearch.user`.
  1. {% include [sdk-before-begin-step2](../../_includes/search-api/sdk-before-begin-step2.md) %}
  1. {% include [sdk-before-begin-step3](../../_includes/ai-studio/sdk-before-begin-step3.md) %}
  1. {% include [sdk-before-begin-step4](../../_includes/ai-studio/sdk-before-begin-step4.md) %}
  1. {% include [sdk-before-begin-step5](../../_includes/ai-studio/sdk-before-begin-step5.md) %}
  1. {% include [sdk-before-begin-step6](../../_includes/ai-studio/sdk-before-begin-step6.md) %}

- REST API {#api}

  1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого будут выполняться запросы к {{ search-api-name }}.
  1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) созданному сервисному аккаунту [роль](../../search-api/security/index.md#search-api-webSearch-user) `search-api.webSearch.user`.
  1. [Создайте](../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), указав для него [область действия](../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.search-api.execute`.
  1. Чтобы воспользоваться примерами, также установите утилиты [cURL](https://curl.haxx.se) и [jq](https://stedolan.github.io/jq).

  В приведенных примерах используется аутентификация с помощью [API-ключа](../../iam/concepts/authorization/api-key.md). Чтобы использовать для аутентификации [IAM-токен](../../iam/concepts/authorization/iam-token.md), измените в примерах запросов заголовок `Authorization`. Подробнее см. в разделе [{#T}](../../search-api/api-ref/authentication.md).

  В приведенных примерах запросы к {{ search-api-name }} выполняются с помощью [REST API](../api-ref/). Примеры выполнения запросов с помощью [gRPC API](../api-ref/grpc/) см. в разделе [{#T}](../operations/web-search.md).

{% endlist %}

## Выполните поисковый запрос {#make-request}

Приведенный в примере запрос возвращает страницу с результатами поиска по запросу `кофемашина` в форматах [HTML](../concepts/html-response.md) и [XML](../concepts/response.md).

Чтобы выполнить поисковый запрос с помощью {{ search-api-name }}:

{% list tabs group=instructions %}

- SDK {#sdk}

  1. Создайте файл `web-search.py` и добавьте в него следующий код:

      ```python
      #!/usr/bin/env python3

      from __future__ import annotations

      from yandex_cloud_ml_sdk import YCloudML

      from yandex_cloud_ml_sdk.search_api import (
          FamilyMode,
          FixTypoMode,
          GroupMode,
          Localization,
          SearchType,
          SortMode,
          SortOrder,
      )

      import pathlib

      USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 YaBrowser/25.2.0.0 Safari/537.36"

      search_query = "кофемашина"

      formats = ["xml", "html"]


      def main() -> None:

          sdk = YCloudML(
              folder_id="<идентификатор_каталога>",
              auth="<API-ключ>",
          )
          sdk.setup_default_logging("error")

          search = sdk.search_api.web(
              search_type="ru",
              user_agent=USER_AGENT,
          )

          for format in formats:

              print(f"Saving results in the {format.upper()} format:")
              for page in range(0, 3):
                  operation = search.run_deferred(search_query, format=format, page=page)
                  search_result = operation.wait(poll_interval=1)
                  output_filename = (
                      str(pathlib.Path(__file__).parent)
                      + "/"
                      + "page_"
                      + str(page + 1)
                      + "."
                      + format
                  )
                  file = open(output_filename, "a")
                  file.write(search_result.decode("utf-8"))
                  print(f"Page {page} saved to file {output_filename}")
                  file.close()
              print()


      if __name__ == "__main__":
          main()
      ```

      Где:

      {% include [sdk-code-legend](../../_includes/ai-studio/examples/sdk-code-legend.md) %}

      Подробнее о параметрах запроса см. в разделе [{#T}](../operations/web-search.md).

  1. Выполните созданный файл:

      ```bash
      python3 web-search.py
      ```

      В результате выполнения код сохранит в текущей директории три первые страницы с результатами поиска по запросу `кофемашина` в форматах XML и HTML:

      ```text
      Saving results in the XML format:
      Page 0 saved to file /Users/MyUser/Desktop/page_1.xml
      Page 1 saved to file /Users/MyUser/Desktop/page_2.xml
      Page 2 saved to file /Users/MyUser/Desktop/page_3.xml

      Saving results in the HTML format:
      Page 0 saved to file /Users/MyUser/Desktop/page_1.html
      Page 1 saved to file /Users/MyUser/Desktop/page_2.html
      Page 2 saved to file /Users/MyUser/Desktop/page_3.html
      ```

- REST API {#api}

  1. Отправьте поисковый запрос:

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

            В результате сервис вернет идентификатор [объекта Operation](../../api-design-guide/concepts/operation.md) (значение поля `id`), по которому можно будет получить результат операции. Сохраните полученный идентификатор – он понадобится позднее.
  1. Дождитесь, пока {{ search-api-name }} выполнит запрос и сформирует ответ. На это может потребоваться от нескольких минут до нескольких часов.

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

        В файл `result.json` будет сохранен ответ сервиса. Откройте полученный файл, чтобы убедиться, что он содержит поле `done` в значении `true` и поле `response` с результатом выполнения поискового запроса. Результат в поле `response` сохранен в кодировке [Base64](https://ru.wikipedia.org/wiki/Base64).
  1. Декодируйте полученный результат. Для этого выполните команду:

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

{% endlist %}

#### См. также {#see-also}

* [{#T}](../api-ref/authentication.md)
* [{#T}](../operations/web-search.md)
* [{#T}](../operations/web-search-sync.md)
* [{#T}](../concepts/web-search.md)
* [{#T}](../pricing.md)
