# Перенос данных между кластерами Managed Service for Apache Kafka® с помощью Yandex Data Transfer


# Миграция данных между кластерами Apache Kafka® с помощью Yandex Data Transfer


Данные из топиков Apache Kafka® можно переносить из одного кластера Apache Kafka® в другой в реальном времени. В том числе поддерживаются следующие виды миграции:

* Между разными версиями Apache Kafka® — например, можно перенести топики из версии 2.8 в версию 3.1.
* Между разными зонами доступности — можно [перенести кластер с одним хостом](../operations/host-migration.md#one-host) из одной зоны в другую.

Зеркалирование кластеров Apache Kafka® позволяет:

* выполнить настройку репликации топиков в интерфейсе Консоли управления или в Terraform;
* следить за процессом переноса с помощью [мониторинга трансфера](../../data-transfer/operations/monitoring.md);
* обойтись без создания промежуточной [виртуальной машины](../../glossary/vm.md) или разрешения доступа к вашему кластеру-приемнику из интернета.

{% note info %}

В данном практическом руководстве описан сценарий миграции данных между кластерами Managed Service for Apache Kafka®.

{% endnote %}

Чтобы запустить перенос данных:

1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластеры Managed Service for Apache Kafka®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы Managed Service for Apache Kafka®](../pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы Data Transfer](../../data-transfer/pricing.md)).


## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру поставки данных:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Создайте кластер-источник и кластер-приемник Managed Service for Apache Kafka®](../operations/cluster-create.md) любой подходящей конфигурации с публичным доступом из интернета.

            {% note info %}
            
            Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
            
            {% endnote %}

       1. [Создайте в кластере-источнике топик](../operations/cluster-topics.md#create-topic) с именем `sensors`.
       1. [Создайте в кластере-источнике пользователя](../operations/cluster-accounts.md#create-account) с правами доступа `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_CONSUMER` к созданному топику.
       1. [Создайте в кластере-приемнике пользователя](../operations/cluster-accounts.md#create-account) с правами доступа `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_CONSUMER` ко всем топикам.

   - Terraform {#tf}

       1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
       1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
       1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
       1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

       1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mkf-mkf.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-mirror-managed-kafka/blob/main/data-transfer-mkf-mkf.tf).

           В этом файле описаны:

           * [сеть](../../vpc/concepts/network.md#network);
           * [подсеть](../../vpc/concepts/network.md#subnet);
           * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру Managed Service for Apache Kafka®;
           * кластер-источник Managed Service for Apache Kafka® с публичным доступом из интернета;
           * топик Apache Kafka® для кластера-источника;
           * пользователь Apache Kafka® для кластера-источника;
           * кластер-приемник Managed Service for Apache Kafka®;
           * топик Apache Kafka® для кластера-приемника;
           * пользователь Apache Kafka® для кластера-приемника;
           * трансфер.

       1. Укажите в файле `data-transfer-mkf-mkf.tf` значения параметров:

           * `source_kf_version` — версия Apache Kafka® в кластере-источнике;
           * `source_user_name` — имя пользователя для подключения к топику Apache Kafka®;
           * `source_user_password` — пароль пользователя;
           * `target_kf_version` — версия Apache Kafka® в кластере-приемнике;
           * `transfer_enabled` — значение `0`, чтобы не создавать трансфер до [создания эндпоинта-приемника и эндпоинта-источника вручную](#prepare-transfer).

       1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

           ```bash
           terraform validate
           ```

           Если в файлах конфигурации есть ошибки, Terraform на них укажет.

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

           В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

   {% endlist %}

   В созданный топик Apache Kafka® `sensors` кластера-источника будут поступать тестовые данные от сенсоров автомобиля в формате JSON, например:

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

    - [kafkacat](https://github.com/edenhill/kcat) — для чтения и записи данных в топики Apache Kafka®.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Убедитесь, что можете с ее помощью [подключиться к кластеру-источнику Managed Service for Apache Kafka® через SSL](../operations/connect/clients.md#bash-zsh).

    - [jq](https://stedolan.github.io/jq/) — для потоковой обработки JSON-файлов.

        ```bash
        sudo apt update && sudo apt-get install --yes jq
        ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

    * **Тип базы данных** — `Kafka`.
    * **Параметры эндпоинта**:

       * **Настройки подключения** — `Кластер Managed Service for Apache Kafka`.

          Выберите кластер-приемник из списка и укажите настройки подключения к нему.

       * **Топик**:
          * **Полное имя топика** — `measurements`.

1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

    * **Тип базы данных** — `Kafka`.
    * **Параметры эндпоинта**:
       * **Тип подключения** — `Кластер Managed Service for Apache Kafka`.

          Выберите кластер-источник из списка и укажите настройки подключения к нему.

       * **Полное имя топика** — `sensors`.

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **Репликация**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - Terraform {#tf}

        1. Укажите в файле `data-transfer-mkf-mkf.tf` значения параметров:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
            * `transfer_enabled` – значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, Terraform на них укажет.

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

1. Дождитесь перехода трансфера в статус **Реплицируется**.
1. Убедитесь, что в топик кластера-приемника переносятся данные из топика кластера-источника Managed Service for Apache Kafka®:

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

    1. Отправьте данные из файла `sample.json` в топик `sensors` кластера-источника Managed Service for Apache Kafka® с помощью утилит `jq` и `kafkacat`:

        ```bash
        jq -rc . sample.json | kafkacat -P \
           -b <FQDN_брокера_в_кластере-источнике>:9091 \
           -t sensors \
           -k key \
           -X security.protocol=SASL_SSL \
           -X sasl.mechanisms=SCRAM-SHA-512 \
           -X sasl.username="<имя_пользователя_в_кластере-источнике>" \
           -X sasl.password="<пароль_пользователя_в_кластере-источнике>" \
           -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt -Z
        ```

        Данные отправляются от имени [созданного пользователя](#prepare-source). Подробнее о настройке SSL-сертификата и работе с `kafkacat` см. в разделе [Подключение к кластеру Apache Kafka® из приложений](../operations/connect/clients.md).

    1. Убедитесь, что в кластер-приемник Managed Service for Apache Kafka® перенеслись данные из кластера-источника, с помощью утилиты `kafkacat`:

        ```bash
        kafkacat -C \
                 -b <FQDN_брокера_в_кластере-приемнике>:9091 \
                 -t measurements \
                 -X security.protocol=SASL_SSL \
                 -X sasl.mechanisms=SCRAM-SHA-512 \
                 -X sasl.username="<имя_пользователя_в_кластере-приемнике>" \
                 -X sasl.password="<пароль_пользователя_в_кластере-приемнике>" \
                 -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt -Z -K:
        ```

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete-transfer).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       [Удалите кластеры Managed Service for Apache Kafka®](../operations/cluster-delete.md).

   - Terraform {#tf}

       1. В терминале перейдите в директорию с планом инфраструктуры.
       
           {% note warning %}
       
           Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
       
           {% endnote %}
       
       1. Удалите ресурсы:
       
           1. Выполните команду:
       
               ```bash
               terraform destroy
               ```
       
           1. Подтвердите удаление ресурсов и дождитесь завершения операции.
       
           Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

   {% endlist %}