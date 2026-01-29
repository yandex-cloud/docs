---
title: Как подключиться к кластеру {{ VLK }} в {{ mrd-full-name }}
description: Следуя данной инструкции, вы сможете подключиться к кластеру {{ VLK }}.
---

# Подключение к кластеру {{ VLK }} из приложений

К кластеру {{ VLK }} можно подключиться с помощью [инструментов командной строки](#command-line-tools), из [графических IDE](#connection-ide) и [Docker-контейнера](#connection-docker). О подключении из кода вашего приложения см. [Примеры кода](./code-examples.md).

## Инструменты командной строки {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

Способ настройки зависит от того, включено ли в кластере [шардирование](../../concepts/sharding.md).

### redis-cli {#redis-cli}

Для кластеров {{ VLK }} поддерживается шифрованное соединение через порт `{{ port-mrd-tls }}` и нешифрованное через порт `{{ port-mrd }}`.

{% include [How to use TLS](../../../_includes/mdb/mvk/connect/how-to-use-tls.md) %}

Чтобы всегда подключаться к мастеру в нешардированном кластере, воспользуйтесь [особым FQDN](fqdn.md#special-fqdn), который всегда указывает на мастер, либо отслеживайте роли всех хостов кластера самостоятельно.

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    1. {% include [Install requirements](../../../_includes/mdb/mvk/connect/bash/install-requirements.md) %}

    1. **Подключитесь напрямую к мастеру:**

       * нешардированного кластера:

          ```bash
          redis-cli \
              -h c-<идентификатор_кластера>.rw.{{ dns-zone }} \
              -a <пароль>
          ```
       * шардированного кластера:

          ```bash
           redis-cli \
               -c \
               -h <FQDN_хоста-мастера_в_нужном_шарде> \
               -a <пароль>
           ```

- Подключение с SSL {#with-ssl}

    1. {% include [Install requirements SSL](../../../_includes/mdb/mvk/connect/bash/install-requirements-ssl.md) %}

    1. **Подключитесь напрямую к мастеру:**

       * нешардированного кластера:

         {% include [default-connstring](../../../_includes/mdb/mvk/default-connstring.md) %}

       * шардированного кластера:

          ```bash
          redis-cli \
              -c \
              -h <FQDN_хоста-мастера_в_нужном_шарде> \
              -a <пароль> \
              -p {{ port-mrd-tls }} \
              --tls \
              --cacert ~/.redis/{{ crt-local-file }} \
          ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mvk/fqdn-host.md) %}

{% include [Подключение к кластеру](../../../_includes/mdb/mvk/connect/bash/after-connect.md) %}

### {{ VLK }} Sentinel {#redis-sentinel}

{{ VLK }} Sentinel — это система управления хостами {{ VLK }}, позволяющая проводить мониторинг, отправлять уведомления о состояниях хостов, [переключать мастер](../failover.md) и передавать клиентам актуальные адреса хостов.

Для нешардированных кластеров поддерживается нешифрованное соединение через порт `{{ port-mrd-sentinel }}` с любой версией {{ VLK }}.

Если клиентское приложение не поддерживает подключение через Sentinel, подключитесь напрямую к мастеру. Если в прямом подключении нет необходимости, используйте Sentinel для более надежной работы с хостами кластера:

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    1. {% include [Install requirements](../../../_includes/mdb/mvk/connect/bash/install-requirements.md) %}

    1. **Получите адрес хоста-мастера, используя Sentinel и любой хост {{ VLK }}:**

        ```bash
        redis-cli \
            -h <FQDN_любого_хоста_{{ VLK }}> \
            -p {{ port-mrd-sentinel }} \
            sentinel \
            get-master-addr-by-name <имя_кластера_{{ VLK }}> | head -n 1
        ```

    1. **Подключитесь к хосту с этим адресом:**

        ```bash
        redis-cli \
            -h <адрес_хоста-мастера_{{ VLK }}> \
            -a <пароль_{{ VLK }}>
        ``` 

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mvk/fqdn-host.md) %}

{% include [Подключение к кластеру](../../../_includes/mdb/mvk/connect/bash/after-connect.md) %}

Подробнее о Sentinel см. в разделе [{#T}](../../concepts/replication.md) и [документации {{ VLK }}](https://redis.io/topics/sentinel).

## Подключение из графических IDE {#connection-ide}

{% include [IDE environment settings](../../../_includes/mdb/mvk/ide-envs.md) %}

Подключаться из графических IDE к хостам кластера можно только через [SSH-туннель](../../../glossary/ssh-keygen.md) с помощью [созданной ВМ](./index.md). Перед подключением [подготовьте сертификат](./index.md#get-ssl-cert).

{% include [note-connection-ide](../../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DBeaver {#dbeaver}

    Поддержка подключения к кластеру {{ VLK }} доступна только в [коммерческих редакциях DBeaver](https://dbeaver.com/buy/).

    Чтобы подключиться к кластеру:

    1. Создайте новое соединение с БД:
        1. Выберите в меню **База данных** пункт **Новое соединение**.
        1. Выберите из списка БД **{{ VLK }}**.
        1. Нажмите кнопку **Далее**.
        1. Укажите параметры подключения на вкладке **Главное**:
            * **Хост** — [FQDN хоста-мастера](./fqdn.md) или [особый FQDN](./fqdn.md#special-fqdns), всегда указывающий на текущий хост-мастер.
              При подключении к шардированному кластеру укажите через запятую [FQDN хостов-мастеров](./fqdn.md) каждого шарда.
            * **Порт** — `{{ port-mrd }}` для обычного кластера или `{{ port-mrd-tls }}` для кластера с включенным SSL-шифрованием.
            * В блоке **Аутентификация** укажите пароль от кластера.
        1. На вкладке **SSH**:
            1. Включите настройку **Использовать туннель SSH**.
            1. Укажите параметры SSH-туннеля:
                * **Хост/IP** — публичный IP-адрес [ВМ для подключения](./index.md);
                * **Имя пользователя** — логин для подключения к ВМ;
                * **Метод аутентификации** — `Публичный ключ`;
                * **Секретный ключ** — путь к файлу закрытого ключа для подключения к ВМ;
                * **Passphrase** — пароль от закрытого ключа.
        1. На вкладке **SSL**:
            1. Включите настройки **Использовать SSL** и **Пропустить валидацию имени хоста**.
            1. В блоке **Параметры**:
                1. Выберите **Способ** — **Набор сертификатов**.
                1. В поле **Корневой сертификат** укажите путь к сохраненному файлу [SSL-сертификата](./index.md#get-ssl-cert).
    1. Нажмите кнопку **Тест соединения ...** для проверки соединения с БД. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
    1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

{% endlist %}

{% include [How to connect from a Dockerfile](../../../_includes/mdb/mvk/connect/docker-and-redis.md) %}
