# POST requests

{% note warning %}

Special characters provided as parameter values in the request body should be replaced with respective escaped sequences based on XML-encoding. For example use the `&amp;` sequence instead of the ampersand `&`.

{% endnote %}

## Request format {#post-request-format}

```xml
https://yandex.<domain>/search/xml
  ? [folderid=<folder_ID>]
  & [filter=<filtering_type>]
  & [lr=<search_region_ID>]
  & [l10n=<notification_language>]
```

### Request parameters {#parameters}

{% include [name-and-key](../../_includes/search-api/key.md) %}

Provide the API key value in the `Authorization` header. [Learn more about authorization in {{ search-api-name }}](../operations/auth.md).

{% include [filter](../../_includes/search-api/filter.md) %}

{% include [lr](../../_includes/search-api/lr.md) %}

{% include [l10n](../../_includes/search-api/l10n.md) %}

## Request body format {#post-request-body}

```xml
<?xml version="1.0" encoding="<XML_file_encoding>"?>
<request>
<!--Grouping tag-->
   <query>
   <!--Search query text-->
   </query>
   <sortby>
   <!--Search result sorting type-->
   </sortby>
   <groupings>
   <!--Grouping parameters for child tags-->
      <groupby attr="d" mode="deep" groups-on-page="10" docs-in-group="1" />
   </groupings>
   <page>
   <!--Number of the requested page with search results-->
   </page>
</request>
```

## Request body parameters {#post-body-parameters}

### Grouping tag <request> {#request}

The `<request>` grouping tag groups all the contents of the request body. Child tags contain search query parameters.

{% include [query](../../_includes/search-api/query.md) %}

{% include [sortby](../../_includes/search-api/sortby.md) %}

{% include [passages](../../_includes/search-api/passages.md) %}

{% include [page](../../_includes/search-api/page.md) %}

#### Grouping tag <groupings> {#groupings}

The `groupings` grouping tag unites parameters for grouping results.

##### Groupby result grouping {#groupby}

{% include [groupby-description](../../_includes/search-api/groupby-description.md) %}

Possible `groupby` parameters:

{% include [groupby-description](../../_includes/search-api/groupby-parameters.md) %}

## Sample POST request {#example-post-request}

The following request URL and request body return the third page with search results in response to the `<table>` query for the `xml-search-user` user. Results are sorted by document update time. Search type: **Russian** (yandex.ru). Results are grouped by domain. Each group contains three documents and the number of groups returned per page is 10. Maximum number of passages per document: 2. The service returns a UTF-8 encoded XML file.

Request URL:

```httpget
https://yandex.ru/search/xml?user=xml-search-user`&`key=03.44583456:c876e1b098gh65khg834ggg1jk4ll9j8
```

Request body:

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
