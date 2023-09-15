# GET requests

{% note warning %}

Special characters provided as parameter values should be replaced with respective escaped sequences based on percent-encoding. For example use the `%3D` sequence instead of the equals sign `=`.

{% endnote %}

## Request format {#get-request-format}

```xml
https://yandex.<domain>/search/xml
  ? [folderid=<folder_ID>]
  & [apikey=<API key>]
  & [query=<search_query_text>]
  & [lr=<search_country/region_ID>]
  & [l10n=<notification_language>]
  & [sortby=<sorting_type>]
  & [filter=<filtering_type>]
  & [maxpassages=<passage_count>]
  & [groupby=<result_grouping_parameters>]
  & [page=<page_number>]
```

### Request parameters {#parameters}

{% include [name-and-key](../../_includes/search-api/key.md) %}

{% include [query](../../_includes/search-api/query.md) %}

{% include [lr](../../_includes/search-api/lr.md) %}

{% include [l10n](../../_includes/search-api/l10n.md) %}

{% include [sortby](../../_includes/search-api/sortby.md) %}

Format: `sortby=<sorting type>.order%3D<sorting order>`. For example, for reverse sorting by date, use the following construct: `sortby=tm.order%3Dascending`.

{% include [filter](../../_includes/search-api/filter.md) %}

{% include [passages](../../_includes/search-api/passages.md) %}

#### Rules for grouping results {#groupby}

{% include [groupby-description](../../_includes/search-api/groupby-description.md) %}

Dot-separated parameters are specified in the following format:

```xml
attr%3D<service_attribute>.mode%3D<grouping_type>.groups-on-page%3D<number_of_groups_per_page>.docs-in-group%3D<number_of_documents_per_group>
```

Where:

{% include [groupby-description](../../_includes/search-api/groupby-parameters.md) %}

{% include [page](../../_includes/search-api/page.md) %}

## Sample GET request {#example-get-request}

The following request returns the second page with search results in response to the `<table>` query for the `xml-search-user` user. The search type is `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` (yandex.ru). Results are grouped by domain. Each group contains three documents and the number of groups returned per page is five. Bot protection is disabled.

```xml
https://yandex.ru/search/xml?user=xml-search-user`&`key=03.44583456:c876e1b098gh65khg834ggg1jk4ll9j8`&`query=%3Ctable%3E`&`groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D5.docs-in-group%3D3`&`maxpassages=3`&`page=1
```
