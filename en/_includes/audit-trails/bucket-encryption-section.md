## Encrypting a bucket {#bucket-encryption}

To store logs in encrypted form:

1. Create an [encryption key](../../kms/operations/key.md#create) in {{ kms-full-name }}.
1. [Enable bucket encryption](../../storage/operations/buckets/encrypt.md#add) using the previously created key.
1. Assign the previously created service account the [`kms.keys.encrypterDecrypter`](../../kms/security/index.md#service-roles) role for the key:

   ```bash
   yc kms symmetric-key add-access-binding \
       --role kms.keys.encrypterDecrypter \
       --id <encryption_key_ID> \
       --service-account-id <service_account_ID>
   ```

   Where:
   * `role`: The role assigned.
   * `id`: The ID of the encryption key.
   * `service-account-id`: The ID of your service account.
