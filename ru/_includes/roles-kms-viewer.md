#### kms.viewer {#kms-viewer}

Роль `kms.viewer` дает право просматривать информацию о ключах подписи и шифрования. Не позволяет получить публичный ключ.

Сейчас эту роль можно назначить на [организацию](../organization/), [облако](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../resource-manager/concepts/resources-hierarchy.md#folder) или [ключ](../kms/concepts/key).

Выдать роль может администратор {{ kms-short-name }} (роль `kms.admin`).

Подробнее о том, как работать с ролями в {{ kms-name }}, читайте в разделе [{#T}](../kms/security/index.md).