Роль `security-deck.worker` позволяет просматривать информацию об области сканирования модуля DSPM и контролируемых ресурсах модулей KSPM и CSPM в Security Deck.

Пользователи с этой ролью могут:

* просматривать информацию об [организации](../../organization/concepts/organization.md), просматривать список [облаков](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталогов](../../resource-manager/concepts/resources-hierarchy.md#folder) и [бакетов](../../storage/concepts/bucket.md) в заданной пользователем модуля DSPM [области сканирования](../../security-deck/concepts/dspm.md#data-source) и информацию о них, а также просматривать данные в сканируемых бакетах;
* просматривать список облаков и каталогов и информацию о них в составе контролируемых ресурсов [окружения](../../security-deck/concepts/workspace.md) Security Deck для [модуля KSPM](../../security-deck/concepts/kspm.md);
* просматривать список кластеров Kubernetes, информацию о них и их настройках в составе контролируемых ресурсов окружения Security Deck для модуля KSPM;
* просматривать информацию об организации, просматривать список облаков и каталогов и информацию о них в составе контролируемых ресурсов окружения Security Deck для [модуля CSPM](../../security-deck/concepts/cspm.md).

Роль выдается [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), от имени которого будет выполняться [сканирование](../../security-deck/concepts/dspm.md#scanning) DSPM, проверка KSPM или CSPM. Роль назначается на организацию, облако, каталог или (при использовании [модуля DSPM](../../security-deck/concepts/dspm.md)) бакет.

Роль не позволяет просматривать данные в [зашифрованных бакетах](../../storage/concepts/encryption.md). Для сканирования зашифрованного бакета дополнительно назначьте сервисному аккаунту [роль](../../kms/security/index.md#kms-keys-encrypter) `kms.keys.decrypter` на соответствующий [ключ шифрования](../../kms/concepts/key.md), либо на каталог, облако или организацию, в которой находится этот ключ.

Включает разрешения, предоставляемые ролями `dspm.worker`, `kspm.worker` и `cspm.worker`.

{% note info %}

Роль не может гарантировать доступа к бакету, если к бакету применена [политика доступа](../../storage/security/policy.md) Yandex Object Storage.

{% endnote %}