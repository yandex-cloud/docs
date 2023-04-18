# Handling errors

If a trail cannot send audit logs to the [destination object](../concepts/trail.md#target), the [trail status](../concepts/trail.md#status) will change to `Error`. This guide contains recommendations on how to recover the trail.

{% note info %}

A few minutes after the error cause is removed, the trail status will change to `Active`. All audit logs will be uploaded to the destination object.

{% endnote %}


Destination objects:
* [{{ objstorage-name }} bucket](#storage)
* [{{ yds-name }} stream](#data-streams)
* [{{ cloud-logging-name }} log group](#cloud-logging)


## {{ objstorage-name }} bucket {#storage}

### ACCESS_DENIED {#bucket-access-denied}

* Make sure the service account used by the trail to upload audit logs to the bucket is assigned the `storage.uploader` or a higher [role](../../iam/concepts/access-control/roles.md#storage-uploader).
   * If the bucket is [encrypted](../../storage/tutorials/server-side-encryption.md) with the {{ kms-full-name }} key, make sure the service account used by the trail to upload audit logs to the bucket has the `kms.keys.encrypterDecrypter` [role](../../iam/concepts/access-control/roles.md#kms-keys-encrypterdecrypter) for the key.
* Check the bucket [access control list (ACL)](../../storage/concepts/acl.md) and [bucket policy](../../storage/concepts/policy.md) and make sure they contain no rules that disable the service account to write data to the bucket.

### BUCKET_QUOTA_EXCEEDED {#bucket-quota-exceeded}

[Increase](../../storage/operations/buckets/limit-max-volume.md) the bucket size and [delete](../../storage/operations/objects/delete.md) the objects you do not need.

### BUCKET_CLOUD_QUOTA_EXCEEDED {#bucket-cloud-quota-exceeded}

Contact [support]({{ link-console-support }}) to have the {{ objstorage-name }} [quota](../../storage/concepts/limits.md#storage-quotas) for the cloud increased.

### BUCKET_NOT_FOUND {#bucket-not-found}

Check the bucket specified in the [trail settings](../concepts/trail.md#trail-settings). If the bucket was deleted:
1. [Create](../../storage/operations/buckets/create.md) a new bucket with the same name as that specified in the trail settings.

   You can also change the trail settings by specifying a different bucket under **Destination**.
1. If the bucket is [encrypted](../../storage/tutorials/server-side-encryption.md) with the {{ kms-full-name }} key, grant the `kms.keys.encrypterDecrypter` [role](../../iam/concepts/access-control/roles.md#kms-keys-encrypterdecrypter) for the key to the service account used by the trail to upload audit logs to the bucket.


### BUCKET_INVALID_ENCRYPTION {#bucket-invalid-encryption}

Check whether the {{ kms-full-name }} key used to [encrypt](../../storage/tutorials/server-side-encryption.md) the bucket has the `Active` status.


### UNKNOWN or INTERNAL_ERROR {#bucket-internal-error}

Contact [support]({{ link-console-support }}) for additional information and recommendations.


## {{ yds-name }} stream {#data-streams}

### ACCESS_DENIED {#stream-access-denied}

Make sure the service account used by the trail to upload audit logs to the stream is assigned the `yds.writer` or a higher [role](../../data-streams/security/#yds-editor).

### STREAM_NOT_FOUND {#stream-not-found}

Check the stream specified in the [trail settings](../concepts/trail.md#trail-settings). If the stream or its {{ ydb-short-name }} database was deleted:
1. [Create](../../data-streams/operations/manage-streams.md#create-data-stream) a new stream.
1. Change the trail settings by specifying the new stream under **Destination**.

## {{ cloud-logging-name }} log group {#cloud-logging}

### ACCESS_DENIED {#logging-access-denied}

Make sure the service account used by the trail to upload audit logs to the log group is assigned the `logging.writer` or a higher [role](../../iam/concepts/access-control/roles.md#loggingwriter).

### LOG_GROUP_NOT_FOUND {#log-group-not-found}

Check the log group specified in the [trail settings](../concepts/trail.md#trail-settings). If the log group was deleted:
1. [Create](../../logging/operations/create-group.md) a new log group.
1. Change the trail settings by specifying the new log group under **Destination**.


## See also

* [{#T}](../../iam/operations/sa/assign-role-for-sa.md)
