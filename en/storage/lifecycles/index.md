# Bucket object lifecycles

Object Storage allows you to configure how long to keep bucket objects in storage.

You can manage [lifecycle configurations](configuration.md) in:

- [The Yandex.Cloud management console](setup.md).
- [The HTTP API compatible with Amazon S3](../s3/index.md).

This allows you to manage lifecycle configurations using [tools](../instruments/index.md) that access Object Storage via the HTTP API compatible with Amazon S3.

## Example of uploading a lifecycle configuration via the AWS CLI

1. Describe the objects' lifecycle configuration in a file named `lifecycles.json`:

    ```
    {
        "Rules": [
            {
                "ID": "DeleteOldBackups",
                "Filter": {
                    "Prefix": "backup/"
                },
                "Status": "Enabled",
                "Expiration": {
                        "Days": 180
                }
            }
        ]
    }
    ```

2. Upload the configuration file to the `backup-bucket` bucket:

    ```
    aws s3api put-bucket-lifecycle-configuration \
        --bucket backup-bucket \
        --lifecycle-configuration file://lifecycles.json \
        --endpoint-url=https://storage.yandexcloud.net
    ```

