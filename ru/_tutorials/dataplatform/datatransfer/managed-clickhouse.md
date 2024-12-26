# Миграция данных с использованием сервиса {{ data-transfer-full-name }}

С помощью сервиса {{ data-transfer-name }} вы можете перенести вашу базу данных из стороннего кластера-источника {{ CH }} в кластер-приемник {{ mch-name }}.

Этот способ позволяет:

* скопировать базу без остановки обслуживания пользователей;
* обойтись без создания промежуточной [виртуальной машины](../../../glossary/vm.md) или разрешения доступа к вашему кластеру-приемнику {{ mch-name }} из интернета.

Вы также можете использовать этот способ для переноса данных между двумя кластерами {{ mch-name }}. Для успешного переноса в эндпоинте-источнике укажите порты `8443` и `9440`, а также добавьте [SSL-сертификат](../../../managed-clickhouse/operations/connect/index.md#get-ssl-cert).

Подробнее см. в разделе [{#T}](../../../data-transfer/concepts/use-cases.md).


## Перед началом работы {#before-you-begin}

[Разрешите подключение к кластеру-источнику из интернета](../../../data-transfer/concepts/network.md#source-external).


## Перенос данных {#data-transfer}

1. [Подготовьте кластер-источник](../../../data-transfer/operations/prepare.md#source-ch).
1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте группу безопасности](../../../vpc/operations/security-group-create.md) и [настройте ее](../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

        1. [Создайте кластер-приемник {{ mch-name }}](../../../managed-clickhouse/operations/cluster-create.md), вычислительная мощность и размер хранилища которого соответствуют среде, в которой развернута копируемая база данных.

            При создании кластера укажите группу безопасности, подготовленную ранее.

            Имя базы в кластере-приемнике должно совпадать с именем базы-источника.

            Если вы планируете подключаться к кластеру через сервис [{{ websql-full-name }}](../../../websql/concepts/index.md), включите в настройках кластера настройку **{{ ui-key.yacloud.mdb.cluster.overview.label_access-websql-service }}**.

        1. [Создайте эндпоинт для источника](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `ClickHouse`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseSource.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseSource.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnectionType.on_premise.title }}`.

                Укажите параметры подключения к кластеру-источнику.

        1. [Создайте эндпоинт для приемника](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `ClickHouse`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}`.

                Выберите кластер-приемник из списка и укажите настройки подключения к нему.

        1. [Создайте трансфер](../../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-copy }}_, использующий созданные эндпоинты, и [активируйте](../../../data-transfer/operations/transfer.md#activate) его.

    - С помощью {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-ch-mch.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-on-premise-clickhouse-to-cloud/blob/main/data-transfer-ch-mch.tf).

            В этом файле описаны:

            * [сеть](../../../vpc/concepts/network.md#network);
            * [подсеть](../../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру;
            * кластер-приемник {{ mch-name }};
            * эндпоинт для источника;
            * эндпоинт для приемника;
            * трансфер.

        1. Укажите в файле `data-transfer-ch-mch.tf`:

            * [параметры эндпоинта-источника](../../../data-transfer/operations/endpoint/source/clickhouse.md#on-premise):
                * `source_user` и `source_pwd` — имя и пароль пользователя для доступа к источнику;
                * `source_db_name` — имя базы данных;
                * `source_host` — FQDN или IP-адрес сервера {{ CH }};
                * `source_shard` — имя шарда;
                * `source_http_port` и `source_native_port` — порты для подключения по HTTP-интерфейсу и нативному интерфейсу {{ CH }}.

            * параметры кластера-приемника, которые используются и как [параметры эндпоинта-приемника](../../../data-transfer/operations/endpoint/target/clickhouse.md#managed-service):

                * `target_clickhouse_version` — версия {{ CH }};
                * `target_user` и `target_password` — имя и пароль пользователя-владельца базы данных.

            * параметры [CLI {{ yandex-cloud }}](../../../cli/), чтобы активировать кластер автоматически:

                * `profile_name` — имя вашего профиля в CLI {{ yandex-cloud }}.

                    {% include [cli-install](../../../_includes/cli-install.md) %}

        1. (Опционально) Если вы планируете подключаться к кластеру через сервис [{{ websql-full-name }}](../../../websql/concepts/index.md), добавьте к ресурсу кластера блок `access`:

            ```hcl
            access {
                web_sql = true
            }
            ```

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

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Убедитесь, что в базу данных {{ mch-name }} перенеслись данные из кластера-источника {{ CH }}:

    {% list tabs group=instructions %}
    

    - {{ websql-full-name }} {#websql}

        1. [Создайте подключение](../../../websql/operations/create-connection.md#connect-cluster) к БД в кластере {{ mch-name }}.
        1. Проверьте, что БД содержит таблицы из кластера-источника. Для этого через созданное подключение [выполните запрос](../../../websql/operations/query-executor.md#execute-query) к БД:

            ```sql
            SHOW TABLES FROM <имя_базы_данных>;
            ```

        1. Проверьте, что таблицы содержат данные из таблиц кластера-источника. Для этого через созданное подключение [выполните запрос](../../../websql/operations/query-executor.md#execute-query) к нужной таблице:

            ```sql
            SELECT * FROM <имя_базы_данных>.<имя_таблицы>;
            ```


    - CLI {#cli}

        1. [Получите SSL-сертификат](../../../managed-clickhouse/operations/connect/index.md#get-ssl-cert) для подключения к кластеру {{ mch-name }}.      
        1. [Подключитесь к БД](../../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) в кластере {{ mch-name }} с помощью `clickhouse-client`.
        1. Проверьте, что БД содержит таблицы из кластера-источника:

            ```sql
            SHOW TABLES FROM <имя_базы_данных>;
            ```
 
        1. Проверьте, что таблицы содержат данные из таблиц кластера-источника:

            ```sql
            SELECT * FROM <имя_базы_данных>.<имя_таблицы>;
            ```

    {% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

  * [Удалите кластер {{ mch-name }}](../../../managed-clickhouse/operations/cluster-delete.md).
  * [Удалите завершившийся трансфер](../../../data-transfer/operations/transfer.md#delete).
  * [Удалите эндпоинты](../../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.

- С помощью {{ TF }} {#tf}

  {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
