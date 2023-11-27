# Resolving the "Bucket not empty" error when deleting a bucket from Object Storage



## Issue description {#issue-description}

* When attempting to delete a bucket, you see this error: `Bucket is not empty`

## Solution {#issue-resolution}

To delete a folder or bucket, you need to first delete all objects from it.
Here are the most common reasons you cannot delete a bucket:

* The bucket has incomplete multipart uploads
* The bucket still contains uploaded objects
* All objects have been deleted from the bucket, but versioning is enabled, and old versions of the deleted objects still exist.

You can delete all old versions of objects and incomplete uploads by setting up automatic deletion of all these entities in the bucket's lifecycle rule.
Lifecycle rules are processed at 00:00 UTC once a day.

{% list tabs %}

- Management console

   You can view and delete incomplete uploads from the management console following [this guide](../../../storage/operations/objects/deleting-multipart.md):

   Deleting all objects from a bucket using the management console is described [at this link](../../../storage/operations/objects/delete-all.md):

- AWS CLI

   * You can check for incomplete multipart uploads by running the following command:

      ```bash
      aws --endpoint <https://storage.yandexcloud.net> s3api list-multipart-uploads \
      --bucket \<bucket_name\>
      ```

   * You can abort such uploads with the `abort-multipart-upload` command:

      ```bash
      aws --endpoint <https://storage.yandexcloud.net> s3api abort-multipart-upload \
      --bucket \<bucket_name\> --key \<object_key\> --upload-id \<upload_id\>
      ```

   * You can check for objects in the bucket using the `list-objects` command:

      ```bash
      aws --endpoint <https://storage.yandexcloud.net> s3api list-objects \
      --bucket \<bucket_name\>
      ```

   * You can delete a single object with the `delete-object` command:

      ```bash
      aws --endpoint <https://storage.yandexcloud.net> s3api delete-object \
      --bucket \<bucket_name\> --key
      ```

   * You can delete multiple objects with the `delete-object` command:

      ```bash
      aws --endpoint <https://storage.yandexcloud.net> s3api delete-objects \
      --bucket \<bucket_name\> --delete '\{ "Objects": \[ \{ "Key": \}, \{ "Key": \}, ...\] \}'
      ```

   * If versioning is enabled in your bucket, then even after the objects are deleted from the folder (bucket), their old versions are still retained. You need to delete them as well. You can view the old versions by this command:

      ```bash
      aws --endpoint <https://storage.yandexcloud.net> s3api list-object-versions \
      --bucket \<bucket_name\>

      
   * You can delete a specific version of an object with this command:

      ```bash
      aws --endpoint <https://storage.yandexcloud.net> s3api delete-object \
      --bucket \<bucket_name\> --key \<key_name\> --version-id \<version_id\>
      ```

{% endlist %}
