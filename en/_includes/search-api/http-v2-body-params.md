* `searchType`: Search type. The possible values are:

    * `SEARCH_TYPE_RU`: For the `Russian` search type.
    * `SEARCH_TYPE_TR`: For the `Turkish` search type.
    * `SEARCH_TYPE_COM`: For the `International` search type.

* `queryText`: Search query text. The maximum length is 400 characters.

* `familyMode`: Results filtering. This is an optional parameter. The possible values are:

    * `FAMILY_MODE_MODERATE`: Moderate filter (default). Documents of the Adult category are excluded from search results unless a query is explicitly made for searching resources of this category.
    * `FAMILY_MODE_NONE`: Filtering is disabled. Search results include any documents regardless of their contents.
    * `FAMILY_MODE_STRICT`: Family filter. Regardless of a search query, documents of the Adult category and those with profanity are excluded from search results.

* `page`: Requested page number. This is an optional parameter. By default, the first page with search results is returned. Page numbering starts from zero (`0` stands for page 1).

* `sortMode`: Rule defining the search results sorting mode. This is an optional parameter. The possible values are:

    * `SORT_MODE_BY_RELEVANCE`: Sorting by relevance (default).
    * `SORT_MODE_BY_TIME`: Sorting by document update time.

* `sortOrder`: Search results sorting order. This is an optional parameter. The possible values are:

    * `SORT_ORDER_DESC`: Forward sorting order from most recent to oldest (default).
    * `SORT_ORDER_ASC`: Reverse sorting order from oldest to most recent.

* `groupMode`: Result grouping method. This is an optional parameter. The possible values are:

    * `GROUP_MODE_DEEP`: Grouping by domain. Each group contains documents from one domain (default).
    * `GROUP_MODE_FLAT`: Flat grouping. Each group contains a single document.

* `groupsOnPage`: Maximum number of groups that can be returned per search results page. This is an optional parameter. The values range from `1` to `100`. Default value: `20`.

* `docsInGroup`: Maximum number of documents that can be returned per group. This is an optional parameter. The values range from `1` to `3`. Default value: `1`.

* `maxPassages`: Maximum number of passages that can be used when generating a document snippet. This is an optional parameter. The values range from `1` to `5`. By default, a maximum of four passages with search query text is returned per document.

* `region`: Search country or region ID that affects the document ranking rules. Only supported for `Russian` and `Turkish` search types.

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