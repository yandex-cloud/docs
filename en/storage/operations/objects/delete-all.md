---
title: Deleting all objects from a bucket in {{ objstorage-full-name }}
description: Follow this guide to delete all objects from a bucket in {{ objstorage-name }}.
---

# Deleting all objects from a bucket

{% include [auto-delete-all-multipart](../../../_includes/storage/auto-delete-all-multipart.md) %}

To clear a bucket and avoid storage[charges](../../pricing.md):

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting objects:

      ```bash
      yc storage s3api delete-objects --help
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

  1. Prepare a JSON file listing the objects to delete. Here is an example of its contents:

      ```json
      {
          "Objects": [
              {
                  "Key": "<object_key>"
              },
              {
                  "Key": "<object_key>"
              },
              ...
          ]          
      }
      ```

      Where:

      * `Objects`: Array of objects to delete.
      * `Key`: Object [key](../../concepts/object.md#key). 

  1. Run this command:

      ```bash
      yc storage s3api delete-objects \
        --bucket <bucket_name> \
        --delete <path_to_JSON_file>
      ```

      Where:

      * `--bucket`: Name of your bucket.
      * `--delete`: Path to the JSON file listing the objects to delete.

      Result:

      ```bash
      deleted:
        - key: file-1
          version_id: "null"
        - key: file-2
          version_id: "null"
      request_id: 4c35e7d4********
      ```

- AWS CLI {#aws-cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  1. Create a variable containing the bucket name:
  
     ```bash
     BUCKET_NAME=<bucket_name>
     ```
     
  1. Delete all object versions from the bucket:
    
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

     You can also use `--max-keys` instead of the `--max-items` parameter.

     Result:
         
     ```json
     {
         "Deleted": [
             {
                 "Key": "object_000",
                 "VersionId": "0005CDD3********"
             },
             {
                 "Key": "object_001",
                 "VersionId": "0005CDD3********"
             },
             ...
         ]
     }
     ```
         
     Using this command, you can delete a maximum of 1,000 object versions at a time due to the `aws s3api delete-objects` limitations. If your bucket contains more versions, run the command multiple times.
  
  1. For buckets with enabled [versioning](../../concepts/versioning.md), remove all delete markers:
       
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

     You can also use `--max-keys` instead of the `--max-items` parameter.

     Result:
       
     ```json
     {
         "Deleted": [
             {
                 "Key": "object_034",
                 "DeleteMarker": true,
                 "DeleteMarkerVersionId": "0005CDD3********"
             },
             {
                 "Key": "object_057",
                 "DeleteMarker": true,
                 "DeleteMarkerVersionId": "0005CDD3********"
             },
             ...
         ]
     }
     ```
     
     Using this command, you can delete a maximum of 1,000 delete markers at a time due to the `aws s3api delete-objects` limitations. If your bucket contains more delete markers, run the command multiple times.
   
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
       
     The list may include parts of objects whose upload started before and completed after the preceding step. If the list is not empty, repeat steps 4 and 5.
     
- Python (boto3) {#boto3}

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

- API {#api}

  Use the [deleteMultipleObjects](../../s3/api-ref/object/deletemultipleobjects.md) S3 API method.

{% endlist %}

In the management console, the information about the number of objects and storage space used in the bucket is updated with a few minutes' delay.