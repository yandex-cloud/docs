#### Sorting results {#sortby}

The `sortby` field contains a rule for sorting search results that defines the sequence of the returned search results. The possible values include:

* `rlv`: By relevance (default).
* `tm`: By document update time.

When sorting by update time, the parameter may contain the `order` attribute with the document sorting order:

* `descending`: Direct order from most recent to oldest (default).
* `ascending`: Reverse order from oldest to most recent.
