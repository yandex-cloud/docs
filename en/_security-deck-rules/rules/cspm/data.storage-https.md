### HTTPS for static website hosting is enabled in Yandex Object Storage {#storage-https}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | data.storage-https ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for HTTPS settings on Object Storage static websites.

{% endnote %}

[Object Storage](https://yandex.cloud/en/docs/storage) supports secure connections over HTTPS. You can upload your own security certificate if a connection to your Object Storage website requires HTTPS access. Integration with [Certificate Manager](https://yandex.cloud/en/docs/certificate-manager) is also supported. See the instructions in the Object Storage documentation:

* Configuring [HTTPS](https://yandex.cloud/en/docs/storage/operations/hosting/certificate)
* [Bucket](https://yandex.cloud/en/docs/storage/concepts/bucket)

When using [Object Storage](https://yandex.cloud/en/docs/storage), make sure that support for TLS protocols below version 1.2 is disabled at the client level. Use the aws:[securetransport](https://yandex.cloud/en/docs/storage/s3/api-ref/policy/conditions) bucket policy to make sure running without TLS is disabled for the bucket.

#### Guides and solutions

* Enable access over HTTPS if the bucket is used to host a static website: <https://yandex.cloud/en/docs/storage/operations/hosting/certificate>
