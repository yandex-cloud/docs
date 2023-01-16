# Использование кластера {{ mrd-name }} в качестве хранилища сессий PHP

Кластер {{ mrd-name }} можно использовать в качестве хранилища данных о сессиях PHP.

Чтобы настроить кластер {{ mrd-name }} в качестве хранилища сессий PHP:

1. [Настройте PHP для использования кластера {{ mrd-name }} в качестве хранилища сессий](#settings-php).
1. [Проверьте сохранение данных сессий PHP в кластере {{ mrd-name }}](#test-settings).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs %}

- Вручную

    {% if audience != "internal" %}

    1. [Настройте группу безопасности {{ vpc-name }}](../../vpc/operations/security-group-add-rule.md). Добавьте разрешения для протокола TCP в группу безопасности:

        * входящий трафик через порт `22` с любых IP-адресов для {% if lang == "ru" %}[SSH](../../glossary/ssh-keygen.md){% else %}SSH{% endif %};
        * исходящий и входящий трафик через порты `80` и `443` на любые IP-адреса для HTTP/HTTPS;
        * исходящий и входящий трафик через порт `6379` на IP-адреса внутренней сети для {{ RD }}.

        Подробнее см. [{#T}](../../vpc/concepts/security-groups.md).

    {% endif %}

    1. {% if audience != "internal" %}[Создайте виртуальную машину с LAMP/LEMP](../../tutorials/web/lamp-lemp.md#create-vm){% else %}Создайте виртуальную машину с LAMP/LEMP{% endif %} в {{ compute-full-name }} любой подходящей вам конфигурации.

        {% if audience != "internal" %}

        При создании ВМ выберите группу безопасности, настроенную ранее. Чтобы проверить настройки безопасности, введите в адресной строке браузера публичный IP-адрес ВМ: должна отобразиться страница по умолчанию установленного веб-сервера.

        {% endif %}

    1. [Создайте кластер {{ mrd-name }}](../../managed-redis/operations/cluster-create.md) любой подходящей конфигурации. {% if audience != "internal" %} При создании кластера {{ mrd-name }} укажите те же сеть и группы безопасности, что и для ВМ с веб-сервером. {% endif %}

- С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, {% if audience != "internal" %}[установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите его{% endif %}.
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и {% if audience != "internal" %}[укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}укажите значения параметров{% endif %}.
    1. Скачайте в ту же рабочую директорию файл конфигурации для подходящего типа кластера:

        * [redis-cluster-non-sharded-and-vm.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/redis-as-php-session-storage/redis-cluster-non-sharded-and-vm-for-php.tf) — для нешардированного кластера.
        * [redis-cluster-sharded-and-vm.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/redis-as-php-session-storage/redis-cluster-sharded-and-vm-for-php.tf) — для [шардированного](../../managed-redis/concepts/sharding.md) кластера.

        В каждом файле описаны:

        * сеть;
        * подсеть;
        * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру и виртуальной машине из интернета;
        * кластер {{ mrd-name }};
        * виртуальная машина.

    1. Укажите в файле конфигурации:

        * Пароль для доступа к кластеру {{ mrd-name }}.
        * Идентификатор публичного {% if audience == "external" %}[образа](../../compute/operations/images-with-pre-installed-software/get-list.md){% endif %}{% if audience == "internal" %}образа{% endif %} LAMP/LEMP. Например, `fd832gltdaeepe0m2hi8` для LAMP.
        * Логин и путь к файлу {% if audience != "internal" %}[открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys){% else %}открытого ключа{% endif %}, которые будут использоваться для доступа к виртуальной машине. По умолчанию в используемом образе указанный логин игнорируется, вместо него создается пользователь с логином `ubuntu`. Используйте его для подключения к виртуальной машине.

    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдеров, указанных в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
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

1. {% if audience != "internal" %}[Подключитесь к ВМ с веб-сервером по SSH и настройте его](../../compute/operations/vm-connect/ssh.md){% else %}Подключитесь к ВМ с веб-сервером по SSH и настройте его{% endif %}:

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
        sudo chown <имя пользователя> /var/www/html/ --recursive && \
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

        Где `<FQDN1>`, `<FQDN2>` и `<FQDN3>` — полные доменные имена [хостов-мастеров кластера](../../managed-redis/operations/hosts.md#list). Например, для кластера из 3-х шардов с паролем `password` значение параметра `session.save_path` будет выглядеть так:

        ```ini
        session.save_path = "seed[]=rc1a-t9h8gxqor5v6lcc3.{{ dns-zone }}:6379&seed[]=rc1b-7qxk0h3b8pupxsj9.{{ dns-zone }}:6379&seed[]=rc1c-spy1c1i4vwvj0n8z.{{ dns-zone }}:6379&auth=password"
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

    При каждом обновлении страницы выводимое значение будет увеличиваться. Значение переменной `$count` будет сохраняться в данных сессии. Для каждой сессии в {{ RD }} будет создан уникальный ключ.

1. Из ВМ подключитесь к кластеру {{ RD }} с помощью `redis-cli`:

    ```bash
    redis-cli -c -h <FQDN хоста-мастера> -a <пароль>
    ```

    Введите команду для просмотра хранящихся в {{ RD }} ключей:

    ```text
    KEYS *
    ```

    ```text
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
    ```

    ```text
    1) "PHPREDIS_SESSION:keb02haicgi0ijeju3ngqqnucq"
    2) "PHPREDIS_SESSION:c5r0mbe1v84pn2b5kj1umun1sp"
    ```

    Как видно из результатов запроса, для каждой сессии в {{ RD }} создан свой ключ.

## Удалите созданные ресурсы {#clear-out}

{% list tabs %}

- Вручную

    Если созданные ресурсы вам больше не нужны, удалите их:

    * [Удалите кластер {{ mrd-full-name }}](../../managed-redis/operations/cluster-delete.md).
    * {% if audience != "internal" %}[Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md){% else %}Удалите виртуальную машину{% endif %}.
    * Если вы зарезервировали публичные статические IP-адреса, освободите и {% if audience != "internal" %}[удалите их](../../vpc/operations/address-delete.md){% else %}удалите их{% endif %}.

- С помощью {{ TF }}

    Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#deploy-infrastructure):

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл (`redis-cluster-non-sharded-and-vm.tf` или `redis-cluster-sharded-and-vm.tf`).
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле, будут удалены.

{% endlist %}
