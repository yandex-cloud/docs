# Resolving issues with incorrect MIME-types of objects when uploading them to {{ objstorage-short-name }}



## Issue description {#issue-description}

* You encounter errors when accessing objects uploaded to {{ objstorage-short-name }} (images are not displayed, scripts do not work).
* The JavaScript console of the browser shows errors about an invalid mime-type of objects uploaded from the bucket.

## Solution {#issue-resolution}

{{ objstorage-short-name }} reports that the objects uploaded to the buckets have the Content-Type specified during the upload.
If the Content-Type was omitted at upload, objects are assigned the default object Content-Type: `binary/octet-stream`.

Check the configuration of the S3 client you previously used to upload objects to the bucket specifies a relevant Content-Type. You need to explicitly specify it when uploading a file to the bucket. You can also specify it for previously uploaded objects via the [S3 client or SDK](../../../storage/tools/index.md) of your choice:

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

If the above actions did not help solve the problem, create a [request for technical support]({{ link-console-support }}).
When creating the request, provide the following information:

1. Bucket ID in {{ objstorage-short-name }}.
2. Link to the problematic object.
3. Output from the JS console of the browser with the error or [HAR file](../../../support/create-har.md).
