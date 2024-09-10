Изменение [образа](../../cloud-desktop/concepts/images.md), размера [рабочего диска](../../cloud-desktop/concepts/disks.md#working-disk), vCPU, доли vCPU и RAM в параметрах [группы](../../cloud-desktop/concepts/desktops-and-groups.md) приводит к пересозданию [рабочих столов](../../cloud-desktop/concepts/desktops-and-groups.md).

[Загрузочный диск](../../cloud-desktop/concepts/disks.md#boot-disk) создается заново из образа, который был ранее выбран для группы рабочих столов. Установленные на загрузочный диск ПО и обновления будут потеряны. Рабочий диск остается прежним. Изменения не затрагивают директорию пользователя.

Чтобы применить изменения к конкретному рабочему столу, [обновите](../../cloud-desktop/operations/desktops/update.md) его.