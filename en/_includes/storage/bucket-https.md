{% note info %}

If you use such URLs as `http(s)://<bucket_name>.{{ s3-storage-host }}`, the HTTPS protocol is available for the bucket only if the bucket name does not contain dots, e.g.:

* `https://example.{{ s3-storage-host }}`: HTTPS is available for this bucket.
* `http://example.ru.{{ s3-storage-host }}`: HTTPS is not available for this bucket.

This is because {{ objstorage-name }} uses [Wildcard certificates](https://en.wikipedia.org/wiki/Wildcard_certificate) that only support one level of subdomains.

To provide HTTPS support for a bucket with a dot in the name, [upload your own security certificate](../../storage/operations/hosting/certificate.md) to {{ objstorage-name }}.

{% endnote %}