* `osSettingsSpec` — настройки операционной системы. Чтобы арендовать сервер без операционной системы, пропустите этот параметр.
Возможные настройки:
  * `imageId` — идентификатор одного из доступных [публичных образов](../../baremetal/concepts/images.md#marketplace-images) ОС в {{ marketplace-full-name }}.
  * `storages[]` — настройки разметки дисков. Необязательный параметр. Возможные настройки:
    * `partitions[]` — раздел диска:
      * `type` — файловая система. Возможные значения: `EXT4`, `EXT3`, `SWAP`, `XFS`.
      * `sizeGib` — размер раздела в гигабайтах.
      * `mountPoint` — точка монтирования.
    * `disk` — настройки диска:
      * `id` — идентификатор диска.
      * `type` — тип диска. Возможные значения: `HDD`, `SSD`, `NVME`.
      * `sizeGib` — размер диска в гигабайтах.
    * `raid` — настройки RAID-массива:
      * `type` — тип RAID. Возможные значения: `RAID0`, `RAID1`, `RAID10`.
      * `disks[]` — массив дисков в RAID-конфигурации. Каждый диск содержит поля `id`, `type` и `sizeGib`.
  * `sshPublicKey` — содержимое открытого SSH-ключа. Пару SSH-ключей для подключения к серверу по [SSH](../../glossary/ssh-keygen.md) необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
  * `userSshId` — идентификатор пользователя SSH-ключа. Необязательный параметр.
  * `passwordPlainText` — пароль root-пользователя. Необязательный параметр.

    {% include [server-lease-access-password-warning](server-lease-access-password-warning.md) %}

  * `passwordLockboxSecret` — [секрет](../../lockbox/concepts/secret.md) {{ lockbox-full-name }}:
    * `secretId` — идентификатор секрета.
    * `versionId` — версия секрета.
    * `key` — ключ секрета.
