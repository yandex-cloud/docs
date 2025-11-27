You can set the search parameters for a `sdk.search_api.web` class object in that object’s properties or the `.configure` method properties:

{% cut "Description of object properties" %}

* `search_type`: Search type. The possible values are:

    * `ru`: For the `Russian` search type.
    * `tr`: For the `Turkish` search type.
    * `com`: For the `International` search type.
    * `kk`: For the `Kazakh` search type.
    * `be`: For the `Belarusian` search type.
    * `uz`: For the `Uzbek` search type.
* `family_mode`: Results filtering. This is an optional parameter. The possible values are:

    * `moderate`: Moderate filter (default). _Adult_ category documents are excluded from search results unless the query explicitly targets resources of this category.
    * `none`: Filtering is off. Search results include any documents regardless of their contents.
    * `strict`: Family filter. Regardless of the search query, _Adult_ category documents and documents containing profanity are excluded from search results.
* `fix_typo_mode`: Search query typo correction setting. This is an optional parameter. The possible values are:

    * `on`: Typo correction enabled (default). Search query typos are corrected automatically.
    * `off`: Typo correction disabled. Search query typos are not corrected. The search is performed strictly as per the query.
* `group_mode`: Result grouping method. This is an optional parameter. The possible values are:

    * `deep`: Grouping by domain. Each group contains documents from one domain (default).
    * `flat`: Flat grouping. Each group contains a single document.
* `localization`: Search response notifications language. Affects the text in the `found-docs-human` tag and error messages. This is an optional parameter. Possible values depend on the selected search type:

    * `Russian`:
        * `ru`: Russian (default).
        * `be`: Belarusian.
        * `kk`: Kazakh.
        * `uk`: Ukrainian.
    * `Turkish`:
        * `tr`: Turkish.
    * `International`:
        * `en`: English.
* `sort_order`: Search results sorting order. This is an optional parameter. The possible values are:

    * `desc`: Forward sorting order from most recent to oldest (default).
    * `asc`: Reverse sorting order from oldest to most recent.
* `sort_mode`: Search results sorting mode rule. This is an optional parameter. The possible values are:

    * `by_relevance`: Sorting by relevance (default).
    * `by_time`: Sorting by document update time.
* `docs_in_group`: Maximum number of documents that can be returned per group. This is an optional parameter. The valid values range from `1` to `3`. The default value is `1`.
* `groups_on_page`: Maximum number of groups that can be returned per page. This is an optional parameter. The default value is `20`.

    When getting the result in [XML format](../../search-api/concepts/response.md), the possible values range from `1` to `100`; for [HTML](../../search-api/concepts/html-response.md), the range is from `5` to `50`.
* `max_passages`: Maximum number of passages that can be used when generating a document snippet. This is an optional parameter. The valid values range from `1` to `5`. By default, a maximum of four passages with search query text is returned per document.
* `region`: Search country or region ID that affects the document ranking rules. Only supported for the `Russian` and `Turkish` search types.

    For a list of frequently used country and region IDs, see [Search regions](../../search-api/reference/regions.md).
* `user_agent`: String containing the [User-Agent header](https://en.wikipedia.org/wiki/User-Agent_header). Use this parameter to have your search results optimized for a specific device and browser, including [mobile search results](../../search-api/operations/v2-mobile.md). This is an optional parameter. If not specified, you will get the default output.

**List of supported parameters**:

{% include [xml-html-fields-differ-notice](./xml-html-fields-differ-notice.md) %}

| Parameter  | Supported in [XML response](../../search-api/concepts/response.md)  | Supported in [HTML response](../../search-api/concepts/html-response.md) |
| --- | --- | --- |
| `search_type` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `family_mode` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `fix_typo_mode` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `group_mode` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `localization` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `sort_order` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `sort_mode` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `docs_in_group` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `groups_on_page` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `max_passages` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `region` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `user_agent` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |

{% endcut %}