---
title: Handling errors
description: In this article, you will learn about known errors that occur when sending audit logs to trail destination objects. Follow the suggested recommendations to get the trail back to normal.
---

# Handling errors


If a trail is unable to send audit logs to the [destination object](../concepts/trail.md#target), its [status](../concepts/trail.md#status) will change to `Error`. This guide contains recommendations on how get the trail back to normal.

{% note info %}

A few minutes after the cause of the error is removed, the trail's status will revert to `Active`. All audit logs will be uploaded to the destination object.

{% endnote %}


Destination objects:
* [{{ objstorage-name }} bucket](#storage)
* [{{ yds-name }} stream](#data-streams)
* [{{ cloud-logging-name }} log group](#cloud-logging)


## {{ objstorage-name }} bucket {#storage}

### ACCESS_DENIED {#bucket-access-denied}

* Make sure the service account used by the trail to upload audit logs to the bucket has the `storage.uploader` [role](../../storage/security/index.md#storage-uploader) or higher.
* If the bucket is [encrypted](../../storage/tutorials/server-side-encryption.md) with the {{ kms-full-name }} key, make sure the service account used by the trail to upload audit logs to the bucket has the `kms.keys.decrypter` [role](../../kms/security/index.md#kms-keys-decrypter) for the key.
* If the trail delivers events to the encrypted bucket, check that the {{ kms-name }} key for this bucket exists.
* Check the bucket [access control list (ACL)](../../storage/concepts/acl.md) and [bucket policy](../../storage/concepts/policy.md) and make sure they contain no rules that disable the service account to write data to the bucket.

### BUCKET_QUOTA_EXCEEDED {#bucket-quota-exceeded}

[Increase](../../storage/operations/buckets/limit-max-volume.md) the bucket size and [delete](../../storage/operations/objects/delete.md) the objects you do not need.

### BUCKET_CLOUD_QUOTA_EXCEEDED {#bucket-cloud-quota-exceeded}

Contact [support]({{ link-console-support }}) to have your {{ objstorage-name }} [quota](../../storage/concepts/limits.md#storage-quotas) for the cloud increased.

### BUCKET_NOT_FOUND {#bucket-not-found}

Check the bucket specified in the [trail settings](../concepts/trail.md#trail-settings). If the bucket was deleted:
1. [Create](../../storage/operations/buckets/create.md) a new bucket with the same name as that specified in the trail settings.

    You can also change the trail settings by specifying a different bucket under **{{ ui-key.yacloud.audit-trails.label_destination }}**.
1. If the bucket is [encrypted](../../storage/tutorials/server-side-encryption.md) with a {{ kms-full-name }} key, assign the `kms.keys.decrypter` [role](../../kms/security/index.md#kms-keys-decrypter) for the key to the service account used by the trail to upload audit logs to the bucket.


### BUCKET_INVALID_ENCRYPTION {#bucket-invalid-encryption}

Make sure the {{ kms-full-name }} key used to [encrypt](../../storage/tutorials/server-side-encryption.md) the bucket has the `Active` status.


### UNKNOWN or INTERNAL_ERROR {#bucket-internal-error}

Contact [support]({{ link-console-support }}) for additional information and recommendations.


## {{ yds-name }} data stream {#data-streams}

### ACCESS_DENIED {#stream-access-denied}

Make sure the service account used by the trail to upload audit logs to the stream has the `yds.writer` [role](../../data-streams/security/#yds-editor) or higher.

### STREAM_NOT_FOUND {#stream-not-found}

Check the stream specified in the [trail settings](../concepts/trail.md#trail-settings). If the stream or its {{ ydb-short-name }} database was deleted:
1. [Create](../../data-streams/operations/manage-streams.md#create-data-stream) a new stream.
1. Change the trail settings by specifying the new stream under **{{ ui-key.yacloud.audit-trails.label_destination }}**.

### DATABASE_INACTIVE {#database-inactive}

[Make sure](../../ydb/operations/manage-databases.md#list-db) the {{ ydb-short-name }} database has the `Running` status. Start the database if you need to, e.g., via the [management console]({{ link-console-main }}):
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the database name and select **{{ ui-key.yacloud.common.start }}**.

### DATABASE_NOT_FOUND {#database-not-found}

[Make sure](../../ydb/operations/manage-databases.md#list-db) the {{ ydb-short-name }} database has the `Running` status, and the linked [stream](../../data-streams/operations/manage-streams.md#list-data-streams) is `Active`. If the stream or its {{ ydb-short-name }} database were deleted, create a new [stream](../../data-streams/operations/manage-streams.md#create-data-stream) or [database](../../ydb/operations/manage-databases.md#serverless).

### UNKNOWN or INTERNAL_ERROR {#database-internal-error}

Contact [support]({{ link-console-support }}) for additional information and recommendations.

## {{ cloud-logging-name }} log group {#cloud-logging}

### ACCESS_DENIED {#logging-access-denied}

Make sure the service account used by the trail to upload audit logs to the log group has the `logging.writer` [role](../../logging/security/index.md#logging-writer) or higher.

### LOG_GROUP_NOT_FOUND {#log-group-not-found}

Check the log group specified in the [trail settings](../concepts/trail.md#trail-settings). If the log group was deleted:
1. [Create](../../logging/operations/create-group.md) a new log group.
1. Change the trail settings by specifying the new log group under **{{ ui-key.yacloud.audit-trails.label_destination }}**.

### UNKNOWN or INTERNAL_ERROR {#logging-internal-error}

Contact [support]({{ link-console-support }}) for additional information and recommendations.


## See also

* [{#T}](../../iam/operations/sa/assign-role-for-sa.md)
