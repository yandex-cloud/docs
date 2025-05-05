---
title: Uploading an object to a {{ objstorage-full-name }} bucket using a multipart upload
description: Follow this guide to upload an object to an {{ objstorage-name }} bucket in parts.
---

# Multipart upload

A network failure while uploading an [object](../../concepts/object.md) to an {{ objstorage-name }} [bucket](../../concepts/bucket.md) will terminate the upload, so you will have to re-upload your file. The larger the file size, the longer the upload, thus increasing the risk of network errors.

Therefore, a [multipart upload](../../concepts/multipart.md) is a better choice when uploading large files to the bucket. If there is a network failure when uploading a file part, you will only need to re-upload that one part, not the whole file.

To upload an object to the bucket in parts:

## Split your file into parts {#split}

On your PC, split your original file into parts of preferred size, e.g., using the `split` command:

```bash
split -b 100M ./video.mp4 part.
```

Where:

* `100M`: Size of file parts. In this example, the size is `100 MB`.

    The `M` suffix means the size is in MB. You can also use the `K` and `G` suffixes for KB and GB, respectively.
* `./video.mp4`: Path to the original file you need to split into parts to upload to the bucket.
* `part.`: File name prefix for the parts.

Result:

```text
% ls -l
total 822368
-rw-r--r--@ 1 User  group  104857600 Dec 20 22:56 part.aa
-rw-r--r--@ 1 User  group  104857600 Dec 20 22:56 part.ab
-rw-r--r--@ 1 User  group     808601 Dec 20 22:56 part.ab
-rwx------@ 1 User  group  210523801 Feb 24  2023 video.mp4
```

The `split` command has split `video.mp4` into three parts: `part.aa`, `part.ab`, and `part.ab`.

