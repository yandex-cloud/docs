---
title: Deleting a partially uploaded object in {{ objstorage-full-name }}
description: Follow this guide to delete a partially uploaded object from a bucket in {{ objstorage-name }}.
---

# Deleting a partially uploaded object

You can upload an object in parts using [multipart upload](../../concepts/multipart.md).

{% include [auto-delete-all-multipart](../../../_includes/storage/auto-delete-all-multipart.md) %}

To manually delete a partially uploaded object:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket that contains a partially uploaded object.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. To see all versions of objects in the list, enable **{{ ui-key.yacloud.storage.bucket.switch_file-versions }}** to the right of the object search field in the bucket.
  1. Hover over the yellow field next to the object count.
  1. Click **{{ ui-key.yacloud.storage.buckets.button_open-multipart-uploads }}** as soon as it appears.
  1. Select incomplete uploads you want to delete.
  1. Click **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

  In the management console, the information about the number of objects and storage space used in the bucket is updated with a few minutes' delay.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get a list of incomplete multipart uploads:

      1. See the description of the CLI command to get a list of incomplete multipart uploads in a bucket:

          ```bash
          yc storage s3api list-multipart-uploads --help
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

      1. Run the command below by specifying the bucket name:

          ```bash
          yc storage s3api list-multipart-uploads \
            --bucket <bucket_name>
          ```

          Result:

          ```yaml
          bucket: first-bucket
          max_uploads: "1000"
          uploads:
            - key: video.mp4
              upload_id: 000629B7********
              initiator:
                id: ajeol2afu1js********
                display_name: ajeol2afu1js********
              owner:
                id: ajeol2afu1js********
                display_name: ajeol2afu1js********
              storage_class: STANDARD
              initiated_at: "2024-12-20T18:05:07.312Z"
            - key: video1.mp4
              upload_id: 000629B7********
              initiator:
                id: ajeol2afu1js********
                display_name: ajeol2afu1js********
              owner:
                id: ajeol2afu1js********
                display_name: ajeol2afu1js********
              storage_class: STANDARD
              initiated_at: "2024-12-20T18:20:15.747Z"
          request_id: 75dbac97********
          ```

          Save the multipart upload ID (`uploads.upload_id`) value of the partially uploaded object you want to delete. You will need this value in the next step.

          For more information about the `yc storage s3api list-multipart-uploads` command, see the [CLI reference](../../../cli/cli-ref/storage/cli-ref/s3api/list-multipart-uploads.md).

  1. Delete the partially uploaded object:

      1. See the description of the CLI command to delete a partially uploaded object:

          ```bash
          yc storage s3api abort-multipart-upload --help
          ```
      1. Run this command:

          ```bash
          yc storage s3api abort-multipart-upload \
            --bucket <bucket_name> \
            --key <object_key> \
            --upload-id <multipart_upload_ID>
          ```

          Where:

          * `--bucket`: Name of the bucket in which you want to delete the partially uploaded object.
          * `--key`: [Key](../../concepts/object.md#key) of the object to delete.
          * `--upload-id`: Multipart upload ID obtained in the previous step.

          Result:

          ```text
          request_id: 573ea6e2********
          ```

          For more information about the `yc storage s3api abort-multipart-upload` command, see the [CLI reference](../../../cli/cli-ref/storage/cli-ref/s3api/abort-multipart-upload.md).

- AWS CLI {#aws-cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  1. Get a list of incomplete multipart uploads:

      1. Get a list of available buckets:

          ```bash
          aws s3api list-buckets \
            --endpoint-url=https://{{ s3-storage-host }} 
          ```

          Result:

          ```json
          {
            "Buckets": [
              {
                "Name": "new-bucket",
                "CreationDate": "2024-12-20T17:48:17+00:00"
              },
              {
                "Name": "first-bucket",
                "CreationDate": "2023-12-28T12:20:49.538000+00:00"
              }
            ],
            "Owner": {
              "DisplayName": "",
              "ID": ""
            }
          }
          ```

      1. Run the command below by specifying the bucket name:

          ```bash
          aws s3api list-multipart-uploads \
            --endpoint-url=https://{{ s3-storage-host }} \
            --bucket <bucket_name>
          ```

          Result:

          ```json
          {
            "Uploads": [
              {
                "UploadId": "000629C2********",
                "Key": "video.mp4",
                "Initiated": "2024-12-21T07:40:03.562000+00:00",
                "StorageClass": "STANDARD",
                "Owner": {
                  "DisplayName": "ajegtlf2q28a********",
                  "ID": "ajegtlf2q28a********"
                },
                "Initiator": {
                  "ID": "ajegtlf2q28a********",
                  "DisplayName": "ajegtlf2q28a********"
                }
              },
              {
                "UploadId": "000629C2********",
                "Key": "video1.mp4",
                "Initiated": "2024-12-21T07:42:39.492000+00:00",
                "StorageClass": "STANDARD",
                "Owner": {
                  "DisplayName": "ajegtlf2q28a********",
                  "ID": "ajegtlf2q28a********"
                },
                "Initiator": {
                  "ID": "ajegtlf2q28a********",
                  "DisplayName": "ajegtlf2q28a********"
                }
              }
            ],
            "RequestCharged": null
          }
          ```

          Save the multipart upload ID (`Uploads.UploadId`) value of the partially uploaded object you want to delete. You will need this value in the next step.

  1. Delete the partially uploaded object:

      ```bash
      aws s3api abort-multipart-upload \
        --endpoint-url=https://{{ s3-storage-host }} \
        --bucket <bucket_name> \
        --key <object_key> \
        --upload-id <multipart_upload_ID>
      ```

      Where:

      * `--bucket`: Name of the bucket in which you want to delete the partially uploaded object.
      * `--key`: [Key](../../concepts/object.md#key) of the object to delete.
      * `--upload-id`: Multipart upload ID obtained in the previous step.

- API {#api}

  To get a list of multipart uploads, use the [listUploads](../../s3/api-ref/multipart/listuploads.md) S3 API method.

  To delete a partially uploaded object, use the [abortUpload](../../s3/api-ref/multipart/abortupload.md) S3 API method.

{% endlist %}

