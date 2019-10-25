# Bucket

A logical entity that helps store objects.

## Naming buckets {#naming}

A bucket's name is used as part of the data access URL and is visible to your users. For example, `https://{{ s3-storage-host }}/bucket-name`.

Naming rules:

- Bucket names are unique throughout {{ objstorage-name }}, so you can't create two buckets with the same name (even in different folders in different clouds). Keep this in mind if you plan to create buckets automatically via the API.

- Bucket names are subject to the following restrictions:

   {% include [bucket-name-reqs](../../_includes/bucket-name-reqs.md) %}

{% note info %}

Names containing periods should only be used for [static website hosting](../hosting/index.md). HTTPS is not available for buckets with names that contain periods.

{% endnote %}

## Bucket URL {#bucket-url}

The name of the bucket can be placed in different parts of the URL, which can take one of the following forms:

- `https://{{ s3-storage-host }}/<bucket>?<parameters>`
- `https://<bucket>.{{ s3-storage-host }}?<parameters>`

## Bucket settings {#bucket-settings}

You can:

- [Limit the maximum size of a bucket](../operations/buckets/limit-max-volume.md).

    {{ objstorage-name }} doesn't let you upload objects if adding them exceeds the maximum bucket size.

- Set the default [storage class](storage-class.md).

    Objects uploaded to a bucket are by default saved with the storage class specified for that bucket.
    
- Configure a bucket for [static website hosting](../hosting/index.md).
- Download a [CORS configuration](../cors/index.md) for a bucket.
- Configure [object lifecycles](../lifecycles/index.md).

## Bucket access {#bucket-access}

By default, buckets are created with restricted access, as set in the [IAM](../../iam/concepts/index.md) settings. If necessary, you can configure permissions to buckets and the objects they contain with [ACL](acl.md).

You can use the management console to [open public access](../operations/buckets/bucket-availability.md) to buckets. With public access, any internet user can get a list of objects in a bucket and download them.

## Guidelines and limitations {#details-of-usage}

- A bucket can't be renamed.

- {{ objstorage-name }} performance doesn't depend on the number of buckets. You can store all your data in one or several buckets.

- Buckets can't be nested.

- You can only delete an empty bucket.

- It may take some time after deleting a bucket before you can create a new bucket with the same name. There is also a risk that another Yandex.Cloud user will create a bucket with the name you've released before you claim it again. Don't delete buckets without a reason.

- When objects are uploaded in quick succession, the maximum specified bucket size can be exceeded.

- After deleting objects from a bucket, their storage capacity is considered occupied for some time.

  {% note info %}

  If you limit the maximum size of a bucket, it may remain unavailable for writes for some time, even if you free up enough space for new objects.

  {% endnote %}

