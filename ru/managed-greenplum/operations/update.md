# Изменение настроек {{ GP }}-кластера

После создания кластера вы можете:

* [{#T}](#change-name-and-description).

* [{#T}](#change-additional-settings).

* [{#T}](#change-gp-settings).

* [{#T}](#change-disk-size).

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

    Чтобы изменить имя и описание кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

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

        * **Менеджер подключений** — режим работы и параметры [менеджера подключений](../concepts/pooling.md):

            {% include [Pooling mode](../../_includes/mdb/mgp/pooling-mode.md) %}

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
            --assign-public-ip=<публичный доступ к кластеру: true или false> \
            --deletion-protection=<защита от удаления кластера: true или false> \
        ```

    Вы можете изменить следующие настройки:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--datalens-access` — разрешает доступ из [{{ datalens-full-name }}](../../datalens/concepts/index.md). Значение по умолчанию — `false`.

    * `--datatransfer-access` — разрешает доступ из [{{ data-transfer-full-name }}](../../data-transfer/). Значение по умолчанию — `false`.

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров):

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * `--assign-public-ip` — доступность кластера из интернета.

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

    Чтобы изменить дополнительные настройки кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Настройки публичного доступа в параметре `config.assignPublicIp`.
    * Настройки окна резервного копирования в параметре `config.backupWindowStart`.
    * Настройки доступа из [{{ datalens-full-name }}](../../datalens/concepts/index.md) в параметре `config.access.dataLens`.
    * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

    {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

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

    Чтобы изменить настройки {{ GP }}, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Новые значения в параметре `configSpec.greenplumConfig_<версия>`.
    * Список полей конфигурации кластера, подлежащих изменению, в параметре `updateMask`.

        {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

## Увеличить размер хранилища {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Консоль управления

  Чтобы увеличить размер хранилища для кластера:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ mgp-name }}**.
  1. Выберите нужный кластер.
  1. В верхней части страницы нажмите кнопку **Изменить кластер**.
  1. Измените настройки в блоке **Хранилище**.
  1. Нажмите кнопку **Сохранить изменения**.

- API

  Чтобы увеличить размер хранилища для кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
  * Новый размер хранилища мастера и сегмента в параметрах `masterConfig.resources.diskSize` и `masterConfig.resources.diskSize`.
  * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
