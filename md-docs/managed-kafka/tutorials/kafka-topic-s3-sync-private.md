# Синхронизация данных из топиков Apache Kafka® в бакет Object Storage без использования интернета

# Синхронизация данных из топиков Apache Kafka® в бакет Yandex Object Storage без использования интернета


Вы можете синхронизировать данные из топиков Apache Kafka® в бакет Yandex Object Storage без использования интернета с помощью сервисного подключения в пользовательской сети, где располагается кластер Managed Service for Apache Kafka®. Для этого:

1. [Отправьте данные в топик](#send-data).
1. [Убедитесь в недоступности бакета из внешней сети](#check-bucket-access).
1. [Проверьте наличие данных в бакете](#check-bucket-data).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за бакет Object Storage: хранение данных и выполнение операций с ними ([тарифы Object Storage](../../storage/pricing.md)).
* Плата за кластер Managed Service for Apache Kafka®: использование выделенных хостам вычислительных ресурсов и дискового пространства ([тарифы Managed Service for Apache Kafka®](../../managed-kafka/pricing.md)).
* Плата за использование публичных IP-адресов для хостов кластера ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}


1. Подготовьте инфраструктуру:

    {% list tabs group=resources %}

    - Вручную {#manual}

        1. [Создайте сеть](../../vpc/operations/network-create.md) с именем `my-private-network`. При создании выключите опцию **Создать подсети**.
        1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в любой зоне доступности.
        1. [Создайте сервисное подключение к Object Storage](../../vpc/operations/private-endpoint-create.md) в сети `my-private-network` и запишите его идентификатор.
        1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с именем `storage-pe-admin` и ролью `storage.admin`. Кластер Managed Service for Apache Kafka® будет использовать его для доступа к бакету.
        1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта `storage-pe-admin`.
        1. [Создайте бакет Yandex Object Storage](../../storage/operations/buckets/create.md) и задайте для него политику доступа:

            * **Результат** — `Разрешить`.
            * **Действие** — `Все действия`.
            * **Ресурс** — `<имя_бакета>` и `<имя_бакета>/*`.
            * **Условие** — выберите из списка ключ `yc:private-endpoint-id` и укажите для его значения идентификатор созданного сервисного подключения.

        1. [Создайте кластер Managed Service for Apache Kafka®](../operations/cluster-create.md) любой подходящей [конфигурации](../concepts/instance-types.md) со следующими настройками:

            * Сеть `my-private-network`.
            * Один хост-брокер.
            * Публичный доступ к хостам кластера.

                {% note info %}
                
                Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
                
                {% endnote %}

        
        1. Если вы используете группы безопасности в кластере, убедитесь, что они [настроены правильно](../operations/connect/index.md#configuring-security-groups) и допускают подключение к нему.


        1. [Создайте в кластере топик](../operations/cluster-topics.md#create-topic) с именем `my-private-topic`.
        1. [Создайте в кластере пользователя](../operations/cluster-accounts.md#create-account) с именем `mkf-user` и правом доступа `ACCESS_ROLE_PRODUCER` к созданному топику.
        1. [Создайте в кластере коннектор](../operations/cluster-connector.md#create) со следующими настройками:

            * В блоке **Дополнительные свойства** укажите свойства коннектора:
               * `key.converter`: `org.apache.kafka.connect.storage.StringConverter`
               * `value.converter`: `org.apache.kafka.connect.converters.ByteArrayConverter`
               * `format.output.fields.value.encoding`: `none`
            * Выберите тип коннектора **S3 Sink**.
            * В поле **Топики** укажите `my-private-topic`.
            * В блоке **Подключение к S3** укажите параметры:
               * **Имя бакета** — созданный ранее бакет.
               * **Эндпоинт** — `storage.pe.yandexcloud.net`.
               * **Идентификатор ключа доступа**, **Секретный ключ** — идентификатор и секретный ключ созданного ранее статического ключа доступа.

        1. [Создайте ВМ](../../compute/operations/vm-create/create-linux-vm.md) с публичным IP-адресом в созданной сети `my-private-network` для подключения к бакету.

    - Terraform {#tf}

        1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-objstorage-sync-private-network.tf](https://github.com/yandex-cloud-examples/yc-sync-kafka-to-s3-private-endpoint/blob/main/kafka-objstorage-sync-private-network.tf).

            В этом файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [сервисное подключение](../../vpc/concepts/private-endpoint.md);
            * [группа безопасности](../../vpc/concepts/security-groups.md), необходимая для подключения к кластеру;
            * сервисный аккаунт, который будет использоваться для создания бакета и доступа к нему;
            * бакет Object Storage;
            * кластер Managed Service for Apache Kafka®;
            * топик Apache Kafka®;
            * пользователь Apache Kafka®;
            * коннектор Apache Kafka®;
            * ВМ для чтения данных из бакета.

        1. Укажите в файле `kafka-objstorage-sync-private-network.tf`:

            * `tf_account_name` — имя сервисного аккаунта, такое же, как в настройках провайдера.
            * `bucket_name` — имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
            * `mkf_version` — версия Apache Kafka®;
            * `mkf_user_password` — пароль пользователя Apache Kafka®.
            * `vm_image_id` — идентификатор публичного [образа](../../compute/operations/images-with-pre-installed-software/get-list.md) ВМ.
            * `vm_username` и `vm_ssh_key` – логин и абсолютный путь к [публичному ключу](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys), которые будут использоваться для доступа к ВМ.

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

1. Убедитесь, что в сервисе Yandex Cloud DNS появилась запись `*.storage.pe.yandexcloud.net` в [сервисной зоне](../../dns/concepts/dns-zone.md#service-zones) `.` созданной сети.
1. Установите утилиту [kafkacat](https://github.com/edenhill/kcat) для записи данных в топик Apache Kafka®.

    ```bash
    sudo apt update && sudo apt install --yes kafkacat
    ```

    Убедитесь, что можете с ее помощью [подключиться к созданному ранее кластеру Managed Service for Apache Kafka® через SSL](../operations/connect/clients.md#bash-zsh).

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
             -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt -Z
       done
   ```

1. Убедитесь в репликации данных в бакет. Для этого [откройте статистику загрузок бакета](../../storage/operations/buckets/get-stats.md#storage-ui) и проверьте наличие запросов на графике **Modify Requests**.

## Убедитесь в недоступности бакета из внешней сети {#check-bucket-access}

1. Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).
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

Такой результат означает, что данные из топика Apache Kafka® успешно синхронизированы через сервисное подключение.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=resources %}

- Вручную {#manual}

    * [Удалите кластер Managed Service for Apache Kafka®](../operations/cluster-delete.md).
    * [Удалите бакет Object Storage](../../storage/operations/buckets/delete.md). Перед удалением бакета [удалите](../../storage/operations/objects/delete.md) все объекты из него.
    * [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md)

- Terraform {#tf}

    Предварительно [удалите](../../storage/operations/objects/delete.md) все объекты из [созданного ранее](#before-you-begin) бакета.

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