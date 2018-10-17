# Изменить ВМ

После создания виртуальной машины вы можете изменить ее имя, описание, метки или метаданные.

[!INCLUDE [change-vm-resources](../../_includes_service/change-vm-resources.md)]

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Посмотрите описание команды CLI для обновления параметров виртуальных машин:

    ```
    $ yc compute instance update --help
    ```

2. Получите список всех виртуальных машин в каталоге по умолчанию:

    ```
    $ yc compute instance list

    +----------------------+---------------+---------------+---------+----------------------+
    |          ID          |     NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
    +----------------------+---------------+---------------+---------+----------------------+
    | fhm0b28lgfp4tkoa3jl6 | my-windows-vm | ru-central1-a | RUNNING | my first vm via CLI  |
    | fhm9gk85nj7gcoji2f8s | my-linux-vm   | ru-central1-a | RUNNING | my second vm via CLI |
    +----------------------+---------------+---------------+---------+----------------------+
    ```

3. Выберите `ID` или `NAME` нужной машины, например `my-windows-vm`.
4. Измените параметры виртуальной машины, например переименуйте ее:

    ```
    $ yc compute instance update my-windows-vm \
        --new-name windows-vm
    ```

**[!TAB API]**

Чтобы изменить виртуальную машину, воспользуйтесь методом [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md).

---
