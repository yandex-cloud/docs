For partial purging, you can specify paths to individual files and folders. Each path must start with `/`.

{% note info %}

* The `*` wildcard character can only be used at the end of the path. If you specify `*` at the beginning or middle of a path, the cache for matching files will not be purged.
* If [file segmentation](../../cdn/operations/resources/enable-segmentation.md) is enabled for the resource, keep in mind that when you perform a selective cache purge for a specific file, the file is stored in parts across the CDN servers. Use one of the following options:

    * Append the `*` wildcard character to the file path, e.g., `/image/foobar.png*`.
    * Specify a segment byte range using the `@bytes=<start>-<end>` suffix, e.g., `/image/foobar.png@bytes=0-10485759`, to clear the first 10 MB segment.

    If you specify only the file path without `*` or the `@bytes` suffix, the segmented file cache will not be cleared.

{% endnote %}
