---
title: GET-запросы через API v1 сервиса {{ search-api-full-name }}
description: В данной статье описаны особенности использования и формат GET-запросов при обращении к сервису {{ search-api-name }} через интерфейс API v1.
noIndex: true
---

# GET-запросы

Интерфейс API v1 сервиса {{ search-api-name }} позволяет выполнять запросы к поисковой базе Яндекса с заданным набором параметров. Параметры поиска можно передавать в сервис в виде HTTP-запроса методом GET. {{ search-api-name }} формирует ответ в виде документа в [формате XML](./response.md) или в [формате HTML](./html-response.md).

{% include [text-search-intro](../../_includes/search-api/text-search-intro.md) %}

## Формат запроса {#get-request-format}

{% note warning %}

Специальные символы, передаваемые в качестве значений параметров, необходимо заменять на соответствующие экранированные последовательности в соответствии с percent-encoding. Например, вместо знака равно `=` используйте последовательность `%3D`.

{% endnote %}

URL запроса к сервису {{ search-api-name }} и список поддерживаемых параметров различаются в зависимости от того, в каком формате требуется получить результат: XML или HTML.

{% list tabs group=search_api_request %}

- XML {#xml}

  ```httpget
  https://yandex.<домен>/search/xml
    ? [folderid=<идентификатор_каталога>]
    & [apikey=<API-ключ>]
    & [query=<текст_поискового_запроса>]
    & [lr=<идентификатор_региона_поиска>]
    & [l10n=<язык_уведомлений>]
    & [sortby=<тип_сортировки>]
    & [filter=<тип_фильтрации>]
    & [maxpassages=<количество_пассажей>]
    & [groupby=<параметры_группировки_результатов>]
    & [page=<номер_страницы>]
  ```

- HTML {#html}

  ```httpget
  https://yandex.<домен>/search/xml/html
    ? [folderid=<идентификатор_каталога>]
    & [apikey=<API-ключ>]
    & [query=<текст_поискового_запроса>]
    & [lr=<идентификатор_региона_поиска>]
    & [filter=<тип_фильтрации>]
    & [page=<номер_страницы>]
  ```

{% endlist %}

### Параметры запроса {#parameters}

{% include [name-and-key](../../_includes/search-api/key.md) %}

{% include [query](../../_includes/search-api/query.md) %}

{% include [lr](../../_includes/search-api/lr.md) %}

{% include [l10n](../../_includes/search-api/l10n.md) %}

{% include [sortby](../../_includes/search-api/sortby.md) %}

Формат: `sortby=<тип_сортировки>.order%3D<порядок_сортировки>`. Например, для обратной сортировки по дате необходимо использовать следующую конструкцию: `sortby=tm.order%3Dascending`.

{% include [filter](../../_includes/search-api/filter.md) %}

{% include [passages](../../_includes/search-api/passages.md) %}

#### Правила группировки результатов {#groupby}

{% include [groupby-description](../../_includes/search-api/groupby-description.md) %}

Параметры задаются через точку в формате:

```httpget
attr%3D<служебный_атрибут>.mode%3D<тип_группировки>.groups-on-page%3D<количество_групп_на_одной_странице>.docs-in-group%3D<количество_документов_в_каждой_группе>
```

Где: 

{% include [groupby-parameters](../../_includes/search-api/groupby-parameters.md) %}

{% include [page](../../_includes/search-api/page.md) %}

## Пример GET-запроса {#example-get-request}

Следующий запрос возвращает пятую страницу результатов поиска по запросу `<table>`. Тип поиска — `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` (yandex.ru). Регион поиска — Новосибирская область. Язык уведомлений — русский. К результатам поиска применен семейный фильтр. Количество пассажей — три. Результаты группируются по домену и сортируются по релевантности. Каждая группа содержит три документа, а количество групп, возвращаемых на одной странице, равно пяти.

URL запроса к сервису {{ search-api-name }} и список поддерживаемых параметров различаются в зависимости от того, в каком формате требуется получить результат: XML или HTML.

{% list tabs group=search_api_request %}

- XML {#xml}

  ```httpget
  https://yandex.ru/search/xml?folderid=b1gt6g8ht345********&apikey=your_service_account_API_key********&query=%3Ctable%3E&lr=11316&l10n=ru&sortby=rlv&filter=strict&groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D5.docs-in-group%3D3&maxpassages=3&page=4
  ```

- HTML {#html}

  ```httpget
  https://yandex.ru/search/xml/html?folderid=b1gt6g8ht345********&apikey=your_service_account_API_key********&query=%3Ctable%3E&lr=11316&filter=strict&page=4
  ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](./response.md)
* [{#T}](./html-response.md)
* [{#T}](../operations/searching.md)