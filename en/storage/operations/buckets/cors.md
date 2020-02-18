# Configuring CORS

{{ objstorage-name }} lets you manage [CORS configurations](../../concepts/cors.md) in buckets.

{% list tabs %}

- Management console
    1. In the management console, go to the bucket you want to configure CORS for.
    2. In the left pane, select **CORS**.
    3. Click **Configure CORS**.
    4. A page opens where you can add, delete, and edit configuration rules. For a detailed description of the configuration fields, see [{#T}](../../s3/api-ref/cors/xml-config.md).

- AWS CLI

    To upload a configuration via the AWS CLI:

    1. Describe the CORS configuration of objects in JSON format. For example:

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

        When you're done, you can save your configuration as a file, like `cors.json`.

    2. Upload the configuration to a bucket, like `shared-bucket`:

        ```
        aws s3api put-bucket-cors \
            --bucket shared-bucket \
            --cors-configuration file://cors.json \
            --endpoint-url=https://{{ s3-storage-host }}
        ```

{% endlist %}

