# Перенос данных с использованием сервиса {{ data-transfer-full-name }} {#data-transfer}



Чтобы перенести базу данных из {{ MY }} в {{ mmy-name }} с использованием сервиса {{ data-transfer-full-name }}:

1. [Запустите перенос данных](#start-transfer).
1. [Завершите перенос данных](#finish-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mmy-name }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы {{ mmy-name }}](../../../managed-mysql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы {{ vpc-full-name }}](../../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных ([тарифы {{ data-transfer-name }}](../../../data-transfer/pricing.md)).


## Запустите перенос данных {#start-transfer}

1. [Подготовьте кластер-источник](../../../data-transfer/operations/prepare.md#source-my).
1. Подготовьте инфраструктуру и запустите перенос данных:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте кластер-приемник {{ mmy-name }}](../../../managed-mysql/operations/cluster-create.md) любой подходящей конфигурации. При этом:

            * Версия {{ MY }} должна быть не ниже, чем в кластере-источнике.

                Перенос данных с повышением мажорной версии {{ MY }} возможен, но не гарантируется. Подробнее в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

                Миграция с понижением версии {{ MY }} [невозможна](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

            * [Режим SQL](../../../managed-mysql/concepts/settings-list.md#setting-sql-mode) должен быть таким же, как и в кластере-источнике.

        1. [Подготовьте кластер-приемник](../../../data-transfer/operations/prepare.md#target-my).

        1. [Создайте эндпоинт для источника](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** — `{{ ui-key.yacloud.data-transfer.forms.label_source-type }}`.
            * Укажите имя эндпоинта.
            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `MySQL`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.title }}**:

                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.on_premise.title }}`.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.host.title }}** — укажите IP-адрес или FQDN хоста, к которому необходимо подключиться.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.port.title }}** — укажите номер порта для подключения к кластеру-источнику.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя базы данных в пользовательской инсталляции.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}** — укажите пароль пользователя.

        1. [Создайте эндпоинт для приемника](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** — `{{ ui-key.yacloud.data-transfer.forms.label_target-type }}`.
            * Укажите имя эндпоинта.
            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `MySQL`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.title }}**:

                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.connection.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.
                * **Кластер управляемой БД** — выберите кластер-приемник из списка.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя базы данных в выбранном кластере.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}** — укажите пароль пользователя.

        1. [Создайте трансфер](../../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-copy-repl }}_, использующий созданные эндпоинты.
        1. [Активируйте](../../../data-transfer/operations/transfer.md#activate) его.

            {% note warning %}

            Избегайте любых изменений в схеме данных в кластере-источнике и кластере-приемнике во время работы трансфера. Подробнее в разделе [{#T}](../../../data-transfer/operations/db-actions.md).

            {% endnote %}

    - {{ TF }} {#tf}

        1. [Подготовьте кластер-источник](../../../data-transfer/operations/prepare.md#source-my).

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mysql-mmy.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-on-premise-mysql-to-cloud/blob/main/data-transfer-mysql-mmy.tf).

            В этом файле описаны:

            * [сеть](../../../vpc/concepts/network.md#network);
            * [подсеть](../../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру;
            * кластер-приемник {{ mmy-name }};
            * эндпоинт для источника;
            * эндпоинт для приемника;
            * трансфер.

        1. Укажите в файле `data-transfer-mysql-mmy.tf`:

            * [параметры эндпоинта-источника](../../../data-transfer/operations/endpoint/source/mysql.md#on-premise);
            * параметры кластера-приемника, которые используются и как [параметры эндпоинта-приемника](../../../data-transfer/operations/endpoint/target/mysql.md#managed-service):

                * `target_mysql_version` — версия {{ MY }}, она должна быть не ниже чем в кластере-источнике;
                * `target_sql_mode` — [режим SQL](../../../managed-mysql/concepts/settings-list.md#setting-sql-mode), он должен быть таким же, как и в кластере-источнике;
                * `target_db_name` — имя базы данных;
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

## Завершите перенос данных {#finish-transfer}

1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.
1. Переведите кластер-источник в режим <q>только чтение</q> и переключите нагрузку на кластер-приемник.
1. На странице [мониторинга трансфера](../../../data-transfer/operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum data transfer delay**. Это значит, что в кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
1. [Деактивируйте](../../../data-transfer/operations/transfer.md#deactivate) трансфер и дождитесь его перехода в статус {{ dt-status-stopped }}.

    Подробнее о статусах трансфера смотрите в разделе [Жизненный цикл трансфера](../../../data-transfer/concepts/transfer-lifecycle.md#statuses).

## Удалите созданные ресурсы {#clear-out}


Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:


{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите](../../../data-transfer/operations/transfer.md#delete) остановленный трансфер.
    1. [Удалите эндпоинты](../../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
    1. [Удалите кластер {{ mmy-name }}](../../../managed-mysql/operations/cluster-delete.md).

    
    1. Если для доступа к хостам кластера использовались статические публичные IP-адреса, освободите и [удалите](../../../vpc/operations/address-delete.md) их.


- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}


Реальный пример миграции базы данных {{ MY }} с помощью сервиса {{ data-transfer-name }} приведен в разделе [Синхронизация данных из MySQL с помощью {{ data-transfer-full-name }}](../../../tutorials/dataplatform/sync-mysql.md).
