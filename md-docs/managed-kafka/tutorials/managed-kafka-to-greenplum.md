# Поставка данных в {{ mgp-full-name }} с помощью {{ data-transfer-full-name }}

Вы можете настроить перенос данных из топика {{ mkf-full-name }} в {{ GP }} в сервисе {{ mgp-name }} с помощью {{ data-transfer-full-name }}. Для этого:

1. [Подготовьте тестовые данные](#prepare-data).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mkf-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mkf-name }}](../pricing.md)).
* Кластер {{ mgp-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mgp-name }}](../../managed-greenplum/pricing/index.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин {{ yandex-cloud }}, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

        1. [Создайте кластер-источник {{ mkf-full-name }}](../operations/cluster-create.md#create-cluster) любой подходящей конфигурации c хостами в публичном доступе.

        1. [Создайте в кластере-источнике топик](../operations/cluster-topics.md#create-topic) с именем `sensors`.

        1. [Создайте в кластере-источнике пользователя](../operations/cluster-accounts.md#create-account) с именем `mkf-user` и правами доступа к созданному топику `ACCESS_ROLE_PRODUCER` и `ACCESS_ROLE_CONSUMER`.

        1. [Создайте кластер-приемник {{ GP }}](../../managed-greenplum/operations/cluster-create.md#create-cluster) любой подходящей конфигурации с именем пользователя-администратора `user` и хостами в публичном доступе.

        1. Убедитесь, что группы безопасности кластеров настроены правильно и допускают подключение к ним:
            * [{{ mkf-name }}](../operations/connect/index.md#configuring-security-groups).
            * [{{ mgp-name }}](../../managed-greenplum/operations/connect/index.md#configuring-security-groups).

    - {{ TF }} {#tf}

        1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-greenplum.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-kafka-to-greenplum/blob/main/kafka-greenplum.tf).

            В этом файле описаны:

            * [сети](../../vpc/concepts/network.md#network) и [подсети](../../vpc/concepts/network.md#subnet) для размещения кластеров;
            * [группы безопасности](../../vpc/concepts/security-groups.md) для подключения к кластерам;
            * кластер-источник {{ mkf-name }};
            * кластер-приемник {{ GP }} в сервисе {{ mgp-name }};
            * трансфер.

        1. Укажите в файле `kafka-greenplum.tf` пароли пользователя и версии {{ KF }} и {{ GP }}.
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

1. Установите утилиты:

    * [kafkacat](https://github.com/edenhill/kcat) — для чтения и записи данных в топики {{ KF }}.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Убедитесь, что можете с ее помощью [подключиться к кластеру-источнику {{ mkf-name }} через SSL](../operations/connect/clients.md#bash-zsh).

    * [jq](https://stedolan.github.io/jq/) — для потоковой обработки JSON-файлов.

        ```bash
        sudo apt update && sudo apt-get install --yes jq

## Подготовьте тестовые данные {#prepare-data}

Пусть в качестве сообщения в топик {{ KF }} `sensors` кластера-источника поступают данные от сенсоров автомобиля в формате JSON.

Создайте на рабочей машине файл `sample.json` с тестовыми данными:

{% cut "sample.json" %}

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
```

{% endcut %}

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/kafka.md) типа `{{ KF }}` и задайте для него:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.topic_name.title }}** — `sensors`.
    * Правила конвертации типа `json`. В поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}** выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.json_fields.title }}` и в открывшуюся форму скопируйте следующую спецификацию полей:

    {% cut "sensors-specification" %}

    ```json
    [
        {
            "name": "device_id",
            "type": "utf8",
            "key": true
        },
        {
            "name": "datetime",
            "type": "utf8"
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

1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/greenplum.md) типа `{{ GP }}`, укажите имя пользователя `user`.
1. Создайте и активируйте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-repl }}_, использующий созданные эндпоинты.
        1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус {{ dt-status-repl }}.

    - {{ TF }} {#tf}

        1. Укажите в файле `kafka-greenplum.tf` переменные:

            * `kf_source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `gp_target_endpoint_id` — значение идентификатора эндпоинта для приемника;
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

        1. Трансфер активируется автоматически. Дождитесь его перехода в статус {{ dt-status-repl }}.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

Убедитесь, что в базу данных {{ GP }} переносятся данные из топика кластера-источника {{ mkf-name }}:

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

    Подробнее о настройке SSL-сертификата и работе с `kafkacat` в разделе [{#T}](../operations/connect/clients.md).

1. Убедитесь, что в базу данных {{ GP }} перенеслись данные из кластера-источника {{ mkf-name }}:

    1. [Подключитесь к базе данных {{ GP }}](../../managed-greenplum/operations/connect/index.md).
    1. Проверьте, что база данных содержит таблицу `sensors` с тестовыми данными из топика:

        ```sql
        SELECT * FROM public.sensors;
        ```

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. Убедитесь, что трансфер находится в статусе {{ dt-status-finished }} и [удалите](../../data-transfer/operations/transfer.md#delete) его.
1. [Удалите эндпоинт-источник и эндпоинт-приемник](../../data-transfer/operations/endpoint/index.md#delete).
1. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Удалите кластер {{ mkf-name }}](../operations/cluster-delete.md).
        1. [Удалите кластер {{ mgp-name }}](../../managed-greenplum/operations/cluster-delete.md).

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
```