---
title: Как выполнять текстовый поиск в {{ search-api-full-name }} в синхронном режиме
description: Следуя данной инструкции, вы научитесь использовать интерфейсы сервиса {{ search-api-name }} для отправки поисковых запросов и получения поисковой выдачи в формате XML или HTML в синхронном режиме.
---

# Выполнение текстовых поисковых запросов в синхронном режиме

Сервис {{ search-api-name }} позволяет выполнять текстовый поиск в поисковой базе Яндекса и получать результат поиска в формате [XML](../concepts/response.md) или [HTML](../concepts/html-response.md) в синхронном режиме. Выполнять запросы можно с помощью [{{ ml-sdk-full-name }}](../../ai-studio/sdk/index.md), [REST API](../api-ref/) и [gRPC API](../api-ref/grpc/). Поисковая выдача зависит от заданных в запросе параметров.

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

  1. Создайте файл `web-search-sync.py` и добавьте в него следующий код:

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
          sdk.setup_default_logging()

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
              search_result = search.run(search_query, format=format_, page=page)
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
      python3 web-search-sync.py
      ```

      {% include [web-search-sdk-output](../../_includes/search-api/web-search-sdk-output.md) %}

- REST API {#api}

  1. Отправьте запрос и получите результат в кодировке Base64:

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

      {% include [result-json-saved-instruction-paragraph](../../_includes/search-api/result-json-saved-instruction-paragraph.md) %}

  1. {% include [result-base64-decode-instruction](../../_includes/search-api/result-base64-decode-instruction.md) %}

- gRPC API {#grpc-api}

  1. Отправьте запрос и получите результат в кодировке Base64:

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

      {% include [result-json-saved-instruction-paragraph](../../_includes/search-api/result-json-saved-instruction-paragraph.md) %}

  1. {% include [result-base64-decode-instruction](../../_includes/search-api/result-base64-decode-instruction.md) %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](./web-search.md)
* [{#T}](../concepts/web-search.md)
* [{#T}](../api-ref/authentication.md)
* [{#T}](../concepts/response.md)
* [{#T}](../concepts/html-response.md)