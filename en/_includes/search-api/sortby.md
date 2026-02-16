#### Sorting results {#sortby}

The `sortby` parameter is not supported when getting the result in [HTML format](../../search-api/concepts/html-response.md).

The `sortby` field contains the sorting rule for how the search results must be sorted. The possible values are:

* `rlv`: By relevance (default).
* `tm`: By document update time.

When sorting by update time, the parameter may contain the `order` attribute for document sorting order:

* `descending`: Direct order, i.e., from most recent to oldest (default).
* `ascending`: Reverse order, i.e., from oldest to most recent.
