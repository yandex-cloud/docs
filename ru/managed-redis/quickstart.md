# Как начать работать с {{ mrd-name }}

Чтобы начать работу с сервисом:
1. [Создайте кластер](#cluster-create).
1. [Подключитесь к кластеру](#connect).


## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

1. Есл для кластера не настроен публичный доступ, подключиться к нему можно только изнутри {{ yandex-cloud }}. Для подключения создайте виртуальную машину в той же облачной сети, что и кластер {{ RD }} (на основе [Linux](../compute/quickstart/quick-create-linux.md)).
1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).
1. Установите на ВМ утилиту [redis-cli](https://redis.io/topics/rediscli), например, так (для [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts)):

   ```bash
   sudo apt install redis-tools
   ```


## Создайте кластер {#cluster-create}

1. В консоли управления выберите каталог, в котором нужно создать кластер {{ RD }}.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Задайте параметры кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**. Процесс подробно рассмотрен в разделе [{#T}](operations/cluster-create.md).
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mrd-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

## Подключитесь к кластеру {#connect}

1. Если в вашем кластере включена поддержка TLS, получите SSL-сертификат:

    {% include [install-certificate](../_includes/mdb/mrd/install-certificate.md) %}


1. Если вы используете группы безопасности для облачной сети, [настройте их](operations/connect/index.md#configuring-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.

   {% include [preview-pp.md](../_includes/preview-pp.md) %}


1. Подключитесь к кластеру, используя `redis-cli`.

   {% note info %}

   Для подключения к кластеру с поддержкой SSL [скачайте](https://redis.io/download) архив с исходным кодом утилиты и выполните сборку версии утилиты с TLS командой `make BUILD_TLS=yes`.

   {% endnote %}

   {% include [see-fqdn-in-console](../_includes/mdb/see-fqdn-in-console.md) %}

   {% list tabs %}

   - Нешардированный кластер

     **Чтобы подключиться с помощью [Sentinel](https://redis.io/topics/sentinel) (без SSL)**:

     1. Получите адрес хоста-мастера, используя Sentinel и любой хост {{ RD }}:

        ```bash
        redis-cli -h <FQDN любого хоста {{ RD }}> \
          -p {{ port-mrd-sentinel }} \
          sentinel get-master-addr-by-name <имя кластера {{ RD }}> | head -n 1
        ```

     1. Подключитесь к хосту с этим адресом:

        {% include [default-connstring](../_includes/mdb/mrd/default-connstring.md) %}

     **Чтобы подключиться напрямую к мастеру (без SSL):**

     ```bash
     redis-cli -h c-<идентификатор кластера>.rw.{{ dns-zone }} \
       -p {{ port-mrd }} \
       -a <пароль {{ RD }}>
     ```

     **Чтобы подключиться напрямую к мастеру (с SSL):**

     ```bash
     redis-cli -h c-<идентификатор кластера>.rw.{{ dns-zone }} \
       -p {{ port-mrd-tls }} \
       -a <пароль {{ RD }}> \
       --tls \
       --cacert ~/.redis/{{ crt-local-file }}
     ```

   - Шардированный кластер

     **Чтобы подключиться без SSL:**

     ```bash
     redis-cli -h <FQDN хоста-мастера в любом шарде> \
       -p {{ port-mrd }} \
       -a <пароль {{ RD }}>
     ```

     **Чтобы подключиться с SSL:**

     ```bash
     redis-cli -h <FQDN хоста-мастера в любом шарде> \
       -p {{ port-mrd-tls }} \
       -a <пароль {{ RD }}> \
       --tls \
       --cacert ~/.redis/{{ crt-local-file }}
     ```

   {% endlist %}

1. После успешного подключения отправьте команду `PING`. {{ RD }} должен вернуть ответ `PONG`.

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к кластеру](operations/connect/index.md).
* Ознакомьтесь с [вопросами и ответами](qa/general.md).
