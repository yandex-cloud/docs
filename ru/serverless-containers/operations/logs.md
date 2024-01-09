---
title: "Просмотр журнала выполнения в {{ serverless-containers-full-name }}"
description: "Вы можете посмотреть график мониторинга в {{ serverless-containers-full-name }} с помощью консоли управления. Для этого выберите сервис {{ serverless-containers-name }}, нажмите на контейнер, журнал выполнения которого вы хотите посмотреть. В открывшемся окне перейдите в раздел Логи и укажите период. По умолчанию задан период за 1 час. Логи выполнения контейнера хранятся 14 дней. Время в журнале указано по UTC."
---

# Посмотреть логи контейнера

Логи выполнения контейнера хранятся 14 дней. Время в журнале указано по [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Нажмите на контейнер, журнал выполнения которого хотите посмотреть.
    1. Перейдите на вкладку **{{ ui-key.yacloud.common.logs }}** и укажите период, за который хотите посмотреть логи. По умолчанию задан период 1 час.
    
- CLI {#cli}
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %} 

    {% include [timeslot](../../_includes/functions/timeslot.md) %}
   
    {% include [serverless-containers-list-note](../../_includes/serverless-containers/container-list-note.md) %}

    Посмотрите журнал выполнения контейнера:

    ```
    yc logging read --resource-ids=<идентификатор_контейнера>
    ```
    Результат:
    ```
	2021-12-07 10:39:03  INFO START RequestID: 24ad08bd-10f7-4e76-9f08-b2b14b04495b
	2021-12-07 10:39:03       Hi, I'm inside
	2021-12-07 10:39:03       runtime pid 76: exited with 0
	...
	2021-12-07 10:42:04  INFO END RequestID: 24ad08bd-10f7-4e76-9f08-b2b14b04495b
    ```

{% endlist %}

Подробнее о работе с логами в [документации {{ cloud-logging-full-name }}](../../logging/).