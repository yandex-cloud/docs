(Опционально) Добавьте дополнительный [диск](../../../compute/concepts/disk.md):

* В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
* В открывшемся окне выберите **{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}**. Вы можете выбрать существующий диск или создать новый диск — пустой или из снимка / образа.

    Например, чтобы создать новый пустой диск:

    * Выберите `Создать новый`.
    * В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-none }}`.
    * Укажите имя диска.
    * Выберите [тип диска](../../../compute/concepts/disk.md#disks_types).
    * Задайте нужные размер диска и размер блока.
    * (Опционально) В поле **{{ ui-key.yacloud.compute.field_additional }}** включите опцию **{{ ui-key.yacloud.compute.field_disk-autodelete }}**, если вы хотите автоматически удалять этот диск при удалении ВМ.
    * Нажмите кнопку **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.