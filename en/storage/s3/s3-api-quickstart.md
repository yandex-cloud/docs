---
title: Getting started with the S3 API in {{ objstorage-full-name }}
description: In this article, you will learn how to run basic operations in {{ objstorage-full-name }} using the AWS S3 API.
---

# Getting started with the AWS S3 API in {{ objstorage-full-name }}

[AWS S3 API](https://docs.aws.amazon.com/AmazonS3/latest/API/Type_API_Reference.html) is a {{ objstorage-full-name }}-compatible interface for working with AWS services.

With the AWS S3 API, you will create a bucket, upload an object to it, get a list of objects in the bucket, download an object from the bucket, delete an object, and delete the bucket.

{% note info %}

To use the AWS S3 API directly (without an SDK or apps), you will need to [sign requests yourself](./signing-requests.md). You can test the request and signature generation using the AWS CLI in [debug mode](./signing-requests.md#debugging).

{% endnote %}

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Create a service account and static access key {#create-static-key}

To authenticate with the [AWS S3 API](../s3/api-ref/), use a [static access key](../../iam/concepts/authorization/access-key.md). A static access key is issued for a specific [service account](../../iam/concepts/users/service-accounts.md), and all actions involving this key are performed on behalf of this service account.

1. [Create a service account](../../iam/operations/sa/create.md).
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.editor` [role](../security/index.md#storage-editor) for the folder to the service account. This will allow you to work with all buckets in the folder on behalf of this service account.
1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

    {% include [get-static-key-info](../../_includes/storage/get-static-key-result.md) %}
1. Install [curl](https://curl.se/).

    Starting from version [8.3.0](https://curl.se/changes.html), the `curl` utility supports automatic generation of the [signature string](./signing-requests.md#string-to-sign-gen), [request signing](./signing-requests.md#signing), and substitution of the required headers when working with the AWS S3 API.

    In earlier `curl` versions, you can form the required headers and sign requests manually.

## Create a bucket {#create-bucket}

{% list tabs group=programming_language %}

- curl 8.3.0 and higher {#curl-830}

  1. Set the variables containing the required data:

      ```bash
      AWS_KEY_ID="<static_key_ID>"
      AWS_SECRET_KEY="<secret_key>"
      BUCKET_NAME="<bucket_name>"
      ```

      Where:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME`: [Name](../concepts/bucket.md#naming) of the bucket you are creating.

  1. Run an http request:

      ```bash
      curl \
        --request PUT \
        --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
        --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}"
      ```

      Result:

      ```text
      ...
      < HTTP/2 200
      < server: nginx
      < date: Wed, 14 May 2025 20:00:04 GMT
      < content-type: application/octet-stream
      < location: /my-sample-bucket
      < x-amz-request-id: a5cf0b8d********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

- curl 8.2.1 and lower {#curl-821}

  1. Set the variables containing the required data:

      ```bash
      AWS_KEY_ID="<static_key_ID>"
      AWS_SECRET_KEY="<secret_key>"
      BUCKET_NAME="<bucket_name>"
      DATE_VALUE=`date -R`
      STRING_TO_SIGN="PUT\n\n${CONTENT_TYPE}\n${DATE_VALUE}\n/${BUCKET_NAME}"
      SIGNATURE=`echo -en ${STRING_TO_SIGN} | openssl sha1 -hmac ${AWS_SECRET_KEY} -binary | base64`
      ```

      Where:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME`: [Name](../concepts/bucket.md#naming) of the bucket you are creating.

  1. Run an http request:

      ```bash
      curl \
        --request PUT \
        --verbose \
        --header "Host: {{ s3-storage-host }}" \
        --header "Date: ${DATE_VALUE}" \
        --header "Authorization: AWS ${AWS_KEY_ID}:${SIGNATURE}" \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}"
      ```

      Result:

      ```text
      ...
      < HTTP/2 200
      < server: nginx
      < date: Thu, 15 May 2025 07:06:22 GMT
      < content-type: application/octet-stream
      < location: /my-sample-bucket
      < x-amz-request-id: b8c1bd45********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

{% endlist %}


## Upload an object to the bucket {#upload-object}

{% list tabs group=programming_language %}

- curl 8.3.0 and higher {#curl-830}

  1. Set the variables containing the required data:

      ```bash
      AWS_KEY_ID="<static_key_ID>"
      AWS_SECRET_KEY="<secret_key>"
      LOCAL_FILE="<local_file_path>"
      BUCKET_NAME="<bucket_name>"
      OBJECT_PATH="<object_key>"
      ```

      Where:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `LOCAL_FILE`: Path to the local file you want to upload, e.g., `./sample.txt`.
      * `BUCKET_NAME`: [Name of the bucket](../concepts/bucket.md#naming) to upload the file to.
      * `OBJECT_PATH`: [Key](../concepts/object.md#key) to assign to the object in the bucket, e.g. `new-prefix/sample-object.txt`.

  1. Run an http request:

      ```bash
      curl \
        --request PUT \
        --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
        --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
        --upload-file "${LOCAL_FILE}" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
      ```

      Result:

      ```text
      ...
      < HTTP/2 200
      < server: nginx
      < date: Thu, 15 May 2025 07:17:46 GMT
      < content-type: text/plain
      < etag: "f75a361db63aa4722fb8e083********"
      < x-amz-request-id: 40afeceb********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

- curl 8.2.1 and lower {#curl-821}

  1. Set the variables containing the required data:

      ```bash
      AWS_KEY_ID="<static_key_ID>"
      AWS_SECRET_KEY="<secret_key>"
      LOCAL_FILE="<local_file_path>"
      BUCKET_NAME="<bucket_name>"
      OBJECT_PATH="<object_key>"
      DATE_VALUE=`date -R`
      STRING_TO_SIGN="PUT\n\n${CONTENT_TYPE}\n${DATE_VALUE}\n/${BUCKET_NAME}/${OBJECT_PATH}"
      SIGNATURE=`echo -en ${STRING_TO_SIGN} | openssl sha1 -hmac ${AWS_SECRET_KEY} -binary | base64`
      ```

      Where:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `LOCAL_FILE`: Path to the local file you want to upload, e.g., `./sample.txt`.
      * `BUCKET_NAME`: [Name of the bucket](../concepts/bucket.md#naming) to upload the file to.
      * `OBJECT_PATH`: [Key](../concepts/object.md#key) to assign to the object in the bucket, e.g. `new-prefix/sample-object.txt`.
  
  1. Run an http request:

      ```
      curl \
        --request PUT \
        --upload-file "${LOCAL_FILE}" \
        --verbose \
        --header "Host: {{ s3-storage-host }}" \
        --header "Date: ${DATE_VALUE}" \
        --header "Authorization: AWS ${AWS_KEY_ID}:${SIGNATURE}" \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
      ```

      Result:

      ```text
      ...
      < HTTP/2 200
      < server: nginx
      < date: Thu, 15 May 2025 07:23:08 GMT
      < content-type: text/plain
      < etag: "f75a361db63aa4722fb8e083********"
      < x-amz-request-id: 67ccce91********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

{% endlist %}


## Get a list of objects in the bucket {#list-bucket-objects}

{% list tabs group=programming_language %}

- curl 8.3.0 and higher {#curl-830}

  1. Set the variables containing the required data:

      ```bash
      AWS_KEY_ID="<static_key_ID>"
      AWS_SECRET_KEY="<secret_key>"
      BUCKET_NAME="<bucket_name>"
      ```

      Where:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME`: [Name](../concepts/bucket.md#naming) of the bucket from which you want to get a list of objects.

  1. Run an http request:

      ```bash
      curl \
        --request GET \
        --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
        --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}?list-type=2"
      ```

      Result:

      ```xml
      ...
      < HTTP/2 200
      < server: nginx
      < date: Thu, 15 May 2025 07:44:41 GMT
      < content-type: application/xml; charset=UTF-8
      < content-length: 569
      < x-amz-request-id: cab0999d********
      <
      <?xml version="1.0" encoding="UTF-8"?>
      * Connection #0 to host {{ s3-storage-host }} left intact
      <ListBucketResult
          xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
          <KeyCount>1</KeyCount>
          <Name>my-sample-bucket</Name>
          <Prefix></Prefix>
          <MaxKeys>1000</MaxKeys>
          <IsTruncated>false</IsTruncated>
          <Contents>
              <Key>text.txt</Key>
              <LastModified>2025-05-15T07:23:08.030Z</LastModified>
              <Owner>
                  <ID>ajegtlf2q28a********</ID>
                  <DisplayName>ajegtlf2q28a********</DisplayName>
              </Owner>
              <ETag>&#34;f75a361db63aa4722fb8e083********&#34;</ETag>
              <Size>103</Size>
              <StorageClass>STANDARD</StorageClass>
              <TagSet></TagSet>
          </Contents>
      </ListBucketResult>
      ```

- curl 8.2.1 and lower {#curl-821}

  1. Set the variables containing the required data:

      ```bash
      AWS_KEY_ID="<static_key_ID>"
      AWS_SECRET_KEY="<secret_key>"
      BUCKET_NAME="<bucket_name>"
      DATE_VALUE=`date -R`
      STRING_TO_SIGN="GET\n\n${CONTENT_TYPE}\n${DATE_VALUE}\n/${BUCKET_NAME}"
      SIGNATURE=`echo -en ${STRING_TO_SIGN} | openssl sha1 -hmac ${AWS_SECRET_KEY} -binary | base64`
      ```

      Where:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME`: [Name](../concepts/bucket.md#naming) of the bucket from which you want to get a list of objects.

  1. Run an http request:

      ```
      curl \
        --request GET \
        --verbose \
        --header "Host: {{ s3-storage-host }}" \
        --header "Date: ${DATE_VALUE}" \
        --header "Authorization: AWS ${AWS_KEY_ID}:${SIGNATURE}" \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}?list-type=2"
      ```

      Result:

      ```xml
      ...
      < HTTP/2 200
      < server: nginx
      < date: Thu, 15 May 2025 08:29:36 GMT
      < content-type: application/xml; charset=UTF-8
      < content-length: 569
      < x-amz-request-id: cb4b9a3d********
      <
      <?xml version="1.0" encoding="UTF-8"?>
      * Connection #0 to host {{ s3-storage-host }} left intact
      <ListBucketResult
          xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
          <KeyCount>1</KeyCount>
          <Name>my-sample-bucket</Name>
          <Prefix></Prefix>
          <MaxKeys>1000</MaxKeys>
          <IsTruncated>false</IsTruncated>
          <Contents>
              <Key>text.txt</Key>
              <LastModified>2025-05-15T07:23:08.030Z</LastModified>
              <Owner>
                  <ID>ajegtlf2q28a********</ID>
                  <DisplayName>ajegtlf2q28a********</DisplayName>
              </Owner>
              <ETag>&#34;f75a361db63aa4722fb8e083********&#34;</ETag>
              <Size>103</Size>
              <StorageClass>STANDARD</StorageClass>
              <TagSet></TagSet>
          </Contents>
      </ListBucketResult>
      ```

{% endlist %}


## Download an object from the bucket {#download-object}

{% list tabs group=programming_language %}

- curl 8.3.0 and higher {#curl-830}

  1. Set the variables containing the required data:

      ```bash
      AWS_KEY_ID="<static_key_ID>"
      AWS_SECRET_KEY="<secret_key>"
      BUCKET_NAME="<bucket_name>"
      OBJECT_PATH="<object_key>"
      LOCAL_FILE="<local_file_path>"
      ```

      Where:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME`: [Name of the bucket](../concepts/bucket.md#naming) with the object to download.
      * `OBJECT_PATH`: [Key](../concepts/object.md#key) of the object to download in the bucket, e.g. `new-prefix/sample-object.txt`.
      * `LOCAL_FILE`: Path to the local file you want to save the downloaded object to, e.g., `./sample.txt`.

  1. Run an http request:

      ```bash
      curl \
        --request GET \
        --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
        --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}" \
        > ${LOCAL_FILE}
      ```

      Result:

      ```text
      ...
      < HTTP/2 200
      < server: nginx
      < date: Thu, 15 May 2025 08:55:19 GMT
      < content-type: text/plain
      < content-length: 103
      < accept-ranges: bytes
      < etag: "f75a361db63aa4722fb8e083********"
      < last-modified: Thu, 15 May 2025 07:23:08 GMT
      < x-amz-request-id: 1afc3ec9********
      <
      { [103 bytes data]
      100   103  100   103    0     0   1925      0 --:--:-- --:--:-- --:--:--  1943
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

- curl 8.2.1 and lower {#curl-821}

  1. Set the variables containing the required data:

      ```bash
      AWS_KEY_ID="<static_key_ID>"
      AWS_SECRET_KEY="<secret_key>"
      BUCKET_NAME="<bucket_name>"
      OBJECT_PATH="<object_key>"
      LOCAL_FILE="<local_file_path>"
      DATE_VALUE=`date -R`
      STRING_TO_SIGN="GET\n\n${CONTENT_TYPE}\n${DATE_VALUE}\n/${BUCKET_NAME}/${OBJECT_PATH}"
      SIGNATURE=`echo -en ${STRING_TO_SIGN} | openssl sha1 -hmac ${AWS_SECRET_KEY} -binary | base64`
      ```

      Where:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME`: [Name of the bucket](../concepts/bucket.md#naming) with the object to download.
      * `OBJECT_PATH`: [Key](../concepts/object.md#key) of the object to download in the bucket, e.g., `new-prefix/sample-object.txt`.
      * `LOCAL_FILE`: Path to the local file you want to save the downloaded object to, e.g., `./sample.txt`.

  1. Run an http request:

      ```bash
      curl \
        --request GET \
        --verbose \
        --header "Host: {{ s3-storage-host }}" \
        --header "Date: ${DATE_VALUE}" \
        --header "Authorization: AWS ${AWS_KEY_ID}:${SIGNATURE}" \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}" \
        > ${LOCAL_FILE}
      ```

      Result:

      ```text
      ...
      < HTTP/2 200
      < server: nginx
      < date: Thu, 15 May 2025 09:11:12 GMT
      < content-type: text/plain
      < content-length: 103
      < accept-ranges: bytes
      < etag: "f75a361db63aa4722fb8e083********"
      < last-modified: Thu, 15 May 2025 07:23:08 GMT
      < x-amz-request-id: e86c7119********
      <
      { [103 bytes data]
      100   103  100   103    0     0   3433      0 --:--:-- --:--:-- --:--:--  3433
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

{% endlist %}

The downloaded object was saved to the file whose path is specified in the `LOCAL_FILE` variable.


## Delete an object from the bucket {#delete-object}

{% list tabs group=programming_language %}

- curl 8.3.0 and higher {#curl-830}

  1. Set the variables containing the required data:

      ```bash
      AWS_KEY_ID="<static_key_ID>"
      AWS_SECRET_KEY="<secret_key>"
      BUCKET_NAME="<bucket_name>"
      OBJECT_PATH="<object_key>"
      ```

      Where:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME`: [Name of the bucket](../concepts/bucket.md#naming) to delete the object from.
      * `OBJECT_PATH`: [Key](../concepts/object.md#key) of the object to delete in the bucket, e.g., `new-prefix/sample-object.txt`.

  1. Run an http request:

      ```bash
      curl \
        --request DELETE \
        --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
        --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
      ```

      Result:

      ```text
      ...
      < HTTP/2 204
      < server: nginx
      < date: Thu, 15 May 2025 14:24:01 GMT
      < x-amz-request-id: 7d2f023c********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

- curl 8.2.1 and lower {#curl-821}

  1. Set the variables containing the required data:

      ```bash
      AWS_KEY_ID="<static_key_ID>"
      AWS_SECRET_KEY="<secret_key>"
      BUCKET_NAME="<bucket_name>"
      OBJECT_PATH="<object_key>"
      DATE_VALUE=`date -R`
      STRING_TO_SIGN="DELETE\n\n${CONTENT_TYPE}\n${DATE_VALUE}\n/${BUCKET_NAME}/${OBJECT_PATH}"
      SIGNATURE=`echo -en ${STRING_TO_SIGN} | openssl sha1 -hmac ${AWS_SECRET_KEY} -binary | base64`
      ```

      Where:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME`: [Name of the bucket](../concepts/bucket.md#naming) to delete the object from.
      * `OBJECT_PATH`: [Key](../concepts/object.md#key) of the object to delete in the bucket, e.g., `new-prefix/sample-object.txt`.

  
  1. Run an http request:

      ```
      curl \
        --request DELETE \
        --verbose \
        --header "Host: {{ s3-storage-host }}" \
        --header "Date: ${DATE_VALUE}" \
        --header "Authorization: AWS ${AWS_KEY_ID}:${SIGNATURE}" \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
      ```

      Result:

      ```text
      ...
      < HTTP/2 204
      < server: nginx
      < date: Thu, 15 May 2025 14:30:28 GMT
      < x-amz-request-id: 7dc0c426********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

{% endlist %}


## Delete the bucket {#delete-bucket}

{% list tabs group=programming_language %}

- curl 8.3.0 and higher {#curl-830}

  1. Set the variables containing the required data:

      ```bash
      AWS_KEY_ID="<static_key_ID>"
      AWS_SECRET_KEY="<secret_key>"
      BUCKET_NAME="<bucket_name>"
      ```

      Where:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME`: Name of the bucket to delete. The bucket you want to delete must not contain any objects.

  1. Run an http request:

      ```bash
      curl \
        --request DELETE \
        --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
        --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
        --verbose \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}"
      ```

      Result:

      ```text
      ...
      < HTTP/2 204
      < server: nginx
      < date: Thu, 15 May 2025 14:35:57 GMT
      < x-amz-request-id: 6a13b7ae********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

- curl 8.2.1 and lower {#curl-821}

  1. Set the variables containing the required data:

      ```bash
      AWS_KEY_ID="<static_key_ID>"
      AWS_SECRET_KEY="<secret_key>"
      BUCKET_NAME="<bucket_name>"
      DATE_VALUE=`date -R`
      STRING_TO_SIGN="DELETE\n\n${CONTENT_TYPE}\n${DATE_VALUE}\n/${BUCKET_NAME}"
      SIGNATURE=`echo -en ${STRING_TO_SIGN} | openssl sha1 -hmac ${AWS_SECRET_KEY} -binary | base64`
      ```

      Where:

      {% include [s3-api-quickstart-acc-keys-descs](../../_includes/storage/s3-api-quickstart-acc-keys-descs.md) %}

      * `BUCKET_NAME`: Name of the bucket to delete. The bucket you want to delete must not contain any objects.
  
  1. Run an http request:

      ```
      curl \
        --request DELETE \
        --verbose \
        --header "Host: {{ s3-storage-host }}" \
        --header "Date: ${DATE_VALUE}" \
        --header "Authorization: AWS ${AWS_KEY_ID}:${SIGNATURE}" \
        "https://{{ s3-storage-host }}/${BUCKET_NAME}"
      ```

      Result:

      ```text
      ...
      < HTTP/2 204
      < server: nginx
      < date: Thu, 15 May 2025 14:39:15 GMT
      < x-amz-request-id: 331b2dc4********
      <
      * Connection #0 to host {{ s3-storage-host }} left intact
      ```

{% endlist %}

#### See also {#see-also}

* [{#T}](./index.md)
* [{#T}](../api-ref/authentication.md)
* [{#T}](./signing-requests.md)