# Поставка данных из очереди {{ yds-name }} в {{ mkf-name }} с помощью {{ data-transfer-full-name }}

# Поставка данных из очереди {{ yds-name }} в {{ mkf-name }} с помощью {{ data-transfer-name }}

С помощью сервиса {{ data-transfer-name }} можно поставлять данные из потока {{ yds-name }} в кластер {{ mkf-name }}.

Чтобы перенести данные:

1. [Подготовьте поток данных {{ yds-name }}](#prepare-source).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* База данных {{ ydb-name }} (см. [тарифы {{ ydb-name }}](../../ydb/pricing/index.md)). Стоимость зависит от режима использования:

	* Для бессерверного режима — оплачиваются операции с данными, объем хранимых данных и резервных копий.
  	* Для режима с выделенными инстансами — оплачивается использование выделенных БД вычислительных ресурсов, объем хранилища и резервные копии.

* Сервис {{ yds-name }} (см. [тарифы {{ yds-name }}](../../data-streams/pricing.md)). Стоимость зависит от режима тарификации:

    * [По выделенным ресурсам](../../data-streams/pricing.md#rules) — оплачивается фиксированная почасовая ставка за установленный лимит пропускной способности и срок хранения сообщений, а также дополнительно количество единиц фактически записанных данных.
    * [По фактическому использованию](../../data-streams/pricing.md#on-demand) (On-demand) — оплачиваются выполненные операции записи и чтения данных, объем считанных/записанных данных, а также объем фактически используемого хранилища для сообщений, по которым не истек срок хранения.

* Кластер {{ mkf-name }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ mkf-name }}](../../managed-kafka/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы {{ data-transfer-name }}](../../data-transfer/pricing.md)).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру поставки данных:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.

    1. [Создайте кластер {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации c хостами в публичном доступе.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин {{ yandex-cloud }}, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

    1. [Создайте в кластере {{ mkf-name }} топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `sensors`.

    1. [Создайте в кластере {{ mkf-name }} пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `mkf-user` и правами доступа `ACCESS_ROLE_PRODUCER` и `ACCESS_ROLE_CONSUMER` к созданному топику.


- {{ TF }} {#tf}

    1. Если у вас еще нет {{ TF }}, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [yds-to-kafka.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-yds-to-kafka/blob/main/yds-to-kafka.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру {{ mkf-name }};
        * база данных {{ ydb-name }};
        * кластер {{ mkf-name }};
        * топик {{ mkf-name }} с именем `sensors`;
        * пользователь {{ mkf-name }} с правами доступа `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_CONSUMER` к топику `sensors`;
        * трансфер.

    1. Укажите в файле `yds-to-kafka.tf` значения параметров:

        * `mkf_version` — версия кластера {{ KF }};
        * `ydb_name` — имя базы данных {{ ydb-name }};
        * `mkf_user_name` — имя пользователя в кластере {{ mkf-name }};
        * `mkf_user_password` — пароль пользователя в кластере {{ mkf-name }};
        * `transfer_enabled` — значение `0`, чтобы не создавать трансфер до [создания эндпоинтов вручную](#prepare-transfer).

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

## Создайте поток данных {{ yds-name }} {#prepare-source}

[Создайте поток данных {{ yds-name }}](../../data-streams/quickstart/create-stream.md).

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для источника {{ yds-name }}](../../data-transfer/operations/endpoint/index.md#create).

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ yds-full-name }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.connection.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}** — выберите базу данных {{ ydb-name }} из списка.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}** — укажите имя потока {{ yds-name }}.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}** — выберите или создайте сервисный аккаунт с ролью `yds.editor`.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.advanced_settings.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}** — `JSON`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.json_fields.title }}`:

            Заполните схему данных:

            {% cut "Схема данных" %}

            ```json
                [
                    {
                        "name": "device_id",
                        "type": "string"
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

1. [Создайте эндпоинт для приемника {{ mkf-name }}](../../data-transfer/operations/endpoint/index.md#create).

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `Kafka`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTarget.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTarget.connection.title }}**:
        
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.connection_type.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}** — выберите кластер {{ mkf-name }} из списка.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.auth.title }}** — выберите **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaAuth.sasl.title }}**.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaSASLAuth.user.title }}** — введите имя пользователя в кластере {{ mkf-name }}.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaSASLAuth.password.title }}** — введите пароль пользователя в кластере {{ mkf-name }}.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}** — выберите **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}**.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}** — введите имя топика в кластере {{ mkf-name }}.

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - {{ TF }} {#tf}

        1. Укажите в файле `yds-to-kafka.tf` значения переменных:

            * `source_endpoint_id` — идентификатор эндпоинта для источника;
            * `target_endpoint_id` — идентификатор эндпоинта для приемника;
            * `transfer_enabled` – значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            1. Выполните команду для просмотра планируемых изменений:
            
               ```bash
               terraform plan
               ```
            
               Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
            
            1. Если вас устраивают планируемые изменения, внесите их:
               1. Выполните команду:
            
                  ```bash
                  terraform apply
                  ```
            
               1. Подтвердите изменение ресурсов.
               1. Дождитесь завершения операции.

            Трансфер активируется автоматически.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. [Отправьте в поток {{ yds-name }}](../../data-streams/operations/aws-cli/send.md) тестовые данные:

    ```json
    {
        "device_id":"iv9a94th6rzt********",
        "datetime":"2020-06-05T17:27:00",
        "latitude":"55.70329032",
        "longitude":"37.65472196",
        "altitude":"427.5",
        "speed":"0",
        "battery_voltage":"23.5",
        "cabin_temperature":"17",
        "fuel_level":null
    }
    ```

1. Убедитесь, что данные перенеслись в топик `sensors` кластера {{ mkf-name }}:

    1. [Получите SSL-сертификат](../../managed-kafka/operations/connect/index.md#get-ssl-cert) для подключения к кластеру {{ mkf-name }}.
    1. [Установите](../../managed-kafka/operations/connect/clients.md#bash-zsh) утилиту `kafkacat`.
    1. [Запустите](../../managed-kafka/operations/connect/clients.md#with-ssl_1) команду получения сообщений из топика.

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
1. Если при создании эндпоинта для источника вы создавали сервисный аккаунт, [удалите его](../../iam/operations/sa/delete.md).
1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Удалите кластер {{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).
       1. [Удалите базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md#delete-db)..

   - {{ TF }} {#tf}

       1. В терминале перейдите в директорию с планом инфраструктуры.
       
           {% note warning %}
       
           Убедитесь, что в директории нет {{ TF }}-манифестов с ресурсами, которые вы хотите сохранить. {{ TF }} удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
       
           {% endnote %}
       
       1. Удалите ресурсы:
       
           1. Выполните команду:
       
               ```bash
               terraform destroy
               ```
       
           1. Подтвердите удаление ресурсов и дождитесь завершения операции.
       
           Все ресурсы, которые были описаны в {{ TF }}-манифестах, будут удалены.

   {% endlist %}