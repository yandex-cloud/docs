### storage.admin {#storage-admin}

The `storage.admin` role is intended for managing {{ objstorage-short-name }}. Users with this role can:

* Create [buckets](../storage/concepts/bucket.md).
* Delete buckets.
* Assign an access control list ([ACL](../storage/concepts/acl.md)).
* Manage any bucket [object](../storage/concepts/object.md).
* Manage any bucket [website](../storage/concepts/hosting.md).
* Configure other bucket parameters and objects in the bucket.

This role can grant other users access to a bucket or a specific object in it.

This role can be assigned by the [administrator](#admin) of the cloud (the `admin` role).