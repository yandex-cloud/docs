# Миграция данных с использованием сервиса {{ data-transfer-full-name }} {#data-transfer}


### Перед началом работы {#before-you-begin-dt}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


#### Необходимые платные ресурсы {#paid-resources-dt}

* Кластер {{ mpg-name }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы {{ mpg-name }}](../../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы {{ vpc-name }}](../../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных ([тарифы {{ data-transfer-name }}](../../../data-transfer/pricing.md)).


### Перенесите данные {#transfer-data}

1. [Подготовьте кластер-источник](../../../data-transfer/operations/prepare.md#source-pg).
1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте кластер-приемник {{ mpg-name }}](../../../managed-postgresql/operations/cluster-create.md) любой подходящей конфигурации. Включите те же [расширения {{ PG }}](../../../managed-postgresql/operations/extensions/cluster-extensions.md), что и в кластере-источнике.
        1. [Подготовьте кластер-приемник](../../../data-transfer/operations/prepare.md#target-pg).
        1. [Создайте эндпоинт для источника](../../../data-transfer/operations/endpoint/index.md#create) со следующими параметрами:

             * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** — `{{ ui-key.yacloud.data-transfer.forms.label_source-type }}`.
             * Укажите имя эндпоинта.
             * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `PostgreSQL`.
             * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.title }}**:

                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.connection.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.on_premise.title }}`.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.host.title }}** — укажите IP-адрес или FQDN хоста-мастера кластера-источника.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.port.title }}** — укажите номер порта для подключения к кластеру-источнику.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя БД.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}** — укажите имя пользователя БД.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}** — укажите пароль пользователя.

        1. [Создайте эндпоинт для приемника](../../../data-transfer/operations/endpoint/index.md#create) со следующими параметрами:

             * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** — `{{ ui-key.yacloud.data-transfer.forms.label_target-type }}`.
             * Укажите имя эндпоинта.
             * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ PG }}`.
             * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTarget.title }}**:

                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTarget.connection.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
                 * **Кластер управляемой БД** — выберите кластер-приемник из списка.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя нужной БД.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}** — укажите имя пользователя БД.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}** — укажите пароль пользователя.

        1. [Создайте трансфер](../../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-copy-repl }}_, использующий созданные эндпоинты.
        1. [Активируйте трансфер](../../../data-transfer/operations/transfer.md#activate).

            {% note warning %}

            Избегайте любых изменений в схеме данных в кластере-источнике и кластере-приемнике во время работы трансфера. Подробнее в разделе [{#T}](../../../data-transfer/operations/db-actions.md).

            {% endnote %}

    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-pgsql-mpg.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-on-premise-postgresql-to-cloud/blob/main/data-transfer-pgsql-mpg.tf).

            В этом файле описаны:

            * [сеть](../../../vpc/concepts/network.md#network);
            * [подсеть](../../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру;
            * кластер-приемник {{ mpg-name }};
            * эндпоинт для источника;
            * эндпоинт для приемника;
            * трансфер.

        1. Укажите в файле `data-transfer-pgsql-mpg.tf`:

            * [параметры эндпоинта-источника](../../../data-transfer/operations/endpoint/source/postgresql.md#on-premise);
            * `pg-extensions` – список [расширений {{ PG }}](../../../managed-postgresql/operations/extensions/cluster-extensions.md) в кластере-источнике;
            * параметры кластера-приемника, которые используются и как [параметры эндпоинта-приемника](../../../data-transfer/operations/endpoint/target/postgresql.md#managed-service):

                * `target_pgsql_version` — версия {{ PG }}, она должна быть не ниже, чем в кластере-источнике;
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

1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.
1. Снимите пишущую нагрузку с кластера-источника.
1. На странице [мониторинга трансфера](../../../data-transfer/operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum data transfer delay**. Это значит, что на кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
1. Переключите нагрузку на кластер-приемник.
1. [Деактивируйте](../../../data-transfer/operations/transfer.md#deactivate) трансфер и дождитесь его перехода в статус {{ dt-status-stopped }}.

    Подробнее о статусах трансфера смотрите в разделе [Жизненный цикл трансфера](../../../data-transfer/concepts/transfer-lifecycle.md#statuses).


### Удалите созданные ресурсы {#clear-out-dt}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

{% list tabs group=instructions %}

- Ресурсы созданы вручную {#manual}

    1. [Удалите](../../../data-transfer/operations/transfer.md#delete) остановленный трансфер.
    1. [Удалите эндпоинты](../../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
    1. [Удалите кластер {{ mpg-name }}](../../../managed-postgresql/operations/cluster-delete.md).

- Ресурсы созданы с помощью {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
