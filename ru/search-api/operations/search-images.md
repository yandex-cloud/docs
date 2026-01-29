---
title: Как искать изображения в {{ search-api-name }} по текстовому описанию
description: Следуя данной инструкции, вы научитесь использовать сервис {{ search-api-full-name }} для поиска изображений в индексе Яндекс Картинок по их текстовому описанию.
---

# Поиск изображений по текстовому описанию

Сервис {{ search-api-name }} позволяет искать изображения по текстовым описаниям в индексе [Яндекс Картинок](https://yandex.ru/images) и получать результат поиска в [формате XML](../concepts/image-search.md#xml-response-format). Выполнять запросы можно с помощью [{{ ml-sdk-full-name }}](../../ai-studio/sdk/index.md), [REST API](../api-ref/) и [gRPC API](../api-ref/grpc/). Поисковая выдача зависит от заданных в запросе параметров.

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

  1. Создайте файл `pic-search-by-text.py` и добавьте в него следующий код:

      ```python
      #!/usr/bin/env python3

      from __future__ import annotations

      from yandex_ai_studio_sdk import AIStudio

      from yandex_ai_studio_sdk.search_api import (
          FamilyMode,
          FixTypoMode,
          ImageColor,
          ImageFormat,
          ImageOrientation,
          ImageSize,
          SearchType,
      )

      import pathlib

      USER_AGENT = "Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.6422.112 Mobile Safari/537.36"


      def main() -> None:
          sdk = AIStudio(
              folder_id="<идентификатор_каталога>",
              auth="<API-ключ>",
          )
          sdk.setup_default_logging()

          # you could pass any settings when creating the Search object
          search = sdk.search_api.image(
              "RU",
              family_mode=FamilyMode.MODERATE,
              # By default object configuration property values are set to None,
              # which corresponds to the "default" value which is
              # defined at the service's backend.
              # e.g. docs_in_group=None,
          )

          # but you can also reconfigure the Search object at any time:
          search = search.configure(
              # These are enum-type settings,
              # they could be passed as strings as shown below.
              search_type="kk",
              family_mode="strict",
              fix_typo_mode="off",
              format="jpeg",
              size="LARGE",
              orientation="vertical",
              color="GRAYSCALE",
              docs_on_page=3,
              site="yandex.ru",
              user_agent=USER_AGENT,
          )

          search = search.configure(
              # any enum-like option may also be passed as an explicit enum option;
              # this might be helpful to control and understand which values there can be
              search_type=SearchType.RU,
              family_mode=FamilyMode.STRICT,
              fix_typo_mode=FixTypoMode.OFF,
              format=ImageFormat.JPEG,
              size=ImageSize.LARGE,
              orientation=ImageOrientation.VERTICAL,
              color=ImageColor.GRAYSCALE,
              docs_on_page=5,
          )

          search_query = input("Enter the search query: ")
          if not search_query.strip():
              search_query = "Yandex Cloud"

          for i in range(5):
              search_result = search.run(search_query, format="xml", page=i)

              output_filename = (
                  str(pathlib.Path(__file__).parent) + "/" + "page_" + str(i) + ".xml"
              )
              file = open(output_filename, "a")
              file.write(search_result.decode("utf-8"))
              print(f"Page {i} saved to file {output_filename}")
              file.close()


      if __name__ == "__main__":
          main()
      ```

      Где:

      {% include [sdk-code-legend](../../_includes/ai-studio/examples/sdk-code-legend.md) %}

      Параметры поиска вы можете задать в свойствах соответствующего объекта класса `search_api.image` или в свойствах метода `.configure`:

      {% cut "Описание свойств объекта" %}

      * `search_type` — тип поиска. Возможные значения:

          * `ru` — для типа поиска `Русский`.
          * `tr` — для типа поиска `Турецкий`.
          * `com` — для типа поиска `Международный`.
          * `kk` — для типа поиска `Казахский`.
          * `be` – для типа поиска `Белорусский`.
          * `uz` — для типа поиска `Узбекский`.
      * `family_mode` — фильтрация результатов. Необязательный параметр. Возможные значения:

          * `moderate` — умеренный фильтр (значение по умолчанию). Из выдачи исключаются документы, относящиеся к категории «для взрослых», если запрос явно не направлен на поиск подобных ресурсов.
          * `none` — фильтрация отключена. В выдачу включаются любые документы, вне зависимости от содержимого.
          * `strict` — семейный фильтр. Вне зависимости от поискового запроса из выдачи исключаются документы, относящиеся к категории «для взрослых», а также содержащие ненормативную лексику.
      * `fix_typo_mode` — значение настройки режима исправления опечаток в поисковом запросе. Необязательный параметр. Возможные значения:

          * `on` — исправление опечаток включено (значение по умолчанию). Опечатки в тексте поискового запроса автоматически исправляются.
          * `off` — исправление опечаток отключено. Опечатки в тексте поискового запроса не исправляются, поиск выполняется в полном соответствии с переданным запросом.
      * `format` — поиск изображений указанного формата. Необязательный параметр. Если параметр не задан, выполняется поиск по изображениям всех форматов. Возможные значения:

          * `jpeg` — формат [JPG](https://ru.wikipedia.org/wiki/JPEG).
          * `gif` — формат [GIF](https://ru.wikipedia.org/wiki/GIF).
          * `png` — формат [PNG](https://ru.wikipedia.org/wiki/PNG).
      * `size` — поиск изображений указанного размера. Необязательный параметр. Если параметр не задан, выполняется поиск по изображениям всех размеров. Возможные значения:

          * `enormous` — изображения очень большого размера (более `1600 × 1200` в пикселях).
          * `large` — изображения большого размера (от `800 × 600` до `1600 × 1200` в пикселях).
          * `medium` — изображения среднего размера (от `150 × 150` до `800 × 600` в пикселях).
          * `small` — изображения маленького размера (от `32 × 32` до `150 × 150` в пикселях).
          * `tiny` — иконки (не более `32 × 32` в пикселях).
          * `wallpaper` — обои для рабочего стола.
      * `orientation` — поиск изображений с указанной ориентацией. Необязательный параметр. Если параметр не задан, выполняется поиск по изображениям с любой ориентацией. Возможные значения:

          * `vertical` — изображения с вертикальной ориентацией.
          * `horizontal` — изображения с горизонтальной ориентацией.
          * `square` — изображения с равными сторонами (квадрат).
      * `color` — поиск изображений с заданными параметрами цвета. Необязательный параметр. Если параметр не задан, выполняется поиск по изображениям с любыми цветовыми параметрами. Возможные значения:

          * `color` — цветные изображения.
          * `grayscale` — черно-белые изображения.
          * `red` — изображения, в которых основной цвет — красный.
          * `orange` — изображения, в которых основной цвет — оранжевый.
          * `yellow` — изображения, в которых основной цвет — желтый.
          * `green` — изображения, в которых основной цвет — зеленый.
          * `cyan` — изображения, в которых основной цвет — голубой.
          * `blue` — изображения, в которых основной цвет — синий.
          * `violet` — изображения, в которых основной цвет — фиолетовый.
          * `white` — изображения, в которых основной цвет — белый.
          * `black` — изображения, в которых основной цвет — черный.
      * `docs_on_page` — количество групп результатов, которое выводится на одной странице с результатами поиска. Возможные значения — от `1` до `60`. Необязательный параметр. Значение по умолчанию — `20`.
      * `site` — поиск изображений только на указанном сайте. Например: `yandex.cloud`. Необязательный параметр. Если параметр не задан, поиск выполняется по всем сайтам поисковой базы.
      * `user_agent` — строка, содержащая [заголовок User-Agent](https://en.wikipedia.org/wiki/User-Agent_header). Параметр позволяет получить поисковую выдачу, ориентированную на конкретное устройство и браузер, в том числе [мобильную выдачу](./v2-mobile.md). Необязательный параметр. Если параметр не задан, сервис возвращает стандартную выдачу по умолчанию.

      {% endcut %}

  1. Выполните созданный файл:

      ```bash
      python3 pic-search-by-text.py
      ```

      В процессе выполнения код запросит у вас текст поискового запроса и в результате выполнения сохранит в текущей директории первые пять страниц с результатами поиска по указанному запросу в [XML-формате](../concepts/image-search.md#xml-response-format):

      ```text
      Page 0 saved to file /Users/MyUser/Desktop/page_0.xml
      ...
      Page 4 saved to file /Users/MyUser/Desktop/page_4.xml
      ```

- REST API {#api}

  1. Отправьте запрос и получите результат в кодировке [Base64](https://ru.wikipedia.org/wiki/Base64):

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

          {% include [search-images-by-text-result-json](../../_includes/search-api/search-images-by-text-result-json.md) %}

  1. {% include [search-images-by-text-b64-decode](../../_includes/search-api/search-images-by-text-b64-decode.md) %}

- gRPC API {#grpc-api}

  1. Отправьте запрос и получите результат в кодировке [Base64](https://ru.wikipedia.org/wiki/Base64):

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

          {% include [search-images-by-text-result-json](../../_includes/search-api/search-images-by-text-result-json.md) %}
  
  1. {% include [search-images-by-text-b64-decode](../../_includes/search-api/search-images-by-text-b64-decode.md) %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](./search-images-by-pic.md)
* [{#T}](../concepts/image-search.md)
* [{#T}](../api-ref/authentication.md)