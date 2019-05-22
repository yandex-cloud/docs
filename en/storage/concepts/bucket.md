# Bucket

A logical entity that helps organize the storage of objects.

## Bucket naming {#naming}

A bucket's name is used as part of the data access URL and will be visible to your data users. For example, `http://[!KEYREF s3-storage-host]/bucket-name`.

Naming rules:

- Bucket names are unique in the entire [!KEYREF objstorage-name], that is, you can't create two buckets with the same name even in different folders of different clouds. Keep this in mind if you plan to create buckets automatically via the API.

- The bucket name restrictions are as follows:

   [!INCLUDE [bucket-name-reqs](../../_includes/bucket-name-reqs.md)]

Names containing dots should only be used for [static website hosting](../hosting/index.md).

## Bucket settings {#bucket-settings}

You can:

- [Limit the maximum size of a bucket](../operations/buckets/limit-max-volume.md). [!KEYREF objstorage-name] will not allow uploading an object if, when adding it, the bucket size exceeds the maximum value.
- Set the default [storage class](storage-class.md). Objects uploaded to a bucket are by default saved with the storage class specified for that bucket.
- Configure a bucket for [static website hosting](../hosting/index.md).
- Download a [CORS configuration](../cors/index.md) for a bucket.
- Configure the [lifecycle of objects](../lifecycles/index.md).

## Usage {#details-of-usage}

- A bucket cannot be renamed.

- [!KEYREF objstorage-name] performance does not depend on the number of buckets. You can store all your data in one or several buckets.

- Buckets can't be nested.

- You can only delete an empty bucket.

- It may take some time after deleting a bucket before you can create a new bucket with the same name. There is also a risk that another Yandex.Cloud user will create a bucket with the name you've released before you claim it again. Do not delete buckets for no good reason.

- When objects are uploaded in quick succession, the maximum specified bucket size can be exceeded.

- After deleting objects from a bucket, their storage capacity is considered occupied for some time.

  > [!NOTE]
  >
  >If you have limited the maximum size of a bucket, it may remain unavailable for writes for some time, even if you free up enough space for new objects.

