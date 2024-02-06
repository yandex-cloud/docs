## Roles required to mount a bucket

To mount a bucket, the [service account](../../iam/concepts/users/service-accounts) needs the following roles:
* `storage.viewer` to only read data from the bucket.
* `storage.uploader` to both read and write bucket data.