# Перенос данных с использованием сервиса {{ data-transfer-full-name }} {#data-transfer}

1. [Подготовьте кластер-источник](../../data-transfer/operations/prepare.md#source-my).
1. [Подготовьте кластер-приемник](../../data-transfer/operations/prepare.md#target-my).
1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create) со следующими параметрами:

    * **Тип базы данных** — `{{ MY }}`.
    * **Параметры эндпоинта** → **Настройки подключения** — `Пользовательская инсталляция`.

        Укажите параметры подключения к кластеру-источнику.

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create) со следующими параметрами:

    * **Тип базы данных** — `{{ MY }}`.
    * **Параметры эндпоинта** → **Настройки подключения** — `Кластер MDB`.

        Укажите идентификатор кластера-приемника.

1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-copy-repl }}_, использующий созданные эндпоинты.
1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate).

    {% note warning %}

    Избегайте любых изменений в схеме данных в кластере-источнике и кластере-приемнике во время работы трансфера. Подробнее см. в разделе [{#T}](../../data-transfer/operations/db-actions.md).

    {% endnote %}

1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.
1. Переведите кластер-источник в режим <q>только чтение</q> и переключите нагрузку на кластер-приемник.
1. На странице [мониторинга трансфера](../../data-transfer/operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum lag on delivery**. Это значит, что на кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
1. [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate) трансфер и дождитесь его перехода в статус {{ dt-status-stopped }}.

    Подробнее о статусах трансфера см. в разделе [Жизненный цикл трансфера](../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. [Удалите остановленный трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.


Реальный пример миграции базы данных {{ MY }} с помощью сервиса {{ data-transfer-name }} см. в разделе [Синхронизация данных из MySQL с помощью {{ data-transfer-full-name }}](../../tutorials/dataplatform/sync-mysql.md).
