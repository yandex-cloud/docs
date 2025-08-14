Роль `dspm.worker` позволяет просматривать информацию об [организации](../../organization/concepts/organization.md), просматривать список [облаков](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталогов](../../resource-manager/concepts/resources-hierarchy.md#folder) и [бакетов](../../storage/concepts/bucket.md) в заданной пользователем [области сканирования](../../security-deck/concepts/dspm.md#data-source) и информацию о них, а также просматривать данные в сканируемых бакетах.

Роль выдается [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), от имени которого будет выполняться [сканирование](../../security-deck/concepts/dspm.md#scanning), и назначается на организацию, облако, каталог или бакет.

Роль не позволяет просматривать данные в [зашифрованных бакетах](../../storage/concepts/encryption.md). Для сканирования зашифрованного бакета дополнительно назначьте сервисному аккаунту [роль](../../kms/security/index.md#kms-keys-encrypter) `kms.keys.decrypter` на соответствующий [ключ шифрования](../../kms/concepts/key.md), либо на каталог, облако или организацию, в которой находится этот ключ.

{% note info %}

Роль не может гарантировать доступа к бакету, если к бакету применена [политика доступа](../../storage/security/policy.md) Yandex Object Storage.

{% endnote %}

