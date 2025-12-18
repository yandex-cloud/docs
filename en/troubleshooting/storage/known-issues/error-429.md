# Fixing error 429



## Issue description {#issue-description}

When trying to delete multiple files simultaneously, you get this error:
```
message: ; status: 429; description: ; code: undefined; Request ID: undefined; Trace ID: undefined;
```
## Solution {#issue-resolution}

This error means you are sending too many requests. When this error occurs, we recommend accessing {{ objstorage-name }} less frequently.

{% note info %}

You can check all error codes and {{ objstorage-name }} API responses in [this guide](../../../storage/s3/api-ref/response-codes.md).

{% endnote %}

For bulk deletion of objects, we recommend using AWS CLI to recursively delete files with this command:

```
aws s3 --endpoint-url=https://storage.yandexcloud.net rm s3://bucket-name --recursive
```

You can also recursively delete all files with an identical prefix. The following command will delete all files prefixed with `my-folder/` in `my-bucket`:

```
aws s3 --endpoint-url=https://storage.yandexcloud.net rm s3://my-bucket/my-folder/ --recursive
```

To learn how to install and configure the AWS CLI, see [this guide](../../../storage/tools/aws-cli.md).