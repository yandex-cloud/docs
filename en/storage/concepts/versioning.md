# Bucket versioning

Bucket versioning enables the storage of object history through versions. Each version is a complete copy of an object and occupies space in {{ objstorage-name }}. Using version control protects your data from both unintentional user actions and application faults.

Versioning is enabled at the bucket level and applies to every object in the bucket.

For more information on how to enable versioning, see [Managing bucket versioning](../operations/buckets/versioning.md).

* After you enable this feature, each uploaded object will get the `version_id` parameter. This will allow you to manage specific object versions.
* Before versioning is enabled, each bucket object is assigned a version ID (`version_id`) equal to `null`.

  When versioning is paused, the `version_id` of existing objects does not change. Each new object is assigned a `null` version ID. If a `null` version already exists, it will be overwritten.
* When you overwrite an object version, a new object with the same ID and a randomly generated `version_id` is created.

  To access a previous version of an object, use the object ID and the `version_id` you need.

* If versioning is enabled, you can restore previous object versions by following [this guide](../operations/objects/restore-object-version.md).

{% note info %}

You cannot disable versioning once you enable it, but you can pause the creation of new versions. After you pause versioning, new objects will be saved as `null` versions.

{% endnote %}

When you delete an object version, it is marked as "delete" and no longer takes up any space.

You can remove irrelevant or deleted object versions from a bucket manually or by setting up an [object lifecycle](lifecycles.md).
