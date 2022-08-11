### kms.editor {#kms-editor}

В роль `kms.editor` входят следующие разрешения:

* получение списка ключей в каталоге;
* [создание](../kms/operations/key.md#create) и [изменение](../kms/operations/key.md#update) ключа;
* [шифрование](../kms/operations/encryption.md#encryption) и [расшифровка](../kms/operations/encryption.md#decryption) данных;
* [ротация ключа](../kms/operations/key.md#rotate).

Сейчас эту роль можно назначить на [организацию](../organization/index.yaml), [облако](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../resource-manager/concepts/resources-hierarchy.md#folder) или [ключ](../kms/concepts/key).

Выдать роль может администратор {{ kms-short-name }} (роль `kms.admin`).

Подробнее о том, как работать с ролями в {{ kms-name }}, читайте в разделе [{#T}](../kms/security/index.md).