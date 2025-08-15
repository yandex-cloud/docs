{% note info %}

Avoid using your S3 storage in [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) mode for buckets with single-layer (non-recursive) folders that contain many files, as this will significantly degrade storage performance.

{% endnote %}