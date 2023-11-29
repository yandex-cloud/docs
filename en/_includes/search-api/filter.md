#### Filtering results {#filter}

The `filter` field contains a rule for filtering search results and determines whether any documents should be excluded from search results. The possible values include:

* `none`: Filtering is disabled. Search results include any documents regardless of their contents.
* `moderate`: Moderate filter (default value). Documents of the Adult category are excluded from search results unless a query is explicitly made for searching resources of this category.
* `strict`: Family filter. Regardless of a search query, documents of the Adult category and those with profanity are excluded from search results.