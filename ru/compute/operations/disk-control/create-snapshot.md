---
title: "Как создать снимок диска"
description: "Следуя данной инструкции, вы сможете создать снимок диска."
---

# Создать снимок диска


_Снимок диска_ — это копия файловой системы диска на определенный момент времени.

{% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

## Подготовка {#prepare}

{% include [prepare-snapshots](../../../_includes/compute/prepare-snapshots.md) %}

## Создание снимка {#create}

Чтобы создать снимок диска:

{% include [create-snapshot](../../../_includes/compute/create-snapshot.md) %}

Создание снимка HDD или SSD выполняется асинхронно. Снимок создается сразу после команды создания и получает статус `Creating`. С этого момента можно возобновить запись на диск, операции с диском не повлияют на данные в снимке.

Когда создание снимка завершено, статус снимка изменится на `Ready`. С этого момента снимок можно использовать для создания образов, наполнения дисков и т. п.

{% note alert %}

{% include [include](../../../_includes/compute/duplicated-uuid-note.md) %}

Чтобы этого не произошло, подключите диск к ВМ и поменяйте все дублирующиеся UUID. Подробнее в [инструкции про подключение диска](../vm-control/vm-attach-disk.md).

{% endnote %}


#### См. также {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)
* [{#T}](../disk-create/from-snapshot.md)
