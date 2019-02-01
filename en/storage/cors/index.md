# CORS

[!KEYREF objstorage-full-name] supports cross-domain bucket requests.

You can set up a [CORS configuration](configuration.md) for each bucket via the [HTTP API compatible with Amazon S3](../s3/index.md). This allows you to manage CORS configurations using [tools](../instruments/index.md) that interact with [!KEYREF objstorage-name] via the S3 HTTP API.

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
    --endpoint-url=https://[!KEYREF s3-storage-host]
```

