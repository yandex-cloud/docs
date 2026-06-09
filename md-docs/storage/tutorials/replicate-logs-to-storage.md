# Репликация логов в {{ objstorage-full-name }} с помощью Fluent Bit


Агрегаторы данных позволяют транслировать данные, такие как логи, с [виртуальных машин](../../compute/concepts/vm.md) в сервисы просмотра логов и хранения данных.

С предлагаемой инструкцией вы научитесь автоматически реплицировать логи с виртуальной машины в бакет {{ objstorage-name }} с помощью обработчика логов [Fluent Bit](https://fluentbit.io).

Решение, которое описано ниже, работает по следующей схеме:
1. На рабочей ВМ запущен Fluent Bit как [systemd](https://ru.wikipedia.org/wiki/Systemd)-модуль.
1. Fluent Bit собирает логи в соответствии с настройками конфигурации и отправляет их в [поток](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-name }} по протоколу [Amazon Kinesis Data Streams](https://aws.amazon.com/ru/kinesis/data-streams/).
1. В рабочем каталоге настроен [трансфер](../../data-transfer/concepts/index.md#transfer) {{ data-transfer-name }}, который забирает данные из потока и сохраняет в [бакет](../concepts/bucket.md) {{ objstorage-name }}.

Чтобы настроить репликацию логов:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Настройте окружение](#setup).
1. [Создайте бакет {{ objstorage-name }}, в котором будут храниться логи](#create-bucket).
1. [Создайте поток данных {{ yds-name }}](#create-stream).
1. [Создайте трансфер {{ data-transfer-name }}](#create-transfer).
1. [Установите Fluent Bit](#install-fluent-bit).
1. [Подключите Fluent Bit к потоку данных](#connect).
1. [Проверьте отправку и получение данных](#check-ingestion).

Если вы больше не хотите хранить логи, [удалите используемые ресурсы](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Сервис {{ yds-name }} (см. [тарифы {{ yds-name }}](../../data-streams/pricing.md)). Стоимость зависит от режима тарификации:

    * [По выделенным ресурсам](../../data-streams/pricing.md#rules) — оплачивается фиксированная почасовая ставка за установленный лимит пропускной способности и срок хранения сообщений, а также дополнительно количество единиц фактически записанных данных.
    * [По фактическому использованию](../../data-streams/pricing.md#on-demand) (On-demand) — оплачиваются выполненные операции записи и чтения данных, объем считанных/записанных данных, а также объем фактически используемого хранилища для сообщений, по которым не истек срок хранения.

* База данных {{ ydb-name }}, работающая в бессерверном режиме: операции с данными, объем хранимых данных и резервных копий (см. [тарифы {{ ydb-name }}](../../ydb/pricing/index.md)).
* Бакет {{ objstorage-name }}: использование хранилища и выполнение операций с данными (см. [тарифы {{ objstorage-name }}](../pricing.md)).


## Настройте окружение {#setup}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md), например `logs-sa`, с ролью `editor` на каталог.
1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта. Сохраните идентификатор и секретный ключ. Они понадобятся, чтобы авторизоваться в AWS.
1. [Создайте ВМ](../../compute/operations/vm-create/create-linux-vm.md) из публичного образа [Ubuntu 20.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts). В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите сервисный аккаунт, который создали на предыдущем шаге.
1. [Подключитесь к ВМ](../../compute/operations/vm-connect/ssh.md#vm-connect) по [SSH](../../glossary/ssh-keygen.md).
1. Установите на ВМ утилиту [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
1. Выполните команду:

    ```bash
    aws configure
    ```
1. Последовательно введите:

    * `AWS Access Key ID [None]:` — [идентификатор ключа](../../iam/concepts/authorization/access-key.md) сервисного аккаунта.
    * `AWS Secret Access Key [None]:` — [секретный ключ](../../iam/concepts/authorization/access-key.md) сервисного аккаунта.
    * `Default region name [None]:` — регион `{{ region-id }}`.

## Создайте бакет {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать [бакет](../concepts/bucket.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. Введите имя бакета.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_class }}** выберите `{{ ui-key.yacloud.storage.value_cold }}`.
  1. Нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

## Создайте поток данных {#create-stream}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать [поток данных](../../data-streams/concepts/glossary.md#stream-concepts).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-streams.button_create-stream }}**.
  1. Укажите существующую [бессерверную](../../ydb/concepts/serverless-and-dedicated.md#serverless) базу данных {{ ydb-short-name }} или [создайте](../../ydb/quickstart.md#serverless) новую. Если вы создали новую БД, нажмите значок ![refresh-button](../../_assets/data-streams/refresh-button.svg), чтобы обновить список БД.
  1. Введите имя потока данных, например `logs-stream`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  Дождитесь запуска потока данных. Когда поток станет готов к использованию, его статус изменится с `Creating` на `Active`.

{% endlist %}

## Создайте трансфер {#create-transfer}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать [трансфер](../../data-transfer/concepts/index.md#transfer).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer_ru }}**.
  1. Создайте [эндпоинт](../../data-transfer/concepts/index.md#endpoint)-источник:
     1. На вкладке ![endpoint](../../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}** нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.
     1. В поле **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** выберите `{{ ui-key.yacloud.data-transfer.forms.label_source-type }}`.
     1. Введите имя эндпоинта, например `logs-source`.
     1. В списке **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** выберите `Yandex Data Streams`.
     1. Выберите базу данных, которую указали в настройках [потока данных](../../data-streams/concepts/glossary.md#stream-concepts), созданного ранее.
     1. Введите имя потока данных `logs-stream`.
     1. Выберите созданный ранее [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) `logs-sa`.
     1. В блоке **{{ ui-key.yacloud.alb.label_detailed-settings }}** укажите правила конвертации для данных `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_common_cloud_logging.title }}`.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Создайте эндпоинт-приемник:
     1. На вкладке ![endpoint](../../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}** нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.
     1. В поле **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** выберите `{{ ui-key.yacloud.data-transfer.forms.label_target-type }}`.
     1. Введите имя эндпоинта, например `logs-receiver`.
     1. В списке **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** выберите `Object Storage`.
     1. Введите имя созданного ранее [бакета](../concepts/bucket.md).
     1. Выберите созданный ранее сервисный аккаунт `logs-sa`.
     1. В поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}** выберите `JSON`.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Создайте трансфер:
     1. На вкладке ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}** нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-transfer }}**.
     1. Введите имя трансфера, например `logs-transfer`.
     1. Выберите созданный ранее эндпоинт-источник `logs-source`.
     1. Выберите созданный ранее эндпоинт-приемник `logs-receiver`.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Напротив созданного трансфера нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.data-transfer.label_connector-operation-ACTIVATE }}**.

  Дождитесь активации трансфера. Когда трансфер станет готов к использованию, его [статус](../../data-transfer/concepts/transfer-lifecycle.md#statuses) сменится с `{{ ui-key.yacloud.data-transfer.label_connector-status-CREATING }}` на `{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}`.

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
        stream /<регион>/<идентификатор_каталога>/<идентификатор_базы_данных>/<имя_потока_данных>
        endpoint https://yds.serverless.yandexcloud.net
    ```
    Где:

    * `stream` — идентификатор потока данных {{ yds-name }}. 
        >Например, укажите идентификатор потока `/{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/logs-stream`, если:
        >* `logs-stream` — имя потока;
        >* `{{ region-id }}` — регион;
        >* `aoeu1kuk2dht********` — идентификатор каталога;
        >* `cc8029jgtuab********` — идентификатор базы данных {{ ydb-short-name }}.

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

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали [поток данных](../../data-streams/concepts/glossary.md#stream-concepts), [трансфер](../../data-transfer/concepts/index.md##transfer) и [бакет](../concepts/bucket.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
  1. Выберите поток данных `logs-stream`.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}** и посмотрите графики активности потока.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer_ru }}**.
  1. Выберите трансфер `logs-transfer`.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}** и посмотрите графики активности трансфера.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите бакет, созданный ранее.
  1. Проверьте, что в бакете появились объекты. Скачайте и посмотрите полученные файлы с логами.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete).
1. [Удалите поток данных](../../data-streams/operations/manage-streams.md#delete-data-stream).
1. [Удалите объекты в бакете](../operations/objects/delete.md).
1. [Удалите бакет](../operations/buckets/delete.md).