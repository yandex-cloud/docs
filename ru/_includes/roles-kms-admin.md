### kms.admin {#kms-admin}

В роль администратора ключей `kms.admin` входят следующие разрешения:

* получение списка ключей в каталоге;
* [создание](../kms/operations/key.md#create) и [изменение](../kms/operations/key.md#update) ключа;
* [шифрование](../kms/operations/encryption.md#encryption) и [расшифровка](../kms/operations/encryption.md#decryption) данных;
* [ротация ключа](../kms/operations/key.md#rotate) и [смена основной версии](../kms/operations/version.md#make-primary);
* [удаление ключей](../kms/operations/key.md#delete) и [удаление версий](../kms/operations/version.md#delete);
* [назначение роли](../iam/operations/roles/grant.md), [отзыв роли](../iam/operations/roles/revoke.md) и просмотр назначенных ролей на ключ.

Эти разрешения также входят в роли `admin` и `resource-manager.clouds.owner`.

Сейчас эту роль можно назначить на [организацию](../organization/), [облако](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../resource-manager/concepts/resources-hierarchy.md#folder) или [ключ](../kms/concepts/key).
