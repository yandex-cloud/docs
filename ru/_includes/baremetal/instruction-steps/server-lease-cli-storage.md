`storages` — настройки разметки [дисков](../../../baremetal/concepts/disks/disk-types.md) в параметре `--os-settings-spec`. Необязательная настройка. Возможные значения:

* `partitions` — разделы диска:
  
  * `type` — файловая система. Возможные значения: `EXT3`, `EXT4`, `SWAP`, `XFS`.
  * `size-gib` — размер раздела в гигабайтах.
  * `mount-point` — точка монтирования.

* `storage-type` — тип хранилища:

  * `disk` — отдельный диск:

    * `id` — номер диска.
    * `size-gib` — размер диска в гигабайтах.
    * `type` — тип диска.
  * `raid` — RAID-массив:

    * `type` — [уровень RAID-массива](../../../baremetal/concepts/disks/raid.md#levels).
    * `disks` — список дисков в RAID-массиве.
