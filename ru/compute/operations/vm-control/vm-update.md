# Изменить виртуальную машину

После создания виртуальной машины вы можете изменить ее имя, описание, метки, платформу или метаданные.

Как изменить конфигурацию виртуальной машины читайте в разделе [[!TITLE]](vm-update-resources.md).

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Посмотрите описание команды CLI для обновления параметров виртуальных машин:

    ```
    $ yc compute instance update --help
    ```

1. Получите список виртуальных машин в каталоге по умолчанию:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Выберите `ID` или `NAME` нужной машины, например `first-instance`.
1. Измените параметры виртуальной машины, например, переименуйте машину:

    ```
    $ yc compute instance update first-instance \
        --new-name windows-vm
    ```

**[!TAB API]**

Чтобы изменить виртуальную машину, воспользуйтесь методом [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/).

---

## Примеры

### Просмотреть список изменяемых параметров {#get-list}

Чтобы просмотреть список изменяемых параметров, выполните команду:

---

**[!TAB CLI]**

```
$ yc compute instance update --help
```
---

### Изменить имя и описание {#change-name}

Чтобы изменить имя и описание виртуальной машины, выполните следующие шаги:

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Получите список виртуальных машин в каталоге по умолчанию:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Выберите `ID` или `NAME` нужной машины, например `first-instance`.
1. Измените имя и описание виртуальной машины:

    ```
    $ yc compute instance update first-instance \
        --new-name first-vm \
        --description "changed description vm via CLI"
    ```

---

### Изменить метаданные {#change-metadata}

Метаданные на базе разных операционных систем могут отличаться. При изменении имеющийся набор метаданных полностью перезаписывается набором, переданным в команде.

Чтобы изменить метаданные виртуальной машины, выполните следующие шаги:

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Получите список виртуальных машин в каталоге по умолчанию:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Выберите `ID` или `NAME` нужной машины, например `first-instance`.
1. Получите информацию о виртуальной машине вместе с метаданными. Все пользовательские метаданные определены в ключе `user-data`.

    ```
    $ yc compute instance get --full first-instance
    ```

1. Измените метаданные виртуальной машины. Изменить метаданные можно с помощью флагов:

    - `--metadata` — для изменения значения из одной строки;
    - `--metadata-from-file` — для изменения значения из нескольких строк.

    Пример изменения пароля администратора на виртуальной машине, на базе операционной системы Windows.

    ```
    $ yc compute instance update first-instance \
        --metadata user-data="#ps1\nnet user Administrator <пароль>"
    ```

    Имеющийся набор метаданных будет полностью перезаписан.

    [!INCLUDE [metadata-from-file](../../_includes_service/metadata-from-file.md)]

---

### Изменить SSH ключ {#change-ssh-key}

Чтобы изменить или добавить SSH ключ, выполните следующие шаги:

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Получите список виртуальных машин в каталоге по умолчанию:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Выберите `ID` или `NAME` нужной машины, например `first-instance`.
1. Получите информацию о виртуальной машине вместе с метаданными. Все пользовательские метаданные определены в ключе `user-data`.

    ```
    $ yc compute instance get --full first-instance
    ```

    Пример ответа:

    ```
    ...
    #cloud-config
    users:
    - name: demo
        groups: sudo
        shell: /bin/bash
        sudo: ['ALL=(ALL) NOPASSWD:ALL']
        ssh-authorized-keys:
            - ssh-rsa AAAAB3Nza......OjbSMRX user@example.com
    ...
    ```

1. Создайте текстовый файл с произвольным именем, например `metadata.txt`.
1. Скопируйте в созданный файл полученные данные, добавив новый SSH ключ.

    Пример:

    ```
    #cloud-config
    users:
    - name: demo
        groups: sudo
        shell: /bin/bash
        sudo: ['ALL=(ALL) NOPASSWD:ALL']
        ssh-authorized-keys:
            - ssh-rsa AAAAB3Nza......OjbSMRX user@example.com
            - ssh-rsa AAAAB3Nza......Pu00jRN user@example.com
    ```

1. Измените метаданные виртуальной машины:

    ```
    $ yc compute instance update first-instance \
        --metadata-from-file user-data=metadata.txt
    ```

    Имеющийся набор метаданных будет полностью перезаписан.

---
