---
title: Как искать изображения в {{ search-api-name }} по изображению
description: Следуя данной инструкции, вы научитесь использовать сервис {{ search-api-full-name }} для отправки поисковых запросов на поиск изображений по исходному изображению.
---

# Поиск изображений по заданному изображению

Сервис {{ search-api-name }} позволяет искать изображения по заданному изображению в индексе [Яндекс Картинок](https://yandex.ru/images) и получать результат поиска в [формате JSON](../concepts/image-search.md#json-response-format). Выполнять запросы можно с помощью [{{ ml-sdk-full-name }}](../../ai-studio/sdk/index.md), [REST API](../api-ref/) и [gRPC API](../api-ref/grpc/). Поисковая выдача зависит от заданных в запросе параметров.

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

  1. Создайте файл `pic-search-by-pic.py` и добавьте в него следующий код:

      ```python
      #!/usr/bin/env python3

      from __future__ import annotations

      import pathlib

      from yandex_ai_studio_sdk import AIStudio
      from yandex_ai_studio_sdk.search_api import FamilyMode

      EXAMPLE_FILE = pathlib.Path(__file__).parent / "image.jpg"


      def main() -> None:
          sdk = AIStudio(
              folder_id="<идентификатор_каталога>",
              auth="<API-ключ>",
          )
          sdk.setup_default_logging()

          # You can pass initial configuration here:
          search = sdk.search_api.by_image(
              family_mode="moderate",
              site="ya.ru",
          )
          # Or configure the Search object later:
          search = search.configure(
              # family mode may be passed as a string or as a special enum value
              family_mode=FamilyMode.NONE,
          )

          # You can reset any config property back to its default value by passing None:
          search = search.configure(site=None)

          search_type = input(
              "Select a search type:\n1 — using a remote image URL (default)\n2 — using bytes data from './image.jpeg'\n\n"
          )
          if not search_type.strip():
              search_type = "1"

          if int(search_type) == 2:

              # The first search option is to search using bytes data:
              image_data = pathlib.Path(EXAMPLE_FILE).read_bytes()
              search_result = search.run(image_data)

          else:

              # The second search option is to search using a remote image url:
              # e.g. Photo of Leo Tolstoy
              url = "https://upload.wikimedia.org/wikipedia/commons/b/be/Leo_Tolstoy_1908_Portrait_%283x4_cropped%29.jpg"
              search_result = search.run_from_url(url)

          # You can examine the search_result structure via pprint
          # to get to know how to work with it:
          # pprint.pprint(search_result)
          # Search results can also be used in boolean context:
          if search_result:
              print(f"{len(search_result)} documents found")
          else:
              print("Nothing found")

          # The third search option is to search using the image's CBIR ID:
          # using CBIR ID is way faster than any other option,
          # but it requires to make at least one "heavy" request to get this ID.

          cbid_id = search_result.cbir_id
          search_result = search.run_from_id(cbid_id, page=1)

          while search_result:
              print(f"Page {search_result.page}:")
              output_filename = (
                  str(pathlib.Path(__file__).parent)
                  + "/"
                  + "results_page_"
                  + str(search_result.page)
                  + ".txt"
              )
              file = open(output_filename, "a")
              for document in search_result:
                  file.write(str(document) + "\n\n")
              print(f"Page {search_result.page} saved to file {output_filename}")
              file.close()

              # search_result.next_page() is a shortcut for
              # `.run_from_id(search_query.cbir_id, page=page + 1)`
              # with search configuration saved from the initial run;
              # last page + 1 will return an "empty" search_result;
              search_result = search_result.next_page()


      if __name__ == "__main__":
          main()
      ```

      Где:

      {% include [sdk-code-legend](../../_includes/ai-studio/examples/sdk-code-legend.md) %}

      Параметры поиска вы можете задать в свойствах соответствующего объекта класса `search_api.by_image` или в свойствах метода `.configure`:

      * `family_mode` — фильтрация результатов. Необязательный параметр. Возможные значения:

          * `moderate` — умеренный фильтр (значение по умолчанию). Из выдачи исключаются документы, относящиеся к категории «для взрослых», если запрос явно не направлен на поиск подобных ресурсов.
          * `none` — фильтрация отключена. В выдачу включаются любые документы, вне зависимости от содержимого.
          * `strict` — семейный фильтр. Вне зависимости от поискового запроса из выдачи исключаются документы, относящиеся к категории «для взрослых», а также содержащие ненормативную лексику.

  1. Выполните созданный файл:

      ```bash
      python3 pic-search-by-pic.py
      ```

      В процессе выполнения код запросит у вас выбрать вариант поиска:

      1. По изображению, опубликованному в интернете. URL этого изображения задан в переменной `url`.
      1. По изображению с локального компьютера. Локальный путь к изображению задан в переменной `EXAMPLE_FILE`.

      На завершающем этапе код выполнит поиск изображений по идентификатору [CBIR](https://ru.wikipedia.org/wiki/Поиск_изображений_по_содержанию), после чего постранично сохранит результаты поиска в текущей директории в текстовые файлы:

      ```text
      Page 1 saved to file /Users/MyUser/Desktop/results_page_1.txt
      ...
      Page 134 saved to file /Users/MyUser/Desktop/results_page_134.txt
      ```

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

      {% include [search-images-by-pic-result-json](../../_includes/search-api/search-images-by-pic-result-json.md) %}

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

      {% include [search-images-by-pic-result-json](../../_includes/search-api/search-images-by-pic-result-json.md) %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](./search-images.md)
* [{#T}](../concepts/image-search.md)
* [{#T}](../api-ref/authentication.md)