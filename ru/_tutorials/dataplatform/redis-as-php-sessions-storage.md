# Использование кластера {{ mrd-name }} в качестве хранилища сессий PHP


Кластер {{ mrd-name }} можно использовать в качестве хранилища данных о сессиях PHP.

Чтобы настроить кластер {{ mrd-name }} в качестве хранилища сессий PHP:

1. [Настройте PHP для использования кластера {{ mrd-name }} в качестве хранилища сессий](#settings-php).
1. [Проверьте сохранение данных сессий PHP в кластере {{ mrd-name }}](#test-settings).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер-приемник {{ mrd-name }}: использование вычислительных ресурсов, выделенных хостам, и дискового пространства (см. [тарифы {{ VLK }}](../../managed-redis/pricing.md)).
* Плата за использование публичных IP-адресов, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Плата за ВМ: использование вычислительных ресурсов, хранилища и публичного IP-адреса (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).


## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    
    1. Если вы используете группы безопасности {{ vpc-name }}, [настройте их](../../vpc/operations/security-group-add-rule.md). Добавьте разрешения для протокола TCP в группу безопасности:

        * входящий трафик через порт `22` с любых IP-адресов для [SSH](../../glossary/ssh-keygen.md);
        * исходящий и входящий трафик через порты `80` и `443` на любые IP-адреса для HTTP/HTTPS;
        * исходящий и входящий трафик через порт `6379` на IP-адреса внутренней сети для {{ VLK }}.

        Подробнее см. [{#T}](../../vpc/concepts/security-groups.md).


    1. [Создайте виртуальную машину с LAMP/LEMP](../../tutorials/web/lamp-lemp/console.md#create-vm) в {{ compute-full-name }} любой подходящей вам конфигурации.

        
        При создании ВМ выберите группу безопасности, настроенную ранее. Чтобы проверить настройки безопасности, введите в адресной строке браузера публичный IP-адрес ВМ: должна отобразиться страница по умолчанию установленного веб-сервера.


    1. [Создайте кластер {{ mrd-name }}](../../managed-redis/operations/cluster-create.md) любой подходящей конфигурации.  При создании кластера {{ mrd-name }} укажите те же сеть и группы безопасности, что и для ВМ с веб-сервером. 

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации для подходящего типа кластера:

        * [redis-cluster-non-sharded-and-vm-for-php.tf](https://github.com/yandex-cloud-examples/yc-redis-as-php-session-storage/blob/main/redis-cluster-non-sharded-and-vm-for-php.tf) — для нешардированного кластера.
        * [redis-cluster-sharded-and-vm-for-php.tf](https://github.com/yandex-cloud-examples/yc-redis-as-php-session-storage/blob/main/redis-cluster-sharded-and-vm-for-php.tf) — для [шардированного](../../managed-redis/concepts/sharding.md) кластера.

        В каждом файле описаны:

        * сеть;
        * подсеть;
        * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру и виртуальной машине из интернета;
        * кластер {{ mrd-name }};
        * виртуальная машина.

    1. Укажите в файле конфигурации:

        * Пароль для доступа к кластеру {{ mrd-name }}.
        * Идентификатор публичного [образа](../../compute/operations/images-with-pre-installed-software/get-list.md) LAMP/LEMP.
        * Логин и путь к файлу [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys), которые будут использоваться для доступа к виртуальной машине. По умолчанию в используемом образе указанный логин игнорируется, вместо него создается пользователь с логином `ubuntu`. Используйте его для подключения к виртуальной машине.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Выполните дополнительные настройки {#additional-settings}

1. [Подключитесь к ВМ с веб-сервером по SSH и настройте его](../../compute/operations/vm-connect/ssh.md):

    * Установите сертификаты:

        ```bash
        sudo mkdir --parents {{ crt-local-dir }} && \
        sudo wget "{{ crt-web-path }}" \
            --output-document {{ crt-local-dir }}{{ crt-local-file }}
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

## Настройте PHP для использования кластера {{ mrd-name }} в качестве хранилища сессий {#settings-php}

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
        session.save_path = "tcp://<FQDN_хоста-мастера_{{ VLK }}>:6379?auth=<пароль>"
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

        Где `<FQDN1>`, `<FQDN2>` и `<FQDN3>` — полные доменные имена [хостов-мастеров кластера](../../managed-redis/operations/hosts.md#list). Например, для кластера из 3-х шардов с паролем `password` значение параметра `session.save_path` будет выглядеть так:

        ```ini
        session.save_path = "seed[]=rc1a-t9h8gxqo********.{{ dns-zone }}:6379&seed[]=rc1b-7qxk0h3b********.{{ dns-zone }}:6379&seed[]=rc1c-spy1c1i4********.{{ dns-zone }}:6379&auth=password"
        ```

    {% endlist %}

    Подробнее про подключение к кластеру см. [{#T}](../../managed-redis/operations/connect/index.md).

1. Перезапустите веб-сервер:

    * `sudo systemctl restart apache2` для Apache;
    * `sudo systemctl restart php7.2-fpm` для NGINX.

## Проверьте сохранение данных сессий PHP в кластере {{ mrd-name }} {#test-settings}

1. Создайте в каталоге `/var/www/html/` файл `index.php`, который будет выводить степени числа `2`:

    ```php
    <?php
    session_start();

    $count = isset($_SESSION['count']) ? $_SESSION['count'] : 1;

    echo $count;

    $_SESSION['count'] = $count * 2;
    ```

    При каждом обновлении страницы выводимое значение будет увеличиваться. Значение переменной `$count` будет сохраняться в данных сессии. Для каждой сессии в {{ VLK }} будет создан уникальный ключ.

1. Из ВМ подключитесь к кластеру {{ VLK }} с помощью `redis-cli`:

    ```bash
    redis-cli -c -h <FQDN_хоста-мастера> -a <пароль>
    ```

    Введите команду для просмотра хранящихся в {{ VLK }} ключей:

    ```text
    KEYS *
    ```

    ```text
    (empty list or set)
    ```

    Из результатов запроса видно, что сейчас в {{ VLK }} не хранится никаких данных.

1. Проверьте, сохраняются ли пользовательские сессии при подключении к веб-серверу:

    1. Введите в адресной строке браузера публичный IP-адрес ВМ с веб-сервером. При первом входе будет выведено число `1`.
    1. Обновите страницу несколько раз: выводимое значение будет увеличиваться.
    1. Выполните вход на страницу из другого браузера — отсчет начнется с `1`.
    1. Обновите страницу несколько раз: выводимое значение также будет увеличиваться.

    Сохранение значения переменной `$count` между обновлениями страницы браузера говорит о корректной работе настроенного механизма хранения сессий PHP в кластере {{ mrd-name }}.

1. Повторите запрос на просмотр хранящихся в {{ VLK }} ключей:

    ```text
    KEYS *
    ```

    ```text
    1) "PHPREDIS_SESSION:keb02haicgi0ijeju3********"
    2) "PHPREDIS_SESSION:c5r0mbe1v84pn2b5kj********"
    ```

    Как видно из результатов запроса, для каждой сессии в {{ VLK }} создан свой ключ.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

    * [Удалите кластер {{ mrd-full-name }}](../../managed-redis/operations/cluster-delete.md).
    * [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
    * Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
