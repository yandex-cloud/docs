# POST-запросы

{% note warning %}

Специальные символы, передаваемые в качестве значений параметров в теле запроса, необходимо заменять на соответствующие экранированные последовательности в соответствии с XML-encoding. Например, вместо символа амперсанд `&` используйте последовательность `&amp;`.

{% endnote %}

## Формат запроса {#post-request-format}

```xml
https://yandex.<домен>/search/xml
  ? [folderid=<идентификатор_каталога>]
  & [filter=<тип_фильтрации>]
  & [lr=<идентификатор_региона_поиска>]
  & [l10n=<язык_уведомлений>]
```

### Параметры запроса {#parameters}

{% include [name-and-key](../../_includes/search-api/key.md) %}

Значение API-ключа передавайте в заголовке `Authorization`. [Подробнее об авторизации в {{ search-api-name }}](../operations/auth.md).

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
   <sortby>
   <!--Тип сортировки результатов поиска-->
   </sortby>
   <groupings>
   <!--Параметры группировки в дочерних тегах-->
      <groupby attr="d" mode="deep" groups-on-page="10" docs-in-group="1" />
   </groupings>
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

Приведенные ниже URL и тело запроса возвращают третью страницу результатов поиска по запросу `<table>` для пользователя `xml-search-user`. Результаты сортируются по времени редактирования документа. Тип поиска — **Русский** (yandex.ru). Результаты группируются по домену. Каждая группа содержит три документа, а количество групп, возвращаемых на одной странице, равно десяти. Максимальное количество пассажей на один документ — два. Сервис возвращает XML-файл в кодировке UTF-8.

URL запроса:

```httpget
https://yandex.ru/search/xml?user=xml-search-user`&`key=03.44583456:c876e1b098gh65khg834ggg1jk4ll9j8
```

Тело запроса:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<request>
<query>%3Ctable%3E</query>
      <sortby>tm</sortby>
      <maxpassages>2</maxpassages>
      <page>2</page>
      <groupings>
      <groupby attr="d" mode="deep" groups-on-page="10" docs-in-group="3" />
</groupings>
</request>
```