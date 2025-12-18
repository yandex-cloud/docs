# Fixing issues with incorrect MIME types of objects when uploading them to {{ objstorage-short-name }}



## Issue description {#issue-description}

* You encounter errors when accessing objects uploaded to {{ objstorage-short-name }}, e.g., images are not displayed or scripts do not work.
* The JavaScript console of your browser shows invalid MIME type errors for objects uploaded from the bucket.

## Solution {#issue-resolution}

For objects uploaded to the buckets, {{ objstorage-short-name }} provides the `Content-Type` specified during the upload.
If you did not specify the `Content-Type`, objects get the default `Content-Type`, `binary/octet-stream`.

Make sure the configuration of the S3 client you used to upload objects to the bucket contains the correct `Content-Type`. You need to explicitly specify it when uploading a file to the bucket. You can also specify it for previously uploaded objects via the [S3 client or SDK](../../../storage/tools/index.md) of your choice:

{% list tabs %}

- AWS CLI
    ```
    aws s3 cp --endpoint-url=https://storage.yandexcloud.net \
    s3://<bucket-name>/ \
    s3://<bucket-name>/ \
    --exclude '*' \
    --include '*.js' \
    --no-guess-mime-type \
    --content-type="application/javascript" \
    --metadata-directive="REPLACE" \
    --recursive
    ```
- s3cmd
    ```
    s3cmd put --recursive \
    --exclude "*" \
    --include "*.js" \
    --no-mime-magic \
    --mime-type="application/javascript" \
    --no-preserve \
    --acl-public \
    /path/to/local/directory \
    s3://<bucket-name>/
    ```
{% endlist %}

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Bucket ID in {{ objstorage-short-name }}.
1. Link to the object in question.
1. Output from the JavaScript console of your browser with the error, or [HAR file](../../../support/create-har.md).
