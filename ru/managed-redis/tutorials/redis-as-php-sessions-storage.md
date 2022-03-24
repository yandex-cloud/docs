# Использование кластера {{ mrd-name }} в качестве хранилища сессий PHP

Кластер {{ mrd-name }} можно использовать в качестве хранилища данных о сессиях PHP.

Чтобы настроить кластер {{ mrd-name }} в качестве хранилища сессий PHP:

1. [{#T}](#settings-php).
1. [{#T}](#test-settings).

## Перед началом работы {#before-you-begin}

1. [Настройте группу безопасности {{ vpc-name }}](../../vpc/operations/security-group-update.md#add-rule). Добавьте разрешения для протокола TCP в группу безопасности:

      * входящий трафик через порт `22` с любых IP-адресов для SSH;
      * исходящий и входящий трафик через порты `80` и `443` на любые IP-адреса для HTTP/HTTPS;
      * исходящий и входящий трафик через порт `6379` на IP-адреса внутренней сети для {{ RD }}.


    Подробнее см. [{#T}](../../vpc/concepts/security-groups.md).

1. [Создайте виртуальную машину с LAMP/LEMP](../../tutorials/web/lamp-lemp.md#create-vm) в {{ compute-full-name }} любой подходящей вам конфигурации.

    При создании ВМ выберите группу безопасности, настроенную ранее. Чтобы проверить настройки безопасности, введите в адресной строке браузера публичный IP-адрес ВМ: должна отобразиться страница по умолчанию установленного веб-сервера.

1. [Подключитесь к ВМ с веб-сервером по SSH и настройте его](../../compute/operations/vm-connect/ssh.md):

    * Установите сертификаты:

        ```bash
        sudo mkdir -p /usr/local/share/ca-certificates/Yandex && \
        sudo wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
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
        sudo chown <имя пользователя> /var/www/html/ --recursive && \
        rm /var/www/html/*
        ```

1. [Создайте кластер {{ mrd-name }}](../operations/cluster-create.md) любой подходящей конфигурации. При создании кластера {{ mrd-name }} укажите в блоке **Сетевые настройки** те же сеть и группы безопасности, что и для ВМ с веб-сервером.

## Настройте PHP для использования кластера {{ mrd-name }} в качестве хранилища сессий {#settings-php}

1. Внесите изменения в конфигурационный файл `php.ini` для вашего веб-сервера.

    Обычно файл `php.ini` располагается в каталоге:

    * `/etc/php/7.2/apache2/` для Apache;
    * `/etc/php/7.2/fpm/` для NGINX.

    Уточнить расположение `php.ini` можно с помощью команды `sudo find /etc/ -name php.ini`.

    {% note info %}

    Не нужно вносить изменения в `php.ini` для PHP CLI.

    {% endnote %}

    {% list tabs %}

      - Кластер {{ RD }} без шардирования

        ```ini
        [PHP]
        ...
        extension = redis
        ...
        [Session]
        session.save_handler = redis
        session.save_path = "tcp://<FQDN хоста-мастера Redis>:6379?auth=<пароль>"
        ```

      - Кластер {{ RD }} с шардированием

        ```ini
        [PHP]
        ...
        extension = redis
        ...
        [Session]
        session.save_handler = rediscluster
        session.save_path = "seed[]=<FQDN1>:6379&seed[]=<FQDN2>:6379&seed[]=<FQDN3>:6379&auth=<пароль>"
        ```

        Здесь `<FQDN1>`, `<FQDN2>` и `<FQDN3>` — полные доменные имена [хостов-мастеров кластера](../operations/hosts.md#list). Например, для кластера из 3-х шардов с паролем `password` значение параметра `session.save_path` будет выглядеть так:

        ```ini
        session.save_path = "seed[]=rc1a-t9h8gxqor5v6lcc3.{{ dns-zone }}:6379&seed[]=rc1b-7qxk0h3b8pupxsj9.{{ dns-zone }}:6379&seed[]=rc1c-spy1c1i4vwvj0n8z.{{ dns-zone }}:6379&auth=password"
        ```

    {% endlist %}

    Подробнее про подключение к кластеру см. [{#T}](../operations/connect/index.md).

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

    При каждом обновлении страницы выводимое значение будет увеличиваться. Значение переменной `$count` будет сохраняться в данных сессии. Для каждой сессии в {{ RD }} будет создан уникальный ключ.

1. Из ВМ подключитесь к кластеру {{ RD }} с помощью `redis-cli`:

    ```bash
    redis-cli -c -h <FQDN хоста-мастера> -a <пароль>
    ```

    Введите команду для просмотра хранящихся в {{ RD }} ключей:

    ```text
    KEYS *
    (empty list or set)
    ```

    Из результатов запроса видно, что сейчас в {{ RD }} не хранится никаких данных.

1. Проверьте, сохраняются ли пользовательские сессии при подключении к веб-серверу:

    1. Введите в адресной строке браузера публичный IP-адрес ВМ с веб-сервером. При первом входе будет выведено число `1`.
    1. Обновите страницу несколько раз: выводимое значение будет увеличиваться.
    1. Выполните вход на страницу из другого браузера — отсчет начнется с `1`.
    1. Обновите страницу несколько раз: выводимое значение также будет увеличиваться.

    Сохранение значения переменной `$count` между обновлениями страницы браузера говорит о корректной работе настроенного механизма хранения сессий PHP в кластере {{ mrd-name }}.

1. Повторите запрос на просмотр хранящихся в {{ RD }} ключей:

    ```text
    KEYS *
    1) "PHPREDIS_SESSION:keb02haicgi0ijeju3ngqqnucq"
    2) "PHPREDIS_SESSION:c5r0mbe1v84pn2b5kj1umun1sp"
    ```

    Как видно из результатов запроса, для каждой сессии в {{ RD }} создан свой ключ.
