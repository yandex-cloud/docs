{% note tip %}

Чтобы использовать [UEFI/EFI](https://ru.wikipedia.org/wiki/Extensible_Firmware_Interface)-загрузчик, при создании образа и виртуальной машины {{ compute-name }} выбирайте [поколение оборудования](../../compute/concepts/hardware-generations.md) `Gen 2`. Подробнее о создании ВМ, работающей на виртуализированном оборудовании поколения `Gen 2`, читайте в [инструкции](../../compute/operations/vm-create/create-gen2-vm.md).

Чтобы загружаться с дисков объемом более 2 ТБ с разметкой [GUID Partition Table (GPT)](https://ru.wikipedia.org/wiki/Таблица_разделов_GUID) на виртуальных машинах, работающих на оборудовании поколений `Gen 1.1` и `Gen 1.2`, используйте загрузчик [GRUB 2](https://www.gnu.org/software/grub/manual/grub/html_node/BIOS-installation.html).

{% endnote %}