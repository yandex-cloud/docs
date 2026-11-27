---
title: Инструкция о том, как добавить записи в лог-группу в {{ cloud-logging-name }}
description: Из статьи вы узнаете, как добавить записи в лог-группу в {{ cloud-logging-name }}.
alternate:
  - href: ru/logging/operations/write-logs.md
    type: text/markdown
    title: Markdown version
---

# Добавление записей

{% note info %}

Вы можете создать триггер, который будет запускать [функцию](../../functions/operations/trigger/cloud-logging-trigger-create.md) {{ sf-name }} или [контейнер](../../serverless-containers/operations/cloud-logging-trigger-create.md) {{ serverless-containers-name }} при добавлении записей в лог-группу.

{% endnote %}

{% include [write-logs](../../_includes/logging/write-logs.md) %}


#### Полезные ссылки {#see-also}

* [Чтение записей](read-logs.md)
* [Мониторинг](monitoring.md)
