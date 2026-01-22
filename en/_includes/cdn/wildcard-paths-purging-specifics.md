For partial purging, you can specify paths to individual files and folders. Each path must begin with the `/` or `*` character. The `*` wildcard character can replace any number of characters. 

{% note info %}

You can only specify the `*` wildcard character at the end of the path. If you specify `*` at the beginning or middle of a path, the cache for matching files will not be purged.

{% endnote %}