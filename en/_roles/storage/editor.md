The `storage.editor` role allows any operations with buckets and objects: creating, deleting, and editing them. The role does not allow managing access control list (ACL) settings and creating public buckets.

{% cut "Users with this role can:" %}

* View the list of [buckets](../../storage/concepts/bucket.md), create and delete buckets.
* View the lists of [objects](../../storage/concepts/object.md) in buckets, object info and content.
* View info on [access permissions](../../iam/concepts/access-control/index.md) assigned for buckets and objects inside them.
* Upload objects into a bucket, delete objects and object versions.
* View bucket [CORS](../../storage/concepts/cors.md) configuration info and modify the CORS configuration.
* View bucket [static website hosting](../../storage/concepts/hosting.md) configuration info and modify the static website hosting configuration.
* View bucket access [protocol](../../storage/concepts/bucket.md#bucket-https) info and change the access protocol.
* View bucket action [logging](../../storage/concepts/server-logs.md) settings and change the logging settings.
* View bucket [versioning](../../storage/concepts/versioning.md) settings.
* View bucket [encryption](../../storage/concepts/encryption.md) settings and change the encryption settings.
* View bucket default [storage class](../../storage/concepts/storage-class.md#default-storage-class) info, change the default storage class.
* View and modify bucket [labels](../../storage/concepts/tags.md).
* View bucket region info.
* View object [lifecycle](../../storage/concepts/lifecycles.md) configuration info and change the lifecycle configuration.
* View lists of object versions and version info.
* Restore object versions in versioning-enabled buckets.
* View info on [object version locks](../../storage/concepts/object-lock.md) and set up such locks.
* View object and object version [labels](../../storage/concepts/tags.md#object-tags), modify and delete such labels.
* View info on current [multipart uploads](../../storage/concepts/multipart.md) of objects and their parts, delete partially uploaded objects.
* View [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), and Object Storage statistics.
* View info on Object Storage [quotas](../../storage/concepts/limits.md#storage-quotas).
* View folder info.

{% endcut %}

This role includes the `storage.uploader` permissions.