# Resolving error 429



## Issue description {#issue-description}

When trying to delete several files simultaneously, you see this error:
```
message: ; status: 429; description: ; code: undefined; Request ID: undefined; Trace ID: undefined;
```
## Solution {#issue-resolution}

This error tells you are sending too many requests. When this error occurs, we recommend reducing the frequency of calls to Object Storage.

{% noteinfo %}

You can see all the error codes and API Object Storage responses in the [documentation](../../../storage/s3/api-ref/response-codes).

{% endnote %}

For bulk deletion of objects, we recommend using AWS CLI to recursively delete files with this command:

```
aws s3 --endpoint-url=https://storage.yandexcloud.net rm s3://bucket-name --recursive
```

You can also recursively delete all files with an identical prefix. The following command will delete all files having the `my-folder/` prefix in `my-bucket`:

```
aws s3 --endpoint-url=https://storage.yandexcloud.net rm s3://my-bucket/my-folder/ --recursive
```

A guide for installing and configuring the AWS CLI is also available in our [documentation](../../../docs/storage/tools/aws-cli).
