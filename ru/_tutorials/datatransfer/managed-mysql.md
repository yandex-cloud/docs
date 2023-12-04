# Перенос данных с использованием сервиса {{ data-transfer-full-name }} {#data-transfer}

Чтобы перенести базу данных из {{ MY }} в {{ mmy-name }}:

1. [Запустите перенос данных](#start-transfer).
1. [Завершите перенос данных](#finish-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Запустите перенос данных {#start-transfer}

1. [Подготовьте кластер-источник](../../data-transfer/operations/prepare.md#source-my).
1. Подготовьте инфраструктуру и запустите перенос данных:

    {% list tabs %}

    * Вручную

        1. [Создайте кластер-приемник {{ mmy-name }}](../../managed-mysql/operations/cluster-create.md) любой подходящей конфигурации. При этом:

            * Версия {{ MY }} должна быть не ниже, чем в кластере-источнике.

                Перенос данных с повышением мажорной версии {{ MY }} возможен, но не гарантируется. Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

                Миграция с понижением версии {{ MY }} [невозможна](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

            * [Режим SQL](../../managed-mysql/concepts/settings-list.md#setting-sql-mode) должен быть таким же, как и в кластере-источнике.

        1. [Подготовьте кластер-приемник](../../data-transfer/operations/prepare.md#target-my).

        1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ ui-key.yacloud.data-transfer.label_endpoint-type-MYSQL }}`.
            * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.on_premise.title }}`.

                Укажите параметры подключения к кластеру-источнику.

        1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ ui-key.yacloud.data-transfer.label_endpoint-type-MYSQL }}`.
            * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.

                Выберите кластер-приемник из списка и укажите настройки подключения к нему.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-copy-repl }}_, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

            {% note warning %}

            Избегайте любых изменений в схеме данных в кластере-источнике и кластере-приемнике во время работы трансфера. Подробнее см. в разделе [{#T}](../../data-transfer/operations/db-actions.md).

            {% endnote %}

    * С помощью {{ TF }}

        1. [Подготовьте кластер-источник](../../data-transfer/operations/prepare.md#source-my).

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mysql-mmy.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-migration-mysql-mmy/data-transfer-mysql-mmy.tf).

            В этом файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру;
            * кластер-приемник {{ mmy-name }};
            * эндпоинт для источника;
            * эндпоинт для приемника;
            * трансфер.

        1. Укажите в файле `data-transfer-mysql-mmy.tf`:

            * [параметры эндпоинта-источника](../../data-transfer/operations/endpoint/source/mysql.md#on-premise);
            * параметры кластера-приемника, которые используются и как [параметры эндпоинта-приемника](../../data-transfer/operations/endpoint/target/mysql.md#managed-service):

                * `target_mysql_version` — версия {{ MY }}, она должна быть не ниже чем в кластере-источнике;
                * `target_sql_mode` — [режим SQL](../../managed-mysql/concepts/settings-list.md#setting-sql-mode), он должен быть таким же, как и в кластере-источнике;
                * `target_db_name` — имя базы данных;
                * `target_user` и `target_password` — имя и пароль пользователя-владельца базы данных.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

            Трансфер активируется автоматически после создания.

    {% endlist %}

## Завершите перенос данных {#finish-transfer}

1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.
1. Переведите кластер-источник в режим <q>только чтение</q> и переключите нагрузку на кластер-приемник.
1. На странице [мониторинга трансфера](../../data-transfer/operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum data transfer delay**. Это значит, что в кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
1. [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate) трансфер и дождитесь его перехода в статус {{ dt-status-stopped }}.

    Подробнее о статусах трансфера см. в разделе [Жизненный цикл трансфера](../../data-transfer/concepts/transfer-lifecycle.md#statuses).

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs %}

* Вручную

    * [Удалите кластер {{ mmy-name }}](../../managed-mysql/operations/cluster-delete.md).
    * [Удалите остановленный трансфер](../../data-transfer/operations/transfer.md#delete).
    * [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.

* С помощью {{ TF }}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `data-transfer-mysql-mmy.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `data-transfer-mysql-mmy.tf`, будут удалены.

{% endlist %}


Реальный пример миграции базы данных {{ MY }} с помощью сервиса {{ data-transfer-name }} см. в разделе [Синхронизация данных из MySQL с помощью {{ data-transfer-full-name }}](../../tutorials/dataplatform/sync-mysql.md).

