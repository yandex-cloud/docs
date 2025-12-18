# Fixing the `Bucket is not empty` error when deleting a bucket



## Issue description {#issue-description}

You get the `Bucket is not empty` error when trying to delete a bucket.

## Solution {#issue-resolution}

To delete a folder or bucket, you need to first delete all objects from it. Here are the most common reasons why you cannot delete a bucket:

* Some multipart uploads are incomplete in the bucket.
* The bucket still contains uploaded objects.
* All objects have been deleted from the bucket but since versioning is enabled, the old versions of the deleted objects still exist.

You can delete all old versions of objects and incomplete uploads by setting up automatic deletion of all these entities in the bucket lifecycle rule.

{% note info %}

Lifecycle rules are processed at 00:00 UTC every day.

{% endnote %}

{% list tabs %}

- Management console

  You can view and delete incomplete uploads using the [management console]({{ link-console-main }}) following [this guide](../../../storage/operations/objects/deleting-multipart.md).

  Learn how to delete all objects from a bucket using the management console in [this article](../../../storage/operations/objects/delete-all.md).

- AWS CLI

  * You can check for incomplete multipart uploads using this command:

    ```bash
    aws --endpoint <https://storage.yandexcloud.net> s3api list-multipart-uploads \
    --bucket \<bucket_name\>
    ```

  * You can abort such uploads using the `abort-multipart-upload` command:

    ```bash
    aws --endpoint <https://storage.yandexcloud.net> s3api abort-multipart-upload \
    --bucket \<bucket_name\> --key \<object_key\> --upload-id \<upload_id\>
    ```

  * You can check for objects in the bucket using the `list-objects` command:

    ```bash
    aws --endpoint <https://storage.yandexcloud.net> s3api list-objects \
    --bucket \<bucket_name\>
    ```

  * You can delete a single object using the `delete-object` command:

    ```bash
    aws --endpoint <https://storage.yandexcloud.net> s3api delete-object \
    --bucket \<bucket_name\> --key
    ```

  * You can delete multiple objects using the `delete-object` command:

    ```bash
    aws --endpoint <https://storage.yandexcloud.net> s3api delete-objects \
    --bucket \<bucket_name\> --delete '\{ "Objects": \[ \{ "Key": \}, \{ "Key": \}, ...\] \}'
    ```

  * If you have versioning enabled in your bucket, the old versions are still retained even after you delete all objects from your folder or bucket. You need to delete them as well. You can view the old versions by running this command:

    ```bash
    aws --endpoint <https://storage.yandexcloud.net> s3api list-object-versions \
    --bucket \<bucket_name\>

  * You can delete a specific version of an object with this command:

    ```bash
    aws --endpoint <https://storage.yandexcloud.net> s3api delete-object \
    --bucket \<bucket_name\> --key \<key_name\> --version-id \<version_id\>
    ```

{% endlist %}