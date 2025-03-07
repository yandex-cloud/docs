1. See the description of the CLI command for uploading a file to a bucket:

    ```bash
    yc storage s3api put-object --help
    ```

1. Get a list of buckets in the default folder:

    ```bash
    yc storage bucket list
    ```

    Result:

    ```text
    +------------------+----------------------+-------------+-----------------------+---------------------+
    |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
    +------------------+----------------------+-------------+-----------------------+---------------------+
    | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
    +------------------+----------------------+-------------+-----------------------+---------------------+
    ```

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
    * `--key`: [Key](../../storage/concepts/object.md#key) to use for storing the object in the bucket.

    Result:

    ```bash
    etag: '"d41d8cd98f00b204e980099********"'
    request_id: 3f2705f********      
    ```