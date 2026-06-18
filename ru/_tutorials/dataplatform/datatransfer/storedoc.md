# Миграция данных с использованием сервиса {{ data-transfer-full-name }} {#data-transfer}

1. [Подготовьте кластер-источник](../../../data-transfer/operations/prepare.md#source-mg).
1. [Подготовьте кластер-приемник](../../../data-transfer/operations/prepare.md#target-mg).
1. {% include [source endpoint](../../_tutorials_includes/storedoc-source-endpoint.md) %}
1. {% include [target endpoint](../../_tutorials_includes/storedoc-target-endpoint.md) %}
1. {% include [storedoc transfer](../../_tutorials_includes/storedoc-transfer.md) %}
1. [Активируйте трансфер](../../../data-transfer/operations/transfer.md#activate).
1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.
1. Переведите кластер-источник в режим <q>только чтение</q> и переключите нагрузку на кластер-приемник.
1. На странице [мониторинга трансфера](../../../data-transfer/operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum data transfer delay**. Это значит, что на кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
1. [Деактивируйте](../../../data-transfer/operations/transfer.md#deactivate) трансфер и дождитесь его перехода в статус {{ dt-status-stopped }}.

    Подробнее о статусах трансфера смотрите в разделе [Жизненный цикл трансфера](../../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. [Удалите остановленный трансфер](../../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
