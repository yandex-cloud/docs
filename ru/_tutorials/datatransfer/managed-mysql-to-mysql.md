# Перенос данных с использованием сервиса {{ data-transfer-full-name }} {#data-transfer}

1. [Подготовьте базу данных кластера-источника](../../data-transfer/operations/prepare.md#source-my).
1. [Подготовьте базу данных кластера-приемника](../../data-transfer/operations/prepare.md#target-my).
1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

    * **Тип базы данных** — `{{ MY }}`.
    * **Настройки подключения** — `Кластер MDB`.
        Укажите идентификатор кластера-источника.

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

    * **Тип базы данных** — `{{ MY }}`.
    * **Настройки подключения** — `Пользовательская инсталляция`.
        Укажите параметры подключения к кластеру-приемнику.

1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create-transfer) типа _{{ dt-type-copy-repl }}_, использующий созданные эндпоинты.
1. [Активируйте](../../data-transfer/operations/transfer.md#activate-transfer) его.

    {% note warning %}

    Избегайте любых изменений в схеме данных на кластере-источнике и кластере-приемнике во время работы трансфера. Подробнее см. в разделе [{#T}](../../data-transfer/operations/db-actions.md).

    {% endnote %}

1. Дождитесь перехода трансфера в статус **Реплицируется**.
1. Переведите кластер-источник в режим <q>только чтение</q> и переключите нагрузку на кластер-приемник.
1. На странице [мониторинга трансфера](../../data-transfer/operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum lag on delivery, [s]**. Это значит, что на кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
1. [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate-transfer) трансфер и дождитесь его перехода в статус **Остановлен**.

    Подробнее о жизненном цикле трансфера читайте в [документации {{ data-transfer-full-name }}](../../data-transfer/concepts/transfer-lifecycle.md).

1. [Удалите](../../data-transfer/operations/transfer.md#delete-transfer) остановленный трансфер.
1. [Удалите эндпоинты для источника и приемника](../../data-transfer/operations/endpoint/index.md#delete).
