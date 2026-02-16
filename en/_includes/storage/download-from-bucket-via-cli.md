1. See the description of the CLI command for downloading an object from a bucket:

    ```bash
    yc storage s3api get-object --help
    ```

1. {% include [bucket-list-cli](./bucket-list-cli.md) %}
1. Run this command:

    ```bash
    yc storage s3api get-object \
      --bucket <bucket_name> \
      --key <object_key> \
      <download_path>
    ```

    Where:

    * `--bucket`: Name of your bucket.
    * `--key`: Object [key](../../storage/concepts/object.md#key).
    * `<download_path>`: Local download path.

    Result:

    ```bash
    etag: '"d41d8cd98f00b204e9800998********"'
    request_id: af194b83********
    accept_ranges: bytes
    content_type: application/octet-stream
    last_modified_at: "2024-10-08T12:36:36Z"
    server_side_encryption: aws:kms
    sse_kms_key_id: abj497vtg3h0********
    ```

    Alternative command:

    ```bash
    yc storage s3 cp \
      s3://<bucket_name>/<object_key> \
      <download_path>
    ```

    Result:

    ```text
    download: s3://my-bucket/object.txt to object.txt
    ```

    {% cut "Configuring parameters for the `yc storage s3 cp` command" %}

    {% include [s3-cp-config](s3-cp-config.md) %}

    {% endcut %}