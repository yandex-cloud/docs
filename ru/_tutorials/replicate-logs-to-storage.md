# Репликация логов в {{ objstorage-name }} с помощью Fluent Bit

Агрегаторы данных позволяют транслировать данные, такие как логи, с [виртуальных машин](../compute/concepts/vm.md) в сервисы просмотра логов и хранения данных.

С предлагаемой инструкцией вы научитесь автоматически реплицировать логи с виртуальной машины в бакет {{ objstorage-name }} с помощью обработчика логов [Fluent Bit](https://fluentbit.io).

Решение, которое описано ниже, работает по следующей схеме:
1. На рабочей ВМ запущен Fluent Bit как [systemd](https://ru.wikipedia.org/wiki/Systemd)-модуль.
1. Fluent Bit собирает логи в соответствии с настройками конфигурации и отправляет их в поток {{ yds-name }} по протоколу [Amazon Kinesis Data Streams](https://aws.amazon.com/ru/kinesis/data-streams/).
1. В рабочем каталоге настроен трансфер {{ data-transfer-name }}, который забирает данные из потока и сохраняет в бакет {{ objstorage-name }}.

Чтобы настроить репликацию логов:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Настройте окружение](#setup).
1. [Создайте бакет {{ objstorage-name }}, в котором будут храниться логи](#create-bucket).
1. [Создайте поток данных {{ yds-name }}](#create-stream).
1. [Создайте трансфер {{data-transfer-name}}](#create-transfer).
1. [Установите Fluent Bit](#install-fluent-bit).
1. [Подключите Fluent Bit к потоку данных](#connect).
1. [Проверьте отправку и получение данных](#check-ingestion).

Если вы больше не хотите хранить логи, [удалите используемые ресурсы](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](./_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки хранения данных входит:

* плата за обслуживание потока данных (см. [тарифы {{ yds-name }}](../data-streams/pricing.md));
* плата за перенос данных между источниками и приемниками (см. [тарифы {{ data-transfer-name }}](../data-transfer/pricing.md));
* плата за хранение данных (см. [тарифы {{ objstorage-name }}](../storage/pricing.md)).

## Настройте окружение {#setup}

1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md), например `logs-sa`, с ролью `editor` на каталог.
1. [Создайте статический ключ доступа](../iam/operations/sa/create-access-key.md) для сервисного аккаунта. Сохраните идентификатор и секретный ключ. Они понадобятся, чтобы авторизоваться в AWS.
1. [Создайте ВМ](../compute/operations/vm-create/create-linux-vm.md) из публичного образа [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts). В блоке **Доступ** укажите сервисный аккаунт, который создали на предыдущем шаге.
1. [Подключитесь к ВМ](../compute/operations/vm-connect/ssh.md#vm-connect) по {% if lang == "ru" and audience != "internal" %}[SSH](../glossary/ssh-keygen.md){% else %}SSH{% endif %}.
1. Установите на ВМ утилиту [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
1. Выполните команду:

    ```bash
    aws configure
    ```
1. Последовательно введите:

    * `AWS Access Key ID [None]:` — [идентификатор ключа](../iam/concepts/authorization/access-key.md) сервисного аккаунта.
    * `AWS Secret Access Key [None]:` — [секретный ключ](../iam/concepts/authorization/access-key.md) сервисного аккаунта.
    * `Default region name [None]:` — регион `{{ region-id }}`.

## Создайте бакет {#create-bucket}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [бакет](../storage/concepts/bucket.md).
    1. Выберите сервис **{{ objstorage-name }}**.
    1. Нажмите кнопку **Создать бакет**.
    1. Введите имя бакета, например `logs-bucket`.
    1. В поле **Класс хранилища** выберите `Холодное`.
    1. Нажмите кнопку **Создать бакет**.
  
{% endlist %}

## Создайте поток данных {#create-stream}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [поток данных](../data-streams/concepts/glossary#stream-concepts).
    1. Выберите сервис **{{ yds-name }}**.
    1. Нажмите кнопку **Создать поток**.
    1. Укажите существующую [бессерверную](../ydb/concepts/serverless-and-dedicated.md#serverless) базу данных {{ ydb-short-name }} или [создайте](../ydb/quickstart.md#serverless) новую. Если вы создали новую базу данных, нажмите кнопку ![refresh-button](../_assets/data-streams/refresh-button.svg) **Обновить**, чтобы обновить список баз.
    1. Введите имя потока данных, например `logs-stream`.
    1. Нажмите кнопку **Создать**.

    Дождитесь запуска потока данных. Когда поток станет готов к использованию, его статус изменится с `CREATING` на `ACTIVE`.

{% endlist %}

## Создайте трансфер {#create-transfer}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [трансфер](../data-transfer/concepts/index.md#transfer).
    1. Выберите сервис **{{ data-transfer-name }}**.
    1. Создайте эндпоинт-источник:
        1. Нажмите кнопку **Создать эндпоинт**.
        1. В поле **Направление** выберите `Источник`.
        1. Введите имя эндпоинта, например `logs-source`.
        1. В списке **Тип базы данных** выберите `{{ yds-full-name }}`.
        1. Выберите базу данных для источника.
        1. Введите имя созданного ранее потока данных `logs-stream`.
        1. Выберите созданный ранее сервисный аккаунт `logs-sa`.
        1. Нажмите кнопку **Создать**.
    1. Создайте эндпоинт-приемник:
        1. Нажмите кнопку **Создать эндпоинт**.
        1. В поле **Направление** выберите `Приемник`.
        1. Введите имя эндпоинта, например `logs-receiver`.
        1. В списке **Тип базы данных** выберите `{{ objstorage-name }}`.
        1. Введите имя созданного ранее бакета `logs-bucket`.
        1. Выберите созданный ранее сервисный аккаунт `logs-sa`.
        1. Нажмите кнопку **Создать**.
    1. Создайте трансфер:
        1. На панели слева выберите ![image](../_assets/data-transfer/transfer.svg) **Трансферы**.
        1. Нажмите кнопку **Создать трансфер**.
        1. Введите имя трансфера, например `logs-transfer`.
        1. Выберите созданный ранее эндпоинт-источник `logs-source`.
        1. Выберите созданный ранее эндпоинт-приемник `logs-receiver`.
        1. Нажмите кнопку **Создать**.
        1. Нажмите на значок ![ellipsis](../_assets/horizontal-ellipsis.svg) рядом с именем созданного трансфера и выберите **Активировать**.

    Дождитесь активации трансфера. Когда трансфер станет готов к использованию, его статус сменится с {{ dt-status-creation }} на {{ dt-status-repl }}.

{% endlist %}

## Установите Fluent Bit {#install-fluent-bit}

{% note info %}

В данном руководстве используется актуальная версия Fluent Bit v1.9.

{% endnote %}

1. Чтобы установить Fluent Bit на ВМ, выполните команду:
    ```bash
    curl https://raw.githubusercontent.com/fluent/fluent-bit/master/install.sh | sh
    ```
    Подробнее о том, как установить Fluent Bit, см. в [официальной документации](https://docs.fluentbit.io/manual/installation/linux/ubuntu).

1. Запустите сервис `fluent-bit`:
    ```bash
    sudo systemctl start fluent-bit
    ```
1. Проверьте статус сервиса `fluent-bit`, он должен быть активен:
    ```bash
    sudo systemctl status fluent-bit
    ```

    Результат должен содержать статус `active (running)` и логи встроенного плагина `cpu`, которые Fluent Bit по умолчанию собирает сразу после установки:
    ```bash
    ● fluent-bit.service - Fluent Bit
     Loaded: loaded (/lib/systemd/system/fluent-bit.service; disabled; vendor preset: enabled)
     Active: active (running) since Thu 2022-09-08 10:23:03 UTC; 10s ago
       Docs: https://docs.fluentbit.io/manual/
   Main PID: 1328 (fluent-bit)
      Tasks: 4 (limit: 2310)
     Memory: 2.8M
     CGroup: /system.slice/fluent-bit.service
             └─1328 /opt/fluent-bit/bin/fluent-bit -c //etc/fluent-bit/fluent-bit.conf

     Sep 08 10:23:03 ycl-20 fluent-bit[1328]: [2022/09/08 10:23:03] [ info] [output:stdout:stdout.0] worker #0 started
     Sep 08 10:23:05 ycl-20 fluent-bit[1328]: [0] cpu.local: [1662632584.114661597, {"cpu_p"=>1.000000, "user_p"=>0.000000, >
     Sep 08 10:23:06 ycl-20 fluent-bit[1328]: [0] cpu.local: [1662632585.114797726, {"cpu_p"=>0.000000, "user_p"=>0.000000, >
     ...
     
    ``` 

## Подключите Fluent Bit к потоку данных {#connect}

{% note info %}

Если у вас установлена версия Fluent Bit ниже, чем 1.9, распространяемая как часть пакета `td-agent-bit`, редактируйте файлы `/etc/td-agent-bit/td-agent-bit.conf`, `/lib/systemd/system/td-agent-bit.service` и перезапускайте сервис `td-agent-bit`.

{% endnote %}


1. Откройте файл `/etc/fluent-bit/fluent-bit.conf`: 

   ```bash
   sudo vim  /etc/fluent-bit/fluent-bit.conf
   ```
1. Добавьте блок `OUTPUT` с настройками плагина `kinesis_streams`:

    ```bash
    [OUTPUT]
        Name  kinesis_streams
        Match *
        region ru-central-1
        stream /<регион>/<идентификатор_каталога>/<идентификатор_базы_дфнных>/<имя_потока_данных>
        endpoint https://yds.serverless.yandexcloud.net
    ```
    Где:

    * `stream` — идентификатор потока данных {{ yds-name }}. 
        >Например, укажите идентификатор потока `/{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/logs-stream`, если:
        >* `logs-stream` — имя потока;
        >* `{{ region-id }}` — регион;
        >* `aoeu1kuk2dhtaupdb1es` — идентификатор каталога;
        >* `cc8029jgtuabequtgtbv` — идентификатор базы данных {{ ydb-short-name }}.

    Подробнее о том, как настроить Fluent Bit см. в [официальной документации](https://docs.fluentbit.io/manual/administration/configuring-fluent-bit/classic-mode/configuration-file).

1. Откройте файл `/lib/systemd/system/fluent-bit.service`: 
   ```bash
   sudo vim  /lib/systemd/system/fluent-bit.service
   ```
1. Добавьте в блок `SERVICE` переменные окружения, которые содержат пути к файлам с ключами доступа:
   ```bash
   Environment=AWS_CONFIG_FILE=/home/<имя_пользователя>/.aws/config
   Environment=AWS_SHARED_CREDENTIALS_FILE=/home/<имя_пользователя>/.aws/credentials
   ```

   Где `<имя_пользователя>` — логин, который вы указали в настройках виртуальной машины. 

1. Перезапустите сервис `fluent-bit`:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl restart fluent-bit
   ```
1. Проверьте статус сервиса `fluent-bit`. В нем не должно быть сообщений об ошибках:
    ```bash
    sudo systemctl status fluent-bit
    ```

    Результат:
    ```bash
    Sep 08 16:51:19 ycl-20 fluent-bit[3450]: Fluent Bit v1.9.8
    Sep 08 16:51:19 ycl-20 fluent-bit[3450]: * Copyright (C) 2015-2022 The Fluent Bit Authors
    Sep 08 16:51:19 ycl-20 fluent-bit[3450]: * Fluent Bit is a CNCF sub-project under the umbrella of Fluentd
    Sep 08 16:51:19 ycl-20 fluent-bit[3450]: * https://fluentbit.io
    Sep 08 16:51:19 ycl-20 fluent-bit[3450]: [2022/09/08 16:51:19] [ info] [fluent bit] version=1.9.8, commit=, pid=3450
    Sep 08 16:51:19 ycl-20 fluent-bit[3450]: [2022/09/08 16:51:19] [ info] [storage] version=1.2.0, type=memory-only, sync=normal, checksum=disabled, max_chunks_up=128
    Sep 08 16:51:19 ycl-20 fluent-bit[3450]: [2022/09/08 16:51:19] [ info] [cmetrics] version=0.3.6
    Sep 08 16:51:19 ycl-20 fluent-bit[3450]: [2022/09/08 16:51:19] [ info] [sp] stream processor started
    Sep 08 16:51:19 ycl-20 fluent-bit[3450]: [2022/09/08 16:51:19] [ info] [output:kinesis_streams:kinesis_streams.1] worker #0 started
    Sep 08 16:51:19 ycl-20 fluent-bit[3450]: [2022/09/08 16:51:19] [ info] [output:stdout:stdout.0] worker #0 started
    ```

## Проверьте отправку и получение данных {#check-ingestion}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создали поток данных, трансфер и бакет.
    1. Выберите сервис **{{ yds-name }}**.
    1. Выберите поток данных `logs-stream`.
    1. Перейдите на вкладку **Мониторинг** и посмотрите графики активности потока.
    1. Выберите сервис **{{ data-transfer-name }}**.
    1. Выберите трансфер `logs-transfer`.
    1. Перейдите на вкладку **Мониторинг** и посмотрите графики активности трансфера.
    1. Выберите сервис **{{ objstorage-name }}**.
    1. Выберите бакет `logs-bucket`.
    1. Проверьте, что в бакете появились объекты. Скачайте и посмотрите полученные файлы с логами.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите трансфер](../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../data-transfer/operations/endpoint/index.md#delete).
1. [Удалите поток данных](../data-streams/operations/manage-streams.md#delete-data-stream).
1. [Удалите бакет](../storage/operations/buckets/delete.md).
