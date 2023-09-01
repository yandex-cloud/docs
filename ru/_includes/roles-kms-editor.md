#### kms.editor {#kms-editor}

В роль `kms.editor` входят следующие разрешения:

* получение списка ключей в каталоге;
* [создание](../kms/operations/key.md#create) и [изменение](../kms/operations/key.md#update);
* симметричное [шифрование](../kms/operations/symmetric-encryption.md#encryption) и [расшифровка](../kms/operations/symmetric-encryption.md#decryption) данных;
* создание асимметричных ключей шифрования и подписи;
* подпись с использованием закрытого ключа подписи;
* расшифровка с использованием закрытого ключа шифрования;
* получение публичной части ключа шифрования и подписи;
* [ротация ключа](../kms/operations/key.md#rotate).

Сейчас эту роль можно назначить на [организацию](../organization/), [облако](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../resource-manager/concepts/resources-hierarchy.md#folder) или [ключ](../kms/concepts/key).

Выдать роль может администратор {{ kms-short-name }} (роль `kms.admin`).

Подробнее о том, как работать с ролями в {{ kms-name }}, читайте в разделе [{#T}](../kms/security/index.md).