# Object lock

_Object locks_ in [versioned](versioning.md) buckets allow you to prevent object version deletion or overwrites. Object locks use a WORM (write once, read many) model to store versions, and you can still upload new object versions.

To lock object versions in your bucket, enable the respective option in the bucket settings (see [this guide](../operations/buckets/configure-object-lock.md#enable) for details).

Enabling locks does not mean locking previously uploaded object versions; if required, you can lock them manually. Similarly, if you disable the object lock feature, this will not disable the existing locks. They will still be there, and you will not be able to remove or change them.

There are different [types](#types) of object locks depending on their retention period and restriction level.

You can enable object locks for specific object versions (when or after uploading them) or set [default](#default) object locks for all new versions uploaded to a bucket.

## Object lock types {#types}

There are two types of object locks that are set for a certain period, i.e., until the expiration date and time you provide:

Governance-mode retention

: Users with the permission to upload objects (the [`storage.uploader` role](../security/index.md#storage-uploader)) can set locks.
: Users with the {{ objstorage-name }} admin permissions (the [`storage.admin` role](../security/index.md#storage-admin)) can override locks (delete or overwrite object versions), change their retention period, and remove them. Users need to explicitly confirm such actions, e.g., when sending a request via an Amazon S3-compatible REST API with the `X-Amz-Bypass-Governance-Retention: true` header.

Compliance-mode retention

: Users with the permission to upload objects (the `storage.uploader` role) can set locks.
: Users with the {{ objstorage-name }} admin permissions (the `storage.admin` role) can only extend the retention period.
: You cannot override, shorten, or remove such locks until they expire.

There is another object lock type that has no time limit:

Legal hold

: Users with the permission to upload objects (the `storage.uploader` role) can set and remove locks.
: There is no way to override this type of lock.

Retention periods and legal holds are independent. This means you can place a retention period and a legal hold on your object version at the same time. In this case, the legal hold will take priority: you will not be able to delete and overwrite the object version even if the retention mode allows some users to do that.

### Table of roles and actions {#types-overview}

| Object lock type | ⏳ Governance mode<br>(governance) | ⏳ Compliance mode<br>(compliance) | ♾ Legal hold<br>(legal hold) |
| --- | --- | --- | --- |
| **Who can**:
| Set a lock | `storage.uploader` | `storage.uploader` | `storage.uploader` |
| Delete or overwrite an object version | `storage.admin` | No one | No one |
| Shorten the retention period | `storage.admin` | No one | — |
| Extend the retention period | `storage.admin` | `storage.admin` | — |
| Replace a retention period-based lock with a new one | `storage.admin` | No one | — |
| Remove a lock | `storage.admin` | No one | `storage.uploader` |


## Default object locks {#default}

You can set _default object locks_ for a bucket, which will apply to all new object versions uploaded to it.

For such locks, you need to specify the following:

* [Type](#types): Governance-mode or compliance-mode retention.
* Retention period in days or years after an object version is uploaded. The expiry date and time are defined for each version automatically.

If you set up default object locks for your bucket, you need to calculate [MD5 hash](https://{{ lang }}.wikipedia.org/wiki/MD5) for each uploaded object version, encode it to [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64), and specify the value you get in the request. For example, in the REST API request, specify it in the `Content-MD5` header.

Even if your bucket has the default object locks configured, you can change the retention settings when or after uploading a specific object version, and those new settings will take priority. In this case, however, you will not be able to upload a version without a retention-based lock or remove such a lock after the upload.

Default lock setting changes do not affect the object versions that were previously uploaded to the bucket.


## How to configure object locks {#instructions}

For details, see these guides:

* [Configuring bucket object locks](../operations/buckets/configure-object-lock.md): Enabling object locks and setting up default ones
* [Uploading an object version with an object lock](../operations/objects/upload.md#w-object-lock)
* [Configuring object locks](../operations/objects/edit-object-lock.md): Setting, updating, and removing a lock
* [Deleting an object version with an object lock](../operations/objects/delete.md#w-object-lock)
