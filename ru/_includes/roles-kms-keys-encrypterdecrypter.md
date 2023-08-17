#### kms.keys.encrypterDecrypter {#kms-keys-encrypterdecrypter}

В роль пользователя ключей `kms.keys.encrypterDecrypter` входят следующие разрешения:

* получение информации о ключах и версиях;
* [шифрование](../kms/operations/encryption.md#encryption) и [расшифровка](../kms/operations/encryption.md#decryption) данных.

{% include [roles-editor-includes-permissions](iam/roles-editor-includes-permissions.md) %}

Сейчас эту роль можно назначить на [организацию](../organization/), [облако](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../resource-manager/concepts/resources-hierarchy.md#folder) или [ключ](../kms/concepts/key).

Выдать роль может администратор {{ kms-short-name }} (роль `kms.admin`).

Подробнее о том, как работать с ролями в {{ kms-name }}, читайте в разделе [{#T}](../kms/security/index.md).