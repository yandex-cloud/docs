#### compute.disks.user {#compute-disks-user}

В роль `compute.disks.user` входят следующие разрешения:

- получение списка [дисков](../compute/concepts/disk.md);
- получение информации о диске;
- использование диска для создания новых ресурсов (образов, снимков, новых дисков и виртуальных машин).

{% include [roles-editor-includes-permissions](iam/roles-editor-includes-permissions.md) %}

{% note info %}

Чтобы при создании виртуальной машины пометить диск автоматически удаляемым, этой роли недостаточно. Для этого используйте роль `editor`.

{% endnote %}

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}