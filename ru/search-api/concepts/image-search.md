---
title: Поиск по изображениям в {{ search-api-name }}
description: На этой странице вы узнаете о том, как использовать {{ search-api-full-name }} для отправки поисковых запросов по изображениям и получения поисковой выдачи.
---

# Поиск изображений

{{ search-api-full-name }} позволяет выполнять поиск изображений в индексе [Яндекс Картинок](https://yandex.ru/images) как [по текстовому описанию](#search-by-text-query), так и [по заданному изображению](#search-by-image). Параметры поиска, а также поисковый запрос или исходное изображение передаются в сервис в теле запроса. В зависимости от типа поиска {{ search-api-name }} возвращает ответ в виде документа в формате [XML](#xml-response-format) или [JSON](#json-response-format).

## Поиск по текстовому описанию {#search-by-text-query}

Чтобы [выполнить](../operations/search-images.md) поиск изображений по текстовому описанию, передайте параметры поиска в [теле запроса](#request-body-format) и получите результат поиска в [формате XML](#xml-response-format).

### Формат тела запроса {#request-body-format}

{% include [rest-grpc-fields-differ](../../_includes/search-api/rest-grpc-fields-differ.md) %}

{% list tabs group=instructions %}

- REST API {#api}

  {% include [http-body-imagesearch](../../_includes/search-api/http-body-imagesearch.md) %}

  Описание полей:

  {% include [http-body-params-imagesearch](../../_includes/search-api/http-body-params-imagesearch.md) %}

- gRPC API {#grpc-api}

  {% include [grpc-body-imagesearch](../../_includes/search-api/grpc-body-imagesearch.md) %}

  Описание полей:

  {% include [grpc-body-params-imagesearch](../../_includes/search-api/grpc-body-params-imagesearch.md) %}

{% endlist %}

### Формат XML-ответа {#xml-response-format}

В ответ на текстовый поисковый запрос по изображениям {{ search-api }} возвращает [XML](https://ru.wikipedia.org/wiki/XML)-файл в кодировке [UTF-8](https://ru.wikipedia.org/wiki/UTF-8), содержащий результаты поиска.

XML-файл с ответом состоит из группирующих тегов [request](#request-el) (с обобщенной информацией о параметрах запроса) и [response](#response-el) (с результатами обработки запроса).

#### Пример ответа {#response-example}


```xml
<?xml version="1.0" encoding="utf-8"?>
<yandexsearch version="1.0">
  <request>
    <query>котики</query>
    <page>0</page>
    <sortby order="descending" priority="no">rlv</sortby>
    <maxpassages>1</maxpassages>
    <groupings>
      <groupby attr="ii" mode="deep" groups-on-page="1" docs-in-group="1" curcateg="-1"/>
    </groupings>
  </request>
  <response date="20250530T143927">
    <reqid>1748615967169172-2797787793510975009-balancer-l7leveler-kubr-yp-vla-257-BAL</reqid>
    <found priority="phrase">6558</found>
    <found priority="strict">6558</found>
    <found priority="all">6558</found>
    <found-human>Нашлось 7 тыс. ответов</found-human>
    <is-local>no</is-local>
    <results>
      <grouping attr="ii" mode="deep" groups-on-page="20" docs-in-group="1" curcateg="-1">
        <page first="1" last="20">0</page>
        <group>
          <categ attr="ii" id="2606553042332394200"/>
          <doccount>1</doccount>
          <relevance priority="all"/>
          <doc id="Z493B41CD68505D32">
            <relevance priority="all"/>
            <url>https://***.*****.**/big3/989/426616-Kycb.jpg</url>
            <domain>***.*****.**</domain>
            <modtime>20191126T135649</modtime>
            <size>0</size>
            <charset>utf-8</charset>
            <image-properties>
              <id>082c71c2963a0b5859ac6de15743c7d661c76f4b-4665500-images-thumbs</id>
              <shard>0</shard>
              <thumbnail-link>http://avatars.mds.yandex.net/i?id=082c71c2963a0b5859ac6de15743c7d661c76f4b-4665500-images-thumbs</thumbnail-link>
              <thumbnail-width>320</thumbnail-width>
              <thumbnail-height>320</thumbnail-height>
              <original-width>1374</original-width>
              <original-height>1374</original-height>
              <html-link>https://****.*********.ru/download/kot-kotyara-usy-lapy-hvost-2399/480x272/</html-link>
              <image-link>https://****.*********.ru/original/480x272/8/d3/kot-kotyara-usy-lapy-hvost-2399.jpg</image-link>
              <file-size>130963</file-size>
              <mime-type>jpg</mime-type>
            </image-properties>
            <mime-type>text/html</mime-type>
            <properties/>
          </doc>
        </group>
        <found priority="phrase">2348</found>
        <found priority="strict">2348</found>
        <found priority="all">2348</found>
        <found-docs priority="phrase">2348</found-docs>
        <found-docs priority="strict">2348</found-docs>
        <found-docs priority="all">2348</found-docs>
        <found-docs-human>нашёл 2 тыс. ответов</found-docs-human>
      </grouping>
    </results>
  </response>
</yandexsearch>
```



#### Секция request {#request-el}

Обобщенная информация о параметрах запроса. Может отсутствовать, если ответ содержит ошибки.

#|
|| **Теги группы request** | **Описание** | **Атрибуты** ||
|| query | Текст переданного поискового запроса | Отсутствуют. ||
|| page | Номер возвращенной страницы результатов поиска. Нумерация начинается с нуля (первой странице соответствует значение `0`). | Отсутствуют. ||
|| sortby | 
Параметры сортировки результатов. Служебный тег, принимает значение `rlv` — сортировка по релевантности.
| 
* `order` — порядок сортировки. Служебный атрибут, принимает значение `descending` (обратный порядок сортировки).
* `priority` — служебный атрибут. Принимает значение `no`.
||
|| maxpassages | Максимальное количество текстовых сниппетов, формируемых для каждого изображения. Служебный тег, принимает значение `1`. | Отсутствуют.||
|| groupings | 
Группирующий тег.

Содержит параметры группировок в теге `groupby`. 
| Отсутствуют. ||
|| groupby | Параметры группировки найденных результатов поиска. | 
* `attr` — служебный атрибут, принимает значение `ii`.
* `mode` — метод группировки. Служебный атрибут, принимает значение `deep`.
* `groups-on-page` — максимальное количество групп с результатами поиска, которые могут быть возвращены на одной странице результатов.
* `docs-in-group` — максимальное количество изображений, которые могут быть возвращены в одной группе. Служебный атрибут, принимает значение `1`.
* `curcateg` — служебный атрибут. Принимает значение `-1`.
||
|#

#### Секция response {#response-el}

Результаты обработки поискового запроса. Содержит атрибут `date` — значение даты и времени запроса в формате `<год><месяц><день>Т<час><минута><секунда>` по [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).

Состоит из следующих секций:

* [Общая информация о результатах поиска](#basic-search-info).
* [Секция results](#results-block).

##### Общая информация о результатах поиска {#basic-search-info}

#|
|| **Теги общей информации о результатах поиска** | **Описание** | **Атрибуты** ||
|| error |
Описание ошибки. 

Присутствует только в случае некорректной обработки поискового запроса (например, при пустом запросе, некорректных параметрах и т.п.).

В некоторых случаях является взаимоисключающим с прочими тегами группирующего тега `response`.
| `code` — [код](../reference/error-codes.md) ошибки. ||
|| reqid | Уникальный идентификатор запроса. | Отсутствуют. ||
|| found | Приблизительная оценка количества изображений, найденных по запросу.
| 
`priority` — служебный атрибут. Возможные значения:

* `phrase`;
* `strict`;
* `all`.
||
|| found-human | Строка на языке, соответствующем выбранному [типу поиска](#request-body-format). Содержит сведения о количестве найденных изображений и сопутствующую информацию. | Отсутствуют. ||
|#


##### Секция results {#results-block}

Опциональная секция. Присутствует, если по запросу найдены результаты.

#|
|| **Теги секции results** | **Описание** | **Атрибуты**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||
|| results | Группирующий тег. Дочерние теги содержат сведения о параметрах поиска и найденных изображениях. | Отсутствуют. ||
|| grouping | 
Группирующий тег. Дочерние теги содержат сведения о параметрах поиска и найденных изображениях.

| 
Атрибуты отражают правила группировки найденных изображений.

* `attr` — служебный атрибут, принимает значение `ii`.
* `mode` — метод группировки. Служебный атрибут, принимает значение `deep`.
* `groups-on-page` — максимальное количество групп с результатами поиска, которые могут быть возвращены на одной странице результатов.
* `docs-in-group` — максимальное количество изображений, которые могут быть возвращены в одной группе. Служебный атрибут, принимает значение `1`.
* `curcateg` — служебный атрибут. Принимает значение `-1`.
||
|| page | Номер возвращенной страницы результатов поиска. Нумерация начинается с нуля (первой странице соответствует значение `0`).
| 
* `first` — порядковый номер первой группы с результатами поиска, отображаемой на странице.
* `last` — порядковый номер последней группы с результатами поиска, отображаемой на странице.
||
|| group | 
Группирующий тег.

Каждый тег `group` содержит информацию об одной найденной группе изображений. Так как каждая группа изображений содержит только одно изображение, то в теге приведена информация об одном изображении.
| Отсутствуют.
||
|| categ | Описание найденного изображения. | 
* `attr` — название группировки. Совпадает со значением атрибута `attr` тега `groupby` элемента `request`.
* `id` — идентификатор хоста, на котором хранится изображение.
||
|| doccount | Служебный тег. | Отсутствуют. ||
|| relevance | Служебный тег. | `priority` — служебный атрибут. ||
|| doc | 
Группирующий тег.

Каждый тег `doc` содержит информацию об одном найденном изображении.

| `id` — уникальный идентификатор найденного изображения.
||
|| relevance | Служебный тег. | `priority` — служебный атрибут. ||
|| url | Адрес, по которому доступно изображение. | Отсутствуют. ||
|| domain | Домен, на котором расположен документ, содержащий изображение. | Отсутствуют. ||
|| modtime | Дата и время изменения изображения в формате `<год><месяц><день>Т<час><минута><секунда>` по UTC. | Отсутствуют. ||
|| size | Размер изображения в байтах. | Отсутствуют. ||
|| charset | Кодировка документа, содержащего изображение. | Отсутствуют. ||
|| image-properties | 
Группирующий тег.

Содержит информацию о свойствах изображения, которую следует отдавать в поисковую выдачу.

| Отсутствуют.
||
|| id | Идентификатор уменьшенной копии изображения (thumbnail). | Отсутствуют. ||
|| shard | Номер шарда, содержащего информацию об изображении. | Отсутствуют. ||
|| thumbnail-link | Адрес, по которому доступна уменьшенная копия изображения. | Отсутствуют. ||
|| thumbnail-width | Ширина уменьшенной копии изображения в пикселях. | Отсутствуют. ||
|| thumbnail-height | Высота уменьшенной копии изображения в пикселях. | Отсутствуют. ||
|| original-width | Ширина исходного изображения (оригинала). | Отсутствуют. ||
|| original-height | Высота исходного изображения (оригинала). | Отсутствуют. ||
|| html-link | Адрес страницы, на которой опубликовано изображение. | Отсутствуют. ||
|| image-link | Адрес, по которому доступно изображение. | Отсутствуют. ||
|| file-size | Размер изображения в байтах. | Отсутствуют. ||
|| mime-type | Формат изображения (JPG, GIF или PNG). | Отсутствуют. ||
|| mime-type | Формат документа, содержащего изображение. | Отсутствуют. ||
|| found | Приблизительная оценка количества сформированных групп. | 
`priority` — служебный атрибут. Возможные значения:

* `phrase`;
* `strict`;
* `all`.
||
|| found-docs | 
Приблизительная оценка количества изображений, найденных по запросу.

Является более точной оценкой по сравнению со значением, передаваемым в теге `found` секции с [общей информацией о результатах поиска](#basic-search-info).

| 
`priority` — служебный атрибут. Возможные значения:

* `phrase`;
* `strict`;
* `all`.
||
|| found-docs-human | 
Строка на языке, соответствующем выбранному [типу поиска](#request-body-format). Содержит сведения о количестве найденных изображений и сопутствующую информацию.

Передаваемое значение должно использоваться при оформлении результатов поиска.

| Отсутствуют.
||
|#

## Поиск по заданному изображению {#search-by-image}

Чтобы [выполнить](../operations/search-images-by-pic.md) поиск изображений по заданному изображению, передайте это изображение и параметры поиска в [теле запроса](#request-body-by-pic) и получите результат поиска в [формате JSON](#json-response-format).

### Формат тела запроса {#request-body-by-pic}

{% include [rest-grpc-fields-differ](../../_includes/search-api/rest-grpc-fields-differ.md) %}

{% list tabs group=instructions %}

- REST API {#api}

  {% include [http-body-image-bypic-search](../../_includes/search-api/http-body-image-bypic-search.md) %}

  Описание полей:

  {% include [http-body-params-image-bypic-search](../../_includes/search-api/http-body-params-image-bypic-search.md) %}

- gRPC API {#grpc-api}

  {% include [grpc-body-image-bypic-search](../../_includes/search-api/grpc-body-image-bypic-search.md) %}

  Описание полей:

  {% include [grpc-body-params-image-bypic-search](../../_includes/search-api/grpc-body-params-image-bypic-search.md) %}

{% endlist %}

### Формат JSON-ответа {#json-response-format}

В ответ на поисковый запрос по заданному изображению {{ search-api }} возвращает [JSON](https://ru.wikipedia.org/wiki/JSON)-файл в кодировке [UTF-8](https://ru.wikipedia.org/wiki/UTF-8), содержащий результаты поиска.

#### Пример ответа {#json-response-example}

{% list tabs group=instructions %}

- REST API {#api}

  ```json
  {
    "images": [
      {
        "url": "https://cs10.pikabu.ru/post_img/2019/10/29/8/og_og_1572352646221687176.jpg",
        "format": "IMAGE_FORMAT_JPEG",
        "width": "570",
        "height": "960",
        "passage": "This Pin was discovered by Some Dude.",
        "host": "www.pinterest.com",
        "pageTitle": "How to enrich your cute cats' life? Cute cats, Indoor cat, Cats",
        "pageUrl": "https://www.pinterest.com/pin/how-to-enrich-your-cute-cats-life--703194929319013467/"
      },
      ...
    ],
    "page": "3",
    "maxPage": "37"
  }
  ```

  Описание полей:

  * `images` — массив, содержащий объекты с информацией о найденных изображениях:

      * `url` — URL изображения;
      * `format` — формат изображения:
      
          * `IMAGE_FORMAT_JPEG` — формат [JPG](https://ru.wikipedia.org/wiki/JPEG);
          * `IMAGE_FORMAT_GIF` — формат [GIF](https://ru.wikipedia.org/wiki/GIF);
          * `IMAGE_FORMAT_PNG` — формат [PNG](https://ru.wikipedia.org/wiki/PNG).
      * `width` — ширина изображения в [пикселях](https://ru.wikipedia.org/wiki/Пиксель);
      * `height` — высота изображения в пикселях;
      * `passage`  — текстовый сниппет, описывающий изображение;
      * `host` — домен, на котором расположен документ, содержащий изображение;
      * `pageTitle` — заголовок страницы, содержащей изображение;
      * `pageUrl` — URL страницы, содержащей изображение.
  * `page` — номер текущей страницы с результатами поиска.
  * `maxPage` — номер последней страницы с результатами поиска.

- gRPC API {#grpc-api}

  ```json
  {
    "images": [
      {
        "url": "https://cs10.pikabu.ru/post_img/2019/10/29/8/og_og_1572352646221687176.jpg",
        "format": "IMAGE_FORMAT_JPEG",
        "width": "570",
        "height": "960",
        "passage": "This Pin was discovered by Some Dude.",
        "host": "www.pinterest.com",
        "page_title": "How to enrich your cute cats' life? Cute cats, Indoor cat, Cats",
        "page_url": "https://www.pinterest.com/pin/how-to-enrich-your-cute-cats-life--703194929319013467/"
      },
      ...
    ],
    "page": "3",
    "max_page": "37"
  }
  ```

  Описание полей:

  * `images` — массив, содержащий объекты с информацией о найденных изображениях:

      * `url` — URL изображения;
      * `format` — формат изображения:
      
          * `IMAGE_FORMAT_JPEG` — формат [JPG](https://ru.wikipedia.org/wiki/JPEG);
          * `IMAGE_FORMAT_GIF` — формат [GIF](https://ru.wikipedia.org/wiki/GIF);
          * `IMAGE_FORMAT_PNG` — формат [PNG](https://ru.wikipedia.org/wiki/PNG).
      * `width` — ширина изображения в [пикселях](https://ru.wikipedia.org/wiki/Пиксель);
      * `height` — высота изображения в пикселях;
      * `passage` — текстовый сниппет, описывающий изображение;
      * `host` — домен, на котором расположен документ, содержащий изображение;
      * `page_title` — заголовок страницы, содержащей изображение;
      * `page_url` — URL страницы, содержащей изображение.
  * `page` — номер текущей страницы с результатами поиска.
  * `max_page` — номер последней страницы с результатами поиска.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../operations/search-images.md)
* [{#T}](../operations/search-images-by-pic.md)
* [{#T}](../api-ref/authentication.md)