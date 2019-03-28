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
