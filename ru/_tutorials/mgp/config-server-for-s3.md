# Создание внешней таблицы на базе таблицы из бакета {{ objstorage-full-name }} с помощью конфигурационного файла

При [создании внешней таблицы](../../managed-greenplum/operations/external-tables.md#pxf-examples) из таблицы, расположенной в бакете {{ objstorage-full-name }}, необходимо передать в запросе [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для сервисного аккаунта. Это можно сделать с помощью [протокола `s3`](https://greenplum.docs.pivotal.io/6-20/admin_guide/external/g-s3-protocol.html) и конфигурационного файла, хранящегося на HTTP-сервере.

Чтобы создать внешнюю таблицу с помощью конфигурационного файла:

1. [Настройте веб-сервер с файлом конфигурации](#set-web-server).
1. [Создайте внешнюю таблицу](#create-ext-table).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs %}

* Вручную

    1. [Создайте кластер](../../managed-greenplum/operations/cluster-create.md) {{ mgp-name }} любой подходящей конфигурации.

    
    1. В подсети кластера [настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) и [создайте группу безопасности](../../vpc/operations/security-group-create.md), разрешающую весь входящий и исходящий трафик со всех адресов.


    
    1. [Создайте виртуальную машину с Linux](../../compute/operations/vm-create/create-linux-vm.md) в той же облачной подсети, в которой расположен кластер {{ mgp-name }}.


    1. [Создайте бакет в {{ objstorage-name }}](../../storage/operations/buckets/create.md) с ограниченным доступом. [Загрузите](../../storage/operations/objects/upload.md) в него файл `example.csv`, содержащий тестовую таблицу:

        ```csv
        10,2010
        ```

    
    1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md) для сервисного аккаунта.


* С помощью Terraform

    
    1. {% include [terraform-install](../../_includes/terraform-install.md) %}
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).


    1. Создайте в рабочей директории файл `example.csv`, содержащий тестовую таблицу:

        ```csv
        10,2010
        ```

    1. Скачайте в ту же рабочую директорию [файл конфигурации инфраструктуры](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/greenplum-s3-vm.tf).

        В этом файле описаны:

        * сеть;
        * подсеть;
        * сервисный аккаунт со статическим ключом доступа;
        * кластер {{ mgp-name }};
        * бакет, в который будет помещен файл `example.csv`;
        * виртуальная машина с [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts).

    1. Укажите в файле `greenplum-s3-vm.tf`:

        * Пароль пользователя `user`, который будет использоваться для доступа к кластеру {{ mgp-name }}.
        * Идентификатор образа виртуальной машины.
        * Имя пользователя и путь к [SSH-ключу](../../glossary/ssh-keygen.md) для доступа к виртуальной машине.
        * Идентификатор каталога для сервисного аккаунта, такой же как в настройках провайдера.
        * Имя бакета, которое должно быть уникальным во всем {{ objstorage-name }}.

    1. В терминале перейдите в директорию с планом инфраструктуры.

    1. Для проверки правильности файлов конфигурации выполните команду:

       ```bash
       terraform validate
       ```

       Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте инфраструктуру, необходимую для выполнения инструкций из этого руководства:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    1. Чтобы получить параметры статического ключа, в рабочей директории выполните команду:

        ```bash
        terraform output -raw access_key > static-key.txt && \
        echo \n >> static-key.txt && \
        terraform output -raw secret_key >> static-key.txt
        ```

        Команда сохраняет в файл `static-key.txt` идентификатор статического ключа и статический ключ, они потребуются далее.

    
    1. Перейдите в [консоль управления]({{ link-console-main }}) и [настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подсети, в которой расположен кластер.


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
    accessid = "<идентификатор статического ключа>"
    secret = "<статический ключ>"
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

1. [Подключитесь к кластеру](../../managed-greenplum/operations/connect.md) {{ mgp-name }}.
1. Выполните запрос на создание внешней таблицы, которая ссылается на таблицу `example.csv` в бакете:

    ```sql
    CREATE READABLE EXTERNAL TABLE s3_ext_table(id int, year int)
    LOCATION('s3://{{ s3-storage-host }}/<имя бакета>/example.csv config_server=http://<внутренний IP-адрес виртуальной машины>:8553/s3.config region={{ region-id }}-a')
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

{% list tabs %}

* Вручную

    
    1. [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
    1. Если вы зарезервировали для виртуальной машины публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
    1. [Удалите бакет в {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
    1. [Удалите кластер {{ mgp-name }}](../../managed-greenplum/operations/cluster-delete.md).
    1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).
    1. [Удалите облачную сеть](../../vpc/operations/network-delete.md).


* С помощью Terraform

    Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#deploy-infrastructure):

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите файл `greenplum-s3-vm.tf`.
    1. Выполните команду:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в файле `greenplum-s3-vm.tf`, будут удалены.

{% endlist %}
