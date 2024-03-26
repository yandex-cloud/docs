## Encrypting a bucket {#bucket-encryption}

To store logs in encrypted form:

1. Create a [symmetric encryption key](../../kms/operations/key.md#create) in {{ kms-full-name }}.
1. [Enable bucket encryption](../../storage/operations/buckets/encrypt.md#add) using the previously created key.
1. To upload logs to an encrypted bucket, assign the [`kms.keys.encrypter`](../../kms/security/index.md#service-roles) role for the key to the previously created service account:

   ```bash
   yc kms symmetric-key add-access-binding \
       --role kms.kms.keys.encrypter \
       --id <key_ID> \
       --service-account-id <service_account_ID>
   ```

   Where:
   * `--role`: Role being assigned.
   * `--id`: Encryption key ID.
   * `--service-account-id`: Service account ID.
