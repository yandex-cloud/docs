# Обзор начала работы с {{ yq-name }}

{{ yq-full-name }} позволяет выполнять [аналитическую обработку](../concepts/batch-processing.md) хранимых в [{{ objstorage-full-name }}](../../storage/index.yaml) данных, а также [потоковую обработку](../concepts/stream-processing.md) данных реального времени из [{{ yds-full-name }}](../../data-streams/index.yaml). {{ yq-name }} разработан в концепции [объединенных потоковых и аналитических вычислений](../concepts/unified-processing.md), это позволяет с помощью единого запроса обрабатывать как потоковые, так и аналитические данные.

{{ yq-name }} выполняет запросы к данным на диалекте SQL — [YQL](https://ydb.tech/ru/docs/yql/reference/syntax/).

Чтобы ознакомиться с возможностями {{ yq-name }}, выполните следующие инструкции:

* [{#T}](batch-example.md).
* [{#T}](streaming-example.md).
* [{#T}](unified-example.md).
