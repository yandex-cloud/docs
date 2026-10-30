# Deleting a bucket

If you have a [bucket](../../concepts/components/storage.md) and it is empty, you can delete it.

{% note warning %}

Before deleting the bucket, delete all its objects, including their previous versions and delete markers, and complete or terminate multipart uploads. You cannot delete a bucket that contains such data. If a version is protected with Object Lock, consider the mode and lock period.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Get a list of buckets in the project:

      ```bash
      kubectl get bucket -n <project_name>
      ```

  1. Make sure the bucket is empty. Delete all objects and their versions via the S3 API if you no longer need them. To check versions, delete markers, and incomplete multipart uploads, use the AWS CLI with the [access key](create-accesskey.md):

      ```bash
      aws --endpoint-url=https://storage.sys.<cluster_domain> s3api list-object-versions \
        --bucket <bucket_name>
      aws --endpoint-url=https://storage.sys.<cluster_domain> s3api list-multipart-uploads \
        --bucket <bucket_name>
      ```

      Deleting an object from a bucket with versioning in a regular way does not delete previous versions and creates a delete marker. You need to delete them as well before deleting the bucket.

  1. Delete the bucket resource:

      ```bash
      kubectl delete bucket <bucket_name> -n <project_name>
      ```

  1. Make sure the bucket was deleted:

      ```bash
      kubectl get bucket -n <project_name>
      ```


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **{{ objstorage-name }}**.
  1. Select the bucket.
  1. Click **Delete bucket**.
  1. Confirm the deletion.

{% endlist %}

If you cannot check bucket contents because you cannot access the storage, deletion will be rejected. Repeat the request after regaining access. If the resource switched to `DeletionFailed`, get the error description in the `status.message` field:

```bash
kubectl get bucket <bucket_name> -n <project_name> -o yaml
```
