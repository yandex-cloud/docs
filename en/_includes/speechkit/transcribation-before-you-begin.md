1. [Create](../../storage/operations/buckets/create.md) a bucket and upload the audio file to recognize there.
1. [Create](../../iam/operations/sa/create.md) a service account.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the service account the `storage.uploader` and `ai.speechkit-stt.user` roles for the folder where you created the bucket.
1. [Get](../../iam/operations/iam-token/create-for-sa.md) an IAM token for the created service account.