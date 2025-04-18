# Encryption in {{ objstorage-name }}

When using [{{ objstorage-full-name }}](../../storage/), you have to make sure to encrypt critical data.

We recommend encrypting {{ objstorage-name }} buckets using [{{ kms-full-name }}](../../kms/) keys (server-side encryption) to protect against accidental or intentional publication of the bucket contents on the web.

{% note alert %}

Data in {{ objstorage-short-name }} is encrypted using [envelope encryption](../../kms/concepts/envelope.md), thus, deleting a key is the same as destroying all data encrypted with that key.

{% endnote %}

Server-side encryption requires keys stored in {{ kms-name }}. You should specify the created {{ kms-short-name }} key in the bucket settings. It will be used for encrypting all new objects or when [uploading an object via the API](../../storage/s3/api-ref/object/upload.md).

Objects are encrypted before you save them to a bucket and decrypted when you download them from the bucket. By default, encryption applies to all new objects, while previously uploaded ones remain unchanged.


{% include [encryption-roles](../../_includes/storage/encryption-roles.md) %}

In addition to {{ kms-name }} key-based encryption, you can also use the following approaches:

{% include [encryption-client-side](../../_includes/storage/encryption-client-side.md) %}

## Use cases {#examples}

* [{#T}](../tutorials/server-side-encryption.md)
* [{#T}](../tutorials/static-key-in-lockbox/index.md)
* [{#T}](../tutorials/export-logs-to-arcsight.md)
* [{#T}](../tutorials/export-logs-to-splunk.md)


#### See also {#see-also}

* [{#T}](../operations/buckets/encrypt.md)
* [{#T}](../../kms/operations/key.md)
