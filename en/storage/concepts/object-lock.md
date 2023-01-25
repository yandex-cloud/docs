# Object locks

Using _object locks_ in [versioned](versioning.md) buckets lets you prevent an object version from being deleted or overwritten. Object locks ensure version storage based on the WORM (write once, read many) technology, while you can still upload new object versions.

To be able to put locks on object versions in your bucket:

1. [Contact support](../../support/overview.md#response-time) and request the object lock feature for your cloud. You only need to do it once per cloud.
1. Enable locks in your bucket settings by following the [instructions](../operations/buckets/configure-object-lock.md#enable).

When you enable locks, this doesn't put locks on previously uploaded object versions (you only get an option to put locks). If you disable object lock, this doesn't disable the locks that were put previously. Such locks are still in effect, and you can't remove or change them.

There are different [types](#types) of object locks depending on their retention period and severity.

You can enable object locks for specific object versions (when or after uploading them) or set [default](#default) object locks for all new versions uploaded to a bucket.

## Object lock types {#types}

Two types of object locks are set for a certain period until the date and time you specify:

Object locks with governance-mode retention

: Users with permission to upload objects ([the `storage.uploader` role](../security/index.md#storage-uploader)) can set a lock.
: Users who are {{ objstorage-name }} administrators ([the `storage.admin`](../security/index.md#storage-admin) role) can bypass a lock (delete or overwrite an object version), change its retention period, or remove it. The user should explicitly confirm these actions, for example, when sending a request via the Amazon S3-compatible {% if lang == "ru" and audience != "internal" %}[REST API](../../glossary/rest-api.md){% else %}REST API{% endif %} with the `X-Amz-Bypass-Governance-Retention: true` header.

Object locks with compliance-mode retention

: Users with permission to upload objects (the `storage.uploader` role) can set a lock.
: Users who are {{ objstorage-name }} administrators (the `storage.admin` role) can only extend a lock's retention period.
: This lock can't be bypassed, shortened, or removed until it expires.

There is one more type of object lock that is set indefinitely:

Legal hold

: Users with permission to upload objects (the `storage.uploader` role) can set and remove a lock.
: This lock can't be bypassed.

Object locks set for a certain amount of time and those set indefinitely are managed independently. You can concurrently lock an object version using one lock with a retention period and one legal hold. If applied together, a legal hold takes priority: an object version can't be deleted or overwritten even if a lock with a retention period allows some users to do that.

### Table of roles and actions {#types-overview}

| Type of object lock | ⏳ Governance<br> | ⏳ Compliance<br> | ♾ Legal hold<br> |
| --- | --- | --- | --- |
| **Who can...** |
| ...set a lock | `storage.uploader` | `storage.uploader` | `storage.uploader` |
| ...delete or overwrite an object version | `storage.admin` | No one | No one |
| ...shorten a lock's retention period | `storage.admin` | No one | — |
| ...extend a lock's retention period | `storage.admin` | `storage.admin` | — |
| ...remove a lock set for a certain period and place a new one | `storage.admin` | No one | — |
| ...remove a lock | `storage.admin` | No one | `storage.uploader` |


## Default object locks {#default}

You can set _default object locks_ for a bucket: they will apply to all new object versions uploaded to it.

Specify the following for the default object locks:

* [Type](#types): Governance-mode or compliance-mode retention.
* Retention period in days or years after an object version is uploaded. The retain until date and time are defined for each version automatically.

If you set up the default object locks for your bucket, an [MD5 hash](https://{{ lang }}.wikipedia.org/wiki/MD5) needs to be calculated for each uploaded object version and encoded with [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64). The resulting value should be specified in a request. For example, if you send requests using the REST API, specify it in the `Content-MD5` header.

Even if the bucket has the default object locks configured, you can change the settings of a lock with a retention period when or after uploading a specific object version and the new settings will take priority. In this case, you can't upload a version without a lock set for a certain period or remove it.

Changes to the default lock settings don't affect the object versions already uploaded to the bucket.


## How to configure object locks {#instructions}

See the instructions:

* [Configuring bucket object locks](../operations/buckets/configure-object-lock.md): Enabling object locks and setting up default object locks.
* [Uploading an object version with an object lock](../operations/objects/upload.md#w-object-lock).
* [Configuring object locks](../operations/objects/edit-object-lock.md): setting, updating, and removing a lock.
* [Deleting an object version with an object lock](../operations/objects/delete.md#w-object-lock).
