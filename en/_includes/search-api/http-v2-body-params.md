{% include [http-common-body-params](./http-common-body-params.md) %}

* `sortMode`: Search results sorting mode rule. This is an optional parameter. The possible values are:

    * `SORT_MODE_BY_RELEVANCE`: Sorting by relevance (default).
    * `SORT_MODE_BY_TIME`: Sorting by document update time.
* `sortOrder`: Search results sorting order. This is an optional parameter. The possible values are:

    * `SORT_ORDER_DESC`: Forward sorting order from most recent to oldest (default).
    * `SORT_ORDER_ASC`: Reverse sorting order from oldest to most recent.
* `groupMode`: Result grouping method. This is an optional parameter. The possible values are:

    * `GROUP_MODE_DEEP`: Grouping by domain. Each group contains documents from one domain (default).
    * `GROUP_MODE_FLAT`: Flat grouping. Each group contains a single document.
* `groupsOnPage`: Maximum number of groups that can be returned per page. This is an optional parameter. The default value is `20`.

    When getting the result in [XML format](../../search-api/concepts/response.md), the possible values range from `1` to `100`; for [HTML](../../search-api/concepts/html-response.md), the range is from `5` to `50`.
* `docsInGroup`: Maximum number of documents that can be returned per group. This is an optional parameter. The values range from `1` to `3`. The default value is `1`.
* `maxPassages`: Maximum number of passages that can be used when generating a document snippet. This is an optional parameter. The values range from `1` to `5`. By default, a maximum of four passages with search query text is returned per document.
* `region`: Search country or region ID that affects the document ranking rules. Only supported for the `Russian` and `Turkish` search types.

    For a list of frequently used country and region IDs, see [Search regions](../../search-api/reference/regions.md).
* `l10N`: Search response notifications language. Affects the text in the `found-docs-human` tag and error messages. This is an optional parameter. Possible values depend on the selected search type:

    * `Russian`:
        * `LOCALIZATION_RU`: Russian (default).
        * `LOCALIZATION_BE`: Belarusian.
        * `LOCALIZATION_KK`: Kazakh.
        * `LOCALIZATION_UK`: Ukrainian.
    * `Turkish`:
        * `LOCALIZATION_TR`: Turkish.
    * `International`:
        * `LOCALIZATION_EN`: English.
* `folderId`: [Folder ID](../../resource-manager/operations/folder/get-id.md) of the user or service account you will use for queries.
* `responseFormat`: Search results format. This is an optional parameter. The possible values are:

    * `FORMAT_XML`: The results will be delivered in [XML format](../../search-api/concepts/response.md) (default).
    * `FORMAT_HTML`: The results will be delivered in [HTML format](../../search-api/concepts/html-response.md).
* `userAgent`: String containing the [User-Agent header](https://en.wikipedia.org/wiki/User-Agent_header). Use this parameter to have your search results optimized for a specific device and browser, including [mobile search results](../../search-api/operations/v2-mobile.md). This is an optional parameter. If not specified, you will get the default output.

**List of supported parameters**:

{% include [xml-html-fields-differ-notice](./xml-html-fields-differ-notice.md) %}

| Parameter  | Supported in [XML response](../../search-api/concepts/response.md)  | Supported in [HTML response](../../search-api/concepts/html-response.md) |
| --- | --- | --- |
| `searchType` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `queryText` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `familyMode` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `page` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `fixTypoMode` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `sortMode` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `sortOrder` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `groupMode` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `groupsOnPage` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `docsInGroup` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `maxPassages` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `region` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `l10N` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `folderId` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `responseFormat` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `userAgent` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |