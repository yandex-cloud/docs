---
title: Как выполнять текстовый поиск в {{ search-api-full-name }} в отложенном режиме
description: Следуя данной инструкции, вы научитесь использовать сервис {{ search-api-name }} для отправки поисковых запросов и получения поисковой выдачи в формате XML или HTML в отложенном (асинхронном) режиме.
---

# Выполнение текстовых поисковых запросов в отложенном режиме

Сервис {{ search-api-name }} позволяет выполнять текстовый поиск в поисковой базе Яндекса и получать результат поиска в формате [XML](../concepts/response.md) или [HTML](../concepts/html-response.md) в отложенном (асинхронном) режиме. Выполнять запросы можно с помощью [{{ ml-sdk-full-name }}](../../ai-studio/sdk/index.md), [REST API](../api-ref/) и [gRPC API](../api-ref/grpc/). Поисковая выдача зависит от заданных в запросе параметров.

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

  {% include [prepare-cloud-v2](../../_includes/search-api/prepare-cloud-v2.md) %}

  Чтобы воспользоваться примерами, также установите утилиты [cURL](https://curl.haxx.se) и [jq](https://stedolan.github.io/jq).

- gRPC API {#grpc-api}

  {% include [prepare-cloud-v2](../../_includes/search-api/prepare-cloud-v2.md) %}

  Чтобы воспользоваться примерами, также установите утилиты [gRPCurl](https://github.com/fullstorydev/grpcurl) и [jq](https://stedolan.github.io/jq).

{% endlist %}

## Выполните поисковый запрос {#execute-request}

Чтобы выполнить поисковый запрос:

{% list tabs group=instructions %}

- SDK {#sdk}

  1. Создайте файл `web-search-async.py` и добавьте в него следующий код:

      ```python
      #!/usr/bin/env python3

      from __future__ import annotations

      from typing import Literal, cast

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

      USER_AGENT = "Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.6422.112 Mobile Safari/537.36"


      def main() -> None:

          sdk = YCloudML(
              folder_id="<идентификатор_каталога>",
              auth="<API-ключ>",
          )
          sdk.setup_default_logging("error")

          # you could pass any settings when creating the Search object
          search = sdk.search_api.web(
              "RU",
              family_mode=FamilyMode.MODERATE,
              # By default object configuration property values are set to None,
              # which corresponds to the "default" value which is
              # defined at the service's backend.
              # e.g. docs_in_group=None,
          )

          # but also you could reconfigure the Search object at any time:
          search = search.configure(
              # These are enum-type settings,
              # they could be passed as strings as shown below.
              search_type="ru",
              family_mode="strict",
              fix_typo_mode="off",
              group_mode="deep",
              localization="ru",
              sort_order="desc",
              sort_mode="by_time",
              docs_in_group=None,
              groups_on_page=6,
              max_passages=2,
              region="225",
              user_agent=USER_AGENT,
          )

          search_query = input("Enter the search query: ")
          if not search_query.strip():
              search_query = "Yandex Cloud"

          format_ = input("Choose format ([xml]/html): ")
          format_ = format_.strip() or "xml"
          assert format_.lower() in ("xml", "html")
          format_ = cast(Literal["html", "xml"], format_)

          for page in range(0, 10):
              operation = search.run_deferred(search_query, format=format_, page=page)
              search_result = operation.wait(poll_interval=1)
              output_filename = (
                  str(pathlib.Path(__file__).parent)
                  + "/"
                  + "page_"
                  + str(page + 1)
                  + "."
                  + format_
              )
              file = open(output_filename, "a")
              file.write(search_result.decode("utf-8"))
              print(f"Page {page} saved to file {output_filename}")
              file.close()


      if __name__ == "__main__":
          main()
      ```

      Где:

      {% include [sdk-code-legend](../../_includes/ai-studio/examples/sdk-code-legend.md) %}

      {% include [the-search-configure-method-params](../../_includes/search-api/the-search-configure-method-params.md) %}

  1. Выполните созданный файл:

      ```bash
      python3 web-search-async.py
      ```

      {% include [web-search-sdk-output](../../_includes/search-api/web-search-sdk-output.md) %}

- REST API {#api}

  1. Сформируйте поисковый запрос:

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

          {% include [async-api-search-save-id](../../_includes/search-api/async-api-search-save-id.md) %}

  1. Дождитесь, пока {{ search-api-name }} выполнит запрос и сформирует ответ. На это может потребоваться от пяти минут до нескольких часов.
  
      Чтобы убедиться в успешном выполнении запроса, выполните HTTP-запрос:

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
        "rawData": "<тело_ответа_в_кодировке_Base64>"
      },
      "id": "spp82pc07ebl********",
      "description": "WEB search async",
      "createdAt": "2024-10-03T08:07:07Z",
      "createdBy": "bfbud0oddqp4********",
      "modifiedAt": "2024-10-03T08:12:09Z"
      }
      ```

      {% include [async-api-search-check-if-done](../../_includes/search-api/async-api-search-check-if-done.md) %}

  1. После того как сервис {{ search-api-name }} успешно обработал запрос, получите ответ:

      1. Получите результат:

          ```bash
          curl \
            --request GET \
            --header "Authorization: Bearer <IAM-токен>" \
            https://operation.{{ api-host }}/operations/<идентификатор_запроса> \
            > result.json
          ```

          {% include [async-api-search-b64-result-received](../../_includes/search-api/async-api-search-b64-result-received.md) %}

      1. {% include [api-result-base64-decode](../../_includes/search-api/api-result-base64-decode.md) %}

- gRPC API {#grpc-api}

  1. Сформируйте поисковый запрос:

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

          {% include [async-api-search-save-id](../../_includes/search-api/async-api-search-save-id.md) %}

  1. Дождитесь, пока {{ search-api-name }} выполнит запрос и сформирует ответ. На это может потребоваться от пяти минут до нескольких часов.

      Чтобы убедиться в успешном выполнении запроса, выполните gRPC-вызов:

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
          "rawData": "<тело_ответа_в_кодировке_Base64>"
        }
      }
      ```

      {% include [async-api-search-check-if-done](../../_includes/search-api/async-api-search-check-if-done.md) %}

  1. После того как сервис {{ search-api-name }} успешно обработал запрос, получите ответ:

      1. Получите результат:

          ```bash
          grpcurl \
            -rpc-header "Authorization: Bearer <IAM-токен>" \
            -d '{"operation_id": "<идентификатор_запроса>"}' \
            operation.{{ api-host }}:443 yandex.cloud.operation.OperationService/Get \
            > result.json
          ```

          {% include [async-api-search-b64-result-received](../../_includes/search-api/async-api-search-b64-result-received.md) %}

      1. {% include [api-result-base64-decode](../../_includes/search-api/api-result-base64-decode.md) %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](./web-search-sync.md)
* [{#T}](../concepts/web-search.md)
* [{#T}](../api-ref/authentication.md)
* [{#T}](../concepts/response.md)
* [{#T}](../concepts/html-response.md)