## Create a multipart upload in a bucket {#create-multipart-upload}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating a multipart upload to upload an object into a bucket:

      ```bash
      yc storage s3api create-multipart-upload --help
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

  1. Create a multipart upload:

      ```bash
      yc storage s3api create-multipart-upload \
        --bucket <bucket_name> \
        --key <object_key>
      ```

      Where:

      * `--bucket`: Name of your bucket.
      * `--key`: Object [key](../../concepts/object.md#key) you will use to store the object in the bucket.

      Result:

      ```text
      request_id: 644e7c89********
      bucket: first-bucket
      key: video.mp4
      upload_id: 000629B7********
      ```

      Save the multipart upload ID (`upload_id`), as you will need it for the following steps.

      For more information about the `yc storage s3api create-multipart-upload` command, see the [CLI reference](../../../cli/cli-ref/storage/cli-ref/s3api/create-multipart-upload.md).

- AWS CLI {#aws-cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

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

  1. Create a multipart upload:

      ```bash
      aws s3api create-multipart-upload \
        --endpoint-url=https://{{ s3-storage-host }} \
        --bucket <bucket_name> \
        --key <object_key>
      ```

      Where:

      * `--bucket`: Name of your bucket.
      * `--key`: Object [key](../../concepts/object.md#key) you will use to store the object in the bucket.

      Result:

      ```json
      {
        "Bucket": "first-bucket",
        "Key": "video.mp4",
        "UploadId": "000629C2********"
      }
      ```

      Save the multipart upload ID (`UploadId`), as you will need it for the following steps.

- API {#api}

  Use the [startUpload](../../s3/api-ref/multipart/startupload.md) S3 API method to create a multipart upload in your bucket.

{% endlist %}

## Upload parts of the object to the bucket {#upload-parts}

Upload the first part of the object:

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  1. See the description of the CLI command for uploading a part of the object to a bucket:

      ```bash
      yc storage s3api upload-part --help
      ```

  1. Run this command:

      ```bash
      yc storage s3api upload-part \
        --bucket <bucket_name> \
        --key <object_key> \
        --upload-id <multipart_upload_ID> \
        --part-number <part_number> \
        --body <path_to_part_file>
      ```

      Where:

      * `--bucket`: Name of your bucket.
      * `--key`: Object [key](../../concepts/object.md#key) you will use to store the object in the bucket.
      * `--upload-id`: Multipart upload ID obtained in the previous step.
      * `--part-number`: Sequential number of the object part uploaded to the bucket.

          The number uniquely identifies the part and determines its position in the general sequence. The number is an integer from 1 to 10,000 inclusive.
          
          If multiple parts with the same number are uploaded, {{ objstorage-name }} saves the last one received.
          
          Each part, except the last one, should be at least 5 MB in size.
      * `--body`: Path to the file with the part on your PC.

      Result:

      ```text
      request_id: 7ab2820f********
      etag: '"a2c44573954874e1a62a3f59********"'
      ```

      Save the `etag` value: you will need it to assemble the object from parts on the {{ objstorage-name }} bucket side.

      For more information about the `yc storage s3api upload-part` command, see the [CLI reference](../../../cli/cli-ref/storage/cli-ref/s3api/upload-part.md).

- AWS CLI {#aws-cli}

  ```bash
  aws s3api upload-part \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <bucket_name> \
    --key <object_key> \
    --upload-id <multipart_upload_ID> \
    --part-number <part_number> \
    --body <path_to_part_file>
  ```

  Where:

  * `--bucket`: Name of your bucket.
  * `--key`: Object [key](../../concepts/object.md#key) you will use to store the object in the bucket.
  * `--upload-id`: Multipart upload ID obtained in the previous step.
  * `--part-number`: Sequential number of the object part uploaded to the bucket.

      The number uniquely identifies the part and determines its position in the general sequence. The number is an integer from 1 to 10,000 inclusive.
      
      If multiple parts with the same number are uploaded, {{ objstorage-name }} saves the last one received.
      
      Each part, except the last one, should be at least 5 MB in size.
  * `--body`: Path to the file with the part on your PC.

  Result:

  ```json
  {
      "ETag": "\"a2c44573954874e1a62a3f59********\""
  }
  ```

  Save the `ETag` value: you will need it to assemble the object from parts on the {{ objstorage-name }} bucket side.

- API {#api}

  To upload a part of an object to a bucket, use the [uploadPart](../../s3/api-ref/multipart/uploadpart.md) S3 API method.

{% endlist %}

Similarly, upload the other object parts by successively replacing `--part-number` and the `--body` path to the part's file in your commands. Do not forget to save the unique `etag` value you will get for each part you upload.

## Complete your multipart upload {#complete-upload}

Once all the parts are successfully uploaded, complete the multipart upload and assemble the parts into a whole object:

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  1. See the description of the CLI command for completing a multipart upload:

      ```bash
      yc storage s3api complete-multipart-upload --help
      ```

  1. Run this command:

      ```bash
      yc storage s3api complete-multipart-upload \
        --bucket <bucket_name> \
        --key <object_key> \
        --upload-id <multipart_upload_ID> \
        --multipart-upload \
          '{"Parts": [{"PartNumber": <part_1_number>, "ETag": "<part_1_etag_value>"}, {"PartNumber": <part_2_number>, "ETag": "<part_2_etag_value>"}, ..., {"PartNumber": <part_n_number>, "ETag": "<part_n_etag_value>"}]}'
      ```

      Where:

      * `--bucket`: Name of your bucket.
      * `--key`: Object [key](../../concepts/object.md#key) you will use to store the object in the bucket.
      * `--upload-id`: Multipart upload ID obtained in the previous step.
      * `--multipart-upload`: Object containing the sequential numbers and `etag` values of all uploaded parts in proper order. Here is an example:

          ```json
          --multipart-upload \
            '{"Parts": [{"PartNumber": 1, "ETag": "a2c44573954874e1a62a3f59********"}, {"PartNumber": 2, "ETag": "3c0e70e1d05bd4e2500f5a90********"}, {"PartNumber": 3, "ETag": "953ecfff0150fd0970008320********"}]}'
          ```

      Result:

      ```text
      request_id: bde94875********
      bucket: first-bucket
      key: video.mp4
      etag: '"040d1fe80bd1d4f12728b192********-3"'
      location: https://{{ s3-storage-host }}:443/first-bucket/video.mp4
      ```

      For more information about the `yc storage s3api complete-multipart-upload` command, see the [CLI reference](../../../cli/cli-ref/storage/cli-ref/s3api/complete-multipart-upload.md).

- AWS CLI {#aws-cli}

  ```bash
  aws s3api complete-multipart-upload \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <bucket_name> \
    --key <object_key> \
    --upload-id <multipart_upload_ID> \
    --multipart-upload \
      '{"Parts": [{"PartNumber": <part_1_number>, "ETag": "<part_1_etag_value>"}, {"PartNumber": <part_2_number>, "ETag": "<part_2_etag_value>"}, ..., {"PartNumber": <part_n_number>, "ETag": "<part_n_etag_value>"}]}'
  ```

  Where:

  * `--bucket`: Name of your bucket.
  * `--key`: Object [key](../../concepts/object.md#key) you will use to store the object in the bucket.
  * `--upload-id`: Multipart upload ID obtained in the previous step.
  * `--multipart-upload`: Object containing the sequential numbers and `etag` values of all uploaded parts in proper order. Here is an example:

      ```json
      --multipart-upload \
        '{"Parts": [{"PartNumber": 1, "ETag": "a2c44573954874e1a62a3f59********"}, {"PartNumber": 2, "ETag": "3c0e70e1d05bd4e2500f5a90********"}, {"PartNumber": 3, "ETag": "953ecfff0150fd0970008320********"}]}'
      ```

  Result:

  ```json
  {
    "Location": "https://{{ s3-storage-host }}/first-bucket/video.mp4",
    "Bucket": "first-bucket",
    "Key": "video.mp4",
    "ETag": "\"040d1fe80bd1d4f12728b192********-3\""
  }
  ```

- API {#api}

  Use the [completeUpload](../../s3/api-ref/multipart/completeupload.md) S3 API method to complete your multipart upload.

{% endlist %}

An object with the prefix you specified has thus been created from uploaded parts in an {{ objstorage-name }} bucket. View [this guide](./info.md) to get the information about the new object.