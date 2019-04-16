# Изменить виртуальную машину

После создания виртуальной машины вы можете изменить ее имя, описание, метки, платформу или метаданные.

Как изменить конфигурацию виртуальной машины читайте в разделе [[!TITLE]](vm-update-resources.md).

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

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

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

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

    > [!NOTE]
    >
    > При изменении имени виртуальной машины, имя хоста и, соответственно, FQDN не изменяются. Подробнее про генерацию имени FQDN читайте в разделе [[!TITLE]](../../concepts/network.md#hostname).

---

### Изменить метаданные {#change-metadata}

Метаданные на базе разных операционных систем могут отличаться. При изменении имеющийся набор метаданных полностью перезаписывается набором, переданным в команде.

Чтобы изменить метаданные виртуальной машины, выполните следующие шаги:

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

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

    Пример изменения пароля администратора на виртуальной машине, на базе ОС Windows:

    1. Создайте YAML-файл (например, `metadata.yaml`) и укажите следующие данные:

        ```yaml
        #ps1
        net user administrator "<пароль>"
        ```

    1. Выполните команду:

        ```
        $ yc compute instance update first-instance \
            --metadata-from-file user-data=metadata.yaml
        ```

        Имеющийся набор метаданных будет полностью перезаписан.

---

### Изменить SSH-ключ {#change-ssh-key}

Чтобы изменить или добавить SSH-ключ, выполните следующие шаги:

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Получите список виртуальных машин в каталоге по умолчанию:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Выберите `ID` или `NAME` нужной машины, например `first-instance`.
1. Получите информацию о виртуальной машине вместе с метаданными.

    ```bash
    $ yc compute instance get --full first-instance
    ```

    Пример ответа:

    ```
    ...
    ec2-user-data: |+
        #cloud-config
        ssh_pwauth: no
        users:
        - name: yc-user
            sudo: ALL=(ALL) NOPASSWD:ALL
            shell: /bin/bash
            ssh_authorized_keys:
            - [EXISTING_KEY_VALUE_1]

    ssh-keys: |
        [KEY_1]:[EXISTING_KEY_VALUE_1]
    ...
    ```

    Где:

    - [KEY_1] — имя открытого SSH-ключа.
    - [EXISTING_KEY_VALUE_1] — значение открытого SSH-ключа, которое нужно изменить.

1. Создайте на вашем компьютере текстовый файл с произвольным именем, например, `sshkeys.txt`.
1. Добавьте в созданный файл ключи, которые вы хотите сохранить на виртуальной машине.

    Пример:

    ```txt
    [KEY_1]:[EXISTING_KEY_VALUE_2]
    [KEY_2]:[NEW_KEY_VALUE]
    ```

    Где:

    - [KEY_1], [KEY_2] — имена SSH-ключей.
    - [EXISTING_KEY_VALUE_2] — значение открытого SSH-ключа, которое нужно сохранить.
    - [NEW_KEY_VALUE] — значение открытого SSH-ключа, которое нужно добавить.

1. Измените метаданные виртуальной машины:

    ```bash
    $ yc compute instance add-metadata \
        --name first-instance \
        --metadata-from-file ssh-keys=sshkeys.txt
    ```

    Готово. SSH-ключи успешно сохранены. Проверьте подключение по SSH.

---
