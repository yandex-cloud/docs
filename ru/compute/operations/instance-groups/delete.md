# Удалить группу виртуальных машин

> [!IMPORTANT]
>
> Удаление группы виртуальных машин — неотменяемая и необратимая операция, восстановить удаленную группу невозможно. Вместе с группой удаляются целевая группа [!KEYREF load-balancer-name], виртуальные машины и диски.

Чтобы удалить группу виртуальных машин:

---

**[!TAB Консоль управления]**

1. Откройте страницу каталога в консоли управления.

1. Выберите сервис **[!KEYREF compute-full-name]**.

1. На странице **Виртуальные машины** перейдите на вкладку **Группы виртуальных машин**.

1. Нажмите значок ![image](../../../_assets/vertical-ellipsis.svg) для нужной группы и выберите пункт **Удалить**.

**[!TAB CLI]**

[!INCLUDE [cli-install.md](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue.md](../../../_includes/default-catalogue.md)]

1. Посмотрите описание команды CLI для удаления группы виртуальных машин:

    ```
    $ [!KEYREF yc-compute-ig] delete --help
    ```

1. Получите список групп виртуальных машин в каталоге по умолчанию:

    [!INCLUDE [instance-group-list](../../../_includes/instance-groups/instance-group-list.md)]

1. Выберите `ID` или `NAME` нужной группы, например `first-group`.
1. Удалите группу виртуальных машин:

    ```
    $ [!KEYREF yc-compute-ig] delete --name first-group
    ```

    [!KEYREF ig-name] запустит операцию удаления группы виртуальных машин.

**[!TAB API]**

Воспользуйтесь методом API [delete](../../api-ref/InstanceGroup/delete.md).

Список доступных групп запрашивайте методом [listInstances](../../api-ref/InstanceGroup/listInstances.md).

---
