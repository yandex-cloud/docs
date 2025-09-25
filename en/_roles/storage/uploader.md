The `storage.uploader` role allows you to upload objects into buckets with or without overwriting the previously uploaded ones, read data in buckets, view info on buckets and objects inside them, as well as info on the Object Storage folder and quotas. The role does not allow you to delete objects or configure buckets.

{% cut "Users with this role can:" %}

* View the list of [buckets](../../storage/concepts/bucket.md).
* View the lists of [objects](../../storage/concepts/object.md) in buckets, object info and content.
* Upload objects into a bucket.
* View info on [access permissions](../../iam/concepts/access-control/index.md) assigned for buckets and objects inside them.
* View bucket [CORS](../../storage/concepts/cors.md) configuration info.
* View bucket [static website hosting](../../storage/concepts/hosting.md) configuration info.
* View bucket access [protocol](../../storage/concepts/bucket.md#bucket-https) info.
* View bucket action [logging](../../storage/concepts/server-logs.md) settings.
* View bucket [versioning](../../storage/concepts/versioning.md) settings.
* View bucket [encryption](../../storage/concepts/encryption.md) settings.
* View bucket default [storage class](../../storage/concepts/storage-class.md#default-storage-class) info.
* View bucket [labels](../../storage/concepts/tags.md).
* View bucket region info.
* View object [lifecycle](../../storage/concepts/lifecycles.md) configuration info.
* View lists of object versions and version info.
* View info on [object version locks](../../storage/concepts/object-lock.md) and set up such locks.
* View object and object version [labels](../../storage/concepts/tags.md#object-tags), modify such labels.
* View info on current [multipart uploads](../../storage/concepts/multipart.md) of objects and their parts, delete partially uploaded objects.
* View [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), and Object Storage statistics.
* View info on Object Storage [quotas](../../storage/concepts/limits.md#storage-quotas).
* View folder info.

{% endcut %}

This role includes the `storage.viewer` permissions.