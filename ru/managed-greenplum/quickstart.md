# Как начать работать с {{ mgp-short-name }}

Чтобы начать работу с сервисом:

1. [Создайте кластер](#cluster-create).
1. [Подключитесь к БД](#connect).


## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Если у вас еще нет каталога, создайте его:

    {% include [create-folder](../_includes/create-folder.md) %}

1. Подключаться к кластеру можно как изнутри, так и извне {{ yandex-cloud }}:

    * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте виртуальную машину в той же облачной сети, что и кластер БД (на основе [Linux](../compute/quickstart/quick-create-linux.md) или [Windows](../compute/quickstart/quick-create-windows.md)).  
    * Чтобы подключиться к кластеру из интернета, запросите публичный доступ при создании кластера.

    {% note info %}

    Следующий шаг предполагает, что подключение к кластеру производится с ВМ на основе [Linux](../compute/quickstart/quick-create-linux.md).

    {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к виртуальной машине по SSH.
1. Установите необходимые зависимости и клиент PostgreSQL:

    ```bash
    sudo apt update && sudo apt install postgresql-client --yes
    ```


## Создайте кластер {#cluster-create}

1. В консоли управления выберите каталог, в котором нужно создать кластер БД.
1. Выберите сервис **{{ mgp-name }}**.
1. Нажмите кнопку **Создать кластер**.
1. Задайте параметры кластера и нажмите кнопку **Создать кластер**. Процесс подробно рассмотрен в разделе [{#T}](operations/cluster-create.md).
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mgp-short-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

## Подключитесь к кластеру {#connect}

1. Для подключения к кластеру БД получите SSL-сертификат:

    {% include [install-certificate](../_includes/mdb/mgp/install-certificate.md) %}

1. Подключитесь к первичному хосту-мастеру [по особому FQDN](operations/connect.md#fqdn-master), используя `psql`:

    {% include [default-connstring](../_includes/mdb/mgp/default-connstring.md) %}

1. После успешного подключения выполните запрос:

    ```sql
    SELECT version();
    ```

    Кластер вернет используемые версии {{ PG }} и {{ GP }}.

## Что дальше {#whats-next}

* Изучите [концепции сервиса](./concepts/index.md).
* Узнайте подробнее о [создании кластера](./operations/cluster-create.md) и [подключении к кластеру](./operations/connect.md).

{% include [greenplum-trademark](../_includes/mdb/mgp/trademark.md) %}
