# Deleting a bucket

If you have a [bucket](../../concepts/components/storage.md) and it is empty, you can delete it.

{% note warning %}

Before deleting the bucket, make sure it does not contain any objects. You cannot delete a bucket with objects in it.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Get a list of buckets in the project:

      ```bash
      kubectl get bucket -n <project_name>
      ```

  1. Make sure the bucket is empty. Delete all objects via the S3 API if you no longer need them.

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
