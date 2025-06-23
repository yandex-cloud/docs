* `search_type`: Search type. The possible values are:

    * `SEARCH_TYPE_RU`: For the `Russian` search type.
    * `SEARCH_TYPE_TR`: For the `Turkish` search type.
    * `SEARCH_TYPE_COM`: For the `International` search type.
    * `SEARCH_TYPE_KK`: For the `Kazakh` search type.
    * `SEARCH_TYPE_BE`: For the `Belarusian` search type.
    * `SEARCH_TYPE_UZ`: For the `Uzbek` search type.
* `query_text`: Search query text. The maximum length is 400 characters.
* `family_mode`: Results filtering. This is an optional parameter. The possible values are:

    * `FAMILY_MODE_MODERATE`: Moderate filter (default). Documents of the Adult category are excluded from search results unless a query is explicitly made for searching resources of this category.
    * `FAMILY_MODE_NONE`: Filtering is disabled. Search results include any documents regardless of their contents.
    * `FAMILY_MODE_STRICT`: Family filter. Regardless of a search query, documents of the Adult category and those with profanity are excluded from search results.
* `page`: Requested page number. This is an optional parameter. By default, the first page with search results is returned. Page numbering starts from zero (`0` stands for page 1).
* `fix_typo_mode`: Search query typo correction setting. This is an optional parameter. The possible values are:

    * `FIX_TYPO_MODE_ON`: Typo correction enabled (default). Search query typos are corrected automatically.
    * `FIX_TYPO_MODE_OFF`: Typo correction disabled. Search query typos are not corrected. The search is performed strictly as per the query.
* `sort_mode`: Search results sorting mode rule. This is an optional parameter. The possible values are:

    * `SORT_MODE_BY_RELEVANCE`: Sorting by relevance (default).
    * `SORT_MODE_BY_TIME`: Sorting by document update time.
* `sort_order`: Search results sorting order. This is an optional parameter. The possible values are:

    * `SORT_ORDER_DESC`: Forward sorting order from most recent to oldest (default).
    * `SORT_ORDER_ASC`: Reverse sorting order from oldest to most recent.
* `group_mode`: Result grouping method. This is an optional parameter. The possible values are:

    * `GROUP_MODE_DEEP`: Grouping by domain. Each group contains documents from one domain (default).
    * `GROUP_MODE_FLAT`: Flat grouping. Each group contains a single document.
* `groups_on_page`: Maximum number of groups that can be returned per page. This is an optional parameter. The default value is `20`.

    When getting the result in [XML format](../../search-api/concepts/response.md), the possible values range from `1` to `100`, while for [HTML format](../../search-api/concepts/html-response.md), from `5` to `50`.
* `docs_in_group`: Maximum number of documents that can be returned per group. This is an optional parameter. The values range from `1` to `3`. The default value is `1`.
* `max_passages`: Maximum number of passages that can be used when generating a document snippet. This is an optional parameter. The values range from `1` to `5`. By default, a maximum of four passages with search query text is returned per document.
* `region`: Search country or region ID that affects the document ranking rules. Only supported for the `Russian` and `Turkish` search types.

    For a list of frequently used country and region IDs, see [Search regions](../../search-api/reference/regions.md).
* `l10n`: Search response notifications language. Affects the text in the `found-docs-human` tag and error messages. This is an optional parameter. Possible values depend on the selected search type:

    * `Russian`:
        * `LOCALIZATION_RU`: Russian (default).
        * `LOCALIZATION_BE`: Belarusian.
        * `LOCALIZATION_KK`: Kazakh.
        * `LOCALIZATION_UK`: Ukrainian.
    * `Turkish`:
        * `LOCALIZATION_TR`: Turkish.
    * `International`:
        * `LOCALIZATION_EN`: English.
* `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md) of the user or service account you will use for queries.
* `response_format`: Search results format. This is an optional parameter. The possible values are:

    * `FORMAT_XML`: The results will be delivered in [XML format](../../search-api/concepts/response.md) (default).
    * `FORMAT_HTML`: The results will be delivered in [HTML format](../../search-api/concepts/html-response.md).
* `user_agent`: String containing the [User-Agent header](https://en.wikipedia.org/wiki/User-Agent_header). Use this parameter to have your search results optimized for a specific device and browser, including [mobile search results](../../search-api/operations/v2-mobile.md). This is an optional parameter. If not specified, you will get the default output.

**List of supported parameters**:

{% include [xml-html-fields-differ-notice](./xml-html-fields-differ-notice.md) %}

| Parameter  | Supported in [XML response](../../search-api/concepts/response.md)  | Supported in [HTML response](../../search-api/concepts/html-response.md) |
| --- | --- | --- |
| `search_type` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `query_text` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `family_mode` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `page` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `fix_typo_mode` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `sort_mode` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `sort_order` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `group_mode` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `groups_on_page` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `docs_in_group` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `max_passages` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `region` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `l10n` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `folder_id` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `response_format` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `user_agent` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |