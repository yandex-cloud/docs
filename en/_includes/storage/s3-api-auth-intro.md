To authenticate with the [AWS S3 API](../../storage/s3/api-ref/), you can use an [IAM token](../../iam/concepts/authorization/iam-token.md) or a [static access key](../../iam/concepts/authorization/access-key.md).

{% note warning %}

For AWS S3 API, IAM token authentication if the recommended method: it is more secure and, unlike static key authentication, is does not require creating a [request signature](../../storage/s3/signing-requests.md).

{% endnote %}