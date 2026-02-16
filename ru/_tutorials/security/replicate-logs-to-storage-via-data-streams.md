# Репликация логов в {{ objstorage-full-name }} с помощью {{ yds-full-name }}

С помощью [{{ yds-full-name }}](../../data-streams/) можно настроить автоматическую репликацию логов сервисов и пользовательских приложений в [{{ objstorage-full-name }}](../../storage/).

Решение работает по следующей схеме:
1. В [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-name }} поступают логи, например с [виртуальной машины](../../compute/concepts/vm.md).
1. В настройках лог-группы указан [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-name }}, в который автоматически транслируются логи.
1. Настроен [трансфер](../../data-transfer/concepts/#transfer) {{ data-transfer-name }}, который забирает данные из потока и сохраняет в [бакет](../../storage/concepts/bucket.md) {{ objstorage-name }}.

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

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

* Сервис {{ yds-name }} (см. [тарифы {{ yds-name }}](../../data-streams/pricing.md)). Стоимость зависит от режима тарификации:

    * [По выделенным ресурсам](../../data-streams/pricing.md#rules) — оплачивается фиксированная почасовая ставка за установленный лимит пропускной способности и срок хранения сообщений, а также дополнительно количество единиц фактически записанных данных.
    * [По фактическому использованию](../../data-streams/pricing.md#on-demand) (On-demand) — оплачиваются выполненные операции записи и чтения данных, объем считанных/записанных данных, а также объем фактически используемого хранилища для сообщений, по которым не истек срок хранения.

* База данных {{ ydb-name }}, работающая в бессерверном режиме: операции с данными, объем хранимых данных и резервных копий (см. [тарифы {{ ydb-name }}](../../ydb/pricing/index.md)).
* Бакет {{ objstorage-name }}: использование хранилища и выполнение операций с данными (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).


## Настройте окружение {#prepare-environment}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт, например `logs-sa`, c [ролью](../../iam/roles-reference.md#editor) `editor` на каталог.
1. [Настройте](../../logging/tutorials/) передачу логов в лог-группу. Например, вы можете [передавать](../../logging/tutorials/vm-fluent-bit-logging.md) логи с ВМ или [добавить](../../logging/operations/write-logs.md) в лог-группу тестовые записи.

{% include [create-bucket](../_tutorials_includes/create-bucket.md) %}

{% include [create-stream](../_tutorials_includes/create-stream.md) %}

## Подключите поток данных к лог-группе {#stream-log-connect}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. Напротив лог-группы, в которую поступают логи, нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В поле **{{ ui-key.yacloud.data-streams.label_data-stream }}** выберите поток `logs-stream`, созданный ранее.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

{% include [create-transfer](../_tutorials_includes/create-transfer.md) %}

{% include [check-ingestion](../_tutorials_includes/check-ingestion.md) %}

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/#delete).
1. [Удалите поток данных](../../data-streams/operations/manage-streams.md#delete-data-stream).
1. [Удалите объекты в бакете](../../storage/operations/objects/delete.md).
1. [Удалите бакет](../../storage/operations/buckets/delete.md).
