# Перенос данных между кластерами {{ mkf-full-name }} с помощью {{ data-transfer-full-name }}

Данные из топиков {{ KF }} можно переносить из одного кластера {{ mkf-name }} в другой в реальном времени . В том числе, поддерживается миграция между разными версиями: например, можно перенести топики из {{ KF }} версии 2.8 в версию 3.1.

Этот способ переноса данных позволяет:

* выполнить настройку репликации топиков в интерфейсе Консоли управления или в Terraform;
* следить за процессом переноса с помощью [мониторинга трансфера](../../data-transfer/operations/monitoring.md);
* обойтись без создания промежуточной [виртуальной машины](../../glossary/vm.md) или разрешения доступа к вашему кластеру-приемнику {{ mkf-name }} из интернета.

Чтобы запустить перенос данных:

1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру поставки данных:

   {% list tabs %}

   * Вручную

       1. [Создайте кластер-источник и кластер-приемник {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации с публичным доступом из интернета.
       1. [Создайте в кластере-источнике топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `sensors`.
       1. [Создайте в кластере-источнике пользователя](../../managed-kafka/operations/cluster-accounts.md#create-user) с правами доступа `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_CONSUMER` к созданному топику.
       1. [Создайте в кластере-приемнике пользователя](../../managed-kafka/operations/cluster-accounts.md#create-user) с правами доступа `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_CONSUMER` ко всем топикам.

   * С помощью {{ TF }}

       1. Если у вас еще нет {{ TF }}, [установите и настройте его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
       1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
       1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mkf-mkf.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-mkf-mkf.tf).

           В этом файле описаны:

           * [сеть](../../vpc/concepts/network.md#network);
           * [подсеть](../../vpc/concepts/network.md#subnet);
           * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру {{ mkf-name }};
           * кластер-источник {{ mkf-name }} с публичным доступом из интернета;
           * кластер-приемник {{ mkf-name }};
           * топик {{ KF }};
           * трансфер.

       1. Укажите в файле `data-transfer-mkf-mkf.tf` значения параметров:

           * `source_kf_version` – версия {{ KF }} в кластере-источнике;
           * `source_user_name` – имя пользователя для подключения к топику {{ KF }};
           * `source_user_password` – пароль пользователя;
           * `target_kf_version` – версия {{ KF }} в кластере-приемнике;
           * `transfer_enabled` – значение `0`, чтобы не создавать трансфер до [создания эндпоинта-приемника и эндпоинта-источника вручную](#prepare-transfer).

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

   В созданный топик {{ KF }} `sensors` кластера-источника будут поступать тестовые данные от сенсоров автомобиля в формате JSON, например:

   ```json
   {
       "device_id":"iv9a94th6rztooxh5ur2",
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

        Убедитесь, что можете с ее помощью [подключиться к кластеру-источнику {{ mkf-name }} через SSL](../../managed-kafka/operations/connect.md#connection-string).

    - [jq](https://stedolan.github.io/jq/) — для потоковой обработки JSON-файлов.

        ```bash
        sudo apt update && sudo apt-get install --yes jq
        ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

    * **Тип базы данных** — `{{ KF }}`.
    * **Параметры эндпоинта**:

       * **Настройки подключения** — `Кластер {{ mkf-name }}`.

          Выберите кластер-приемник из списка и укажите настройки подключения к нему.

       * **Настройки топика Apache Kafka**.
          * **Полное имя топика** — `measurements`.

1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

    * **Тип базы данных** — `{{ KF }}`.
    * **Параметры эндпоинта**:
       * **Настройки подключения** — `Кластер {{ mkf-name }}`.

          Выберите кластер-источник из списка и укажите настройки подключения к нему.

       * **Полное имя топика** — `sensors`.

1. Создайте трансфер:

    {% list tabs %}

    * Вручную

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа {{ dt-type-repl }}, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    * С помощью {{ TF }}

        1. Укажите в файле `data-transfer-mkf-mkf.tf` значения параметров:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
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
1. Убедитесь, что в топик кластера-приемника переносятся данные из топика кластера-источника {{ mkf-name }}:

    1. Создайте файл `sample.json` с тестовыми данными:

        ```json
        {
            "device_id": "iv9a94th6rztooxh5ur2",
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
            "device_id": "rhibbh3y08qmz3sdbrbu",
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
            "device_id": "iv9a94th6rztooxh5ur2",
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

    1. Отправьте данные из файла `sample.json` в топик `sensors` кластера-источника {{ mkf-name }} с помощью утилит `jq` и `kafkacat`:

        ```bash
        jq -rc . sample.json | kafkacat -P \
           -b <FQDN брокера в кластере-источнике>:9091 \
           -t sensors \
           -k key \
           -X security.protocol=SASL_SSL \
           -X sasl.mechanisms=SCRAM-SHA-512 \
           -X sasl.username="<имя пользователя в кластере-источнике>" \
           -X sasl.password="<пароль пользователя в кластере-источнике>" \
           -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
        ```

        Данные отправляются от имени [созданного пользователя](#prepare-source). Подробнее о настройке SSL-сертификата и работе с `kafkacat` см. в разделе [{#T}](../../managed-kafka/operations/connect.md).

    1. Убедитесь, что в кластер-приемник {{ mkf-name }} перенеслись данные из кластера-источника, с помощью утилиты `kafkacat`:

        ```bash
        kafkacat -C \
                 -b <FQDN брокера в кластере-приемнике>:9091 \
                 -t measurements \
                 -X security.protocol=SASL_SSL \
                 -X sasl.mechanisms=SCRAM-SHA-512 \
                 -X sasl.username="<имя пользователя в кластере-приемнике>" \
                 -X sasl.password="<пароль пользователя в кластере-приемнике>" \
                 -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z -K:
        ```

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Если созданные ресурсы вам больше не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete-transfer).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs %}

* Вручную

    [Удалите кластеры {{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).

* С помощью {{ TF }}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `data-transfer-mkf-mkf.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `data-transfer-mkf-mkf.tf`, будут удалены.

{% endlist %}
