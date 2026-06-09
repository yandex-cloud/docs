# Подключение к кластеру Valkey™ из приложений

К кластеру Valkey™ можно подключиться с помощью [инструментов командной строки](#command-line-tools), из [графических IDE](#connection-ide) и [Docker-контейнера](#connection-docker). О подключении из кода вашего приложения см. [Примеры кода](code-examples.md).

## Инструменты командной строки {#command-line-tools}

Примеры кода с заполненным FQDN хоста доступны в [консоли управления](https://console.yandex.cloud) по нажатию кнопки **Подключиться** на странице кластера.

Способ настройки зависит от того, включено ли в кластере [шардирование](../../concepts/sharding.md).

### redis-cli {#redis-cli}

Для кластеров Valkey™ поддерживается шифрованное соединение через порт `6380` и нешифрованное через порт `6379`.

{% note warning %}

Используя [SSL-соединение](../../../glossary/ssl-certificate.md), можно подключаться только к кластерам с включенной настройкой **Поддержка TLS**.

{% endnote %}

Чтобы всегда подключаться к мастеру в нешардированном кластере, воспользуйтесь [особым FQDN](fqdn.md#special-fqdn), который всегда указывает на мастер, либо отслеживайте роли всех хостов кластера самостоятельно.

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    1. **Перед подключением установите зависимости:**
       
       ```bash
       sudo apt update && sudo apt install -y redis-tools
       ```

    1. **Подключитесь напрямую к мастеру:**

       * нешардированного кластера:

          ```bash
          redis-cli \
              -h c-<идентификатор_кластера>.rw.mdb.yandexcloud.net \
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

    1. **Перед подключением установите зависимости:**
       
       Соберите утилиту `redis-tools` с поддержкой TLS одним из двух способов:
       
       * **Из репозитория**
       
           1. Подключите репозиторий:
       
               ```bash
               sudo apt-add-repository ppa:redislabs/redis
               ```
       
               Пакеты в этом репозитории уже собраны с флагом `BUILD_TLS=yes`.
       
           1. Установите утилиту:
       
               ```bash
               sudo apt update && sudo apt install -y redis-tools
               ```
       
       * **Вручную**
       
           Перейдите в директорию, куда хотите скачать дистрибутив. Скачайте стабильную версию утилиты и выполните сборку и установку:
       
           ```bash
           wget https://download.redis.io/redis-stable.tar.gz && \
           tar -xzvf redis-stable.tar.gz && \
           cd redis-stable && \
           make BUILD_TLS=yes && \
           sudo make install && \
           sudo cp ./src/redis-cli /usr/bin/
           ```

    1. **Подключитесь напрямую к мастеру:**

       * нешардированного кластера:

         ```bash
         redis-cli \
             -h c-<идентификатор_кластера>.rw.mdb.yandexcloud.net \
             -a <пароль> \
             -p 6380 \
             --tls \
             --cacert ~/.redis/YandexInternalRootCA.crt
         ```

       * шардированного кластера:

          ```bash
          redis-cli \
              -c \
              -h <FQDN_хоста-мастера_в_нужном_шарде> \
              -a <пароль> \
              -p 6380 \
              --tls \
              --cacert ~/.redis/YandexInternalRootCA.crt \
          ```

{% endlist %}

О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

После подключения к кластеру выполните команды:

```text
SET foo bar
GET foo
```

При успешном подключении к кластеру и выполнении тестового запроса будет выведена строка `bar`.

### Valkey™ Sentinel {#redis-sentinel}

Valkey™ Sentinel — это система управления хостами Valkey™, позволяющая проводить мониторинг, отправлять уведомления о состояниях хостов, [переключать мастер](../failover.md) и передавать клиентам актуальные адреса хостов.

Для нешардированных кластеров поддерживается нешифрованное соединение через порт `26379` с любой версией Valkey™.

Если клиентское приложение не поддерживает подключение через Sentinel, подключитесь напрямую к мастеру. Если в прямом подключении нет необходимости, используйте Sentinel для более надежной работы с хостами кластера:

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    1. **Перед подключением установите зависимости:**
       
       ```bash
       sudo apt update && sudo apt install -y redis-tools
       ```

    1. **Получите адрес хоста-мастера, используя Sentinel и любой хост Valkey™:**

        ```bash
        redis-cli \
            -h <FQDN_любого_хоста_Valkey™> \
            -p 26379 \
            sentinel \
            get-master-addr-by-name <имя_кластера_Valkey™> | head -n 1
        ```

    1. **Подключитесь к хосту с этим адресом:**

        ```bash
        redis-cli \
            -h <адрес_хоста-мастера_Valkey™> \
            -a <пароль_Valkey™>
        ``` 

{% endlist %}

О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

После подключения к кластеру выполните команды:

```text
SET foo bar
GET foo
```

При успешном подключении к кластеру и выполнении тестового запроса будет выведена строка `bar`.

Подробнее о Sentinel см. в разделе [Репликация и персистентность в Yandex Managed Service for Valkey™](../../concepts/replication.md) и [документации Valkey™](https://valkey.io/topics/sentinel/).

## Подключение из графических IDE {#connection-ide}

**Подключение проверялось в следующем окружении:**
* MacOS Big Sur 11.3.
* DBeaver Enterprise: `21.0`.

Подключаться из графических IDE к хостам кластера можно только через [SSH-туннель](../../../glossary/ssh-keygen.md) с помощью [созданной ВМ](index.md). Перед подключением [подготовьте сертификат](index.md#get-ssl-cert).

Чтобы избежать ошибок при подключении, [сохраните сертификат](https://storage.yandexcloud.net/cloud-certs/RootCA.pem) в локальную папку, для доступа к которой не требуются права администратора.

{% list tabs group=ide %}

- DBeaver {#dbeaver}

    Поддержка подключения к кластеру Valkey™ доступна только в [коммерческих редакциях DBeaver](https://dbeaver.com/buy/).

    Чтобы подключиться к кластеру:

    1. Создайте новое соединение с БД:
        1. Выберите в меню **База данных** пункт **Новое соединение**.
        1. Выберите из списка БД **Valkey™**.
        1. Нажмите кнопку **Далее**.
        1. Укажите параметры подключения на вкладке **Главное**:
            * **Хост** — [FQDN хоста-мастера](fqdn.md) или [особый FQDN](fqdn.md#special-fqdns), всегда указывающий на текущий хост-мастер.
              При подключении к шардированному кластеру укажите через запятую [FQDN хостов-мастеров](fqdn.md) каждого шарда.
            * **Порт** — `6379` для обычного кластера или `6380` для кластера с включенным SSL-шифрованием.
            * В блоке **Аутентификация** укажите пароль от кластера.
        1. На вкладке **SSH**:
            1. Включите настройку **Использовать туннель SSH**.
            1. Укажите параметры SSH-туннеля:
                * **Хост/IP** — публичный IP-адрес [ВМ для подключения](index.md);
                * **Имя пользователя** — логин для подключения к ВМ;
                * **Метод аутентификации** — `Публичный ключ`;
                * **Секретный ключ** — путь к файлу закрытого ключа для подключения к ВМ;
                * **Passphrase** — пароль от закрытого ключа.
        1. На вкладке **SSL**:
            1. Включите настройки **Использовать SSL** и **Пропустить валидацию имени хоста**.
            1. В блоке **Параметры**:
                1. Выберите **Способ** — **Набор сертификатов**.
                1. В поле **Корневой сертификат** укажите путь к сохраненному файлу [SSL-сертификата](index.md#get-ssl-cert).
    1. Нажмите кнопку **Тест соединения ...** для проверки соединения с БД. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
    1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

{% endlist %}

## Подготовка к подключению из Docker-контейнера {#connection-docker}

Чтобы подключаться к кластеру Yandex Managed Service for Valkey™ из Docker-контейнера, добавьте в Dockerfile строки:

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

    ```bash
    # Собрать вручную утилиту redis-tools с поддержкой TLS.
    RUN apt-get update && \
        apt-get install make gcc libssl-dev --yes && \
        wget https://download.redis.io/redis-stable.tar.gz && \
        tar -xzvf redis-stable.tar.gz && \
        cd redis-stable && \
        make BUILD_TLS=yes MALLOC=libc && \
        make install && \
        cp ./src/redis-cli /usr/bin/
    ```


- Подключение с SSL {#with-ssl}

    ```bash
    # Собрать вручную утилиту redis-tools с поддержкой TLS.
    RUN apt-get update && \
        apt-get install wget make gcc libssl-dev --yes && \
        wget https://download.redis.io/redis-stable.tar.gz && \
        tar -xzvf redis-stable.tar.gz && \
        cd redis-stable && \
        make BUILD_TLS=yes MALLOC=libc && \
        make install && \
        cp ./src/redis-cli /usr/bin/ && \
        # Получить SSL-сертификат.
        mkdir --parents ~/.redis && \
        wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
             --output-document ~/.redis/YandexInternalRootCA.crt && \
        chmod 0655 ~/.redis/YandexInternalRootCA.crt
    ```

{% endlist %}