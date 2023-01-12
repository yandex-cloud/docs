# Deleting all objects in a bucket

To clear a bucket{% if product == "yandex-cloud" %} and not {% if audience != "internal" %}[pay](../../pricing.md){% else %}pay{% endif %} for storage{% endif %}:

{% list tabs %}

- AWS CLI

   If you don't have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   1. Create a variable containing the bucket name:

      ```bash
      BUCKET_NAME=<bucket_name>
      ```

   1. Delete all versions of objects from the bucket:

      ```bash
      aws s3api delete-objects \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket $BUCKET_NAME \
        --delete \
          "$(aws s3api list-object-versions \
            --endpoint-url https://{{ s3-storage-host }} \
            --bucket $BUCKET_NAME \
            --query '{Objects: Versions[].{Key: Key, VersionId: VersionId}}' \
            --max-items 1000)"
      ```

      Result:

      ```json
      {
          "Deleted": [
              {
                  "Key": "object_000",
                  "VersionId": "0005CDD3521954A6"
              },
              {
                  "Key": "object_001",
                  "VersionId": "0005CDD3523B6ADB"
              },
              ...
          ]
      }
      ```

      With this command, you can delete up to 1000 versions of objects: this is related to restrictions for the `aws s3api delete-objects` operation. If there are more versions in the bucket, run the command several times.

   1. If the bucket has [versioning](../../concepts/versioning.md) enabled, delete all the delete markers:

      ```bash
      aws s3api delete-objects \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket $BUCKET_NAME \
        --delete \
          "$(aws s3api list-object-versions \
            --endpoint-url https://{{ s3-storage-host }} \
            --bucket $BUCKET_NAME \
            --query '{Objects: DeleteMarkers[].{Key: Key, VersionId: VersionId}}' \
            --max-items 1000)"
      ```

      Result:

      ```json
      {
          "Deleted": [
              {
                  "Key": "object_034",
                  "DeleteMarker": true,
                  "DeleteMarkerVersionId": "0005CDD35274A467"
              },
              {
                  "Key": "object_057",
                  "DeleteMarker": true,
                  "DeleteMarkerVersionId": "0005CDD3528B1BC3"
              },
              ...
          ]
      }
      ```

      With this command, you can delete up to 1000 delete markers: this is related to restrictions for the `aws s3api delete-objects` operation. If there are more versions in the bucket, run the command several times.

   1. Delete partially uploaded objects:

      ```bash
      aws s3api list-multipart-uploads \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket $BUCKET_NAME \
      | jq -r '.Uploads[] | "--key \"\(.Key)\" --upload-id \(.UploadId)"' \
      | while read -r line; do
        eval
          "aws s3api abort-multipart-upload \
            --endpoint-url https://{{ s3-storage-host }} \
            --bucket $BUCKET_NAME \
            $line";
      done
      ```

   1. Get a list of object parts remaining in the bucket:

      ```bash
      aws s3api list-multipart-uploads \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket $BUCKET_NAME \
      | jq -r '.Uploads[] | "--key \"\(.Key)\" --upload-id \(.UploadId)"' \
      | while read -r line; do
        eval
          "aws s3api list-parts \
            --endpoint-url https://{{ s3-storage-host }} \
            --bucket $BUCKET_NAME \
            $line";
      done
      ```

      The list may contain parts of objects that began uploading before and finished uploading after the previous step executed. If the list is not empty, repeat steps 4 and 5.

- Python 3 (boto3)

   Run the following code:

   ```python
   import boto3

   bucket_name = '<bucket_name>'
   s3 = boto3.resource('s3',
       endpoint_url='https://{{ s3-storage-host }}',
       aws_access_key_id='<key_ID>',
       aws_secret_access_key='<secret_key>')
   bucket = s3.Bucket(bucket_name)

   # Deleting all versions (works for non-versioned buckets too).
   bucket.object_versions.delete()

   # Aborting all multipart uploads, which also deletes all parts.
   for multipart_upload in bucket.multipart_uploads.iterator():
       # Part uploads that are currently in progress may or may not succeed,
       # so it might be necessary to abort a multipart upload multiple times.
       while len(list(multipart_upload.parts.all())) > 0:
           multipart_upload.abort()
   ```

{% endlist %}
