---
title: Инструкции по работе с конструктором шагов рабочих процессов
description: Из статьи вы узнаете, как работать с конструктором шагов рабочих процессов {{ sw-full-name }}. Вы научитесь добавлять интеграционные и управляющие шаги в рабочий процесс с помощью конструктора.
---

# Обзор конструктора шагов рабочего процесса {{ sw-name }}

Для настройки интеграционных и управляющих шагов [рабочего процесса](../../../concepts/workflows/workflow.md) вы можете использовать конструктор. Конструктор доступен в [консоли управления]({{ link-console-main }}) при [создании](../workflow/create-constructor.md) и [изменении](../workflow/update.md) рабочего процесса.

В конструкторе вы можете настроить следующие шаги рабочих процессов:

## Интеграционные шаги {#integration-steps}

* [{{ sf-short-name }}](./functioncall.md)
* [{{ serverless-containers-name }}](./containercall.md)
* [{{ postbox-short-name }}](./postbox.md)
* [{{ tracker-name }}](./tracker.md)
* [HTTP](./httpcall.md)
* [gRPC](./grpccall.md)
* [{{ objstorage-name }}](./objectstorage.md)
* [{{ foundation-models-name }}](./foundationmodelscall.md)
* [{{ ydb-name }}](./ydbdocument.md)
* [{{ yds-name }}](./yds.md)
* [{{ message-queue-name }}](./ymq.md)
* [Яндекс Диск](./yadisk.md)
* [{{ sw-name }}](./workflow.md)
* [AI-агент](./aiagent.md)
* [Telegram-бот](./telegrambot.md)

## Управляющие шаги {control-steps}

* [Switch](./switch.md)
* [Foreach](./foreach.md)
* [While](./while.md)
* [Parallel](./parallel.md)
* [No op](./noop.md)
* [Fail](./fail.md)
* [Success](./success.md)
* [Wait](./wait.md)

## Общие настройки {#general-settings}

* [{#T}](./setup-restart-policy.md)
