# Использование кластера Yandex Managed Service for Valkey™ в качестве хранилища сессий PHP


# Использование кластера Yandex Managed Service for Valkey™ в качестве хранилища сессий PHP


Кластер Yandex Managed Service for Valkey™ можно использовать в качестве хранилища данных о сессиях PHP.

Чтобы настроить кластер Yandex Managed Service for Valkey™ в качестве хранилища сессий PHP:

1. [Настройте PHP для использования кластера Yandex Managed Service for Valkey™ в качестве хранилища сессий](#settings-php).
1. [Проверьте сохранение данных сессий PHP в кластере Yandex Managed Service for Valkey™](#test-settings).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер-приемник Yandex Managed Service for Valkey™: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Valkey™](../../managed-valkey/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы ([тарифы Compute Cloud](../../compute/pricing.md)).


## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    
    1. Если вы используете группы безопасности Virtual Private Cloud, [настройте их](../../vpc/operations/security-group-add-rule.md). Добавьте разрешения для протокола TCP в группу безопасности:

        * входящий трафик через порт `22` с любых IP-адресов для [SSH](../../glossary/ssh-keygen.md);
        * исходящий и входящий трафик через порты `80` и `443` на любые IP-адреса для HTTP/HTTPS;
        * исходящий и входящий трафик через порт `6379` на IP-адреса внутренней сети для Valkey™.

        Подробнее в разделе [Группы безопасности](../../vpc/concepts/security-groups.md).


    1. [Создайте виртуальную машину с LAMP/LEMP](../../tutorials/web/lamp-lemp/console.md#create-vm) в Yandex Compute Cloud любой подходящей вам конфигурации.

        
        При создании ВМ выберите группу безопасности, настроенную ранее. Чтобы проверить настройки безопасности, введите в адресной строке браузера публичный IP-адрес ВМ: должна отобразиться страница по умолчанию установленного веб-сервера.


    1. [Создайте кластер Yandex Managed Service for Valkey™](../operations/cluster-create.md) любой подходящей конфигурации.  При создании кластера Yandex Managed Service for Valkey™ укажите те же сеть и группы безопасности, что и для ВМ с веб-сервером. 

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации для подходящего типа кластера:

        * [redis-cluster-non-sharded-and-vm-for-php.tf](https://github.com/yandex-cloud-examples/yc-redis-as-php-session-storage/blob/main/redis-cluster-non-sharded-and-vm-for-php.tf) — для нешардированного кластера.
        * [redis-cluster-sharded-and-vm-for-php.tf](https://github.com/yandex-cloud-examples/yc-redis-as-php-session-storage/blob/main/redis-cluster-sharded-and-vm-for-php.tf) — для [шардированного](../concepts/sharding.md) кластера.

        В каждом файле описаны:

        * сеть;
        * подсеть;
        * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру и виртуальной машине из интернета;
        * кластер Yandex Managed Service for Valkey™;
        * виртуальная машина.

    1. Укажите в файле конфигурации:

        * Пароль для доступа к кластеру Yandex Managed Service for Valkey™.
        * Идентификатор публичного [образа](../../compute/operations/images-with-pre-installed-software/get-list.md) LAMP/LEMP.
        * Логин и путь к файлу [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys), которые будут использоваться для доступа к виртуальной машине. По умолчанию в используемом образе указанный логин игнорируется, вместо него создается пользователь с логином `ubuntu`. Используйте его для подключения к виртуальной машине.

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

### Выполните дополнительные настройки {#additional-settings}

1. [Подключитесь к ВМ с веб-сервером по SSH и настройте его](../../compute/operations/vm-connect/ssh.md):

    * Установите сертификаты:

        ```bash
        sudo mkdir --parents /usr/local/share/ca-certificates/Yandex/ && \
        sudo wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
            --output-document /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
        ```

    * Подготовьте окружение и установите библиотеку [phpredis](https://github.com/phpredis/phpredis) с помощью `pecl`:

        ```bash
        sudo apt update && \
        sudo apt install php-dev pkg-php-tools redis-tools --yes && \
        sudo pecl channel-update pecl.php.net && \
        sudo pecl install redis
        ```

    * Станьте владельцем каталога `/var/www/html/` и удалите из него все содержимое:

        ```bash
        sudo chown <имя_пользователя> /var/www/html/ --recursive && \
        rm /var/www/html/*
        ```

## Настройте PHP для использования кластера Yandex Managed Service for Valkey™ в качестве хранилища сессий {#settings-php}

1. Внесите изменения в конфигурационный файл `php.ini` для вашего веб-сервера.

    Обычно файл `php.ini` располагается в каталоге:

    * `/etc/php/7.2/apache2/` для Apache;
    * `/etc/php/7.2/fpm/` для NGINX.

    Уточнить расположение `php.ini` можно с помощью команды `sudo find /etc/ -name php.ini`.

    {% note info %}

    Не нужно вносить изменения в `php.ini` для PHP CLI.

    {% endnote %}
    
    {% list tabs group=cluster %}

      - Нешардированный кластер {#non-sharded}

        ```ini
        [PHP]
        ...
        extension = redis
        ...
        [Session]
        session.save_handler = redis
        session.save_path = "tcp://<FQDN_хоста-мастера_Valkey™>:6379?auth=<пароль>"
        ```

      - Шардированный кластер {#sharded}

        ```ini
        [PHP]
        ...
        extension = redis
        ...
        [Session]
        session.save_handler = rediscluster
        session.save_path = "seed[]=<FQDN1>:6379&seed[]=<FQDN2>:6379&seed[]=<FQDN3>:6379&auth=<пароль>"
        ```

        Где `<FQDN1>`, `<FQDN2>` и `<FQDN3>` — полные доменные имена [хостов-мастеров кластера](../operations/hosts.md#list). Например, для кластера из 3-х шардов с паролем `password` значение параметра `session.save_path` будет выглядеть так:

        ```ini
        session.save_path = "seed[]=rc1a-t9h8gxqo********.mdb.yandexcloud.net:6379&seed[]=rc1b-7qxk0h3b********.mdb.yandexcloud.net:6379&seed[]=rc1c-spy1c1i4********.mdb.yandexcloud.net:6379&auth=password"
        ```

    {% endlist %}

    Подробнее про подключение к кластеру смотрите в разделе [Предварительная настройка для подключения к кластеру Valkey™](../operations/connect/index.md).

1. Перезапустите веб-сервер:

    * `sudo systemctl restart apache2` для Apache;
    * `sudo systemctl restart php7.2-fpm` для NGINX.

## Проверьте сохранение данных сессий PHP в кластере Yandex Managed Service for Valkey™ {#test-settings}

1. Создайте в каталоге `/var/www/html/` файл `index.php`, который будет выводить степени числа `2`:

    ```php
    <?php
    session_start();

    $count = isset($_SESSION['count']) ? $_SESSION['count'] : 1;

    echo $count;

    $_SESSION['count'] = $count * 2;
    ```

    При каждом обновлении страницы выводимое значение будет увеличиваться. Значение переменной `$count` будет сохраняться в данных сессии. Для каждой сессии в Valkey™ будет создан уникальный ключ.

1. Из ВМ подключитесь к кластеру Valkey™ с помощью `redis-cli`:

    ```bash
    redis-cli -c -h <FQDN_хоста-мастера> -a <пароль>
    ```

    Введите команду для просмотра хранящихся в Valkey™ ключей:

    ```text
    KEYS *
    ```

    ```text
    (empty list or set)
    ```

    Из результатов запроса видно, что сейчас в Valkey™ не хранится никаких данных.

1. Проверьте, сохраняются ли пользовательские сессии при подключении к веб-серверу:

    1. Введите в адресной строке браузера публичный IP-адрес ВМ с веб-сервером. При первом входе будет выведено число `1`.
    1. Обновите страницу несколько раз: выводимое значение будет увеличиваться.
    1. Выполните вход на страницу из другого браузера — отсчет начнется с `1`.
    1. Обновите страницу несколько раз: выводимое значение также будет увеличиваться.

    Сохранение значения переменной `$count` между обновлениями страницы браузера говорит о корректной работе настроенного механизма хранения сессий PHP в кластере Yandex Managed Service for Valkey™.

1. Повторите запрос на просмотр хранящихся в Valkey™ ключей:

    ```text
    KEYS *
    ```

    ```text
    1) "PHPREDIS_SESSION:keb02haicgi0ijeju3********"
    2) "PHPREDIS_SESSION:c5r0mbe1v84pn2b5kj********"
    ```

    Как видно из результатов запроса, для каждой сессии в Valkey™ создан свой ключ.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

    * [Удалите кластер Yandex Managed Service for Valkey™](../operations/cluster-delete.md).
    * [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
    * Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).

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