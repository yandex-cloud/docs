# Encryption in {{ objstorage-name }}

When using [{{ objstorage-full-name }}](../../storage/), you have to make sure to encrypt critical data.

We recommend encrypting {{ objstorage-name }} buckets using [{{ kms-full-name }}](../../kms/) keys (server-side encryption). This encryption method protects against accidental or intentional publication of the bucket content on the web.

{% note alert %}

Data in {{ objstorage-short-name }} is encrypted using [envelope encryption](../../kms/concepts/envelope.md), meaning that deleting a key is the same as destroying all data encrypted with that key.

{% endnote %}

Server-side encryption is performed using keys stored in {{ kms-full-name }}. A created {{ kms-short-name }} key is specified in the bucket settings. It will be used for encrypting all new objects or when [uploading an object via the API](../../storage/s3/api-ref/object/upload.md).

Objects are encrypted before you save them to a bucket and decrypted when you download them from the bucket. By default, encryption applies to all new objects, while previously uploaded ones remain unchanged.


To decrypt objects, the user must have both the `storage.editor` role and the `kms.keys.dencrypter` role that allows them to [read the encryption key](../../kms/security/index.md#service).



In addition to {{ kms-full-name }} key-based encryption, you can also use the following approaches:

{% include [encryption-client-side](../../_includes/storage/encryption-client-side.md) %}


#### See also {#see-also}

* [{#T}](../operations/buckets/encrypt.md)
* [{#T}](../../kms/operations/key.md)
