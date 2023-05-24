### kms.keys.encrypter {#kms-keys-encrypter}

В роль пользователя ключей `kms.keys.encrypter` входят следующие разрешения:

* получение информации о ключах и версиях;
* [шифрование](../kms/operations/encryption.md#encryption) данных.

{% include [roles-crypt-includes-permissions](iam/roles-crypt-includes-permissions.md) %}

Сейчас эту роль можно назначить на [организацию](../organization/), [облако](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../resource-manager/concepts/resources-hierarchy.md#folder) или [ключ](../kms/concepts/key).

Выдать роль может администратор {{ kms-short-name }} (роль `kms.admin`).

Подробнее о том, как работать с ролями в {{ kms-name }}, читайте в разделе [{#T}](../kms/security/index.md).