The `storage.configViewer` role allows you to view the settings info of buckets and objects inside them but not the data inside the bucket.

{% cut "Users with this role can:" %}

* View the list of [buckets](../../storage/concepts/bucket.md) and lists of [objects](../../storage/concepts/object.md) in buckets without access to object content.
* View info on [access permissions](../../iam/concepts/access-control/index.md) assigned for buckets and objects inside them.
* View bucket [access policy](../../storage/concepts/policy.md) info.
* View bucket [CORS](../../storage/concepts/cors.md) configuration info.
* View bucket [static website hosting](../../storage/concepts/hosting.md) configuration info.
* View bucket access [protocol](../../storage/concepts/bucket.md#bucket-https) info.
* View bucket action [logging](../../storage/concepts/server-logs.md) settings.
* View bucket [versioning](../../storage/concepts/versioning.md) settings.
* View bucket region info.
* View [object version locks](../../storage/concepts/object-lock.md) info.
* View lists of object versions in buckets.
* View bucket [encryption](../../storage/concepts/encryption.md) settings.
* View bucket default [storage class](../../storage/concepts/storage-class.md#default-storage-class) info.
* View bucket [labels](../../storage/concepts/tags.md).
* View object [lifecycle](../../storage/concepts/lifecycles.md) configuration info.
* View info on current [multipart uploads](../../storage/concepts/multipart.md) of objects and their parts.
* View [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), and Object Storage statistics.
* View folder info.

{% endcut %}
