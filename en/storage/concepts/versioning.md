# Bucket versioning

Bucket versioning is the capability to store the history of an object using versions. Each version is a complete copy of the object and occupies space in {{ objstorage-name }}. By using version control, you can protect your data from both unintentional user actions and application faults.

Versioning is enabled at the bucket level and applied to every object in the bucket.

For more information about how to enable versioning, see [Managing bucket versioning](../operations/buckets/versioning.md).

* After you enable this feature, the `version_id` parameter is added to each uploaded object. It lets you manage specific object versions.
* Before versioning is enabled, each bucket object is assigned a version ID (`version_id`) equal to `null`.

  When versioning is paused, the `version_id` of existing objects no longer changes. Each new object is assigned a version ID of `null`. If a `null` version already exists, it's overwritten.
* When you overwrite an object version, a new object with the same ID and a randomly generated `version_id` is created.

  To access a previous version of the object, use the object ID and the desired `version_id`.

* If versioning is enabled, previous object versions can be restored by following the [instructions](../operations/objects/restore-object-version.md).

{% note info %}

Enabling versioning is irreversible: you can't disable versioning, but you can pause the creation of new versions. After you pause versioning, new objects are saved as `null` versions.

{% endnote %}

When you delete an object version, a delete marker is added to the version and it no longer takes up space.

You can remove unneeded or deleted object versions from a bucket manually or by setting up the [object lifecycle](lifecycles.md).
