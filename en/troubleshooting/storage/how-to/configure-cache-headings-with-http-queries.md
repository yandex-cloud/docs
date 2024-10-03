# How to configure cache-control headers for objects in a bucket during HTTP requests


## Scenario description {#case-description}

You need to set up cache-control headers for objects in the bucket during HTTP requests.

## Solution {#case-resolution}

You can add the `Cache-Control` header to system metadata during the upload or modification of an object in the bucket. For more details about object metadata, see the [documentation](https://cloud.yandex.ru/docs/storage/concepts/object#metadata).

To add `Cache-Control` to a previously uploaded object, you can use the `s3cmd` utility.
To do this, run the following command:
```
s3cmd --add-header 'Cache-Control:3600' modify s3://<your-bucket-name>/object-name.
```

To add the `Cache-Control` header during the object upload to the bucket using `s3cmd`, specify the `--add-header` parameter:
```
s3cmd --add-header 'Cache-Control:3600' put local_file s3://<your-bucket-name>/object-name.
```

{% note info %}

You can install and configure the `s3cmd` utility [following this guide](../../../storage/tools/s3cmd).

{% endnote %}

You can also use the [AWS CLI utility](../../../storage/tools/aws-cli) to add the Cache-Control header.
Example command for AWS CLI:
```
aws --endpoint-url=https://storage.yandexcloud.net s3 \
cp local_file s3://bucket_name --cache-control 'max-age=3600'
```
