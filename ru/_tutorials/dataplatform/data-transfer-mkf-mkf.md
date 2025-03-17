# Миграция данных между кластерами {{ KF }} с помощью {{ data-transfer-full-name }}


Данные из топиков {{ KF }} можно переносить из одного кластера {{ KF }} в другой в реальном времени. В том числе поддерживаются следующие виды миграции:

* Между разными версиями {{ KF }} — например, можно перенести топики из версии 2.8 в версию 3.1.
* Между разными зонами доступности — можно [перенести кластер с одним хостом](../../managed-kafka/operations/host-migration.md#one-host) из одной зоны в другую.

Зеркалирование кластеров {{ KF }} позволяет:

* выполнить настройку репликации топиков в интерфейсе Консоли управления или в {{ TF }};
* следить за процессом переноса с помощью [мониторинга трансфера](../../data-transfer/operations/monitoring.md);
* обойтись без создания промежуточной [виртуальной машины](../../glossary/vm.md) или разрешения доступа к вашему кластеру-приемнику из интернета.

{% note info %}

В данном практическом руководстве описан сценарий миграции данных между кластерами {{ mkf-name }}.

{% endnote %}

Чтобы запустить перенос данных:

1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за каждый кластер {{ KF }}: использование вычислительных ресурсов, выделенных хостам (в том числе хостам ZooKeeper), и дискового пространства (см. [тарифы {{ KF }}](../../managed-kafka/pricing.md)).
* Плата за использование публичных IP-адресов для хостов кластеров (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Плата за трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы {{ data-transfer-name }}](../../data-transfer/pricing.md)).


## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру поставки данных:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Создайте кластер-источник и кластер-приемник {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации с публичным доступом из интернета.
       1. [Создайте в кластере-источнике топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `sensors`.
       1. [Создайте в кластере-источнике пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с правами доступа `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_CONSUMER` к созданному топику.
       1. [Создайте в кластере-приемнике пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с правами доступа `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_CONSUMER` ко всем топикам.

   - {{ TF }} {#tf}

       1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
       1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
       1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
       1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

       1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mkf-mkf.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-mirror-managed-kafka/blob/main/data-transfer-mkf-mkf.tf).

           В этом файле описаны:

           * [сеть](../../vpc/concepts/network.md#network);
           * [подсеть](../../vpc/concepts/network.md#subnet);
           * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру {{ mkf-name }};
           * кластер-источник {{ mkf-name }} с публичным доступом из интернета;
           * топик {{ KF }} для кластера-источника;
           * пользователь {{ KF }} для кластера-источника;
           * кластер-приемник {{ mkf-name }};
           * топик {{ KF }} для кластера-приемника;
           * пользователь {{ KF }} для кластера-приемника;
           * трансфер.

       1. Укажите в файле `data-transfer-mkf-mkf.tf` значения параметров:

           * `source_kf_version` — версия {{ KF }} в кластере-источнике;
           * `source_user_name` — имя пользователя для подключения к топику {{ KF }};
           * `source_user_password` — пароль пользователя;
           * `target_kf_version` — версия {{ KF }} в кластере-приемнике;
           * `transfer_enabled` — значение `0`, чтобы не создавать трансфер до [создания эндпоинта-приемника и эндпоинта-источника вручную](#prepare-transfer).

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

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `Kafka`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTarget.title }}**:

       * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTarget.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`.

          Выберите кластер-приемник из списка и укажите настройки подключения к нему.

       * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**:
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}** — `measurements`.

1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `Kafka`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSource.title }}**:
       * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`.

          Выберите кластер-источник из списка и укажите настройки подключения к нему.

       * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.topic_name.title }}** — `sensors`.

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа {{ dt-type-repl }}, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - {{ TF }} {#tf}

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
            "device_id": "iv9a94th6rzt********",
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
           -b <FQDN_брокера_в_кластере-источнике>:9091 \
           -t sensors \
           -k key \
           -X security.protocol=SASL_SSL \
           -X sasl.mechanisms=SCRAM-SHA-512 \
           -X sasl.username="<имя_пользователя_в_кластере-источнике>" \
           -X sasl.password="<пароль_пользователя_в_кластере-источнике>" \
           -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
        ```

        Данные отправляются от имени [созданного пользователя](#prepare-source). Подробнее о настройке SSL-сертификата и работе с `kafkacat` см. в разделе [{#T}](../../managed-kafka/operations/connect/clients.md).

    1. Убедитесь, что в кластер-приемник {{ mkf-name }} перенеслись данные из кластера-источника, с помощью утилиты `kafkacat`:

        ```bash
        kafkacat -C \
                 -b <FQDN_брокера_в_кластере-приемнике>:9091 \
                 -t measurements \
                 -X security.protocol=SASL_SSL \
                 -X sasl.mechanisms=SCRAM-SHA-512 \
                 -X sasl.username="<имя_пользователя_в_кластере-приемнике>" \
                 -X sasl.password="<пароль_пользователя_в_кластере-приемнике>" \
                 -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z -K:
        ```

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete-transfer).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs group=instructions %}

- Вручную {#manual}

    [Удалите кластеры {{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
