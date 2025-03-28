1. [Create](../../storage/operations/buckets/create.md) a bucket and [upload](../../storage/operations/objects/upload.md) to it the audio file you want to recognize.
1. [Create](../../iam/operations/sa/create.md) a service account.

   {% note warning %}

   You can recognize audio files asynchronously only as a service account. Do not use any [other accounts {{ yandex-cloud }}](../../iam/concepts/users/accounts.md) for the purpose.

   {% endnote %}

1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) to the service account the `storage.uploader` and `ai.speechkit-stt.user` roles for the folder you had created the bucket in.
1. Get an [IAM token](../../iam/operations/iam-token/create-for-sa.md) or [API key](../../iam/operations/authentication/manage-api-keys.md#create-api-key) for the created service account.
