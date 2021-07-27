---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Как начать работать с {{ mrd-short-name }}


Чтобы начать работу с сервисом:

1. [Создайте кластер](#cluster-create).
1. [Подключитесь к кластеру](#connect).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

1. Подключиться к кластеру можно только изнутри {{ yandex-cloud }}. Для подключения создайте виртуальную машину в той же облачной сети, что и кластер {{ RD }} (на основе [Linux](../compute/quickstart/quick-create-linux.md) или [Windows](../compute/quickstart/quick-create-windows.md)).
1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к виртуальной машине по SSH.
1. Установите на виртуальную машину утилиту [redis-cli](https://redis.io/topics/rediscli), например, так (для Ubuntu 20.04 LTS):

   ```bash
   sudo apt install redis-tools
   ```

## Создайте кластер {#cluster-create}

1. В консоли управления выберите каталог, в котором нужно создать кластер {{ RD }}.
1. Выберите сервис **{{ mrd-full-name }}**.
1. Нажмите кнопку **Создать кластер**.
1. Задайте параметры кластера и нажмите кнопку **Создать кластер**. Процесс подробно рассмотрен в разделе [{#T}](operations/cluster-create.md).
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mrd-short-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

## Подключитесь к кластеру {#connect}

1. Если ваш кластер развернут с версией 6 или выше и включена поддержка TLS, то настройте SSL-сертификат:

    1. Создайте каталог:

        ```bash
        $ mkdir ~/.redis
        ```

    1. Получите сертификат:

        ```bash
        $ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.redis/YandexInternalRootCA.crt
        ```

    1. Настройте права доступа к сертификату:

        ```bash
        $ chmod 0600 ~/.redis/YandexInternalRootCA.crt
        ```
        
1. [Настройте группы безопасности](operations/connect.md#configuring-security-groups) для облачной сети так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.

1. Подключитесь к хосту-мастеру кластера {{ RD }}, используя `redis-cli`.

   {% note info %}

   Для подключения к кластеру с поддержкой TLS [скачайте](https://redis.io/download) архив с исходным кодом утилиты и выполните сборку версии утилиты с TLS командой `make BUILD_TLS=yes`.

   {% endnote %}

   {% include [see-fqdn-in-console](../_includes/mdb/see-fqdn-in-console.md) %}

   Чтобы подключиться:
   - К мастеру через любой хост кластера с помощью [Sentinel](https://redis.io/topics/sentinel) (без TLS):
     1. Получите адрес хоста-мастера, используя Sentinel и любой хост {{ RD }}:
     
        ```bash
        redis-cli -h <FQDN любого хоста {{ RD }}> -p {{ port-mrd-sentinel }} sentinel get-master-addr-by-name <имя кластера {{ RD }}> | head -n 1
        ```

     1. Подключитесь к хосту с этим адресом:

        ```bash
        redis-cli -h <адрес хоста-мастера {{ RD }}> -a <пароль {{ RD }}>
        ```
        
   - Напрямую к хосту-мастеру:

      - Подключитесь без использования TLS:

        ```bash
        redis-cli -h <FQDN хоста-мастера {{ RD }}> -p {{ port-mrd }} -a <пароль {{ RD }}>
        ```

      - Подключитесь с использованием TLS:

        ```bash
        redis-cli -h <FQDN хоста-мастера {{ RD }}> -p {{ port-mrd-tls }} -a <пароль {{ RD }}> --tls --cacert ~/.redis/YandexInternalRootCA.crt
        ```

1. После успешного подключения отправьте команду `PING`. {{ RD }} должен вернуть ответ `PONG`.

## Что дальше {#whats-next}

- Изучите [концепции сервиса](./concepts/index.md).
- Узнайте подробнее о [создании кластера](./operations/cluster-create.md) и [подключении к кластеру](./operations/connect.md).
- Ознакомьтесь с [вопросами и ответами](./qa/general.md).
