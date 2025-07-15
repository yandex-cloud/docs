---
title: Инструкции по работе с {{ si-full-name }}
description: Из статьи вы узнаете, как работать с {{ si-full-name }} в {{ yandex-cloud }}.
---

# Пошаговые инструкции для {{ si-name }}

## {{ sw-name }} {#workflows}

### Получение информации о рабочем процессе {#workflow-get-info}

* [{#T}](workflows/workflow/get-list.md)
* [{#T}](workflows/workflow/get-info.md)

### Управление рабочим процессом {#workflow-control}

* [{#T}](workflows/workflow/create-constructor.md)
* [{#T}](workflows/workflow/create-yawl.md)
* [{#T}](workflows/workflow/update.md)
* [{#T}](workflows/workflow/network-add.md)
* [Добавить метку](workflows/workflow/label-add.md)
* [Изменить метку](workflows/workflow/label-update.md)
* [Удалить метку](workflows/workflow/label-delete.md)
* [{#T}](workflows/workflow/logs-read.md)
* [{#T}](workflows/workflow/logs-write.md)
* [{#T}](workflows/workflow/monitoring.md)
* [{#T}](workflows/workflow/delete.md)

### Конструктор шагов рабочего процесса {#constructor}

* [{{ sf-short-name }}](workflows/constructor/functioncall.md)
* [{{ serverless-containers-name }}](workflows/constructor/containercall.md)
* [{{ postbox-short-name }}](workflows/constructor/postbox.md)
* [{{ tracker-name }}](workflows/constructor/tracker.md)
* [HTTP](workflows/constructor/httpcall.md)
* [gRPC](workflows/constructor/grpccall.md)
* [{{ objstorage-name }}](workflows/constructor/objectstorage.md)
* [{{ foundation-models-name }}](workflows/constructor/foundationmodelscall.md)
* [{{ ydb-name }}](workflows/constructor/ydbdocument.md)
* [{{ yds-name }}](workflows/constructor/yds.md)
* [{{ message-queue-name }}](workflows/constructor/ymq.md)
* [Яндекс Диск](workflows/constructor/yadisk.md)
* [{{ sw-name }}](workflows/constructor/workflow.md)
* [AI-агент](workflows/constructor/aiagent.md)
* [Telegram-бот](workflows/constructor/telegrambot.md)
* [Switch](workflows/constructor/switch.md)
* [Foreach](workflows/constructor/foreach.md)
* [While](workflows/constructor/while.md)
* [Parallel](workflows/constructor/parallel.md)
* [No op](workflows/constructor/noop.md)
* [Fail](workflows/constructor/fail.md)
* [Success](workflows/constructor/success.md)
* [Wait](workflows/constructor/wait.md)
* [{#T}](workflows/constructor/setup-restart-policy.md)

### Получение информации о запуске рабочего процесса {#execution-get-info}

* [{#T}](workflows/execution/get-list.md)
* [{#T}](workflows/execution/get-info.md)
* [{#T}](workflows/execution/get-history.md)

### Управление запуском рабочего процесса {#execution-control}

* [{#T}](workflows/execution/start.md)
* [{#T}](workflows/execution/stop.md)
* [{#T}](workflows/execution/terminate.md)

### Получение дополнительной информации {#get-additional-info}

* [Просмотр операций с ресурсами сервиса](operation-logs.md)

## {{ er-name }} {#event-router}

### Получение информации о шине {#bus-get-info}

* [{#T}](eventrouter/bus/get-list.md)
* [{#T}](eventrouter/bus/get-info.md)

### Управление шиной {#bus-control}

* [{#T}](eventrouter/bus/create.md)
* [{#T}](eventrouter/bus/update.md)
* [Добавить метку](eventrouter/bus/label-add.md)
* [Изменить метку](eventrouter/bus/label-update.md)
* [Удалить метку](eventrouter/bus/label-delete.md)
* [{#T}](eventrouter/bus/delete.md)

### Отправка событий в шину {#bus-deliver-data}

* [{#T}](eventrouter/bus/data-put.md)
* [{#T}](eventrouter/bus/data-send.md)

### Получение информации о коннекторе {#connector-get-info}

* [{#T}](eventrouter/connector/get-list.md)
* [{#T}](eventrouter/connector/get-info.md)

### Управление коннектором {#connector-control}

* [{#T}](eventrouter/connector/create-timer.md)
* [{#T}](eventrouter/connector/create-api-eventrouter.md)
* [{#T}](eventrouter/connector/create-yds.md)
* [{#T}](eventrouter/connector/create-message-queue.md)
* [{#T}](eventrouter/connector/update.md)
* [Добавить метку](eventrouter/connector/label-add.md)
* [Изменить метку](eventrouter/connector/label-update.md)
* [Удалить метку](eventrouter/connector/label-delete.md)
* [{#T}](eventrouter/connector/start.md)
* [{#T}](eventrouter/connector/stop.md)
* [{#T}](eventrouter/connector/delete.md)

### Получение информации о правиле {#rule-get-info}

* [{#T}](eventrouter/rule/get-list.md)
* [{#T}](eventrouter/rule/get-info.md)

### Управление правилом {#rule-control}

* [{#T}](eventrouter/rule/create-api-gw.md)
* [{#T}](eventrouter/rule/create-functions.md)
* [{#T}](eventrouter/rule/create-logging.md)
* [{#T}](eventrouter/rule/create-data-streams.md)
* [{#T}](eventrouter/rule/create-message-queue.md)
* [{#T}](eventrouter/rule/create-serverless-containers.md)
* [{#T}](eventrouter/rule/create-workflows.md)
* [{#T}](eventrouter/rule/update.md)
* [{#T}](eventrouter/rule/add-target.md)
* [{#T}](eventrouter/rule/update-target.md)
* [{#T}](eventrouter/rule/delete-target.md)
* [Добавить метку](eventrouter/rule/label-add.md)
* [Изменить метку](eventrouter/rule/label-update.md)
* [Удалить метку](eventrouter/rule/label-delete.md)
* [{#T}](eventrouter/rule/enable.md)
* [{#T}](eventrouter/rule/disable.md)
* [{#T}](eventrouter/rule/delete.md)

### Управление правами доступа к ресурсам {#access-rights}

* [{#T}](eventrouter/access-rights/role-list.md)
* [{#T}](eventrouter/access-rights/role-add.md)
* [{#T}](eventrouter/access-rights/role-revoke.md)

### Получение дополнительной информации {#get-additional-info}

* [Просмотр операций с ресурсами сервиса](operation-logs.md)
