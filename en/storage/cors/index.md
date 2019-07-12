# CORS

Yandex Object Storage supports cross-domain requests to bucket objects.

You can set up a [CORS configuration](configuration.md) for each bucket via:

- [The Yandex.Cloud management console](setup.md).

- [The HTTP API compatible with Amazon S3](../s3/index.md).

    This allows you to manage CORS configurations using [tools](../instruments/index.md) that interact with Object Storage via the HTTP API compatible with Amazon S3.

## Example of uploading a CORS configuration via the AWS CLI

Put the CORS configuration in the `cors.json` file:

```
{
    "CORSRules": [
        {
            "AllowedHeaders": ["*"],
            "AllowedMethods": ["GET", "HEAD", "PUT", "DELETE"],
            "MaxAgeSeconds": 3000,
            "AllowedOrigins": ["*"]
        }
    ]
}
```

Upload `cors.json` to a bucket named `shared-bucket`:

```
aws s3api put-bucket-cors --bucket shared-bucket --cors-configuration file://cors.json \
    --endpoint-url=https://storage.yandexcloud.net
```

