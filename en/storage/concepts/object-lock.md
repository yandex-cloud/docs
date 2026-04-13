# Object lock

An _object lock_ in [versioned](versioning.md) buckets protects data from accidental or intentional deletion and modification. You cannot modify or delete a locked object version manually or as part of a [lifecycle](lifecycles.md), but you can read it as many times as you need or [restore](../operations/objects/restore-object-version.md) it.

Locks apply only to a specific object version and do not restrict actions on the object itself. You can delete it or upload it again with the same key, in which case a new object version will be created. You can also delete unlocked versions as usual if you no longer need them.

{% include [versioning-block-relations](../../_includes/storage/versioning-block-relations.md) %}

Enabling locks does not mean locking previously uploaded object versions; if required, you can lock them manually. Similarly, if you disable the object lock feature, this will not disable the existing locks. They will still be there, and you will not be able to remove or change them.

To lock object versions in your bucket, enable the respective option in the bucket settings (see [this guide](../operations/buckets/configure-object-lock.md#enable) for details).

## Object lock types {#types}

There are different types of object locks depending on their retention period and restriction level.

There are two types of object locks that are set for a certain period, i.e., until the expiration date and time you provide:

Governance-mode retention

: Users with the permission to upload objects (the [`storage.uploader`](../security/index.md#storage-uploader) role) can set locks.
: Users with the {{ objstorage-name }} admin permissions (the [`storage.admin`](../security/index.md#storage-admin) role) can override locks (delete or overwrite object versions), change their retention period, and remove them. Users need to explicitly confirm such actions, e.g., when sending a request via an Amazon S3-compatible REST API with the `X-Amz-Bypass-Governance-Retention: true` header.

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

The table below lists the minimum roles required for specific actions based on the lock type. An empty cell indicates the action is unavailable; no role grants the permissions to perform it.

| Action | Governance-mode <br>retention | Compliance-mode <br>retention | Legal hold<br> |
| --- | --- | --- | --- |
| Set a lock | `storage.uploader` | `storage.uploader` | `storage.uploader` |
| Delete or overwrite a locked object version | `storage.admin` | — | — |
| Shorten the retention period | `storage.admin` | — | — |
| Extend the retention period | `storage.admin` | `storage.admin` | — |
| Replace a retention period-based lock with a new one | `storage.admin` | — | — |
| Remove a lock | `storage.admin` | — | `storage.uploader` |

## Default object locks {#default}

You can enable object locks for specific object versions or set default locks for all new object versions uploaded to a bucket.

For such locks, you need to specify the following:

* [Type](#types): Governance-mode or compliance-mode retention.
* Retention period in days or years after an object version is uploaded. The expiry date and time are defined for each version automatically.

If you set up default object locks for your bucket, you need to calculate [MD5 hash](https://{{ lang }}.wikipedia.org/wiki/MD5) for each uploaded object version, encode it to [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64), and specify the value you get in the request. For example, in the REST API request, specify it in the `Content-MD5` header.

Even if your bucket has the default object locks configured, you can change the retention settings when or after uploading a specific object version, and those new settings will take priority. In this case, however, you will not be able to upload a version without a retention-based lock or remove such a lock after the upload.

Default lock setting changes do not affect the object versions that were previously uploaded to the bucket.


## How to configure object locks {#instructions}

1. [Enable bucket versioning](../operations/buckets/versioning.md).
1. [Enable object locks](../operations/buckets/configure-object-lock.md#enable) in the bucket.
1. [Lock an existing object version](../operations/objects/edit-object-lock) or [upload an object version with a lock](../operations/objects/upload.md#w-object-lock).

See also:
* [Setting up default object locks](../operations/buckets/configure-object-lock.md).
* [Setting, updating, and removing locks](../operations/objects/edit-object-lock.md).
* [Deleting a locked object version](../operations/objects/delete.md#w-object-lock).
* [Restoring an object version in a versioned bucket](../operations/objects/restore-object-version.md).


## Use cases {#examples}

* [{#T}](../tutorials/backup-with-veeam.md)

