1. [Create](../../storage/operations/buckets/create.md) a bucket and [upload](../../storage/operations/objects/upload.md) the audio file for recognition.
1. [Create](../../iam/operations/sa/create.md) a service account.

   {% note warning %}

   Please note that you can only recognize audio files asynchronously under a service account. Do not use any [other accounts in {{ yandex-cloud }}](../../iam/concepts/users/accounts.md) for that.

   {% endnote %}

1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the service account the `storage.uploader` and `ai.speechkit-stt.user` roles for the folder where you created the bucket.
1. Get an [IAM token](../../iam/operations/iam-token/create-for-sa.md) or [API key](../../iam/operations/api-key/create.md) for the created service account.
