# Использование скриптов инициализации для настройки GeeseFS в {{ dataproc-name }}

В сервисе {{ dataproc-full-name }} вы можете использовать для настройки хостов {% if audience != "internal" %}[скрипты инициализации](../../data-proc/concepts/init-action.md){% else %}скрипты инициализации{% endif %} (initialization actions).

С их помощью можно автоматизировать установку и настройку программы [GeeseFS](../../storage/tools/geesefs.md), позволяющей хостам кластера {{ dataproc-full-name }} монтировать бакеты {{ objstorage-full-name }} через [FUSE]({% if lang == "ru" %}https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра){% else %}https://en.wikipedia.org/wiki/Filesystem_in_Userspace{% endif %}).

Чтобы настроить GeeseFS:

1. [Подготовьте скрипт инициализации](#prepare-init-scripts).
1. [Создайте кластер, использующий скрипт инициализации](#create-cluster).
1. [Проверьте доступность бакета](#check-availability).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. {% if audience != "internal" %}[Создайте сервисный аккаунт](../../iam/operations/sa/create.md){% else %}Создайте сервисный аккаунт{% endif %} с ролью `mdb.dataproc.agent`.

1. [Создайте бакет](../../storage/operations/buckets/create.md) {{ objstorage-full-name }}.

1. Предоставьте сервисному аккаунту доступ на чтение из бакета. Для этого воспользуйтесь одним из способов:

    * [Настройте ACL бакета](../../storage/operations/buckets/edit-acl.md) и выдайте сервисному аккаунту разрешение `READ`.

        Сервисный аккаунт получит доступ на чтение только к указанному бакету.

    * {% if audience != "internal" %}[Назначьте сервисному аккаунту роль](../../iam/operations/sa/assign-role-for-sa.md){% else %}Назначьте сервисному аккаунту роль{% endif %} `storage.viewer`.

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

{% if audience != "internal" %}[Создайте кластер {{ dataproc-name }}](../../data-proc/operations/cluster-create.md){% else %}Создайте кластер {{ dataproc-name }}{% endif %} со следующими параметрами:

* **Сервисный аккаунт** — выберите созданный ранее сервисный аккаунт.
* **Пользовательские скрипты** — добавьте скрипт со следующими настройками:

    * **URI** — укажите путь к файлу скрипта в бакете, например:

        ```http
        s3a://<имя бакета>/geesefs_mount.sh
        ```

    * **Аргументы** — укажите имя созданного ранее бакета и точку монтирования `/mnt/test`. Аргументы указываются на отдельных строках:

        ```text
        <имя бакета>
        /mnt/test
        ```

* **Имя бакета** — выберите созданный ранее бакет.

* **Подкластеры** — включите в настройках опцию **Публичный доступ**. Это позволит подключаться к хостам подкластеров без использования промежуточной виртуальной машины.

## Проверьте доступность бакета {#check-availability}

1. После того, как кластер перейдет в статус **Alive**, {% if audience != "internal" %}[подключитесь](../../data-proc/operations/connect.md#data-proc-ssh) по {% if lang == "ru" %}[SSH](../../glossary/ssh-keygen.md){% else %}SSH{% endif %}{% else %}подключитесь по SSH{% endif %} от имени пользователя `ubuntu` к любому из его хостов.

1. Чтобы убедиться в успешном монтировании бакета, выполните команду:

    ```bash
    ls /mnt/test/<имя бакета>
    ```

    Она вернет список объектов, хранящихся в корневом каталоге бакета. В данном случае — имя файла `geesefs_mount.sh`.

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:

1. {% if audience != "internal" %}[Удалите кластер {{ dataproc-name }}](../../data-proc/operations/cluster-delete.md){% else %}Удалите кластер {{ dataproc-name }}{% endif %}.
1. Если для доступа к хостам кластера использовались статические публичные IP-адреса, освободите и {% if audience != "internal" %}[удалите их](../../vpc/operations/address-delete.md){% else %}удалите их{% endif %}.
1. [Удалите бакет](../../storage/operations/buckets/delete.md) {{ objstorage-full-name }}.
