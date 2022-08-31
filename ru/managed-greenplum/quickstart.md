# Как начать работать с {{ mgp-short-name }}

Чтобы начать работу с сервисом:

1. [Создайте кластер](#cluster-create).
1. [Подключитесь к БД](#connect).

{% if audience != "internal" %}

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Если у вас еще нет каталога, создайте его:

    {% include [create-folder](../_includes/create-folder.md) %}

1. Подключаться к кластеру можно как изнутри, так и извне {{ yandex-cloud }}:

    * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте виртуальную машину в той же облачной сети, что и кластер БД (на основе [Linux](../compute/quickstart/quick-create-linux.md){% if product == "cloud-il" %} или [Windows](../compute/quickstart/quick-create-windows.md){% endif %}).
    * Чтобы подключиться к кластеру из интернета, запросите публичный доступ при создании кластера.

    {% note info %}

    Следующий шаг предполагает, что подключение к кластеру производится с ВМ на основе [Linux](../compute/quickstart/quick-create-linux.md).

    {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к виртуальной машине по SSH.
1. Установите необходимые зависимости и клиент PostgreSQL:

    ```bash
    sudo apt update && sudo apt install postgresql-client --yes
    ```

{% else %}

Для внутреннего сервиса MDB развернут [веб-интерфейс]({{ console-link }}), где кластер БД можно накликать. Подробнее про [квоты]({{ link-console-quotas }}) и соответствие ABC-сервисов облакам и каталогам читайте в разделе [{#T}](../mdb/access.md).

## Доступ к кластерам БД {#access}

В [Панчере](https://puncher.yandex-team.ru/) уже сделаны правила для доступа к кластерам MDB: из [серверных сетей Яндекса](https://puncher.yandex-team.ru/?id=5ce6a766d89cb04f14acafb3), и [для штатных разработчиков](https://puncher.yandex-team.ru/?id=61f8da624928bbfd5d61d651).

Если этих правил не хватает, запросите доступ к макросу `_PGAASINTERNALNETS_`. Для подключения к кластерам {{ PG }} нужен доступ к любому входящему и исходящему трафику по любому протоколу с любых IP-адресов.

## Настройка CLI

Если вы планируете использовать CLI, установите и настройте его согласно [инструкции](../cli/quickstart.md).

Если все сделано правильно, должен заработать запрос списка кластеров:

```bash
{{ yc-mdb-pg }} cluster list
```

{% endif %}

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
