# Изменение настроек кластера

После создания кластера вы можете:

* [{#T}](#change-name-and-description).

* [{#T}](#change-additional-settings).

* [{#T}](#increase-host-segment).

* [Настроить серверы {{ GP }} согласно документации {{ GP }}](#change-gp-settings).

## Изменить имя и описание кластера {#change-name-and-description}

{% list tabs %}

- Консоль управления

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
    1. Выберите кластер и нажмите кнопку **Редактировать** в верхней части страницы.
    1. В блоке **Базовые параметры** задайте новые имя и описание кластера.
    1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить имя и описание кластера {{ GP }}:

  1. Посмотрите текущие имя (`name`) и описание (`description`) кластера:

     ```bash
     {{ yc-mdb-gp }} cluster get <идентификатор или имя кластера>
     ```

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Задайте новое имя и описание кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update <идентификатор или имя кластера> \
         --new-name <новое имя кластера> \
         --description <новое описание кластера>
      ```

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Новое имя в параметре `name`.
    * Новое описание в параметре `description`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `name`, `description`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

- Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ mgp-name }}**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. Измените дополнительные настройки кластера:

        * {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}
        * **Окно обслуживания** — настройки времени [технического обслуживания](../concepts/maintenance.md):

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

        * {% include [Datalens access](../../_includes/mdb/console/datalens-access.md) %}
        * {% include [DataTransfer access](../../_includes/mdb/console/datatransfer-access.md) %}
        * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-gp }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        {{ yc-mdb-gp }} cluster update <идентификатор или имя кластера> \
            --backup-window-start <время начала резервного копирования> \
            --datalens-access=<true или false> \
            --datatransfer-access=<true или false> \
            --maintenance-window type=<тип технического обслуживания: anytime или weekly>,`
                                `day=<день недели для типа weekly>,`
                                `hour=<час дня для типа weekly> \
            --deletion-protection=<защита от удаления кластера: true или false> \
        ```

    Вы можете изменить следующие настройки:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    {% if product == "yandex-cloud" %}* `--datalens-access` — разрешает доступ из [{{ datalens-full-name }}](../../datalens/concepts/index.md). Значение по умолчанию — `false`.{% endif %}

    * `--datatransfer-access` — разрешает доступ из [{{ data-transfer-full-name }}](../../data-transfer/index.yaml). Значение по умолчанию — `false`.

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров):

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Настройки публичного доступа в параметре `assignPublicIp`.
    * Настройки окна резервного копирования в параметре `config.backupWindowStart`.
    * Настройки доступа из [{{ datalens-full-name }}](../../datalens/concepts/index.md) в параметре `config.access.dataLens`.
    * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

    {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить количество хостов-сегментов кластера {#increase-host-segment}

Вы можете добавить хосты-сегменты в кластере {{ mgp-name }}. Данные перераспределяются между существующими и добавленными сегментами. Число добавляемых сегментов не может быть меньше двух.

{% list tabs %}

{% if audience == "draft" %}

- Консоль управления

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
    1. Выберите кластер и нажмите кнопку **Редактировать** в верхней части страницы.
    1. Выберите вкладку **Segment** и измените настройку **Количество хостов**.

       Можно добавить не менее двух хостов-сегментов.

    1. Выберите режим распределения данных по новым сегментам в настройке **Распределение данных**:
       * **Автоматически** — Величина таймаута будет подобрана автоматически, исходя из конфигурации кластера и объема данных.
       * **Вручную** — Укажите таймаут перераспределения данных (в секундах). Минимальное значение — `0` (не выполнять перераспределение).

{% endif %}

- API

    Воспользуйтесь методом API [expand](../api-ref/Cluster/expand.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.
    * Число добавляемых хостов-сегментов в параметре `segment_host_count`.
    * Число сегментов на хост в параметре `add_segments_per_host_count`.
    * Таймаут перераспределения данных (в секундах) в параметре `duration`. Минимальное значение и значение по умолчанию — `0` (не выполнять перераспределение).

    Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

Подробнее см. в разделе [{#T}](hosts/cluster-expand.md).

## Изменить настройки {{ GP }} {#change-gp-settings}

Вы можете изменить настройки СУБД для хостов вашего кластера.

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mgp-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Измените [настройки {{ GP }}](../concepts/settings-list.md), нажав кнопку **Настроить** в блоке **Настройки СУБД**.
  1. Нажмите кнопку **Сохранить**.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [настройки СУБД {{ GP }}](../concepts/settings-list.md):

  1. Посмотрите полный список настроек, установленных для кластера:

     ```bash
     {{ yc-mdb-gp }} cluster get <идентификатор или имя кластера>
     ```

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update-config --help
      ```

  1. Установите нужные значения параметров:

      Все поддерживаемые параметры перечислены в [формате запроса для метода update](../api-ref/Cluster/update.md), в поле `greenplumConfig_<версия {{ GP }}>`. Чтобы указать имя параметра в вызове CLI, преобразуйте его имя из вида <q>lowerCamelCase</q> в <q>snake_case</q>, например, параметр `maxConnections` из запроса к API преобразуется в `max_connections` для команды CLI:

      ```bash
      {{ yc-mdb-gp }} cluster update-config <идентификатор или имя кластера> \
         --set <имя параметра1>=<значение1>,<имя параметра2>=<значение2>,...
      ```

      {{ mgp-short-name }} запустит операцию по изменению настроек кластера.

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Новые значения в параметре `configSpec.greenplumConfig_<версия>`.
    * Список полей конфигурации кластера, подлежащих изменению, в параметре `updateMask`.

        {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
