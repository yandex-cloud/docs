# Object locks

Using _object locks_ in [versioned](versioning.md) buckets allows you to prevent an object version from being deleted or overwritten. Object locks ensure version storage based on the WORM (write once, read many) principle, while you can still upload new object versions.

To enable locking object versions in your bucket:

1. [Contact support](../../support/overview.md#response-time) and request the object lock feature for your cloud. You only need to do it once per cloud.
1. Enable locks in your bucket settings by following [this guide](../operations/buckets/configure-object-lock.md#enable).

Enabling locks does not mean locking previously uploaded object versions; if required, you can lock them manually. Similarly, if you disable the object lock feature, this will not disable the existing locks. They will still be there, and you will not be able to remove or change them.

There are different [types](#types) of object locks depending on their retention period and severity.

You can enable object locks for specific object versions (when or after uploading them) or set [default](#default) object locks for all new versions uploaded to a bucket.

## Object lock types {#types}

There are two types of object locks that are set for a certain period, i.e., until the expiration date and time you provide:

Object locks with governance-mode retention

: Users with the permission to upload objects ([the `storage.uploader` role](../security/index.md#storage-uploader)) can set locks.
: Users with the {{ objstorage-name }} administrator status ([the `storage.admin`](../security/index.md#storage-admin) role) can bypass locks (delete or overwrite object versions), change their retention period, and remove them. Users need to explicitly confirm such actions, e.g., when sending a request via an Amazon S3-compatible REST API with the `X-Amz-Bypass-Governance-Retention: true` header.

Object locks with compliance-mode retention

: Users with the permission to upload objects (the `storage.uploader` role) can set locks.
: Users with the {{ objstorage-name }} administrator status (the `storage.admin` role) can only extend the lock retention period.
: Such locks cannot be bypassed or removed until they expire. You cannot reduce their retention period either.

There is another object lock type that has no time limit:

Legal hold

: Users with the permission to upload objects (the `storage.uploader` role) can set and remove locks.
: Such locks cannot be bypassed.

Object locks with and without time limit are managed independently. This means you can lock an object version using a lock with a retention period and a legal hold lock, simultaneously. In this case, the legal hold one will take priority: deleting and overwriting the object version will be unavailable even in case the other lock allows some users to do that.

### Table of roles and actions {#types-overview}

| Object lock type | ⏳ Governance<br> | ⏳ Compliance<br> | ♾ Legal hold<br> |
| --- | --- | --- | --- |
| **Who can:** |
| Set a lock | `storage.uploader` | `storage.uploader` | `storage.uploader` |
| Delete or overwrite an object version | `storage.admin` | No one | No one |
| Reduce the lock retention period | `storage.admin` | No one | N/A |
| Extend the lock retention period | `storage.admin` | `storage.admin` | N/A |
| Replace a retention period-based lock with a new one | `storage.admin` | No one | N/A |
| Remove a lock | `storage.admin` | No one | `storage.uploader` |


## Default object locks {#default}

You can set _default object locks_ for a bucket, which will apply to all new object versions uploaded to it.

For such locks, you need to specify the following:

* [Type](#types): Governance-mode or compliance-mode retention.
* Retention period in days or years after an object version is uploaded. The expiry date and time are defined for each version automatically.

If you set up default object locks for your bucket, you need to calculate [MD5 hash](https://{{ lang }}.wikipedia.org/wiki/MD5) for each uploaded object version, encode it with [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64), and specify the obtained value in the request. For example, if you send requests through REST API, specify it in the `Content-MD5` header.

Even though your bucket has the default object locks configured, you can change the settings of a retention period-based lock when or after uploading a specific object version, and those new settings will take priority. In this case, however, you will not be able to upload a version without a retention period-based lock or remove such a lock after the upload.

Default lock setting changes do not affect the object versions that were previously uploaded to the bucket.


## How to configure object locks {#instructions}

See these guides for details:

* [Configuring bucket object locks](../operations/buckets/configure-object-lock.md): Enabling object locks and setting up default ones.
* [Uploading an object version with an object lock](../operations/objects/upload.md#w-object-lock).
* [Configuring object locks](../operations/objects/edit-object-lock.md): Setting, updating, and removing a lock.
* [Deleting an object version with an object lock](../operations/objects/delete.md#w-object-lock).
