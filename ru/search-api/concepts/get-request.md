# GET-запросы

{% note warning %}

Специальные символы, передаваемые в качестве значений параметров, необходимо заменять на соответствующие экранированные последовательности в соответствии с percent-encoding. Например, вместо знака равно `=` используйте последовательность `%3D`.

{% endnote %}

## Формат запроса {#get-request-format}

```xml
https://yandex.<домен>/search/xml
  ? [folderid=<идентификатор_каталога>]
  & [apikey=<API-ключ>]
  & [query=<текст_поискового_запроса>]
  & [lr=<идентификатор_страны/региона_поиска>]
  & [l10n=<язык_уведомлений>]
  & [sortby=<тип_сортировки>]
  & [filter=<тип_фильтрации>]
  & [maxpassages=<количество_пассажей>]
  & [groupby=<параметры_группировки_результатов>]
  & [page=<номер_страницы>]
```

### Параметры запроса {#parameters}

{% include [name-and-key](../../_includes/search-api/key.md) %}

{% include [query](../../_includes/search-api/query.md) %}

{% include [lr](../../_includes/search-api/lr.md) %}

{% include [l10n](../../_includes/search-api/l10n.md) %}

{% include [sortby](../../_includes/search-api/sortby.md) %}

Формат: `sortby=<тип сортировки>.order%3D<порядок сортировки>`. Например, для обратной сортировки по дате необходимо использовать следующую конструкцию: `sortby=tm.order%3Dascending`.

{% include [filter](../../_includes/search-api/filter.md) %}

{% include [passages](../../_includes/search-api/passages.md) %}

#### Правила группировки результатов {#groupby}

{% include [groupby-description](../../_includes/search-api/groupby-description.md) %}

Параметры задаются через точку в формате:

```xml
attr%3D<служебный_атрибут>.mode%3D<тип_группировки>.groups-on-page%3D<количество_групп_на_одной_странице>.docs-in-group%3D<количество_документов_в_каждой_группе>
```

Где: 

{% include [groupby-description](../../_includes/search-api/groupby-parameters.md) %}

{% include [page](../../_includes/search-api/page.md) %}

## Пример GET-запроса {#example-get-request}
 
Следующий запрос возвращает вторую страницу результатов поиска по запросу `<table>` для пользователя `xml-search-user`. Тип поиска — `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` (yandex.ru). Результаты группируются по домену. Каждая группа содержит три документа, а количество групп, возвращаемых на одной странице, равно пяти. Защиты от роботов нет.
 
 ```xml
 https://yandex.ru/search/xml?user=xml-search-user`&`key=03.44583456:c876e1b098gh65khg834ggg1jk4ll9j8`&`query=%3Ctable%3E`&`groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D5.docs-in-group%3D3`&`maxpassages=3`&`page=1
 ```