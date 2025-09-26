{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. View the description of the CLI command to get an object pre-signed URL:

    ```bash
    yc storage s3 presign --help
    ```

1. {% include [bucket-list-cli](../../_includes/storage/bucket-list-cli.md) %}
1. View a list of objects in the bucket by specifying its [name](../concepts/bucket.md#naming):

    ```bash
    yc storage s3api list-objects \
      --bucket <bucket_name>
    ```

    Result:

    ```text
    contents:
      - key: sample.txt
        last_modified: "2025-09-04T06:02:16.884Z"
        etag: '"7bd56d2f6096d582420e8a01********"'
        size: "17"
        owner:
          id: ajeol2afu1js********
          display_name: ajeol2afu1js********
        storage_class: STANDARD
    name: first-bucket
    max_keys: "1000"
    key_count: "1"
    request_id: 338862e1********
    ```

1. Generate a pre-signed URL. You can do this either via the {{ yandex-cloud }} API on behalf of the [account](../../iam/concepts/users/accounts.md) currently authenticated in the {{ yandex-cloud }} CLI profile, or locally on behalf of the [service account](../../iam/concepts/users/service-accounts.md), providing its [static access key](../../iam/concepts/authorization/access-key.md) in the command.

    {% list tabs %}

    - Using the {{ yandex-cloud }} API

      To generate a pre-signed URL to download an object on behalf of the account currently authenticated in the {{ yandex-cloud }} CLI profile, run this command:

      ```bash
      yc storage s3 presign \
        s3://<bucket_name>/<object_key> \
        --expires-in <link_validity> \
        --as-attachment
      ```

      Where:

      {% include [get-presigned-link-cli-legend-part1](../../_includes/storage/get-presigned-link-cli-legend-part1.md) %}

      Result:

      ```text
      https://{{ s3-storage-host }}/first-bucket/sample.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEIUp_5V5nBFDgIgh-NLc2%2F20250904%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20250904T063033Z&X-Amz-Expires=36000&X-Amz-Signature=d661b64566753dba1ef66b467e56db0e7f7c69581b0ddd2c8a0a7b505bc3ff61&X-Amz-SignedHeaders=host&response-content-disposition=attachment
      ```

    - Locally

      To generate a pre-signed URL to download an object locally on behalf of a service account, run this command:

      ```bash
      yc storage s3 presign \
        s3://<bucket_name>/<object_key> \
        --expires-in <link_validity> \
        --as-attachment \
        --local \
        --access-key <key_ID> \
        --secret-key <secret_key>
      ```

      Where:

      {% include [get-presigned-link-cli-legend-part1](../../_includes/storage/get-presigned-link-cli-legend-part1.md) %}

      * `--access-key`: Static access key ID of the service account.
      * `--secret-key`: Secret key of the service account static access key.

      Result:

      ```text
      https://{{ s3-storage-host }}:443/first-bucket/sample.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJE98uTrKJwAtqwrHJXNh5L%2F20250904%2Fdefault%2Fs3%2Faws4_request&X-Amz-Date=20250904T072650Z&X-Amz-Expires=36000&X-Amz-SignedHeaders=host&response-content-disposition=attachment&x-id=GetObject&X-Amz-Signature=e60562ef242588eec44916ad9e97d2864b250a73f4e5a70e29bb2bd8926249b0
      ```

    {% endlist %}