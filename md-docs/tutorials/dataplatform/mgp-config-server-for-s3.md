# Создание внешней таблицы на базе таблицы из бакета Yandex Object Storage с помощью конфигурационного файла

При [создании внешней таблицы](../../managed-greenplum/operations/pxf/create-table.md) из таблицы, расположенной в бакете Yandex Object Storage, необходимо передать в запросе [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для сервисного аккаунта. Это можно сделать с помощью [протокола S3](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/admin_guide-external-g-s3-protocol.html) и конфигурационного файла, хранящегося на HTTP-сервере.

Чтобы создать внешнюю таблицу с помощью конфигурационного файла:

1. [Настройте веб-сервер с файлом конфигурации](#set-web-server).
1. [Создайте внешнюю таблицу](#create-ext-table).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Yandex MPP Analytics for PostgreSQL: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Yandex MPP Analytics for PostgreSQL](../../managed-greenplum/pricing/index.md)).
* NAT-шлюз: почасовое использование шлюза и исходящий через него трафик ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).
* Бакет Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).
* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы ([тарифы Yandex Compute Cloud](../../compute/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер](../../managed-greenplum/operations/cluster-create.md) Greenplum® любой подходящей конфигурации.

    
    1. В подсети кластера [настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) и [создайте группу безопасности](../../vpc/operations/security-group-create.md), разрешающую весь входящий и исходящий трафик со всех адресов.

    1. [Создайте виртуальную машину с Linux](../../compute/operations/vm-create/create-linux-vm.md) в той же облачной подсети, в которой расположен кластер Greenplum®.


    1. [Создайте бакет в Object Storage](../../storage/operations/buckets/create.md) с ограниченным доступом. [Загрузите](../../storage/operations/objects/upload.md) в него файл `example.csv`, содержащий тестовую таблицу:

        ```csv
        10,2010
        ```

    
    1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта.



- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Создайте в рабочей директории файл `example.csv`, содержащий тестовую таблицу:

        ```csv
        10,2010
        ```

    1. Скачайте в ту же рабочую директорию [файл конфигурации инфраструктуры](https://github.com/yandex-cloud-examples/yc-greenplum-config-server-for-s3/blob/main/greenplum-s3-vm.tf).

        В этом файле описаны:

        * сеть;
        * подсеть;
        * сервисный аккаунт со статическим ключом доступа;
        * кластер Greenplum® в сервисе Yandex MPP Analytics for PostgreSQL;
        * бакет, в который будет помещен файл `example.csv`;
        * виртуальная машина с [Ubuntu 20.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts).

    1. Укажите в файле `greenplum-s3-vm.tf`:

        * Пароль пользователя `user`, который будет использоваться для доступа к кластеру Greenplum®.
        * Идентификатор образа виртуальной машины.
        * Имя пользователя и путь к [SSH-ключу](../../glossary/ssh-keygen.md) для доступа к виртуальной машине.
        * Идентификатор каталога для сервисного аккаунта, такой же как в настройках провайдера.
        * Имя бакета, которое должно быть уникальным во всем Object Storage.

    1. В терминале перейдите в директорию с планом инфраструктуры.

    1. Для проверки правильности файлов конфигурации выполните команду:

       ```bash
       terraform validate
       ```

       Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Создайте инфраструктуру, необходимую для выполнения инструкций из этого руководства:

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

    1. Чтобы получить параметры статического ключа, в рабочей директории выполните команду:

        ```bash
        terraform output -raw access_key > static-key.txt && \
        echo \n >> static-key.txt && \
        terraform output -raw secret_key >> static-key.txt
        ```

        Команда сохраняет в файл `static-key.txt` идентификатор статического ключа и статический ключ, они потребуются далее.    

    1. Перейдите в [консоль управления](https://console.yandex.cloud) и [настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подсети, в которой расположен кластер.


{% endlist %}

## Настройте веб-сервер с файлом конфигурации {#set-web-server}

Настройте веб-сервер на виртуальной машине и создайте на нем файл конфигурации для протокола `s3`:


1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по SSH.


1. Создайте каталог `/opt/gp_http_server` и поместите в него файл `s3.config`, который содержит параметры статического ключа и другие настройки конфигурации для протокола `s3`:

    ```bash
    sudo mkdir /opt/gp_http_server
    ```

    Содержимое файла `s3.config`:

    ```config
    [default]
    accessid = "<идентификатор_статического_ключа>"
    secret = "<статический_ключ>"
    threadnum = 4
    chunksize = 67108864
    low_speed_limit = 10240
    low_speed_time = 60
    encryption = true
    version = 2
    proxy = ""
    autocompress = true
    verifycert = true
    server_side_encryption = ""
    # gpcheckcloud config
    gpcheckcloud_newline = "\n"
    ```

1. В каталог `/etc/systemd/system/` поместите файл конфигурации веб-сервера `gp_s3_config_http.service`:

    ```config
    [Unit]
    Description=HTTP server config to connect Greenplum with Object Storage
    After=network.target

    [Service]
    KillMode=process
    Restart=on-failure
    Type=simple
    User=root
    ExecStart=python3 -m http.server 8553 --directory /opt/gp_http_server

    [Install]
    WantedBy=multi-user.target
    ```

1. Запустите веб-сервер:

    ```bash
    sudo systemctl daemon-reload && \
    sudo systemctl enable gp_s3_config_http && \
    sudo systemctl start gp_s3_config_http
    ```

1. Чтобы проверить состояние веб-сервера, выполните команду:

    ```bash
    sudo systemctl status gp_s3_config_http
    ```

## Создайте внешнюю таблицу {#create-ext-table}

1. [Подключитесь к кластеру](../../managed-greenplum/operations/connect/index.md) Greenplum®.
1. Выполните запрос на создание внешней таблицы, которая ссылается на таблицу `example.csv` в бакете:

    ```sql
    CREATE READABLE EXTERNAL TABLE s3_ext_table(id int, year int)
    LOCATION('s3://storage.yandexcloud.net/<имя_бакета>/example.csv config_server=http://<внутренний_IP-адрес_виртуальной_машины>:8553/s3.config region=ru-central1-a')
    FORMAT 'csv';
    ```

    Успешный запрос вернет ответ:

    ```sql
    CREATE EXTERNAL TABLE
    ```

1. Запросите данные из внешней таблицы:

    ```sql
    SELECT * FROM s3_ext_table;
    ```

    Ожидаемый результат выполнения команды:

    ```text
     id | year
    ----+------
     10 | 2010
    (1 row)
    ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    
    1. [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
    1. Если вы зарезервировали для виртуальной машины публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
    1. [Удалите бакет в Object Storage](../../storage/operations/buckets/delete.md).
    1. [Удалите кластер Greenplum®](../../managed-greenplum/operations/cluster-delete.md).
    1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).
    1. [Удалите подсеть](../../vpc/operations/subnet-delete.md).
    1. [Удалите таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
    1. [Удалите NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
    1. [Удалите облачную сеть](../../vpc/operations/network-delete.md).



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

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._