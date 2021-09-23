# Резервное копирование кластера {{ k8s }} в {{ objstorage-full-name }}

Данные в кластерах {{ managed-k8s-name }} надежно хранятся и реплицируются в инфраструктуре {{ yandex-cloud }}. Однако в любой момент вы можете сделать резервные копии данных из групп узлов кластеров {{ k8s }} и хранить их в [{{ objstorage-name }}](../../storage/) или другом хранилище.

Вы можете делать резервные копии:
* данных из групп узлов кластера {{ k8s }} с помощью инструмента [Velero](https://velero.io/);
* постоянных [томов](../concepts/volume.md) (Persistent Volumes) с помощью программы [restic](https://restic.net/). Более подробная информация о настройке программы restic описана в [документации Velero](https://velero.io/docs/v1.5/restic/#backup).

  Программа restic копирует данные с Persistent Volumes в виде файлов, поэтому мы рекомендуем выполнять резервное копирование БД средствами самого приложения. Например, для СУБД {{ CH }} использовать утилиту clickhouse-backup, для СУБД {{ MY }} — утилиту MySQLdump, для {{ PG }} — pg_dump.

## Требования {#requirements}

У группы узлов кластера {{ k8s }} должен быть [доступ в интернет](../concepts/index.md#kubernetes-cluster). Предоставить доступ в интернет можно только на этапе [создания группы узлов](../operations/node-group/node-group-create.md).

Кроме того, для доступа узлов в интернет требуется [настройка групп безопасности](../operations/security-groups.md#rules-internal).

## Резервное копирование {#backup}

Чтобы выполнить резервное копирование данных группы узлов:

1. Выберите [последнюю версию программы Velero](https://github.com/vmware-tanzu/velero/releases) для своей платформы.

1. Скачайте Velero, распакуйте архив и установите программу. Подробнее об установке программы читайте в [документации Velero](https://velero.io/docs/v1.5/basic-install/#install-the-cli).

1. Посмотрите описание любой команды Velero с помощью флага `--help`. Например:

   {% list tabs %}

   - CLI

     ```bash
     velero --help
     ```

   {% endlist %}

1. Создайте в {{ objstorage-name }} [бакет](../../storage/concepts/bucket.md), в котором будет храниться резервная копия данных:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
     1. Выберите сервис **{{ objstorage-name }}**.
     1. Нажмите кнопку **Создать бакет**.
     1. На странице **Новый бакет**:
        1. Введите **Имя** бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).

           Например, `velero-backup`.
        1. При необходимости ограничьте **Максимальный размер** бакета.

           {% include [storage-no-max-limit](../../storage/_includes_service/storage-no-max-limit.md) %}

        1. Выберите тип [Доступа](../../storage/concepts/bucket.md#bucket-access).
        1. Выберите [Класс хранилища](../../storage/concepts/storage-class.md): **Стандартное**.
        1. Нажмите кнопку **Создать бакет** для завершения операции.

   {% endlist %}

1. Создайте сервисный аккаунт, которому будет назначен доступ к бакету:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
     1. Выберите вкладку **Сервисные аккаунты**.
     1. Нажмите кнопку **Создать сервисный аккаунт**.
     1. Введите **Имя** сервисного аккаунта. Например, `velero-sa`.

        {% include [name-format](../../_includes/name-format.md) %}

     1. Нажмите кнопку **Создать**.

   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Создайте сервисный аккаунт:

     ```bash
     yc iam service-account create --name velero-sa
     ```

     Где:
     * `name` — имя сервисного аккаунта.

     Результат выполнения команды:

     ```bash
     id: abcdo12h3j04odg56def
     folder_id: b1g23ga45ghf0cljderg
     created_at: "2020-10-19T12:59:56Z"
     name: velero-sa
     ```

   {% endlist %}

1. Создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для сервисного аккаунта `velero-sa`:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервисный аккаунт `velero-sa`.
     1. Выберите вкладку **Сервисные аккаунты**.
     1. Выберите сервисный аккаунт `velero-sa` и нажмите на строку с его именем.
     1. На странице **Обзор** нажмите кнопку **Создать новый ключ** на верхней панели.
     1. Выберите пункт **Создать статический ключ доступа**.
     1. В открывшемся окне **Новый ключ** нажмите кнопку **Создать**.
     1. Сохраните идентификатор и секретный ключ.

        {% note alert %}

        После закрытия диалога значение секретного ключа будет недоступно.

        {% endnote %}

   - CLI

     1. Создайте статический ключ доступа для сервисного аккаунта:

        ```bash
        yc iam access-key create --service-account-name velero-sa
        ```

        Где:
        * `service-account-name` — имя сервисного аккаунта.

        Результат выполнения команды:

        ```bash
        access_key:
          id: abcdo12h3j04odg56def
          service_account_id: ajego12h3j03slk16upe
          created_at: "2020-10-19T13:22:29Z"
          key_id: y1qiM23o-Y3WeoP5oSdc
        secret: MLSeE12TYJZpjFkfgMeKJ3e7PR7z6dk3UyEeC7PJ
        ```

     1. Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.

   {% endlist %}

1. Создайте файл со статическим ключом доступа.

   Например, вы можете создать файл с именем `credentials` и сохранить его в домашней директории.

   Чтобы созданные статические ключи доступа были совместимы с AWS API, содержимое файла должно выглядеть следующим образом:

   ```
   [default]
   aws_access_key_id=y1qiM23o-Y3WeoP5oSdc
   aws_secret_access_key=MLSeE12TYJZpjFkfgMeKJ3e7PR7z6dk3UyEeC7PJ
   ```

1. Выдайте сервисному аккаунту `velero-sa` доступ к бакету `velero-backup`. {{ objstorage-name }} поддерживает управление доступом с помощью [ACL](../../storage/concepts/acl.md).

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан бакет `velero-backup`.
     1. Выберите сервис **{{ objstorage-name }}**.
     1. Чтобы отредактировать ACL, нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) справа от имени бакета и выберите **ACL бакета**.
      1. В появившемся окне **Редактирование ACL**:
         1. Выберите пользователя `velero-sa`.
         1. Выдайте ему разрешения **READ + WRITE**.
      1. Нажмите кнопку **Добавить**.
      1. Нажмите кнопку **Сохранить**.

   {% endlist %}

1. Установите программу Velero в кластер {{ k8s }}, из которого необходимо сделать резервное копирование данных:

   {% list tabs %}

   - CLI

     ```bash
     velero install \
       --backup-location-config s3Url=https://storage.yandexcloud.net,region=ru-central1 \
       --bucket velero-backup \
       --plugins velero/velero-plugin-for-aws:v1.0.0 \
       --provider aws \
       --secret-file ./credentials \
       --use-restic \
       --use-volume-snapshots false
     ```

     Где:
     * `backup-location-config` — конфигурация адреса хранилища резервных копий. URL-адрес хранилища {{ objstorage-name }} и [зоны доступности](../../overview/concepts/geo-scope.md).
     * `bucket` — имя бакета для хранения резервных копий.
     * `plugins` — образ плагина для совместимости с AWS API.
     * `provider` — имя провайдера объектного хранилища {{ objstorage-name }}.
     * `secret-file` — имя файла со статическим ключом доступа и путь до него.
     * `use-restic` — флаг для использования программы restic для резервного копирования Persistent Volumes.
     * `use-volume-snapshots` — флаг, необходимый, чтобы снимки хранилищ не создавались автоматически.

     Результат выполнения команды:

     ```bash
     CustomResourceDefinition/backups.velero.io: attempting to create resource
     CustomResourceDefinition/backups.velero.io: already exists, proceeding
     CustomResourceDefinition/backups.velero.io: created
     ...
     DaemonSet/restic: already exists, proceeding
     DaemonSet/restic: created
     Velero is installed! ⛵ Use 'kubectl logs deployment/velero -n velero' to view the status.
     ```

   {% endlist %}

1. Выполните резервное копирование данных с группы узлов кластера {{ k8s }}:

   {% list tabs %}

   - CLI

     ```bash
     velero backup create my-backup --default-volumes-to-restic
     ```

     Где:
     * `default-volumes-to-restic` — копирование Persistent Volumes из пространства имен `default` с помощью программы restic.

     Результат выполнения команды:

     ```bash
     Backup request "my-backup" submitted successfully.
     Run `velero backup describe my-backup` or `velero backup logs my-backup` for more details.
     ```

   {% endlist %}

1. Дождитесь завершения резервного копирования. В графе `STATUS` появится значение `Completed`.

   {% list tabs %}

   - CLI

     ```bash
     velero backup get
     ```

     Результат выполнения команды:

     ```bash
     NAME        STATUS      ERRORS   WARNINGS   CREATED                         EXPIRES   STORAGE LOCATION   SELECTOR
     my-backup   Completed   0        0          2020-10-19 17:13:25 +0300 MSK   29d       default            <none>
     ```

   {% endlist %}

## Восстановление данных их резервной копии {#restoring}

Чтобы восстановить данные группы узлов кластера {{ k8s }}:

1. Создайте кластер {{ k8s }}.

   {% cut "Как создать кластер {{ k8s }}" %}

   {% list tabs %}

   - Консоль управления

     {% include [create-cluster](../../_includes/managed-kubernetes/cluster-create.md) %}

   - CLI

     Выполните команду:

     ```
     yc managed-kubernetes cluster create \
       --name cluster-from-backup \
       --network-name network \
       --node-service-account-name docker \
       --service-account-name k8s \
       --zone ru-central1-a
     ```

     Где:
     * `name` — имя кластера {{ k8s }}.
     * `network-name` — имя сети.
     * `node-service-account-id` — уникальный идентификатор сервисного аккаунта для узлов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.
     * `service-account-id` — уникальный идентификатор сервисного аккаунта для ресурсов. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
     * `zone` — зона доступности.

     Результат выполнения команды:

     ```
     done (6m9s)
     id: catab1c2f0fmb3d0ef94
     folder_id: b1g23ga82bcv0cdeferg
     created_at: "2020-10-19T17:41:28Z"
     name: cluster-from-backup
     status: RUNNING
     health: HEALTHY
     network_id: enpabc1rfondide2fflu3
     master:
       zonal_master:
         zone_id: ru-central1-a
         internal_v4_address: 10.0.0.32
       version: "1.17"
       endpoints:
         internal_v4_endpoint: https://10.0.0.32
       master_auth:
         cluster_ca_certificate: |
           -----BEGIN CERTIFICATE-----
           MIIAbCCCAbCgAwIBAgIBADANBgkqhkiG1w0BAQsFADAVMRMwEQYDVQQDEwdefWJl
           ...
           pi0jAbcDCLzCkfFuNimHejsSvVFN1N2bYYBCBMkhaYDzV5Ypfy/De0fHJ9U=
           -----END CERTIFICATE-----
       version_info:
         current_version: "1.17"
       maintenance_policy:
         auto_upgrade: true
         maintenance_window:
           anytime: {}
     ip_allocation_policy:
       cluster_ipv4_cidr_block: 10.112.0.0/16
       node_ipv4_cidr_mask_size: "24
       service_ipv4_cidr_block: 10.96.0.0/16
     service_account_id: ajeabcfldeftb1238n99
     node_service_account_id: ajea1b023cmndeft7t7j
     release_channel: REGULAR
     ```

   - API

     Чтобы создать кластер {{ k8s }}, воспользуйтесь методом [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster).

   {% endlist %}

   {% endcut %}

1. Создайте группу узлов.

   При создании группы узлов укажите публичный IP-адрес, чтобы узлы имели доступ в интернет.

   {% cut "Как создать группу узлов" %}

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан кластер {{ k8s }}.
     1. В списке сервисов выберите **{{ managed-k8s-name }}**.
     1. Выберите кластер {{ k8s }}, для которого необходимо создать группу узлов.
     1. На странице кластера {{ k8s }} перейдите на вкладку **Группы узлов**.
     1. Нажмите кнопку **Создать группу узлов**.
     1. Введите имя и описание группы узлов.
     1. Укажите **Версию {{ k8s }}** для узлов.
     1. Укажите количество узлов в группе узлов.
     1. В блоке **Масштабирование**:
        * Выберите тип политики масштабирования.
        * Укажите количество узлов в группе узлов.
     1. В блоке **В процессе создания и обновления разрешено** укажите максимальное количество виртуальных машин, на которое можно превысить и уменьшить размер группы.
     1. В блоке **Вычислительные ресурсы**:
        * Выберите [платформу](../../compute/concepts/vm-platforms.md).
        * Укажите необходимое количество vCPU и [гарантированную долю vCPU](../../compute/concepts/performance-levels.md), а также объем RAM.
     1. В блоке **Хранилище**:
        * Укажите **Тип диска** узла:
          * **HDD** — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
          * **SSD** — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
        * Укажите размер диска узла.
     1. В блоке **Сетевые настройки**:
        * В поле **Публичный адрес** выберите способ назначения адреса:
          * **Автоматически** — чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}.
        * Укажите расположение узлов по зонам доступности и сетям.
     1. В блоке **Доступ** укажите данные для доступа на узел:
        * В поле **Логин** введите имя пользователя.
        * В поле **SSH-ключ** вставьте содержимое файла [публичного ключа](../../managed-kubernetes/operations/node-connect-ssh.md#creating-ssh-keys).
     1. В блоке **Настройки окна обновлений**:
        * В поле **Частота обновлений / Отключение** выберите окно для обновлений:
          * **Отключено** — отключение автоматических обновлений.
          * **В любое время** — обновления разрешены в любое время.
          * **Ежедневно** — обновления будут происходить во временной интервал, указанный в поле **Время (UTC) и продолжительность**.
          * **В выбранные дни** — обновления будут происходить во временной интервал, указанный в поле **Расписание по дням**.
     1. Нажмите кнопку **Создать группу узлов**.

   - CLI

     Выполните команду:

     ```
     yc managed-kubernetes node-group create \
       --cluster-name cluster-from-backup \
       --fixed-size 1 \
       --network-interface subnets=subnet,ipv4-address=nat
     ```

     Где:
     * `cluster-name` — имя кластера {{ k8s }}, в котором будет создана группа узлов.
     * `fixed-size` — количество узлов в группе.
     * `--network-interface` — настройки сети:

         {% include [network-interface](../../_includes/managed-kubernetes/cli-network-interface.md) %}

     Результат выполнения:

     ```
     done (2m31s)
     id: catabcio1iq2sdefial3
     cluster_id: catab1c2f0fmb3d0ef94
     created_at: "2020-10-19T17:43:54Z"
     status: RUNNING
     node_template:
       platform_id: standard-v2
       resources_spec:
         memory: "4294967296"
         cores: "2"
         core_fraction: "100"
       boot_disk_spec:
         disk_type_id: network-hdd
         disk_size: "103079215104"
       v4_address_spec:
         one_to_one_nat_spec:
           ip_version: IPV4
       scheduling_policy: {}
     scale_policy:
       fixed_scale:
         size: "1"
     allocation_policy:
       locations:
       - zone_id: ru-central1-a
         subnet_id: e1bm23abcs81edef6dqg
     deploy_policy:
       max_expansion: "3"
     instance_group_id: cl1ca2bch3lde1fi2tk7
     node_version: "1.17"
     version_info:
       current_version: "1.17"
     maintenance_policy:
       auto_upgrade: true
       auto_repair: true
       maintenance_window:
         anytime: {}
     ```

   - API

     Чтобы создать группу узлов, воспользуйтесь методом [create](../api-ref/NodeGroup/create.md) для ресурса [NodeGroup](../api-ref/NodeGroup).

   {% endlist %}

   {% endcut %}

1. Установите программу Velero в кластер {{ k8s }}, в котором необходимо восстановить данные:

   {% list tabs %}

   - CLI

     ```bash
     velero install \
       --backup-location-config s3Url=https://storage.yandexcloud.net,region=ru-central1 \
       --bucket velero-backup \
       --plugins velero/velero-plugin-for-aws:v1.0.0 \
       --provider aws \
       --secret-file ./credentials \
       --use-restic \
       --use-volume-snapshots false
     ```

     Где:
     * `backup-location-config` — конфигурация адреса хранилища резервных копий. URL-адрес хранилища {{ objstorage-name }} и все [зоны доступности](../../overview/concepts/geo-scope.md).
     * `bucket` — имя бакета для хранения резервных копий.
     * `plugins` — образ плагина для совместимости с AWS API.
     * `provider` — имя провайдера объектного хранилища {{ objstorage-name }}.
     * `secret-file` — имя файла со статическим ключом доступа и путь до него.
     * `use-restic` — использование программы restic для резервного копирования Persistent Volumes.
     * `use-volume-snapshots` — опция создания снимков хранилищ. Возможные значения: `false` — не создавать, `true` — создавать. Значение по умолчанию: `true`.

     Результат выполнения команды:

     ```bash
     CustomResourceDefinition/backups.velero.io: attempting to create resource
     CustomResourceDefinition/backups.velero.io: already exists, proceeding
     CustomResourceDefinition/backups.velero.io: created
     ...
     DaemonSet/restic: already exists, proceeding
     DaemonSet/restic: created
     Velero is installed! ⛵ Use 'kubectl logs deployment/velero -n velero' to view the status.
     ```

   {% endlist %}

1. Проверьте, что в созданном кластере {{ k8s }} отображается резервная копия данных:

   {% list tabs %}

   - CLI

     ```bash
     velero backup get
     ```

     Результат выполнения команды:

     ```bash
     NAME        STATUS      ERRORS   WARNINGS   CREATED                         EXPIRES   STORAGE LOCATION   SELECTOR
     my-backup   Completed   0        0          2020-10-19 17:13:25 +0300 MSK   29d       default            <none>
     ```

   {% endlist %}

1. Восстановите данные из резервной копии:

   {% list tabs %}

   - CLI

     ```bash
     velero restore create create --exclude-namespaces velero --from-backup my-backup
     ```

     Где:
     * `exclude-namespaces` — флаг, позволяющий не восстанавливать объекты из пространства имен `velero`.
     * `from-backup` — имя бакета, где хранится резервная копия.

     Результат выполнения команды:

     ```bash
     Restore request "create" submitted successfully.
     Run `velero restore describe create` or `velero restore logs create` for more details.
     ```

   {% endlist %}

1. Дождитесь завершения восстановления данных из резервной копии. В графе `STATUS` появится значение `Completed`.

   {% list tabs %}

   - CLI

     ```bash
     velero get restore
     ```

     Результат выполнения команды:

     ```bash
     NAME     BACKUP    STATUS      STARTED                         COMPLETED                       ERRORS   WARNINGS   CREATED                         SELECTOR
     create   my-backup   Completed   2020-10-20 14:04:55 +0300 MSK   2020-10-20 14:05:22 +0300 MSK   0        23         2020-10-20 14:04:55 +0300 MSK   <none>
     ```

   {% endlist %}