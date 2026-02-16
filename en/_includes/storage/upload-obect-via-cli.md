1. See the description of the CLI command for uploading a file to a bucket:

    ```bash
    yc storage s3api put-object --help
    ```

1. {% include [bucket-list-cli](./bucket-list-cli.md) %}
1. Run this command:

    ```bash
    yc storage s3api put-object \
      --body <local_file_path> \
      --bucket <bucket_name> \
      --key <object_path>
    ```

    Where:

    * `--body`: Path to the file you need to upload to the bucket.
    * `--bucket`: Name of your bucket.
    * `--key`: [Key](../../storage/concepts/object.md#key) by which to store the object in the bucket.

    Result:

    ```text
    etag: '"d41d8cd98f00b204e980099********"'
    request_id: 3f2705f********
    ```

    Alternative command:

    ```bash
    yc storage s3 cp \
      <local_file_path> \
      s3://<bucket_name>/<object_path>
    ```

    Result:

    ```text
    upload: object.txt to s3://my-bucket/object.txt
    ```

    {% cut "Configuring parameters for the `yc storage s3 cp` command" %}

    {% include [s3-cp-config](s3-cp-config.md) %}

    {% endcut %}