# Как начать работать с {{ mms-short-name }}

{% include [ms-licensing-personal-data](../_includes/ms-licensing-personal-data.md) %}

Чтобы начать работу с сервисом:

1. [Создайте кластер](#cluster-create).
1. [Подключитесь к БД](#connect).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Если у вас еще нет каталога, создайте его:

    {% include [create-folder](../_includes/create-folder.md) %}

1. Подключаться к кластерам БД можно как изнутри, так и извне {{ yandex-cloud }}:
   - Чтобы подключиться изнутри {{ yandex-cloud }}, создайте виртуальную машину на основе [Linux](../compute/quickstart/quick-create-linux.md){% if product == "cloud-il" %} или [Windows](../compute/quickstart/quick-create-windows.md){% endif %} в той же сети, что и кластер БД.
   - Чтобы подключиться к кластеру из интернета, запросите публичный доступ к хостам при создании или изменении кластера.

   {% note info %}

   Следующий шаг предполагает, что подключение к кластеру производится с ВМ на основе [Linux](../compute/quickstart/quick-create-linux.md).

   {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к виртуальной машине по SSH.
1. Установите зависимости и клиентское приложение `mssql-cli`:

   ```bash
   sudo apt update && \
   sudo apt install python3-pip python-is-python3 && \
   pip3 install mssql-cli && \
   source ~/.profile
   ```

## Создайте кластер {#cluster-create}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер БД.
1. Выберите сервис **{{ mms-name }}**.
1. Нажмите кнопку **Создать кластер**.
1. Задайте параметры кластера и нажмите кнопку **Создать кластер**. Процесс подробно рассмотрен в разделе [{#T}](operations/cluster-create.md).
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mms-short-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

## Подключитесь к БД {#connect}

1.  Для подключения к серверу БД получите SSL-сертификат:

      {% include [install-certificate](../_includes/mdb/mms/install-certificate.md) %}

1. Используйте для подключения команду `mssql-cli`:

   {% include [default-connstring](../_includes/mdb/mms/default-connstring.md) %}

1. После выполнения команды введите пароль пользователя для завершения процедуры подключения.

## Что дальше {#whats-next}

- Изучите [концепции сервиса](concepts/index.md).
- Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к БД](operations/connect.md).
- Ознакомьтесь с [вопросами и ответами](qa/general.md).
