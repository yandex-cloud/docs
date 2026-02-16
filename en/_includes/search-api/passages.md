#### Maximum number of passages {#maxpassages}

The `maxpassages` parameter is not supported when getting the result in [HTML format](../../search-api/concepts/html-response.md).

A _passage_ is a fragment of found document that contains words from a search query. Passages are used to generate _snippets_ that are text annotations to found documents.

The `maxpassages` field sets the maximum number of passages that can be used when generating a document snippet.

The possible values range from 1 to 5. A search result may contain fewer passages than specified by this parameter. By default, a maximum of four passages with search query text is returned per document.