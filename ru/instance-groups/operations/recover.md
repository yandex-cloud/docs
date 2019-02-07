# Восстановить группу виртуальных машин

Вы можете восстановить группу, если в работе одной из виртуальных машин произошел сбой: виртуальная машина перешла в статус `FAILED`. Подробнее о статусах читайте в разделе [[!TITLE]](../concepts/instance-group-statuses-vm.md).

Чтобы восстановить группу виртуальных машин:

---

**[!TAB Консоль управления]**

1. Откройте страницу каталога в консоли управления.
1. Выберите сервис **[!KEYREF compute-full-name]**.
1. На странице **Виртуальные машины** перейдите на вкладку **Группы виртуальных машин**.
1. Нажмите на имя группы, которую желаете восстановить.
1. Нажмите **Восстановить** в правом верхнем углу страницы.

**[!TAB CLI]**

[!INCLUDE [cli-install.md](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue.md](../../_includes/default-catalogue.md)]

1. Посмотрите описание команды CLI для восстановления группы:

   ```
   $ [!KEYREF yc-compute-ig] recover --help
   ```

1. Получите список групп виртуальных машин в каталоге по умолчанию:

    [!INCLUDE [instance-group-list.md](../../_includes/instance-groups/instance-group-list.md)]

1. Выберите `ID` или `NAME` нужной группы, например `first-instance-group`.
1. Восстановите группу виртуальных машин в каталоге по умолчанию:

    ```
    $ [!KEYREF yc-compute-ig] recover --name first-instance-group
    ```

   [!KEYREF instance-groups-name] запустит операцию восстановления группы виртуальных машин.

**[!TAB API]**

Воспользуйтесь методом API [recover](../../instance-groups/api-ref/InstanceGroup/recover.md).

Список доступных групп запрашивайте методом [listInstances](../../instance-groups/api-ref/InstanceGroup/listInstances.md).

---
