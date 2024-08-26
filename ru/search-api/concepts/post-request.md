---
title: "POST-запросы"
description: "В данной статье описаны особенности использования POST-запросов."
---

# POST-запросы

{{ search-api-name }} позволяет выполнять поиск по поисковой базе Яндекса с заданным набором параметров и получать результат поиска в формате XML. Параметры поиска можно передавать в сервис в виде HTTP-запроса методом POST. {{ search-api-name }} формирует [ответ](./response.md) в виде документа в формате XML.

{% include [text-search-intro](../../_includes/search-api/text-search-intro.md) %}

{% note warning %}

Специальные символы, передаваемые в качестве значений параметров в теле запроса, необходимо заменять на соответствующие экранированные последовательности в соответствии с XML-encoding. Например, вместо символа амперсанд `&` используйте последовательность `&amp;`.

{% endnote %}

## Формат запроса {#post-request-format}

```httpget
https://yandex.<домен>/search/xml
  ? [folderid=<идентификатор_каталога>]
  & [filter=<тип_фильтрации>]
  & [lr=<идентификатор_региона_поиска>]
  & [l10n=<язык_уведомлений>]
```

### Параметры запроса {#parameters}

{% include [name-and-key](../../_includes/search-api/key.md) %}

Значение API-ключа [передавайте](../operations/auth.md) в заголовке `Authorization` в формате:

```yaml
Authorization: Api-Key <API-ключ>
```

{% include [filter](../../_includes/search-api/filter.md) %}

{% include [lr](../../_includes/search-api/lr.md) %}

{% include [l10n](../../_includes/search-api/l10n.md) %}

## Формат тела запроса {#post-request-body}

```xml
<?xml version="1.0" encoding="<кодировка_XML-файла>"?>
<request>
<!--Группирующий тег-->
  <query>
     <!--Текст поискового запроса-->
  </query>
  <sortby order="<!--порядок сортировки документов-->">
     <!--Тип сортировки результатов поиска-->
  </sortby>
  <groupings>
    <!--Параметры группировки в дочерних тегах-->
    <groupby attr="d" mode="deep" groups-on-page="10" docs-in-group="1" />
  </groupings>
  <maxpassages>
    <!--максимальное количество пассажей-->
  </maxpassages>
  <page>
    <!--Номер запрашиваемой страницы результатов поиска-->
  </page>
</request>
```

## Параметры тела запроса {#post-body-parameters}

### Группирующий тег <request> {#request}

Группирующий тег `<request>` объединяет все содержимое тела запроса. Дочерние теги содержат параметры поискового запроса. 

{% include [query](../../_includes/search-api/query.md) %}

{% include [sortby](../../_includes/search-api/sortby.md) %}

{% include [passages](../../_includes/search-api/passages.md) %}

{% include [page](../../_includes/search-api/page.md) %}

#### Группирующий тег <groupings> {#groupings}

Группирующий тег `groupings` объединяет параметры группировки результатов. 

##### Группировка результатов groupby {#groupby}

{% include [groupby-description](../../_includes/search-api/groupby-description.md) %}

Возможные параметры `groupby`:

{% include [groupby-description](../../_includes/search-api/groupby-parameters.md) %}

## Пример POST-запроса {#example-post-request}

Приведенные ниже URL и тело запроса возвращают пятую страницу результатов поиска по запросу `<table>`. Результаты сортируются по времени редактирования документа в порядке от наиболее свежего к наиболее старому. Тип поиска — `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` (yandex.ru). Регион поиска — Новосибирская область. К результатам поиска применен семейный фильтр. Результаты группируются по домену. Каждая группа содержит три документа, а количество групп, возвращаемых на одной странице, равно десяти. Максимальное количество пассажей на один документ — два. Сервис возвращает XML-файл в кодировке UTF-8.

URL запроса:

```httpget
https://yandex.ru/search/xml?folderid=b1gt6g8ht345********&filter=strict&lr=11316&l10n=ru
```

Тело запроса:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<request>
  <query>&lt;table&gt;</query>
  <sortby order="descending">tm</sortby>
  <maxpassages>2</maxpassages>
  <page>4</page>
  <groupings>
    <groupby attr="d" mode="deep" groups-on-page="10" docs-in-group="3" />
  </groupings>
</request>
```

#### См. также {#see-also}

* [{#T}](./response.md)
* [{#T}](../operations/searching.md)