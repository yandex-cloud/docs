# Изменить группу виртуальных машин

После создания группы виртуальных машин вы можете:

- [Изменить имя и описание](#change-name).
- [Изменить вычислительные ресурсы](#change-compute-resources).
- [Увеличить размер диска](#change-disk-size).

## Изменить имя и описание {#change-name}

Чтобы изменить имя и описание группы виртуальных машин:

---

**[!TAB Консоль управления]**

1. Откройте страницу каталога в консоли управления.
1. Выберите сервис **[!KEYREF compute-full-name]**.
1. На странице **Виртуальные машины** перейдите на вкладку **Группы виртуальных машин**.
1. Нажмите на имя группы, которую желаете изменить.
1. Нажмите **Изменить** в правом верхнем углу страницы.
1. Укажите нужное имя и описание группы.
1. Нажмите **Сохранить**.

**[!TAB CLI]**

[!INCLUDE [cli-install.md](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue.md](../../_includes/default-catalogue.md)]

1. Посмотрите описание команды CLI для изменения группы:

   ```
   $ [!KEYREF yc-compute-ig] update --help
   ```

1. Получите список групп виртуальных машин в каталоге по умолчанию:

    [!INCLUDE [instance-group-list.md](../../_includes/instance-groups/instance-group-list.md)]

1. Выберите `ID` или `NAME` нужной группы, например `first-instance-group`.
1. Укажите нужное имя и описание в YAML-файле, по которому создавалась группа, например `template.yaml`. Если YAML-файл не сохранился, [получите информацию](get-info.md) о группе виртуальных машин и создайте новый. Подробнее читайте в разделе [[!TITLE]](create-fixed-group.md).
1. Обновите группу виртуальных машин в каталоге по умолчанию:

    ```
    $ [!KEYREF yc-compute-ig] update --name first-instance-group --file template.yaml
    ```

   [!KEYREF instance-groups-name] запустит операцию изменения группы виртуальных машин.

**[!TAB API]**

Изменить имя и описание группы можно с помощью метода API [update](../../instance-groups/api-ref/InstanceGroup/update.md).

Список доступных групп запрашивайте методом [listInstances](../../instance-groups/api-ref/InstanceGroup/listInstances.md).

---

## Изменить вычислительные ресурсы {#change-compute-resources}

После создания группы виртуальных машин вы можете изменить:

- гарантированную долю vCPU;
- количество vCPU и объем RAM.

Чтобы изменить вычислительные ресурсы группы виртуальных машин:

---

**[!TAB Консоль управления]**

1. Откройте страницу каталога в консоли управления.
1. Выберите сервис **[!KEYREF compute-full-name]**.
1. На странице **Виртуальные машины** перейдите на вкладку **Группы виртуальных машин**.
1. Нажмите на имя группы, которую желаете изменить.
1. Нажмите **Изменить** в правом верхнем углу страницы.
1. Удалите текущий шаблон виртуальной машины и создайте новый с нужными параметрами ВМ.
1. Нажмите **Сохранить**.

**[!TAB CLI]**

[!INCLUDE [cli-install.md](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue.md](../../_includes/default-catalogue.md)]

1. Посмотрите описание команды CLI для изменения группы:

   ```
   $ [!KEYREF yc-compute-ig] update --help
   ```

1. Получите список групп виртуальных машин в каталоге по умолчанию:

    [!INCLUDE [instance-group-list.md](../../_includes/instance-groups/instance-group-list.md)]

1. Выберите `ID` или `NAME` нужной группы, например `first-instance-group`.
1. Укажите нужные параметры виртуальной машины в YAML-файле (ключ `resources_spec`), по которому создавалась группа, например `template.yaml`. Если YAML-файл не сохранился, [получите информацию](get-info.md) о группе виртуальных машин и создайте новый. Подробнее читайте в разделе [[!TITLE]](create-fixed-group.md).
1. Обновите группу виртуальных машин в каталоге по умолчанию:

    ```
    $ [!KEYREF yc-compute-ig] update --name first-instance-group --file template.yaml
    ```

   [!KEYREF instance-groups-name] запустит операцию изменения группы виртуальных машин.

**[!TAB API]**

Изменить вычислительные ресурсы можно с помощью метода API [update](../../instance-groups/api-ref/InstanceGroup/update.md).

Список доступных групп запрашивайте методом [listInstances](../../instance-groups/api-ref/InstanceGroup/listInstances.md).

---

## Увеличить размер диска {#change-disk-size}

Чтобы увеличить размер диска группы виртуальных машин:

---

**[!TAB Консоль управления]**

1. Откройте страницу каталога в консоли управления.
1. Выберите сервис **[!KEYREF compute-full-name]**.
1. На странице **Виртуальные машины** перейдите на вкладку **Группы виртуальных машин**.
1. Нажмите на имя группы, которую желаете изменить.
1. Нажмите **Изменить** в правом верхнем углу страницы.
1. В блоке **Диски**, укажите нужный размер диска.
1. Нажмите **Сохранить**.

**[!TAB CLI]**

[!INCLUDE [cli-install.md](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue.md](../../_includes/default-catalogue.md)]

1. Посмотрите описание команды CLI для изменения группы:

   ```
   $ [!KEYREF yc-compute-ig] update --help
   ```

1. Получите список групп виртуальных машин в каталоге по умолчанию:

    [!INCLUDE [instance-group-list.md](../../_includes/instance-groups/instance-group-list.md)]

1. Выберите `ID` или `NAME` нужной группы, например `first-instance-group`.
1. Укажите нужный размер хранилища в YAML-файле (ключ `boot_disk_spec`), по которому создавалась группа, например `template.yaml`. Если YAML-файл не сохранился, [получите информацию](get-info.md) о группе виртуальных машин и создайте новый. Подробнее читайте в разделе [[!TITLE]](create-fixed-group.md).
1. Обновите группу виртуальных машин в каталоге по умолчанию:

    ```
    $ [!KEYREF yc-compute-ig] update --name first-instance-group --file template.yaml
    ```

   [!KEYREF instance-groups-name] запустит операцию изменения группы виртуальных машин.

**[!TAB API]**

Изменить размер диска можно с помощью метода API [update](../../instance-groups/api-ref/InstanceGroup/update.md).

Список доступных групп запрашивайте методом [listInstances](../../instance-groups/api-ref/InstanceGroup/listInstances.md).

---

