{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. View the description of the CLI command to get an object pre-signed URL:

    ```bash
    yc storage s3 presign --help
    ```

1. {% include [bucket-list-cli](../../_includes/storage/bucket-list-cli.md) %}

1. Generate a pre-signed URL. You can do this either via the {{ yandex-cloud }} API on behalf of the [account](../../iam/concepts/users/accounts.md) currently authenticated in the {{ yandex-cloud }} CLI profile, or locally on behalf of the [service account](../../iam/concepts/users/service-accounts.md), providing its [static access key](../../iam/concepts/authorization/access-key.md) in the command.

    {% list tabs %}

    - Using the {{ yandex-cloud }} API

      To generate a pre-signed URL to upload an object on behalf of the account currently authenticated in the {{ yandex-cloud }} CLI profile, run this command:

      ```bash
      yc storage s3 presign \
        s3://<bucket_name>/<object_key> \
        --expires-in <link_validity> \
        --http-method PUT
      ```

      Where:

      {% include [get-presigned-upload-link-cli-legend-part1](../../_includes/storage/get-presigned-upload-link-cli-legend-part1.md) %}

      Result:

      ```text
      https://{{ s3-storage-host }}/first-bucket/sample.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEwkbVN5BKvE2wqYiZCzlQ%2F20260205%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20260205T131200Z&X-Amz-Expires=3600&X-Amz-Signature=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&X-Amz-SignedHeaders=host
      ```

    - Local

      To generate a pre-signed URL to upload an object locally on behalf of a service account, run this command:

      ```bash
      yc storage s3 presign \
        s3://<bucket_name>/<object_key> \
        --expires-in <link_validity> \
        --http-method PUT \
        --local \
        --access-key <key_ID> \
        --secret-key <secret_key>
      ```

      Where:

      {% include [get-presigned-upload-link-cli-legend-part1](../../_includes/storage/get-presigned-upload-link-cli-legend-part1.md) %}

      * `--access-key`: Static access key ID of the service account.
      * `--secret-key`: Secret key of the service account static access key.

      Result:

      ```text
      https://{{ s3-storage-host }}/first-bucket/sample.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJE98uTrKJwAtqwrHJXNh5L%2F20250904%2Fdefault%2Fs3%2Faws4_request&X-Amz-Date=20250904T072650Z&X-Amz-Expires=36000&X-Amz-SignedHeaders=host&x-id=PutObject&X-Amz-Signature=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      ```

    {% endlist %}

1. To upload the file using the pre-signed URL, run this command:

   ```bash
   curl --request PUT \
     --upload-file <file_path> \
     "<obtained_pre-signed_URL>"
   ```

   Where:
   * `<file_path>`: Path to the local file to upload to the bucket, e.g., `~/sample.txt` or `./sample.txt`.
   * `<obtained_pre-signed_URL>`: URL you got in the previous step.

   Here is an example:

   ```bash
   curl --request PUT \
     --upload-file ~/sample.txt \
     "https://{{ s3-storage-host }}/first-bucket/sample.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEwkbVN5BKvE2wqYiZCzlQ%2F20260205%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20260205T131200Z&X-Amz-Expires=3600&X-Amz-Signature=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&X-Amz-SignedHeaders=host"
   ```

   If the file is uploaded successfully, the command will not return any message. To view the request details, add the `--verbose` flag.