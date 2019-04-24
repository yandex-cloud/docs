# Подключить диск к виртуальной машине

[!INCLUDE [disk-auto-delete](../../_includes_service/disk-auto-delete.md)]

Чтобы подключить диск к виртуальной машине:

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Посмотрите описание команды CLI для подключения дисков:

    ```
    $ yc compute instance attach-disk --help
    ```

1. Получите список виртуальных машин в каталоге по умолчанию:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Выберите `ID` или `NAME` нужной машины, например `first-instance`.
1. Остановите виртуальную машину:

    ```
    $ yc compute instance stop first-instance
    ```

1. Получите список дисков в каталоге по умолчанию:

    [!INCLUDE [compute-disk-list](../../_includes_service/compute-disk-list.md)]

1. Выберите `ID` или `NAME` нужного диска, например `first-disk`. Посмотреть список подключенных к виртуальной машине дисков можно с помощью команды:

    ```
    $ yc compute instance get --full first-instance
    ```

1. Подключите диск к виртуальной машине:

    ```
    $ yc compute instance attach-disk first-instance \
        --disk-name first-disk \
        --mode rw
    ```
    
    [!INCLUDE [attach_empty_disk](../../_includes_service/attach-empty-disk.md)]

    Чтобы указать необходимость удаления диска при удалении машины, установите флаг `--auto-delete`:

    ```
    $ yc compute instance attach-disk first-instance \
        --disk-name first-disk \
        --mode rw \
        --auto-delete
    ```

1. Запустите виртуальную машину:

    ```
    $ yc compute instance start first-instance
    ```

**[!TAB API]**

Воспользуйтесь методом [attachDisk](../../api-ref/Instance/attachDisk.md) для ресурса [Instance](../../api-ref/Instance/).

---

## Разметить и смонтировать пустой диск в Linux {#mount}

Чтобы самостоятельно разметить и смонтировать пустой диск:

1. Выполните команду `lsblk`, чтобы проверить, подключен ли диск как устройство и узнать его путь в системе.  Обычно, пустой диск имеет метку вида `/dev/vdb`.

1. Разметьте диск. Для этого, создайте на нём [разделы](https://help.ubuntu.ru/wiki/%D1%80%D0%B0%D0%B7%D0%B4%D0%B5%D0%BB%D1%8B_%D0%B8_%D1%84%D0%B0%D0%B9%D0%BB%D0%BE%D0%B2%D1%8B%D0%B5_%D1%81%D0%B8%D1%81%D1%82%D0%B5%D0%BC%D1%8B_linux) с помощью утилит [`cfdisk`](https://www.alv.me/utility-razmetki-cfdisk/), `fdisk`, или `parted`. Отформатируйте диск в нужную файловую систему, например, с помощью утилиты [`mkfs`](https://www.opennet.ru/man.shtml?topic=mkfs&category=8&russian=0).

1. Выполните команду [`mount`](https://help.ubuntu.ru/wiki/%D0%BC%D0%BE%D0%BD%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5_%D1%80%D0%B0%D0%B7%D0%B4%D0%B5%D0%BB%D0%BE%D0%B2), чтобы смонтировать готовый раздел.

1. Выполните команду `df`, чтобы проверить состояние файловой системы.