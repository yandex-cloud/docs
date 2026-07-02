[Документация Yandex Cloud](../../../../index.md) > [Yandex Serverless Integrations](../../../index.md) > [Пошаговые инструкции](../../index.md) > Workflows > Конструктор шагов рабочего процесса > Обзор

# Обзор конструктора шагов рабочего процесса Workflows

Для настройки интеграционных и управляющих шагов [рабочего процесса](../../../concepts/workflows/workflow.md) вы можете использовать конструктор. Конструктор доступен в [консоли управления](https://console.yandex.cloud) при [создании](../workflow/create-constructor.md) и [изменении](../workflow/update.md) рабочего процесса.

В конструкторе вы можете настроить следующие шаги рабочих процессов:

## Интеграционные шаги {#integration-steps}

* [Модели AI Studio](foundationmodelscall.md)
* [Агент AI Studio](aistudioagent.md)
* [Vector Store](vectorstore.md)
* [Cloud Functions](functioncall.md)
* [Serverless Containers](containercall.md)
* [Yandex Cloud Postbox](postbox.md)
* [Трекер](tracker.md)
* [HTTP](httpcall.md)
* [gRPC](grpccall.md)
* [Object Storage](objectstorage.md)
* [Managed Service for YDB](ydbdocument.md)
* [Data Streams](yds.md)
* [Message Queue](ymq.md)
* [Яндекс Диск](yadisk.md)
* [Workflows](workflow.md)
* [Telegram-бот](telegrambot.md)
* [Database Query](databasequery.md)

## Управляющие шаги {control-steps}

* [Switch](switch.md)
* [Foreach](foreach.md)
* [While](while.md)
* [Parallel](parallel.md)
* [No op](noop.md)
* [Fail](fail.md)
* [Success](success.md)
* [Wait](wait.md)

## Общие настройки {#general-settings}

* [Настроить политику повторных попыток для рабочего процесса](setup-restart-policy.md)
* [Настроить правило перехода по ошибкам](setup-catch-rule.md)