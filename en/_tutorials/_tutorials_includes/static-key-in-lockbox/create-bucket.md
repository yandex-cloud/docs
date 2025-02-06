{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  ```bash
  aws --endpoint-url=https://storage.yandexcloud.net \
    s3 mb s3://<bucket_name>
  ```

  Result:

  ```bash
  make_bucket: my-first-bucket
  ```

{% endlist %}

This will create a new bucket in {{ objstorage-name }}. When creating a bucket, a static access key is used obtained from the {{ lockbox-name }} secret and saved in environment variables.

You can also include the key ID, secret key, and placement region values directly in each AWS CLI command: