---
title: "Изменение настроек кластера {{ OS }}"
description: "После создания кластера {{ OS }} вы можете изменить его сервисные настройки."
keywords:
  - настройки OpenSearch
  - настройки кластера OpenSearch
  - OpenSearch
---

# Изменение настроек кластера {{ OS }}

После создания кластера вы можете изменить его сервисные настройки. Также вы можете изменить [конфигурацию групп хостов](host-groups.md#update-host-group), [версию {{ OS }}](cluster-version-update.md) и [зону доступности для групп хостов](host-migration.md).


## Изменить сервисные настройки {#change-service-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Выберите кластер и нажмите кнопку ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**:

        1. Измените пароль пользователя `admin`.
        1. При необходимости измените дополнительные настройки кластера:

            {% include [Сервисные настройки](../../_includes/mdb/mos/extra-settings.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить сервисные настройки:

    1. Получите имя и идентификатор нужного кластера вместе со списком всех {{ OS }}-кластеров:

        ```bash
        {{ yc-mdb-os }} cluster list
        ```

    1. Измените настройки с помощью команды:

        ```bash
        {{ yc-mdb-os }} cluster update <имя_или_идентификатор_кластера> \
           --maintenance schedule=<тип_технического_обслуживания>,`
                        `weekday=<день_недели>,`
                        `hour=<час_дня> \
           --service-account-name <имя_сервисного_аккаунта> \
           --delete-protection <защита_от_удаления:_true_или_false>
        ```

        Где:

        * `--maintenance` — настройки времени технического обслуживания:

            * Чтобы разрешить проведение технического обслуживания в любое время, укажите `--maintenance schedule=anytime`.
            * Чтобы указать предпочтительное время начала обслуживания, укажите в команде параметр `--maintenance schedule=weekly,weekday=<день_недели>,hour=<час_дня_по_UTC>`. Тогда техническое обслуживание будет проходить каждую неделю в обозначенный день и время. Например, если указать `--maintenance schedule=weekly,weekday=mon,hour=14`, кластер будет обслуживаться каждый понедельник с 13:00 до 14:00.

            Операции по обслуживанию проводятся для включенных и выключенных кластеров. Во время обслуживания могут, например, применяться патчи или обновляться СУБД.

        * `--service-account-name` — имя сервисного аккаунта для [доступа к {{ objstorage-full-name }}](s3-access.md) в качестве репозитория [снапшотов](../../glossary/snapshot.md) {{ OS }}. Подробнее о сервисных аккаунтах см. в [документации {{ iam-full-name }}](../../iam/concepts/users/service-accounts.md).

        * `--delete-protection` — защита кластера от непреднамеренного удаления пользователем: `true` или `false`. Включенная защита от удаления кластера не помешает подключиться к нему вручную и удалить данные.

- API {#api}

    Воспользуйтесь методом [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Новый пароль пользователя `admin` в параметре `configSpec.adminPassword`.
    * Список плагинов в параметре `configSpec.opensearchSpec.plugins`. Плагины, не указанные в списке, будут выключены.
    * Настройки доступа из других сервисов в параметре `configSpec.access`.
    
    
    * Идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), используемого для работы с кластером, в параметре `serviceAccountId`.


    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
