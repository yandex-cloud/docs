# Поставка данных из {{ mkf-full-name }} в {{ yds-full-name }} с помощью {{ data-transfer-full-name }}

# Поставка данных из очереди {{ KF }} в {{ DS }}


В поток данных {{ yds-name }} можно в реальном времени поставлять данные из топиков {{ KF }}.

Чтобы запустить поставку данных:

1. [Создайте поток данных приемника {{ yds-name }}](#create-target-yds).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mkf-name }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ mkf-name }}](../../managed-kafka/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* База данных {{ ydb-name }} (см. [тарифы {{ ydb-name }}](../pricing/index.md)). Стоимость зависит от режима использования:

	* Для бессерверного режима — оплачиваются операции с данными, объем хранимых данных и резервных копий.
  	* Для режима с выделенными инстансами — оплачивается использование выделенных БД вычислительных ресурсов, объем хранилища и резервные копии.

* Сервис {{ yds-name }} (см. [тарифы {{ yds-name }}](../../data-streams/pricing.md)). Стоимость зависит от режима тарификации:

    * [По выделенным ресурсам](../../data-streams/pricing.md#rules) — оплачивается фиксированная почасовая ставка за установленный лимит пропускной способности и срок хранения сообщений, а также дополнительно количество единиц фактически записанных данных.
    * [По фактическому использованию](../../data-streams/pricing.md#on-demand) (On-demand) — оплачиваются выполненные операции записи и чтения данных, объем считанных/записанных данных, а также объем фактически используемого хранилища для сообщений, по которым не истек срок хранения.


## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру поставки данных:

    {% list tabs group=instructions %}

    - Вручную {#manual}


        1. [Создайте кластер-источник {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации.
        1. [Создайте базу данных {{ ydb-name }}](../operations/manage-databases.md) любой подходящей конфигурации.
        1. [Создайте в кластере-источнике топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `sensors`.
        1. [Создайте в кластере-источнике пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с правами доступа `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_CONSUMER` к созданному топику.

    - {{ TF }} {#tf}

        1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mkf-ydb.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-kafka-to-yds/blob/main/data-transfer-mkf-ydb.tf).

            В этом файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру {{ mkf-name }};
            * кластер-источник {{ mkf-name }};
            * топик {{ KF }};
            * пользователь {{ KF }};
            * база данных {{ ydb-name }};
            * трансфер.

        1. Укажите в файле `data-transfer-mkf-ydb.tf` переменные:

            * `source_kf_version` — версия {{ KF }} в кластере-источнике;
            * `source_user_name` — имя пользователя для подключения к топику {{ KF }};
            * `source_user_password` — пароль пользователя;
            * `target_db_name` — имя базы данных {{ ydb-name }};
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

    В созданный топик {{ KF }} `sensors` кластера-источника будут поступать тестовые данные от сенсоров автомобиля в формате JSON:

    ```json
    {
        "device_id":"iv9a94th6rzt********",
        "datetime":"2020-06-05 17:27:00",
        "latitude":"55.70329032",
        "longitude":"37.65472196",
        "altitude":"427.5",
        "speed":"0",
        "battery_voltage":"23.5",
        "cabin_temperature":"17",
        "fuel_level":null
    }
    ```

1. Установите утилиты:

    - [kafkacat](https://github.com/edenhill/kcat) — для чтения и записи данных в топики {{ KF }}.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Убедитесь, что можете с ее помощью [подключиться к кластеру-источнику {{ mkf-name }} через SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

    - [jq](https://stedolan.github.io/jq/) — для потоковой обработки JSON-файлов.

        ```bash
        sudo apt update && sudo apt-get install --yes jq
        ```

## Создайте поток данных приемника {{ yds-name }} {#create-target-yds}

[Создайте поток данных приемника {{ yds-name }}](../../data-streams/operations/aws-cli/create.md) для базы данных {{ ydb-name }}.

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для [источника `{{ KF }}`](../../data-transfer/operations/endpoint/source/kafka.md):

    **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSource.title }}**:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`.

        Выберите кластер-источник из списка и укажите настройки подключения к нему.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSource.advanced_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceAdvancedSettings.converter.title }}**.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceAdvancedSettings.converter.title }}** – `json`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}** –  Вы можете задать схему двумя способами:

            * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.fields.title }}`.

                Задайте список полей топика вручную:

                | Имя | Тип | Ключ |
                | :-- | :-- | :--- |
                |`device_id`|`STRING`| Да|
                |`datetime` |`STRING`|  |
                |`latitude` |`DOUBLE`|  |
                |`longitude`|`DOUBLE`|  |
                |`altitude` |`DOUBLE`|  |
                |`speed`    |`DOUBLE`|  |
                |`battery_voltage`| `DOUBLE`||
                |`cabin_temperature`| `UINT16`||
                | `fuel_level`|`UINT16`||

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
                        "type": "string"
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
                        "type": "double"
                    },
                    {
                        "name": "cabin_temperature",
                        "type": "uint16"
                    },
                    {
                        "name": "fuel_level",
                        "type": "uint16"
                    }
                ]
                ```

                {% endcut %}

1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для [приемника `{{ yds-full-name }}`](../../data-transfer/operations/endpoint/target/data-streams.md):

    **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSTarget.connection.title }}**:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}** — выберите базу данных {{ ydb-name }} из списка.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}** — укажите имя потока {{ yds-name }}.

    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}** — выберите или создайте сервисный аккаунт с ролью `yds.editor`.


1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_**, использующий созданные эндпоинты.

            Если в процессе трансфера вы хотите преобразовать данные, укажите в настройках трансфера нужные трансформеры:

            * [{#T}](../../data-transfer/concepts/data-transformation.md#rename-tables)
            * [{#T}](../../data-transfer/concepts/data-transformation.md#columns-filter)
            * [{#T}](../../data-transfer/concepts/data-transformation.md#data-mask)
            * [{#T}](../../data-transfer/concepts/data-transformation.md#subtable-splitting)
            * [{#T}](../../data-transfer/concepts/data-transformation.md#replace-primary-key)
            * [{#T}](../../data-transfer/concepts/data-transformation.md#convert-to-string)
            * [{#T}](../../data-transfer/concepts/data-transformation.md#shard)
            * [{#T}](../../data-transfer/concepts/data-transformation.md#append-only-sources)

        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - {{ TF }} {#tf}

        1. Укажите в файле `data-transfer-mkf-ydb.tf` переменные:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
            * `transfer_enabled` – значение `1` для создания трансфера.

        1. Если в процессе трансфера вы хотите преобразовать данные, добавьте в ресурс `yandex_datatransfer_transfer` блок `transformation` со списком нужных трансформеров:

            ```hcl
            resource "yandex_datatransfer_transfer" "mkf-ydb-transfer" {
              ...
              transformation {
                transformers{
                  <трансформер_1>
                }
                transformers{
                  <трансформер_2>
                }
                ...
                transformers{
                  <трансформер_N>
                }
              }
            }
            ```

            Доступны следующие типы трансформеров:

            * [{#T}](../../data-transfer/concepts/data-transformation.md#rename-tables)
            * [{#T}](../../data-transfer/concepts/data-transformation.md#columns-filter)
            * [{#T}](../../data-transfer/concepts/data-transformation.md#data-mask)
            * [{#T}](../../data-transfer/concepts/data-transformation.md#subtable-splitting)
            * [{#T}](../../data-transfer/concepts/data-transformation.md#replace-primary-key)
            * [{#T}](../../data-transfer/concepts/data-transformation.md#convert-to-string)
            * [{#T}](../../data-transfer/concepts/data-transformation.md#shard)
            * [{#T}](../../data-transfer/concepts/data-transformation.md#append-only-sources)

            Подробнее о настройке трансформеров см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-transfer }}).

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

            Трансфер активируется автоматически после создания.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.
1. Убедитесь, что в поток данных {{ yds-name }} переносятся данные из топика кластера-источника {{ mkf-name }}:

    1. Создайте файл `sample.json` с тестовыми данными:

        ```json
        {
            "device_id": "iv9a94th6rzt********",
            "datetime": "2020-06-05 17:27:00",
            "latitude": 55.70329032,
            "longitude": 37.65472196,
            "altitude": 427.5,
            "speed": 0,
            "battery_voltage": 23.5,
            "cabin_temperature": 17,
            "fuel_level": null
        }

        {
            "device_id": "rhibbh3y08qm********",
            "datetime": "2020-06-06 09:49:54",
            "latitude": 55.71294467,
            "longitude": 37.66542005,
            "altitude": 429.13,
            "speed": 55.5,
            "battery_voltage": null,
            "cabin_temperature": 18,
            "fuel_level": 32
        }

        {
            "device_id": "iv9a94th6r********",
            "datetime": "2020-06-07 15:00:10",
            "latitude": 55.70985913,
            "longitude": 37.62141918,
            "altitude": 417.0,
            "speed": 15.7,
            "battery_voltage": 10.3,
            "cabin_temperature": 17,
            "fuel_level": null
        }
        ```

    1. Отправьте данные из файла `sample.json` в топик `sensors` {{ mkf-name }} с помощью утилит `jq` и `kafkacat`:

        ```bash
        jq -rc . sample.json | kafkacat -P \
           -b <FQDN_хоста-брокера>:9091 \
           -t sensors \
           -k key \
           -X security.protocol=SASL_SSL \
           -X sasl.mechanisms=SCRAM-SHA-512 \
           -X sasl.username="<имя_пользователя_в_кластере-источнике>" \
           -X sasl.password="<пароль_пользователя_в_кластере-источнике>" \
           -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
        ```

        Данные отправляются от имени [созданного пользователя](#prepare-source). Подробнее о настройке SSL-сертификата и работе с `kafkacat` см. в разделе [{#T}](../../managed-kafka/operations/connect/clients.md).

    Проверьте, что в поток данных {{ yds-name }} перенеслись данные из источника:
    
      {% list tabs group=instructions %}
    
      - Консоль управления {#console}
    
          1. В [консоли управления]({{ link-console-main }}) выберите каталог.
          1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
          1. Выберите поток-приемник из списка и перейдите в раздел ![image](../../_assets/console-icons/bars.svg) **{{ ui-key.yacloud.data-streams.label_data-introspection }}**.
          1. Убедитесь, что в сегменте `shard-000000` появились сообщения, содержащие строки таблицы из источника. Чтобы рассмотреть сообщения подробнее, нажмите на значок ![image](../../_assets/console-icons/eye.svg).
    
      - AWS CLI {#cli}
    
          1. [Установите AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
          1. [Настройте окружение](../../data-streams/quickstart/index.md) для {{ yds-name }}.
          1. Прочитайте данные из потока с помощью:
    
              * [AWS CLI](../../data-streams/operations/aws-cli/get-records.md).
              * [AWS SDK](../../data-streams/operations/aws-sdk/get-records.md).
    
      {% endlist %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.


1. Если при создании эндпоинта для приемника вы создавали сервисный аккаунт, [удалите его](../../iam/operations/sa/delete.md).


1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Удалите кластер {{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).
       1. [Удалите базу данных {{ ydb-name }}](../operations/manage-databases.md#delete-db).

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