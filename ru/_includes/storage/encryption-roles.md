Чтобы работать с объектами в [зашифрованном](../../storage/concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вместе с [ролью](../../storage/security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../kms/operations/key-access.md):

* `kms.keys.encrypter` — для чтения ключа, [шифрования](../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
* `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
* `kms.keys.encrypterDecrypter` — включает [разрешения](../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.

Подробнее см. [Сервисные роли {{ kms-name }}](../../kms/security/index.md#service-roles).