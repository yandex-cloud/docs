# Сохранение потока данных {{ yds-full-name }} в {{ mch-full-name }}

С помощью сервиса {{ data-transfer-name }} вы можете поставлять данные из [потока {{ yds-name }}](../../data-streams/concepts/glossary.md#stream-concepts) в сервис {{ mch-name }}.

Чтобы перенести данные:

1. [Подготовьте поток данных {{ yds-name }}](#prepare-source).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs %}

* Вручную

    1. [Создайте базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.
    1. [Создайте кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) любой подходящей конфигурации.
    1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

        * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ CH }}`.
        * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseSource.connection.title }}**:

                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnectionType.mdb_cluster_id.title }}`.

                    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnectionType.mdb_cluster_id.title }}** — выберите кластер-приемник из списка.

                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}** — укажите имя базы данных.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.user.title }}** и **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.password.title }}** — укажите имя и пароль пользователя с доступом к базе, например, владельца базы данных.

* С помощью {{ TF }}

    1. {% include [terraform-install](../../_includes/terraform-install.md) %}
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-yds-mch.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-yds-mch.tf).

        В этом файле описаны:

        * база данных {{ ydb-name }};
        * сервисный аккаунт с ролью `yds.editor`;
        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру {{ mch-name }} из интернета;
        * кластер-приемник {{ mch-name }};
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `data-transfer-yds-mch.tf`:

        * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будут созданы ресурсы.
        * `sa_name` — имя сервисного аккаунта для использования в эндпоинтах.
        * `source_db_name` — имя базы данных {{ ydb-name }}.
        * `target_db_name` — имя базы данных {{ CH }}.
        * `target_user` и `target_password` — имя и пароль пользователя-владельца базы данных {{ CH }}.
        * `transfer_enabled` – значение `0`, чтобы не создавать трансфер до [создания эндпоинта-источника вручную](#prepare-transfer).

    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте поток данных {{ yds-name }} {#prepare-source}

1. [Создайте поток данных {{ yds-name }}](../../data-streams/operations/aws-cli/create.md).
1. [Отправьте в поток](../../data-streams/operations/aws-cli/send.md) тестовые данные. В качестве сообщения используйте данные от сенсоров автомобиля в формате JSON:

```json
{
    "device_id":"iv9a94th6rzt********",
    "datetime":"2022-06-05 17:27:00",
    "latitude":55.70329032,
    "longitude":37.65472196,
    "altitude":427.5,
    "speed":0,
    "battery_voltage":"23.5",
    "cabin_temperature":17,
    "fuel_level":null
}
```

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ yds-full-name }}`.
    * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.connection.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}** — выберите базу данных {{ ydb-name }} из списка.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}** — укажите имя потока {{ yds-name }}.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}** — выберите или создайте сервисный аккаунт с ролью `yds.editor`.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.advanced_settings.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}** — `JSON`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}** –  Вы можете задать схему двумя способами:
              * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.fields.title }}`.

                Задайте список полей топика вручную:

                | {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ColSchema.name.title }} | {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ColSchema.type.title }} | {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ColSchema.key.title }} |
                | :-- | :-- | :--- |
                |`device_id`|`STRING`| Да|
                |`datetime` |`DATETIME`|  |
                |`latitude` |`DOUBLE`|  |
                |`longitude`|`DOUBLE`|  |
                |`altitude` |`DOUBLE`|  |
                |`speed`    |`DOUBLE`|  |
                |`battery_voltage`| `ANY`||
                |`cabin_temperature`| `DOUBLE`||
                | `fuel_level`|`ANY`||

              * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.json_fields.title }}`.

                Создайте и загрузите файл схемы данных в формате JSON `json_schema.json`:

                {% cut "json_schema.json" %}

                ```json
                [
                    {
                        "name": "device_id",
                        "type": "string",
                        "key": true
                    },
                    {
                        "name": "datetime",
                        "type": "datetime"
                    },
                    {
                        "name": "latitude",
                        "type": "double"
                    },
                    {
                        "name": "longitude",
                        "type": "double"
                    },
                    {
                        "name": "altitude",
                        "type": "double"
                    },
                    {
                        "name": "speed",
                        "type": "double"
                    },
                    {
                        "name": "battery_voltage",
                        "type": "any"
                    },
                    {
                        "name": "cabin_temperature",
                        "type": "double"
                    },
                    {
                        "name": "fuel_level",
                        "type": "any"
                    }
                ]
                ```

                {% endcut %}

1. Создайте трансфер:

    {% list tabs %}

    * Вручную

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    * С помощью {{ TF }}

        1. Укажите в файле `data-transfer-yds-mch.tf` переменные:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `transfer_enabled` – значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Трансфер активируется автоматически после создания.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. [Отправьте в поток](../../data-streams/operations/aws-cli/send.md) {{ yds-name }} новое сообщение:

    ```json
    {
        "device_id":"rhibbh3y08qm********",
        "datetime":"2022-06-06 09:49:54",
        "latitude":55.71294467,
        "longitude":37.66542005,
        "altitude":429.13,
        "speed":55.5,
        "battery_voltage":null,
        "cabin_temperature":18,
        "fuel_level":32
    }
    ```

1. Убедитесь, что в базу данных кластера {{ mch-name }} перенеслись данные из потока {{ yds-name }}:

   1. [Подключитесь к кластеру-приемнику {{ mch-name }}](../../managed-clickhouse/operations/connect.md).
   1. Проверьте, что в базе {{ CH }} существует таблица с именем [созданного потока {{ yds-name }}](#prepare-source) с теми же колонками, что и [схема данных в эндпоинте-источнике](#prepare-transfer), и отправленными тестовыми данными.

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. Удалите ресурсы в зависимости от способа их создания:

   {% list tabs %}

   * Вручную

       * [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для приемника.
       * [Удалите базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md#delete-db).
       * [Удалите кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md).

   * С помощью {{ TF }}

       1. В терминале перейдите в директорию с планом инфраструктуры.
       1. Удалите конфигурационный файл `data-transfer-yds-mch.tf`.
       1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

           ```bash
           terraform validate
           ```

           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

       1. Подтвердите изменение ресурсов.

           {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

           Все ресурсы, которые были описаны в конфигурационном файле `data-transfer-yds-mch.tf`, будут удалены.

   {% endlist %}

1. [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для источника.
