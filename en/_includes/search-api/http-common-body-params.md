* `searchType`: Search type. The possible values are:

    * `SEARCH_TYPE_RU`: For the `Russian` search type.
    * `SEARCH_TYPE_TR`: For the `Turkish` search type.
    * `SEARCH_TYPE_COM`: For the `International` search type.
    * `SEARCH_TYPE_KK`: For the `Kazakh` search type.
    * `SEARCH_TYPE_BE`: For the `Belarusian` search type.
    * `SEARCH_TYPE_UZ`: For the `Uzbek` search type.
* `queryText`: Search query text. The maximum length is 400 characters.
* `familyMode`: Results filtering. This is an optional parameter. The possible values are:

    * `FAMILY_MODE_MODERATE`: Moderate filter (default). _Adult_ category documents are excluded from search results unless the query explicitly targets resources of this category.
    * `FAMILY_MODE_NONE`: Filtering is off. Search results include any documents regardless of their contents.
    * `FAMILY_MODE_STRICT`: Family filter. Regardless of the search query, _Adult_ category documents and documents containing profanity are excluded from search results.
* `page`: Requested page number. This is an optional parameter. By default, the first page with search results is returned. Page numbering starts from zero (`0` stands for page one).
* `fixTypoMode`: Search query typo correction setting. This is an optional parameter. The possible values are:

    * `FIX_TYPO_MODE_ON`: Typo correction enabled (default). Search query typos are corrected automatically.
    * `FIX_TYPO_MODE_OFF`: Typo correction disabled. Search query typos are not corrected. The search is performed strictly as per the query.