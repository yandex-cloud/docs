# Использование скриптов инициализации для настройки GeeseFS в {{ dataproc-name }}


В сервисе {{ dataproc-full-name }} вы можете использовать для настройки хостов [скрипты инициализации](../../data-proc/concepts/init-action.md) (initialization actions).

С их помощью можно автоматизировать установку и настройку программы [GeeseFS](../../storage/tools/geesefs.md), позволяющей хостам кластера {{ dataproc-full-name }} монтировать бакеты {{ objstorage-full-name }} через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)).

Чтобы настроить GeeseFS:

1. [Подготовьте скрипт инициализации](#prepare-init-scripts).
1. [Создайте кластер, использующий скрипт инициализации](#create-cluster).
1. [Проверьте доступность бакета](#check-availability).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `mdb.dataproc.agent`.

1. [Создайте бакет](../../storage/operations/buckets/create.md) {{ objstorage-full-name }}.

1. Предоставьте сервисному аккаунту доступ на чтение из бакета. Для этого воспользуйтесь одним из способов:

    * [Настройте ACL бакета](../../storage/operations/buckets/edit-acl.md) и выдайте сервисному аккаунту разрешение `READ`.

        Сервисный аккаунт получит доступ на чтение только к указанному бакету.

    * [Назначьте сервисному аккаунту роль](../../iam/operations/sa/assign-role-for-sa.md) `storage.viewer`.

        Сервисный аккаунт получит доступ на чтение ко всем бакетам в каталоге.

## Подготовьте скрипт инициализации {#prepare-init-scripts}

1. Создайте файл скрипта инициализации `geesefs_mount.sh`, принимающий два позиционных аргумента — имя бакета {{ objstorage-full-name }} и директорию в файловой системе хоста, куда он должен быть смонтирован.

    ```bash
    #!/bin/bash

    set -e

    BUCKET=$1
    MOUNT_POINT=$2

    # Загрузка GeeseFS
    wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-linux-amd64 -O /opt/geesefs
    chmod a+rwx /opt/geesefs
    mkdir -p "${MOUNT_POINT}"

    # Подготовка скрипта, выполняющегося при каждой загрузке
    BOOT_SCRIPT="/var/lib/cloud/scripts/per-boot/80-geesefs-mount.sh"
    echo "#!/bin/bash" >> ${BOOT_SCRIPT}
    echo "/opt/geesefs -o allow_other --iam ${BUCKET} ${MOUNT_POINT}" >> ${BOOT_SCRIPT}
    chmod 755 ${BOOT_SCRIPT}

    # Запуск скрипта
    ${BOOT_SCRIPT}
    ```

1. [Загрузите](../../storage/operations/objects/upload.md) файл `geesefs_mount.sh` в созданный ранее бакет {{ objstorage-full-name }}.

## Создайте кластер, использующий скрипт инициализации {#create-cluster}

[Создайте кластер {{ dataproc-name }}](../../data-proc/operations/cluster-create.md) со следующими параметрами:

* В поле **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** выберите сервисный аккаунт, [созданный ранее](#before-you-begin).
* В поле **{{ ui-key.yacloud.mdb.forms.config_field_initialization-action }}** нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_add-initialization-action }}** и задайте параметры скрипта:

    * В поле **{{ ui-key.yacloud.mdb.forms.field_initialization-action-uri }}** укажите путь к файлу скрипта в бакете, например:

        ```http
        s3a://<имя_бакета>/geesefs_mount.sh
        ```

    * В поле **{{ ui-key.yacloud.mdb.forms.field_initialization-action-args }}** укажите имя [созданного ранее](#before-you-begin) бакета и точку монтирования `/mnt/test`. Аргументы указываются на отдельных строках:

        ```text
        <имя_бакета>
        /mnt/test
        ```

* В поле **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}** выберите бакет, [созданный ранее](#before-you-begin).

* В меню **{{ ui-key.yacloud.mdb.forms.section_subclusters }}** включите в настройках опцию **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}**. Это позволит подключаться к хостам подкластеров без использования промежуточной виртуальной машины.

## Проверьте доступность бакета {#check-availability}

1. После того, как кластер перейдет в статус **Alive**, [подключитесь](../../data-proc/operations/connect.md#data-proc-ssh) по [SSH](../../glossary/ssh-keygen.md) от имени пользователя `ubuntu` к любому из его хостов.

1. Чтобы убедиться в успешном монтировании бакета, выполните команду:

    ```bash
    ls /mnt/test/<имя_бакета>
    ```

    В результате будет выведен список объектов, хранящихся в корневом каталоге бакета. В данном случае — имя файла `geesefs_mount.sh`.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

1. [Удалите кластер {{ dataproc-name }}](../../data-proc/operations/cluster-delete.md).
1. Если для доступа к хостам кластера использовались статические публичные IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).
1. [Удалите бакет](../../storage/operations/buckets/delete.md) {{ objstorage-full-name }}.
