# Синхронизация данных из топиков {{ KF }} в бакет {{ objstorage-full-name }} без использования интернета



{% note info %}

Функциональность сервисных подключений (VPC Private Endpoints) в {{ vpc-full-name }} находится на стадии [Preview](../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь к вашему аккаунт-менеджеру.

{% endnote %}


Вы можете синхронизировать данные из топиков {{ KF }} в бакет {{ objstorage-full-name }} без использования интернета с помощью сервисного подключения в пользовательской сети, где располагается кластер {{ mkf-name }}. Для этого:

1. [Отправьте данные в топик](#send-data).
1. [Убедитесь в недоступности бакета из внешней сети](#check-bucket-access).
1. [Проверьте наличие данных в бакете](#check-bucket-data).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за бакет {{ objstorage-name }}: хранение данных и выполнение операций с ними (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).
* Плата за кластер {{ mkf-name }}: использование выделенных хостам вычислительных ресурсов и дискового пространства (см. [тарифы {{ mkf-name }}](../../managed-kafka/pricing.md)).
* Плата за использование публичных IP-адресов для хостов кластера (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}


1. Подготовьте инфраструктуру:

    {% list tabs group=resources %}

    - Вручную {#manual}

        1. [Создайте сеть](../../vpc/operations/network-create.md) с именем `my-private-network`. При создании выключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
        1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в любой зоне доступности.
        1. [Создайте сервисное подключение к {{ objstorage-name }}](../../vpc/operations/private-endpoint-create.md) в сети `my-private-network` и запишите его идентификатор.
        1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с именем `storage-pe-admin` и ролью `storage.admin`. Кластер {{ mkf-name }} будет использовать его для доступа к бакету.
        1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта `storage-pe-admin`.
        1. [Создайте бакет {{ objstorage-full-name }}](../../storage/operations/buckets/create.md) и задайте для него политику доступа:

            * **Результат** — `Разрешить`.
            * **Действие** — `Все действия`.
            * **Ресурс** — `<имя_бакета>` и `<имя_бакета>/*`.
            * **Условие** — выберите из списка ключ `yc:private-endpoint-id` и укажите для его значения идентификатор созданного сервисного подключения.

        1. [Создайте кластер {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) любой подходящей [конфигурации](../../managed-kafka/concepts/instance-types.md) со следующими настройками:

            * Один хост-брокер.
            * Публичный доступ к хостам кластера.
            * Сеть `my-private-network`.

        
        1. Если вы используете группы безопасности в кластере, убедитесь, что они [настроены правильно](../../managed-kafka/operations/connect/index.md#configuring-security-groups) и допускают подключение к нему.


        1. [Создайте в кластере топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `my-private-topic`.
        1. [Создайте в кластере пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `mkf-user` и правом доступа `ACCESS_ROLE_PRODUCER` к созданному топику.
        1. [Создайте в кластере коннектор](../../managed-kafka/operations/cluster-connector.md#create) со следующими настройками:

            * В блоке **{{ ui-key.yacloud.kafka.section_properties }}** укажите свойства коннектора:
               * `key.converter`: `org.apache.kafka.connect.storage.StringConverter`
               * `value.converter`: `org.apache.kafka.connect.converters.ByteArrayConverter`
               * `format.output.fields.value.encoding`: `none`
            * Выберите тип коннектора **S3 Sink**.
            * В поле **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}** укажите `my-private-topic`.
            * В блоке **{{ ui-key.yacloud.kafka.field_connector-s3-connection }}** укажите параметры:
               * **{{ ui-key.yacloud.kafka.field_connector-bucket-name }}** — созданный ранее бакет.
               * **{{ ui-key.yacloud.kafka.field_connector-endpoint }}** — `storage.pe.yandexcloud.net`.
               * **{{ ui-key.yacloud.kafka.field_connector-access-key-id }}**, **{{ ui-key.yacloud.kafka.field_connector-secret-access-key }}** — идентификатор и секретный ключ созданного ранее статического ключа доступа.

        1. [Создайте ВМ](../../compute/operations/vm-create/create-linux-vm.md) с публичным IP-адресом в созданной сети `my-private-network` для подключения к бакету.

    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-objstorage-sync-private-network.tf](https://github.com/yandex-cloud-examples/yc-sync-kafka-to-s3-private-endpoint/blob/main/kafka-objstorage-sync-private-network.tf).

            В этом файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [сервисное подключение](../../vpc/concepts/private-endpoint.md);
            * [группа безопасности](../../vpc/concepts/security-groups.md), необходимая для подключения к кластеру;
            * сервисный аккаунт, который будет использоваться для создания бакета и доступа к нему;
            * бакет {{ objstorage-name }};
            * кластер {{ mkf-name }};
            * топик {{ KF }};
            * пользователь {{ KF }};
            * коннектор {{ KF }};
            * ВМ для чтения данных из бакета.

        1. Укажите в файле `kafka-objstorage-sync-private-network.tf`:

            * `tf_account_name` — имя сервисного аккаунта, такое же, как в настройках провайдера.
            * `bucket_name` — имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
            * `mkf_version` — версия {{ KF }};
            * `mkf_user_password` — пароль пользователя {{ KF }}.
            * `vm_image_id` — идентификатор публичного [образа](../../compute/operations/images-with-pre-installed-software/get-list) ВМ.
            * `vm_username` и `vm_ssh_key` – логин и абсолютный путь к [публичному ключу](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys), которые будут использоваться для доступа к ВМ.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. Убедитесь, что в сервисе {{ dns-full-name }} появилась запись `*.storage.pe.yandexcloud.net` в [сервисной зоне](../../dns/concepts/dns-zone.md#service-zones) `.` созданной сети.
1. Установите утилиту [kafkacat](https://github.com/edenhill/kcat) для записи данных в топик {{ KF }}.

    ```bash
    sudo apt update && sudo apt install --yes kafkacat
    ```

    Убедитесь, что можете с ее помощью [подключиться к созданному ранее кластеру {{ mkf-name }} через SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

## Отправьте данные в топик {#send-data}

1. Отправьте тестовые данные в топик `my-private-topic` с помощью утилиты `kafkacat`:

   ```bash
   for i in $(echo {1..50})
       do
          echo "test message_"$i | kafkacat -P \
             -b <FQDN_хоста-брокера>:9091 \
             -t my-private-topic \
             -k key \
             -X security.protocol=SASL_SSL \
             -X sasl.username="<имя_пользователя_в_кластере-источнике>" \
             -X sasl.password="<пароль_пользователя_в_кластере-источнике>" \
             -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
       done
   ```

1. Убедитесь в репликации данных в бакет. Для этого [откройте статистику загрузок бакета](../../storage/operations/buckets/get-stats.md#storage-ui) и проверьте наличие запросов на графике **Modify Requests**.

## Убедитесь в недоступности бакета из внешней сети {#check-bucket-access}

1. {% include [aws-cli-install](../../_includes/aws-cli-install.md) %}
1. Выполните команду для получения списка объектов бакета по адресу в публичной сети:

   ```bash
   aws s3 ls s3://<имя_бакета> \
       --endpoint-url=https://storage.yandexcloud.net \
       --recursive
   ```

   Результат:

   ```text
   An error occurred (AccessDenied) when calling the ListObjectsV2 operation: Access Denied
   ```

1. Выполните команду для получения списка объектов бакета по адресу в приватной сети:

   ```bash
   aws s3 ls s3://<имя_бакета> \
       --endpoint-url=https://storage.pe.yandexcloud.net \
       --recursive
   ```

   Результат:

   ```text
   Could not connect to the endpoint URL: "https://storage.pe.yandexcloud.net/<имя_бакета>?list-type=2&prefix=&encoding-type=url"
   ```

## Проверьте наличие данных в бакете по сервисному подключению {#check-bucket-data}

[Подключитесь по SSH](../../compute/operations/vm-connect/ssh.md) к созданной ранее ВМ и выполните следующие действия:

1. [Установите и сконфигурируйте интерфейс командной строки AWS CLI](../../storage/tools/aws-cli.md).
1. Выполните команду для получения списка объектов бакета по адресу в приватной сети:

    ```bash
    aws s3 ls s3://<имя_бакета> \
        --endpoint-url=https://storage.pe.yandexcloud.net \
        --recursive
    ```

    Результат:

    ```text
    2025-08-01 14:38:23         20 my-private-topic-1-0
    2025-08-01 14:38:23        587 my-private-topic-1-1
    2025-08-01 14:38:24        440 my-private-topic-1-29
    ```

Такой результат означает, что данные из топика {{ KF }} успешно синхронизированы через сервисное подключение.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=resources %}

- Вручную {#manual}

    * [Удалите кластер {{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).
    * [Удалите бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md). Перед удалением бакета [удалите](../../storage/operations/objects/delete.md) все объекты из него.
    * [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md)

- {{ TF }} {#tf}

    Предварительно [удалите](../../storage/operations/objects/delete.md) все объекты из [созданного ранее](#before-you-begin) бакета.

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
