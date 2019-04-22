# Получить список групп виртуальных машин

Чтобы получить список групп виртуальных машин:

---

**[!TAB Консоль управления]**

1. Откройте страницу каталога в консоли управления.
1. Выберите сервис **[!KEYREF compute-full-name]**.
1. На странице **Виртуальные машины** перейдите на вкладку **Группы виртуальных машин**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Посмотрите описание команды CLI для работы с группой виртуальных машин:

    ```
    $ [!KEYREF yc-compute-ig] --help
    ```

1. Получите список групп виртуальных машин в каталоге по умолчанию:

    [!INCLUDE [instance-group-list](../../../_includes/instance-groups/instance-group-list.md)]

**[!TAB API]**

Воспользуйтесь методом API [list](../../instancegroup/api-ref/InstanceGroup/list.md).

Список доступных групп запрашивайте методом [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md).

---
