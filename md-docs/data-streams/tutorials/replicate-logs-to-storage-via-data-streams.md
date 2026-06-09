# Репликация логов в Yandex Object Storage с помощью Data Streams

# Репликация логов в Yandex Object Storage с помощью Yandex Data Streams

С помощью [Yandex Data Streams](../index.md) можно настроить автоматическую репликацию логов сервисов и пользовательских приложений в [Yandex Object Storage](../../storage/index.md).

Решение работает по следующей схеме:
1. В [лог-группу](../../logging/concepts/log-group.md) Cloud Logging поступают логи, например с [виртуальной машины](../../compute/concepts/vm.md).
1. В настройках лог-группы указан [поток данных](../concepts/glossary.md#stream-concepts) Data Streams, в который автоматически транслируются логи.
1. Настроен [трансфер](../../data-transfer/concepts/index.md#transfer) Data Transfer, который забирает данные из потока и сохраняет в [бакет](../../storage/concepts/bucket.md) Object Storage.

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

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Сервис Data Streams (см. [тарифы Data Streams](../pricing.md)). Стоимость зависит от режима тарификации:

    * [По выделенным ресурсам](../pricing.md#rules) — оплачивается фиксированная почасовая ставка за установленный лимит пропускной способности и срок хранения сообщений, а также дополнительно количество единиц фактически записанных данных.
    * [По фактическому использованию](../pricing.md#on-demand) (On-demand) — оплачиваются выполненные операции записи и чтения данных, объем считанных/записанных данных, а также объем фактически используемого хранилища для сообщений, по которым не истек срок хранения.

* База данных Managed Service for YDB, работающая в бессерверном режиме: операции с данными, объем хранимых данных и резервных копий (см. [тарифы Managed Service for YDB](../../ydb/pricing/index.md)).
* Бакет Object Storage: использование хранилища и выполнение операций с данными (см. [тарифы Object Storage](../../storage/pricing.md)).


## Настройте окружение {#prepare-environment}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт, например `logs-sa`, c [ролью](../../iam/roles-reference.md#editor) `editor` на каталог.
1. [Настройте](../../logging/tutorials/index.md) передачу логов в лог-группу. Например, вы можете [передавать](../../logging/tutorials/vm-fluent-bit-logging.md) логи с ВМ или [добавить](../../logging/operations/write-logs.md) в лог-группу тестовые записи.

## Создайте бакет {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать [бакет](../../storage/concepts/bucket.md).
  1. Перейдите в сервис **Object Storage**.
  1. Нажмите **Создать бакет**.
  1. Введите имя бакета.
  1. В поле **Класс хранилища** выберите `Холодное`.
  1. Нажмите **Создать бакет**.

{% endlist %}

## Создайте поток данных {#create-stream}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать [поток данных](../concepts/glossary.md#stream-concepts).
  1. Перейдите в сервис **Data Streams**.
  1. Нажмите кнопку **Создать поток**.
  1. Укажите существующую [бессерверную](../../ydb/concepts/serverless-and-dedicated.md#serverless) базу данных YDB или [создайте](../../ydb/quickstart.md#serverless) новую. Если вы создали новую БД, нажмите значок ![refresh-button](../../_assets/data-streams/refresh-button.svg), чтобы обновить список БД.
  1. Введите имя потока данных, например `logs-stream`.
  1. Нажмите кнопку **Создать**.

  Дождитесь запуска потока данных. Когда поток станет готов к использованию, его статус изменится с `Creating` на `Active`.

{% endlist %}

## Подключите поток данных к лог-группе {#stream-log-connect}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится лог группа.
  1. Перейдите в сервис **Cloud Logging**.
  1. Напротив лог-группы, в которую поступают логи, нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. В поле **Поток данных** выберите поток `logs-stream`, созданный ранее.
  1. Нажмите кнопку **Сохранить**.

{% endlist %}

## Создайте трансфер {#create-transfer}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать [трансфер](../../data-transfer/concepts/index.md#transfer).
  1. Перейдите в сервис **Data Transfer**.
  1. Создайте [эндпоинт](../../data-transfer/concepts/index.md#endpoint)-источник:
     1. На вкладке ![endpoint](../../_assets/console-icons/aperture.svg) **Эндпоинты** нажмите кнопку **Создать эндпоинт**.
     1. В поле **Направление** выберите `Источник`.
     1. Введите имя эндпоинта, например `logs-source`.
     1. В списке **Тип базы данных** выберите `Yandex Data Streams`.
     1. Выберите базу данных, которую указали в настройках [потока данных](../concepts/glossary.md#stream-concepts), созданного ранее.
     1. Введите имя потока данных `logs-stream`.
     1. Выберите созданный ранее [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) `logs-sa`.
     1. В блоке **Расширенные настройки** укажите правила конвертации для данных `Парсер CloudLogging`.
     1. Нажмите кнопку **Создать**.
  1. Создайте эндпоинт-приемник:
     1. На вкладке ![endpoint](../../_assets/console-icons/aperture.svg) **Эндпоинты** нажмите кнопку **Создать эндпоинт**.
     1. В поле **Направление** выберите `Приёмник`.
     1. Введите имя эндпоинта, например `logs-receiver`.
     1. В списке **Тип базы данных** выберите `Object Storage`.
     1. Введите имя созданного ранее [бакета](../../storage/concepts/bucket.md).
     1. Выберите созданный ранее сервисный аккаунт `logs-sa`.
     1. В поле **Выходной формат** выберите `JSON`.
     1. Нажмите кнопку **Создать**.
  1. Создайте трансфер:
     1. На вкладке ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **Трансферы** нажмите кнопку **Создать трансфер**.
     1. Введите имя трансфера, например `logs-transfer`.
     1. Выберите созданный ранее эндпоинт-источник `logs-source`.
     1. Выберите созданный ранее эндпоинт-приемник `logs-receiver`.
     1. Нажмите кнопку **Создать**.
  1. Напротив созданного трансфера нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **Активировать**.

  Дождитесь активации трансфера. Когда трансфер станет готов к использованию, его [статус](../../data-transfer/concepts/transfer-lifecycle.md#statuses) сменится с `Создается` на `Реплицируется`.

{% endlist %}

## Проверьте отправку и получение данных {#check-ingestion}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали [поток данных](../concepts/glossary.md#stream-concepts), [трансфер](../../data-transfer/concepts/index.md##transfer) и [бакет](../../storage/concepts/bucket.md).
  1. Перейдите в сервис **Data Streams**.
  1. Выберите поток данных `logs-stream`.
  1. Перейдите на вкладку **Мониторинг** и посмотрите графики активности потока.
  1. Перейдите в сервис **Data Transfer**.
  1. Выберите трансфер `logs-transfer`.
  1. Перейдите на вкладку **Мониторинг** и посмотрите графики активности трансфера.
  1. Перейдите в сервис **Object Storage**.
  1. Выберите бакет, созданный ранее.
  1. Проверьте, что в бакете появились объекты. Скачайте и посмотрите полученные файлы с логами.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete).
1. [Удалите поток данных](../operations/manage-streams.md#delete-data-stream).
1. [Удалите объекты в бакете](../../storage/operations/objects/delete.md).
1. [Удалите бакет](../../storage/operations/buckets/delete.md).