#### Requested page number {#page}

The `page` field contains the number of a requested page with search results. The number defines a range of positions of documents returned in response. Page numbering starts from zero (the `0` value stands for page 1).

For example, if the number of documents returned on a page is `n` and the provided parameter is set to `p`, the search results will include documents within the result position range from `p*n+1` to `p*n+n`, inclusive.

By default, the first page with search results is returned.