`--storage` — настройки разметки [дисков](../../../baremetal/concepts/disks/disk-types.md). Необязательный параметр. Возможные настройки:

* `partition` — раздел диска:
  
  * `type` — файловая система. Возможные значения: `Ext3`, `Ext4`, `Swap`, `Xfs`.
  * `size-gib` — размер раздела в гигабайтах.
  * `mount-point` — точка монтирования.

* `disk` — диск:
  
  * `id` — номер диска.
  * `size-gib` — размер диска в гигабайтах.
  * `type` — тип диска
* `raid-type` — [уровень RAID-массива](../../../baremetal/concepts/disks/raid.md#levels).