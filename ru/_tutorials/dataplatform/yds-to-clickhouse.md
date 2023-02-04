# Сохранение потока данных {{ yds-full-name }} в {{ mch-full-name }}

С помощью сервиса {{ data-transfer-name }} вы можете поставлять данные из {% if audience != "internal" and product == "yandex-cloud"%}[потока {{ yds-name }}](../../data-streams/concepts/glossary.md#stream-concepts){% else %}потока {{ yds-name }}{% endif %} в сервис {{ mch-name }}.

Чтобы перенести данные:

1. [Подготовьте поток данных {{ yds-name }}](#prepare-source).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs %}

* Вручную

    1. {% if audience != "internal" %}[Создайте базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md#create-db){% else %}Создайте базу данных {{ ydb-name }}{% endif %} любой подходящей конфигурации.
    1. [Создайте кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) любой подходящей конфигурации.
    1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

        * **Тип базы данных** — `{{ CH }}`.
        * **Параметры эндпоинта**:

            * **Настройки подключения**:

                * **Тип подключения** — `Кластер {{ mch-name }}`.

                    * **Кластер {{ mch-name }}** — выберите кластер-приемник из списка.

                * **База данных** — укажите имя базы данных.
                * **Пользователь** и **Пароль** — укажите имя и пароль пользователя с доступом к базе, например, владельца базы данных.

* С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, {% if audience != "internal" %}[установите и настройте его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите и настройте его{% endif %}.
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и {% if audience != "internal" %}[укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}укажите значения параметров{% endif %}.

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-yds-mch.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-yds-mch.tf).

        В этом файле описаны:

        * база данных {{ ydb-name }};
        * сервисный аккаунт с ролью `yds.editor`;
        * {% if audience != "internal" %}[сеть](../../vpc/concepts/network.md#network){% else %}сеть{% endif %};
        * {% if audience != "internal" %}[подсеть](../../vpc/concepts/network.md#subnet){% else %}подсеть{% endif %};
        * {% if audience != "internal" %}[группа безопасности](../../vpc/concepts/security-groups.md){% else %}группа безопасности{% endif %} и правила, необходимые для подключения к кластеру {{ mch-name }} из интернета;
        * кластер-приемник {{ mch-name }};
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `data-transfer-yds-mch.tf`:

        * `folder_id` — {% if audience != "internal" %}[идентификатор каталога](../../resource-manager/operations/folder/get-id.md){% else %}идентификатор каталога{% endif %}, в котором будут созданы ресурсы.
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

1. {% if audience != "internal" and product == "yandex-cloud" %}[Создайте поток данных {{ yds-name }}](../../data-streams/operations/aws-cli/create.md){% else %}Создайте поток данных {{ yds-name }}{% endif %}.
1. {% if audience != "internal" and product == "yandex-cloud" %}[Отправьте в поток](../../data-streams/operations/aws-cli/send.md){% else %}Отправьте в поток{% endif %} тестовые данные. В качестве сообщения используйте данные от сенсоров автомобиля в формате JSON:

```json
{
    "device_id":"iv9a94th6rztooxh5ur2",
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

    * **Тип базы данных** — `{{ yds-full-name }}`.
    * **Параметры эндпоинта**:

        * **Настройки подключения**:

            * **База данных** — выберите базу данных {{ ydb-name }} из списка.
            * **Поток** — укажите имя потока {{ yds-name }}.
            * **Сервисный аккаунт** — выберите или создайте сервисный аккаунт с ролью `yds.editor`.

        * **Расширенные настройки** → **Правила конвертации**:

            * **Формат данных** — `JSON`.
            * **Схема данных** –  Вы можете задать схему двумя способами:
              * `Список полей`.

                Задайте список полей топика вручную:

                | Имя | Тип | Ключ |
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

              * `JSON спецификация`.

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

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа {{ dt-type-repl }}, использующий созданные эндпоинты.
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

1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.

1. {% if audience != "internal" and product == "yandex-cloud" %}[Отправьте в поток](../../data-streams/operations/aws-cli/send.md){% else %}Отправьте в поток{% endif %} {{ yds-name }} новое сообщение:

    ```json
    {
        "device_id":"rhibbh3y08qmz3sdbrbu",
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

Если созданные ресурсы вам больше не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. Удалите ресурсы в зависимости от способа их создания:

   {% list tabs %}

   * Вручную

       * [Удалите эндпоинт](../../data-transfer/operations/endpoint/index.md#delete) для приемника.
       * {% if audience != "internal" %}[Удалите базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md#delete-db){% else %}Удалите базу данных {{ ydb-name }}{% endif %}.
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
