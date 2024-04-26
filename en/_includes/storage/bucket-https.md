{% note info %}

When using a URL in `http(s)://<bucket_name>.{{ s3-storage-host }}` format, the HTTPS protocol is available for the bucket only if the bucket name does not contain dots. For example:

* `https://example.{{ s3-storage-host }}` HTTPS is available for this bucket.
* `http://example.ru.{{ s3-storage-host }}` HTTPS is not available for this bucket.

This is because {{ objstorage-name }} uses [Wildcard certificates](https://en.wikipedia.org/wiki/Wildcard_certificate), which only support one level of subdomains.

To provide HTTPS support for a bucket with a dot in the name, [upload your own security certificate](../../storage/operations/hosting/certificate.md) to {{ objstorage-name }}.

{% endnote %}