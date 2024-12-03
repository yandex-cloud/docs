# Перешардирование данных в кластере {{ mch-name }}

С помощью сервиса {{ data-transfer-name }} вы можете перенести вашу базу данных из шардированного кластера-источника {{ mch-name }} в кластер-приемник {{ mch-name }} с другой конфигурацией шардов.

Этот способ позволяет перераспределить данные шардированных таблиц по новой конфигурации шардов кластера {{ CH }}.

## Перенесите данные с перераспределением по шардам {#resharding}

1. [Подготовьте кластер-источник](../../../data-transfer/operations/prepare.md#source-ch).
1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте кластер-приемник {{ mch-name }}](../../../managed-clickhouse/operations/cluster-create.md), вычислительная мощность и размер хранилища которого соответствуют среде, в которой развернута копируемая база данных.

           Имя базы в кластере-приемнике должно совпадать с именем базы-источника.

        1. [Добавьте нужное количество шардов в кластер-приемник {{ mch-name }}](../../../managed-clickhouse/operations/shards.md#add-shard).

        1. [Подготовьте кластер-приемник](../../../data-transfer/operations/prepare.md#target-ch).

        1. [Создайте эндпоинт для источника](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `ClickHouse`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseSource.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseSource.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnectionType.managed.title }}`.

                Выберите кластер-источник из списка и укажите настройки подключения к нему.

        1. [Создайте эндпоинт для приемника](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `ClickHouse`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}`.

                Выберите кластер-приемник из списка и укажите настройки подключения к нему.

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.sharding_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettings.sharding_settings_oneof.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_round_robin.title }}`.

        1. [Создайте трансфер](../../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-copy }}_, использующий созданные эндпоинты.
        1. [Активируйте](../../../data-transfer/operations/transfer.md#activate) его.

    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mch-mch-resharding.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-clickhouse-data-resharding/blob/main/data-transfer-mch-mch-resharding.tf).

            В этом файле описаны:

            * [сеть](../../../vpc/concepts/network.md#network);
            * [подсеть](../../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру;
            * кластер-приемник {{ mch-name }} с заданным количеством шардов;
            * эндпоинт для источника;
            * эндпоинт для приемника;
            * трансфер.

        1. Укажите в файле `data-transfer-mch-mch-resharding.tf`:

            * [параметры эндпоинта-источника](../../../data-transfer/operations/endpoint/source/clickhouse.md#on-premise):
                * `source_cluster` — идентификатор кластера-источника {{ mch-name }};
                * `source_user` и `source_pwd` — имя и пароль пользователя для доступа к источнику;
                * `source_db_name` — имя базы данных.

            * параметры кластера-приемника, которые используются и как [параметры эндпоинта-приемника](../../../data-transfer/operations/endpoint/target/clickhouse.md#managed-service):
                * `target_clickhouse_version` — версия {{ CH }};
                * `target_user` и `target_password` — имя и пароль пользователя-владельца базы данных.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

            Трансфер активируется автоматически после создания.

    {% endlist %}

1. Дождитесь перехода трансфера в статус {{ dt-status-finished }}.

    Подробнее о статусах трансфера см. в разделе [Жизненный цикл трансфера](../../../data-transfer/concepts/transfer-lifecycle.md#statuses).

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите кластер-приемник {{ mch-name }}](../../../managed-clickhouse/operations/cluster-delete.md).
    1. [Удалите завершившийся трансфер](../../../data-transfer/operations/transfer.md#delete).
    1. [Удалите эндпоинты](../../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
