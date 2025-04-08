# Монтирование бакетов {{ objstorage-full-name }} к файловой системе хостов {{ dataproc-full-name }}


В сервисе {{ dataproc-full-name }} вы можете использовать для настройки хостов [скрипты инициализации](../../data-proc/concepts/init-action.md) (initialization actions).

С их помощью можно автоматизировать установку и настройку программы [GeeseFS](../../storage/tools/geesefs.md), позволяющей хостам кластера {{ dataproc-full-name }} монтировать бакеты {{ objstorage-full-name }} через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)).

Чтобы настроить GeeseFS:

1. [Подготовьте скрипт инициализации](#prepare-init-scripts).
1. [Создайте кластер, использующий скрипт инициализации](#create-cluster).
1. [Проверьте доступность бакета](#check-availability).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ dataproc-name }} (см. [тарифы {{ dataproc-name }}](../../data-proc/pricing.md)).
* Плата за NAT-шлюз (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Плата за бакет {{ objstorage-name }}: хранение данных и выполнение операций с ними (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).
* Плата за публичные IP-адреса для хостов кластера (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролями `dataproc.agent` и `dataproc.provisioner`.

  1. [Создайте бакет](../../storage/operations/buckets/create.md) {{ objstorage-name }}.

  1. Предоставьте сервисному аккаунту доступ на чтение из бакета. Для этого воспользуйтесь одним из способов:

      * [Настройте ACL бакета](../../storage/operations/buckets/edit-acl.md) и выдайте сервисному аккаунту разрешение `READ`.

          Сервисный аккаунт получит доступ на чтение только к указанному бакету.

      * [Назначьте сервисному аккаунту роль](../../iam/operations/sa/assign-role-for-sa.md) `storage.viewer`.

          Сервисный аккаунт получит доступ на чтение ко всем бакетам в каталоге.

  1. Создайте [NAT-шлюз](../../vpc/operations/create-nat-gateway) для подсети, в которой будет создан кластер {{ dataproc-name }}.

- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

  1. Скачайте в ту же рабочую директорию файл конфигурации [data-processing-init-actions-geesefs.tf](https://github.com/yandex-cloud-examples/yc-data-processing-init-actions/blob/main/data-processing-init-actions-geesefs.tf).

      В этом файле описаны:

      * [сеть](../../vpc/concepts/network.md#network);
      * [подсеть](../../vpc/concepts/network.md#subnet);
      * [таблица маршрутизации](../../vpc/concepts/routing.md#rt-vpc);
      * [NAT-шлюз](../../vpc/concepts/gateways.md);
      * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру {{ dataproc-name }};
      * [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с ролями, которые требуются для работы с бакетом {{ objstorage-name }} и кластером {{ dataproc-name }};
      * [статический ключ](../../iam/concepts/authorization/access-key.md) сервисного аккаунта для управления бакетом {{ objstorage-name }};
      * [бакет {{ objstorage-name }}](../../storage/concepts/bucket.md);
      * [кластер {{ dataproc-name }}](../../data-proc/concepts/index.md).

  1. Укажите в файле `data-processing-init-actions-geesefs.tf` значения параметров:

      * `dp_network_name` — имя сети для кластера {{ dataproc-name }};
      * `dp_subnet_name` — имя подсети для кластера {{ dataproc-name }};
      * `dp_sg_name` — имя группы безопасности для кластера {{ dataproc-name }};
      * `dp_sa_folder_id` — идентификатор каталога, в котором будет создана инфраструктура и кластер {{ dataproc-name }};
      * `dp_sa_name` — имя сервисного аккаунта для кластера {{ dataproc-name }} и бакета {{ objstorage-name }};
      * `dp_bucket_name` — имя бакета {{ objstorage-name }};
      * `dataproc_name` — имя кластера {{ dataproc-name }};
      * `ssh-path` — путь к файлу публичного SSH-ключа для кластера {{ dataproc-name }}.

  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Создайте необходимую инфраструктуру:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте скрипт инициализации {#prepare-init-scripts}

1. Создайте файл скрипта инициализации `geesefs_mount.sh`, принимающий два позиционных аргумента — имя бакета {{ objstorage-name }} и директорию в файловой системе хоста, куда он должен быть смонтирован.

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

1. [Загрузите](../../storage/operations/objects/upload.md) файл `geesefs_mount.sh` в созданный ранее бакет {{ objstorage-name }}.

## Создайте кластер, использующий скрипт инициализации {#create-cluster}

{% list tabs group=instructions %}

- Вручную {#manual}

  [Создайте кластер {{ dataproc-name }}](../../data-proc/operations/cluster-create.md) со следующими параметрами:

  * В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите версию `2.0`.
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

- {{ TF }} {#tf}

  1. В файле `data-processing-init-actions-geesefs.tf` укажите значение переменной `create_cluster` = `1`.

  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Создайте необходимую инфраструктуру:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Проверьте доступность бакета {#check-availability}

1. После того, как кластер перейдет в статус **Alive**, [подключитесь](../../data-proc/operations/connect.md#data-proc-ssh) по [SSH](../../glossary/ssh-keygen.md) от имени пользователя `ubuntu` к любому из его хостов.

1. Чтобы убедиться в успешном монтировании бакета, выполните команду:

    ```bash
    ls /mnt/test
    ```

    В результате будет выведен список объектов, хранящихся в корневом каталоге бакета. В данном случае — имя файла `geesefs_mount.sh`.

## Удалите созданные ресурсы {#clear-out}

{% note tip %}

Перед удалением инфраструктуры удалите вручную все объекты из бакета.

{% endnote %}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Удалите кластер {{ dataproc-name }}](../../data-proc/operations/cluster-delete.md).
  1. Если для доступа к хостам кластера использовались статические публичные IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).
  1. [Удалите бакет](../../storage/operations/buckets/delete.md) {{ objstorage-name }}.
  1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

  1. В терминале перейдите в рабочую директорию с конфигурационным файлом `data-processing-init-actions-geesefs.tf`.
  1. Удалите ресурсы с помощью команды:

      ```bash
      terraform destroy
      ```

  1. Введите слово `yes` и нажмите **Enter**.

      Все ресурсы, которые были описаны в конфигурационном файле `data-processing-init-actions-geesefs.tf`, будут удалены.

{% endlist %}
