* `site`: Searching for images only on specified website, e.g., `yandex.cloud`. This is an optional parameter. If not set, the search includes all websites in the search base.
* `folderId`: [Folder ID](../../resource-manager/operations/folder/get-id.md) of the user or service account you will use for queries.
* `url`: Source image URL.
* `data`: Source image data, [Base64]({{ link-base64 }})-encoded.

    {% note info %}

    You can provide only one of these parameters in your query: `url`, or `data`.

    {% endnote %}

* `page`: Requested page number. This is an optional parameter. By default, the first page with search results is returned. Page numbering starts from zero (`0` stands for page one).