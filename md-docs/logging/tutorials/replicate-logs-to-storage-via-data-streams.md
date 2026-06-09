# Репликация логов в {{ objstorage-full-name }} с помощью {{ yds-full-name }}

С помощью [{{ yds-full-name }}](../../data-streams/index.md) можно настроить автоматическую репликацию логов сервисов и пользовательских приложений в [{{ objstorage-full-name }}](../../storage/index.md).

Решение работает по следующей схеме:
1. В [лог-группу](../concepts/log-group.md) {{ cloud-logging-name }} поступают логи, например с [виртуальной машины](../../compute/concepts/vm.md).
1. В настройках лог-группы указан [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-name }}, в который автоматически транслируются логи.
1. Настроен [трансфер](../../data-transfer/concepts/index.md#transfer) {{ data-transfer-name }}, который забирает данные из потока и сохраняет в [бакет](../../storage/concepts/bucket.md) {{ objstorage-name }}.

Чтобы настроить репликацию логов:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Настройте окружение](#prepare-environment).
1. [Создайте бакет](#create-bucket).
1. [Создайте поток данных](#create-stream).
1. [Подключите поток данных к лог-группе](#stream-log-connect).
1. [Создайте трансфер](#create-transfer).
1. [Проверьте отправку и получение данных](#check-ingestion).

Если вы больше не хотите хранить логи, [удалите используемые ресурсы](#clear-out).

## Перед началом работы {#before-you-begin}

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
* Бакет {{ objstorage-name }}: использование хранилища и выполнение операций с данными (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).


## Настройте окружение {#prepare-environment}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт, например `logs-sa`, c [ролью](../../iam/roles-reference.md#editor) `editor` на каталог.
1. [Настройте](index.md) передачу логов в лог-группу. Например, вы можете [передавать](vm-fluent-bit-logging.md) логи с ВМ или [добавить](../operations/write-logs.md) в лог-группу тестовые записи.

## Создайте бакет {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать [бакет](../../storage/concepts/bucket.md).
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

## Подключите поток данных к лог-группе {#stream-log-connect}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится лог группа.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. Напротив лог-группы, в которую поступают логи, нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В поле **{{ ui-key.yacloud.data-streams.label_data-stream }}** выберите поток `logs-stream`, созданный ранее.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

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
     1. Введите имя созданного ранее [бакета](../../storage/concepts/bucket.md).
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

## Проверьте отправку и получение данных {#check-ingestion}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали [поток данных](../../data-streams/concepts/glossary.md#stream-concepts), [трансфер](../../data-transfer/concepts/index.md##transfer) и [бакет](../../storage/concepts/bucket.md).
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
1. [Удалите объекты в бакете](../../storage/operations/objects/delete.md).
1. [Удалите бакет](../../storage/operations/buckets/delete.md).