{% note info %}

Avoid using S3 storage in [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) mode for buckets with single-layer (non-recursive) folders that include many files, as this will significantly decrease storage performance.

{% endnote %}