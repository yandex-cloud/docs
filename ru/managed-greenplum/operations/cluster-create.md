# Создание кластера

Кластер {{ mgp-name }} состоит из хостов-мастеров, которые принимают запросы от клиента, и хостов-сегментов, которые обеспечивают обработку и хранение данных.

Подробнее см. в разделе [{#T}](../concepts/index.md).

## Как создать кластер {{ mgp-name }} {#create-cluster}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер баз данных.
    1. Выберите сервис **{{ mgp-name }}**.
    1. Нажмите кнопку **Создать кластер**.
    1. Введите имя кластера. Оно должно быть уникальным в рамках каталога.
    1. (опционально) Введите описание кластера.
    1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
        * `PRODUCTION` — для стабильных версий ваших приложений.
        * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mgp-full-name }}. В Prestable-окружении раньше появляются новые функциональные возможности, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
    1. Выберите версию {{ GP }}.

    {% if product == "yandex-cloud" and audience != "internal" %}

    1. (опционально) Выберите группы [выделенных хостов](../../compute/concepts/dedicated-host.md), на которых будет размещен кластер.
       
        {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

    {% endif %}

    1. В блоке **Сетевые настройки**:
        * Выберите облачную сеть для размещения кластера.
        * В параметре **Группы безопасности** укажите [группу безопасности](../operations/connect.md#configuring-security-groups), которая содержит правила, разрешающие любой исходящий и входящий трафик по любому протоколу с любых IP-адресов.

            {% note alert %}

            Для корректной работы кластера {{ mgp-name }} необходимо, чтобы хотя бы в одной из его групп безопасности были правила, разрешающие любой входящий и исходящий трафик с любых IP-адресов.

            {% endnote %}

        * Выберите зону доступности и подсеть для размещения кластера. Чтобы создать новую подсеть, нажмите кнопку **Создать новую** рядом с нужной зоной доступности.
        * Выберите опцию **Публичный доступ**, чтобы подключаться к кластеру из интернета.
  
    1. Укажите настройки пользователя-администратора. Это специальный пользователь, который необходим для управления кластером и не может быть удален. Подробнее в разделе [{#T}](../concepts/cluster-users.md).

        * **Имя пользователя** — может содержать латинские буквы, цифры, дефис и нижнее подчеркивание, но не может начинаться с дефиса. Длина от 1 до 32 символов.

            {% note info %}

            Имена `admin`, `gpadmin`, `mdb_admin`, `mdb_replication`, `monitor`, `none`, `postgres`, `public`, `repl` зарезервированы для собственных нужд {{ mgp-name }}. Создавать пользователей с этими именами нельзя.

            {% endnote %}

        * **Пароль** — длина от 8 до 128 символов.

    1. При необходимости задайте дополнительные настройки кластера:

        * {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}
        * **Окно обслуживания** — настройки времени [технического обслуживания](../concepts/maintenance.md):

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

        * {% include [Datalens access](../../_includes/mdb/console/datalens-access.md) %}
        * {% include [DataTransfer access](../../_includes/mdb/console/datatransfer-access.md) %}
        * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

            {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. При необходимости задайте [настройки СУБД уровня кластера](../concepts/settings-list.md#dbms-cluster-settings).

    1. Укажите параметры хостов-мастеров на вкладке **Master**. Рекомендуемую конфигурацию см. в разделе [Расчет конфигурации кластера](calculate-specs.md#master).

        * Класс хоста — определяет технические характеристики виртуальных машин, на которых будут развернуты хосты-мастеры кластера.
        * В блоке **Хранилище**:
          * Выберите [тип хранилища](../concepts/storage.md).

            {% if audience != "internal" %}
            {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}
            {% endif %}

    1. Укажите параметры хостов-сегментов на вкладке **Segment**. Рекомендуемую конфигурацию см. в разделе [Расчет конфигурации кластера](calculate-specs.md#segment).

        * Количество хостов-сегментов.
        * Количество сегментов на хост. Максимальное значение этого параметра зависит от класса хостов.
        * Класс хоста — определяет технические характеристики виртуальных машин, на которых будут развернуты хосты-сегменты кластера.
        * В блоке **Хранилище**:
           * Выберите [тип хранилища](../concepts/storage.md).

             {% if audience != "internal" %}
             {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}
             {% endif %}

    1. Нажмите кнопку **Создать**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать кластер:

    {% if audience != "internal" %}

    1. Проверьте, есть ли в каталоге подсети для хостов кластера:

        ```bash
        yc vpc subnet list
        ```

        Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.

    {% endif %}

    1. Посмотрите описание команды CLI для создания кластера:

        ```bash
        {{ yc-mdb-gp }} cluster create --help
        ```

    1. Укажите параметры кластера в команде создания (в примере приведены не все доступные параметры):

        {% if audience != "internal" %}

        ```bash
        {{ yc-mdb-gp }} cluster create <имя кластера> \
           --greenplum-version=<версия {{ GP }}: {{ versions.cli.str }}> \
           --environment=<окружение: PRESTABLE или PRODUCTION> \
           --network-name=<имя сети> \
           --user-name=<имя пользователя> \
           --user-password=<пароль пользователя> \
           --master-config resource-id=<класс хоста>,`
                          `disk-size=<объем хранилища, ГБ>,`
                          `disk-type=<тип хранилища> \
           --segment-config resource-id=<класс хоста>,`
                          `disk-size=<объем хранилища, ГБ>,`
                          `disk-type=<тип хранилища> \
           --zone-id=<зона доступности> \
           --subnet-id=<идентификатор подсети> \
           --assign-public-ip=<доступ к хостам через публичный IP-адрес: true или false> \
           --security-group-ids=<список идентификаторов групп безопасности> \
           --deletion-protection=<защита от удаления кластера: true или false>
        ```

        {% note info %}

        Имя кластера должно быть уникальным в каталоге. Оно может содержать латинские буквы, цифры, дефис и нижнее подчеркивание. Максимальная длина имени 63 символа.

        {% endnote %}

        Где:

        * `--greenplum-version` — версия {{ GP }}.
        * `--environment` — окружение:
            * `PRODUCTION` — для стабильных версий ваших приложений.
            * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ GP }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
        * `--network-name` — [имя сети](../../vpc/concepts/network.md#network).
        * `--user-name` — имя пользователя. Может содержать латинские буквы, цифры, дефис и нижнее подчеркивание, но должно начинаться с буквы, цифры или нижнего подчеркивания. Длина от 1 до 32 символов.
        * `--user-password` — пароль. Длина от 8 до 128 символов.
        * `--master-config` и `--segment-config` — конфигурация хостов-мастеров и хостов-сегментов:
            * `resource-id` — [класс хоста](../concepts/instance-types.md#available-flavors).
            * `disk-size` — объем хранилища в гигабайтах.
            * `disk-type` — [тип хранилища](../concepts/storage.md):
                * `network-hdd`;
                * `network-ssd`;
                * `local-ssd`;
                * `network-ssd-nonreplicated`.
        * `--zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `--subnet-id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.
        * `--assign-public-ip` — флаг, который указывается, если хостам требуется [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).
        * `--security-group-ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).
        * `--deletion-protection` — защита от удаления кластера.

        {% else %}

        ```bash
        {{ yc-mdb-gp }} cluster create <имя кластера> \
           --greenplum-version=<версия {{ GP }}: {{ versions.cli.str }}> \
           --environment=<окружение: PRESTABLE или PRODUCTION> \
           --network-name=<имя сети> \
           --user-name=<имя пользователя> \
           --user-password=<пароль пользователя> \
           --master-config resource-id=<класс хоста>,`
                          `disk-size=<объем хранилища, ГБ>,`
                          `disk-type=<тип хранилища> \
           --segment-config resource-id=<класс хоста>,`
                          `disk-size=<объем хранилища, ГБ>,`
                          `disk-type=<тип хранилища> \
           --zone-id=<зона доступности> \
           --security-group-ids=<список идентификаторов групп безопасности> \
           --deletion-protection=<защита от удаления кластера: true или false>
        ```

        {% note info %}

        Имя базы должно быть уникальным в каталоге. Оно может содержать латинские буквы, цифры, дефис и нижнее подчеркивание. Максимальная длина имени 63 символа.

        {% endnote %}

        Где:

        * `--greenplum-version` — версия {{ GP }}.
        * `--environment` — окружение:
            * `PRODUCTION` — для стабильных версий ваших приложений.
            * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ GP }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
        * `--network-name` — имя сети.
        * `--user-name` — имя пользователя. Может содержать латинские буквы, цифры, дефис и нижнее подчеркивание, но должно начинаться с буквы, цифры или нижнего подчеркивания. Длина от 1 до 32 символов.
        * `--user-password` — пароль. Длина от 8 до 128 символов.
        * `--master-config` и `--segment-config` — конфигурация хостов-мастеров и хостов-сегментов:
            * `resource-id` — [класс хоста](../concepts/instance-types.md#available-flavors).
            * `disk-size` — объем хранилища в гигабайтах.
            * `disk-type` — [тип хранилища](../concepts/storage.md):
                * `local-ssd`;
                * `local-hdd`.
        * `--zone-id` — зона доступности.
        * `--security-group-ids` — список идентификаторов групп безопасности.
        * `--deletion-protection` — защита от удаления кластера.

        {% endif %}

            {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Чтобы задать время начала резервного копирования, передайте нужное значение в формате `HH:MM:SS` в параметре `--backup-window-start`:

        ```bash
        {{ yc-mdb-gp }} cluster create <имя кластера> \
           ...
           --backup-window-start=<время начала резервного копирования>
        ```

    {% if product == "yandex-cloud" and audience != "internal" %}

    1. Чтобы создать кластер, размещенный на группах [выделенных хостов](../../compute/concepts/dedicated-host.md), укажите через запятую их идентификаторы в параметре `--host-group-ids`:

        ```bash
        {{ yc-mdb-gp }} cluster create <имя кластера> \
           ...
           --host-group-ids=<идентификаторы групп выделенных хостов>
        ```

        {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

    {% endif %}

    1. Чтобы настроить время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), передайте нужное значение в параметре `--maintenance-window` при создании кластера:

        ```bash
        {{ yc-mdb-gp }} cluster create <имя кластера> \
           ...
           --maintenance-window type=<тип технического обслуживания: anytime или weekly>,`
                               `day=<день недели для типа weekly>,`
                               `hour=<час дня для типа weekly>
        ```

        Где:

        * `type` — тип технического обслуживания:
            * `anytime` — в любое время.
            * `weekly` — по расписанию.
        * `day` — день недели для типа `weekly` в формате `DDD`. Например, `MON`.
        * `hour` — час дня по UTC для типа `weekly` в формате `HH`. Например, `21`.

    1. Чтобы разрешить доступ из других сервисов, передайте значение `true` в их параметрах при создании кластера:

        ```bash
        {{ yc-mdb-gp }} cluster create <имя кластера> \
           ...
           --datalens-access=<доступ из DataLens: true или false> \
           --websql-access=<доступ из консоли управления: true или false>
        ```

- API

    Воспользуйтесь методом API [create](../api-ref/Cluster/create.md) и передайте в запросе:

    * Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
    * Имя кластера в параметре `name`.
    * Окружение кластера в параметре `environment`.
    * Версию {{ GP }} в параметре `config.version`.
    * Имя пользователя в параметре `userName`.
    * Пароль пользователя в параметре `userPassword`.
    * Идентификатор сети в параметре `networkId`.
    * Идентификаторы [групп безопасности](../concepts/network.md#security-groups) в параметре `securityGroupIds`.
    * Конфигурацию хостов-мастеров в параметре `masterConfig`.
    * Конфигурацию хостов-сегментов в параметре `segmentConfig`.

    При необходимости передайте дополнительные настройки кластера:

    * Настройки публичного доступа в параметре `assignPublicIp`.
    * Настройки окна резервного копирования в параметре `config.backupWindowStart`.
    * Настройки доступа из [{{ datalens-full-name }}](../../datalens/concepts/index.md) в параметре `config.access.dataLens`.
    * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.
    * [Настройки СУБД](../concepts/settings-list.md#dbms-cluster-settings) в параметре `configSpec.greenplumConfig_<версия>`.
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

{% endlist %}

## Примеры {#examples}

### Создание кластера {#create-example}

{% list tabs %}

- CLI

    Создайте кластер {{ mgp-name }} с тестовыми характеристиками:

    {% if audience != "internal" %}

    * С именем `gp-cluster`.
    * Версии `{{ versions.cli.latest }}`.
    * В окружении `PRODUCTION`.
    * В сети `default`.
    * С пользователем `user1`.
    * С паролем `user1user1`.
    * С хостами-мастерами и хостами-сегментами:

        * Класса `s2.medium`.
        * С хранилищем на локальных SSD-дисках (`local-ssd`) объемом 100 ГБ.

    * В зоне доступности `{{ region-id }}-a`, в подсети `{{ subnet-id }}`.
    * С публичным доступом к хостам.
    * В группе безопасности `{{ security-group }}`.
    * С защитой от случайного удаления кластера.

    {% else %}

    * С именем `gp-cluster`.
    * Версии `{{ versions.cli.latest }}`.
    * В окружении `PRODUCTION`.
    * В сети `default`.
    * С пользователем `user1`.
    * С паролем `user1user1`.
    * С хостами-мастерами и хостами-сегментами:

        * Класса `s2.medium`.
        * С хранилищем на локальных SSD-дисках (`local-ssd`) объемом 100 ГБ.

    * В зоне доступности `{{ zone-id }}`.
    * С публичным доступом к хостам.
    * В группе безопасности `{{ security-group }}`.
    * С защитой от случайного удаления кластера.

    {% endif %}

    Выполните следующую команду:

    {% if audience != "internal" %}

    ```bash
    {{ yc-mdb-gp }} cluster create \
       --name=gp-cluster \
       --sqlserver-version={{ versions.cli.latest }} \
       --environment=PRODUCTION \
       --network-name=default \
       --user-name=user1 \
       --user-password=user1user1 \
       --master-config resource-id=s2.medium,`
                      `disk-size=100,`
                      `disk-type=local-ssd \
       --segment-config resource-id=s2.medium,`
                       `disk-size=100,`
                       `disk-type=local-ssd \
       --zone-id={{ region-id }}-a \
       --subnet-id={{ subnet-id }} \
       --assign-public-ip=true \
       --security-group-ids={{ security-group }} \
       --deletion-protection=true
    ```

    {% else %}

    ```bash
    {{ yc-mdb-gp }} cluster create \
       --name=gp-cluster \
       --sqlserver-version={{ versions.cli.latest }} \
       --environment=PRODUCTION \
       --network-name=default \
       --user-name=user1 \
       --user-password=user1user1 \
       --master-config resource-id=s2.medium,`
                      `disk-size=100,`
                      `disk-type=local-ssd \
       --segment-config resource-id=s2.medium,`
                       `disk-size=100,`
                       `disk-type=local-ssd \
       --zone-id={{ zone-id }} \
       --assign-public-ip=true \
       --security-group-ids={{ security-group }} \
       --deletion-protection=true
    ```

    {% endif %}

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
