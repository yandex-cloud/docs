# How to configure `Cache-Control` headers for objects in a bucket when running HTTP requests



## Case description {#case-description}

You need to configure `Cache-Control` headers for objects in a bucket when running HTTP requests.

## Solution {#case-resolution}

You can add the `Cache-Control` header to system metadata while uploading or modifying an object in the bucket. For more details about object metadata, see [this guide](../../../storage/concepts/object.md#metadata).

To add `Cache-Control` to a previously uploaded object, you can use the `s3cmd` utility. To do this, run this command:
```
s3cmd --add-header 'Cache-Control:max-age=3600' modify s3://<your-bucket-name>/object-name.
```

To add the `Cache-Control` header when uploading an object to the bucket using `s3cmd`, specify `--add-header`: 
```
s3cmd --add-header 'Cache-Control:max-age=3600' put local_file s3://<your-bucket-name>/object-name.
```

{% note info %}

To install and configure `s3cmd`, follow [this guide](../../../storage/tools/s3cmd.md).

{% endnote %}

You can also use [AWS CLI](../../../storage/tools/aws-cli.md) to add the `Cache-Control` header. Example command for AWS CLI:

```
aws --endpoint-url=https://storage.yandexcloud.net s3 \
cp local_file s3://bucket_name --cache-control 'max-age=3600'
```
