# Handling errors

If a trail cannot send events to the [destination object](../concepts/trail.md#target), the [trail status](../concepts/trail.md#status) will change to `error`. This guide contains recommendations on how to recover the trail.

{% note info %}

When the error cause is removed, the trail status will change to `active` after a few minutes.

{% endnote %}


## Destination object: {{ objstorage-full-name }}{#storage}

### ACCESS_DENIED {#access-denied}

* Check the service account rights, namely, whether it can write data to a bucket. This requires the `storage.uploader` role or higher.
* If the bucket is [encrypted](../../storage/tutorials/server-side-encryption.md) with the {{ kms-full-name }} key, make sure the service account has the `kms.keys.encrypterDecrypter` role for the key.
* Check the [bucket ACL](../../storage/concepts/acl.md) and [bucket policy](../../storage/concepts/policy.md) and make sure they contain no rules that disable the service account to write data to the bucket.


### BUCKET_QUOTA_EXCEEDED {#bucket-quota-exceeded}

Increase the bucket size and delete the objects you do not need.

### BUCKET_CLOUD_QUOTA_EXCEEDED {#bucket-cloud-quota-exceeded}

Contact [support]({{ link-console-support }}) to have the {{ objstorage-name }} quota for the cloud increased.

### BUCKET_NOT_FOUND {#bucket-not-found}

* Create a bucket with the same name and assign the service account bucket roles.
* You can also edit the trail by specifying a different destination bucket.


### BUCKET_INVALID_ENCRYPTION {#bucket-invalid-encryption}

Check whether the key used to encrypt the bucket has the `active` status.


### UNKNOWN or INTERNAL_ERROR {#internal-error}

Contact [support]({{ link-console-support }}) for additional information and recommendations.
