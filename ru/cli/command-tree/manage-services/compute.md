# yc compute

Управление ресурсами {{ compute-full-name }}.

#### Использование команды

Синтаксис:

`yc compute <group>`

#### Группы

- `yc compute instance` — управление [виртуальными машинами](../../../compute/concepts/vm.md).
    - `get` — [получить информацию об указанной виртуальной машине](../../../compute/operations/vm-info/get-info.md).
    - `list` — получить список виртуальных машин.
    - `create` — [создать виртуальную машину](../../../compute/operations/vm-create/create-linux-vm.md).
    - `update` — [изменить указанную виртуальную машину](../../../compute/operations/vm-control/vm-update.md).
    - `delete` — [удалить указанную виртуальную машину](../../../compute/operations/vm-control/vm-delete.md).
    - `get-serial-port-output` — [получить вывод последовательного порта указанной виртуальной машины](../../../compute/operations/vm-info/get-serial-port-output.md).
    - `stop` — [остановить указанную виртуальную машину](../../../compute/operations/vm-control/vm-stop-and-start.md#stop).
    - `start` — [запустить указанную виртуальную машину](../../../compute/operations/vm-control/vm-stop-and-start.md#start).
    - `restart` — [перезапустить указанную виртуальную машину](../../../compute/operations/vm-control/vm-stop-and-start.md#restart).
    - `attach-disk` — [подключить существующий диск к указанной виртуальной машине](../../../compute/operations/vm-control/vm-attach-disk.md).
    - `attach-new-disk` — подключить новый диск к указанной виртуальной машине.
    - `detach-disk` — [отключить существующий диск от указанной виртуальной машине](../../../compute/operations/vm-control/vm-detach-disk.md).
    - `list-operations` — получить список операций для указанной виртуальной машины.
- `yc compute disk` — управление [дисками](../../../compute/concepts/disk.md).
    - `get` — получить информацию об указанном диске.
    - `list` — получить список дисков.
    - `create` — [создать диск](../../../compute/operations/disk-create/empty.md).
    - `update` — изменить диск.
    - `resize` — изменить размер указанного диска.
    - `delete` — [удалить указанный диск](../../../compute/operations/disk-control/delete.md).
    - `list-operations` — получить список операций для указанного диска.
- `yc compute disk-type` — получение информации о доступных типах диска.
    - `get` —  получить информацию об указанном типе диска.
    - `list` — получить список типов диска.
- `yc compute image` — управление [образами](../../../compute/concepts/image.md).
    - `get` — получить информацию об указанном образе.
    - `list`— [получить список образов](../../../compute/operations/images-with-pre-installed-software/get-list.md).
    - `get-latest-from-family` — получить информацию о последнем образе, который является частью семейства образов.
    - `create` — [создать образ](../../../compute/operations/image-create/upload.md#2.-sozdajte-obraz-v-compute-cloud).
    - `update` — изменить указанный образ.
    - `delete` — удалить указанный образ.
    - `list-operations` — получить список операций для указанного образа.
- `yc compute snapshot` — управление [снимками дисков](../../../compute/concepts/snapshot.md).
    - `get` — получить информацию об указанном снимке диска.
    - `list` — получить список снимков диска.
    - `create` — [создать снимок указанного диска](../../../compute/operations/disk-control/create-snapshot.md).
    - `update` — изменить указанный снимок диска.
    - `delete` — [удалить указанный снимок диска](../../../compute/operations/snapshot-control/delete.md).
    - `list-operations` — получить список операций для указанного снимка диска.
- `yc compute zone` — получение [зон доступности](../../../overview/concepts/geo-scope.md).
    - `get` — получить информацию об указанной зоне доступности.
    - `list` — получить список зон доступности.

