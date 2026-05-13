# Пошаговые инструкции для Serverless Integrations

## Workflows {#workflows}

### Получение информации о рабочем процессе {#workflow-get-info}

* [Получить список рабочих процессов](workflows/workflow/get-list.md)
* [Получить информацию о рабочем процессе](workflows/workflow/get-info.md)

### Управление рабочим процессом {#workflow-control}

* [Создать рабочий процесс с помощью конструктора](workflows/workflow/create-constructor.md)
* [Создать рабочий процесс с помощью YaWL-спецификации](workflows/workflow/create-yawl.md)
* [Изменить рабочий процесс](workflows/workflow/update.md)
* [Указать облачную сеть, в которой будет выполняться рабочий процесс](workflows/workflow/network-add.md)
* [Добавить метку](workflows/workflow/label-add.md)
* [Изменить метку](workflows/workflow/label-update.md)
* [Удалить метку](workflows/workflow/label-delete.md)
* [Посмотреть логи рабочего процесса](workflows/workflow/logs-read.md)
* [Записать логи в журнал выполнения рабочего процесса](workflows/workflow/logs-write.md)
* [Посмотреть графики мониторинга рабочего процесса](workflows/workflow/monitoring.md)
* [Удалить рабочий процесс](workflows/workflow/delete.md)

### Конструктор шагов рабочего процесса {#constructor}

* [Модели AI Studio](workflows/constructor/foundationmodelscall.md)
* [Агент AI Studio](workflows/constructor/aistudioagent.md)
* [Vector Store](workflows/constructor/vectorstore.md)
* [Cloud Functions](workflows/constructor/functioncall.md)
* [Serverless Containers](workflows/constructor/containercall.md)
* [Yandex Cloud Postbox](workflows/constructor/postbox.md)
* [Трекер](workflows/constructor/tracker.md)
* [HTTP](workflows/constructor/httpcall.md)
* [gRPC](workflows/constructor/grpccall.md)
* [Object Storage](workflows/constructor/objectstorage.md)
* [Managed Service for YDB](workflows/constructor/ydbdocument.md)
* [Data Streams](workflows/constructor/yds.md)
* [Message Queue](workflows/constructor/ymq.md)
* [Яндекс Диск](workflows/constructor/yadisk.md)
* [Workflows](workflows/constructor/workflow.md)
* [AI-агент](workflows/constructor/aiagent.md)
* [Telegram-бот](workflows/constructor/telegrambot.md)
* [Database Query](workflows/constructor/databasequery.md)
* [Switch](workflows/constructor/switch.md)
* [Foreach](workflows/constructor/foreach.md)
* [While](workflows/constructor/while.md)
* [Parallel](workflows/constructor/parallel.md)
* [No op](workflows/constructor/noop.md)
* [Fail](workflows/constructor/fail.md)
* [Success](workflows/constructor/success.md)
* [Wait](workflows/constructor/wait.md)
* [Настроить политику повторных попыток для рабочего процесса](workflows/constructor/setup-restart-policy.md)
* [Настроить правило перехода по ошибкам](workflows/constructor/setup-catch-rule.md)

### Получение информации о запуске рабочего процесса {#execution-get-info}

* [Получить список запусков рабочего процесса](workflows/execution/get-list.md)
* [Получить информацию о запуске рабочего процесса](workflows/execution/get-info.md)
* [Получить детальную информацию о выполнении каждого шага рабочего процесса](workflows/execution/get-history.md)

### Управление запуском рабочего процесса {#execution-control}

* [Запустить рабочий процесс](workflows/execution/start.md)
* [Запустить рабочий процесс по таймеру](workflows/execution/start-by-timer.md)
* [Остановить запуск рабочего процесса](workflows/execution/stop.md)
* [Прекратить запуск рабочего процесса](workflows/execution/terminate.md)

### Управление правами доступа к рабочим процессам {#sw-access-rights}

* [Посмотреть роли, назначенные на рабочий процесс](workflows/access-rights/role-list.md)
* [Назначить роли на рабочий процесс](workflows/access-rights/role-add.md)
* [Отозвать роли, назначенные на рабочий процесс](workflows/access-rights/role-revoke.md)

### Получение дополнительной информации {#get-additional-info}

* [Просмотр операций с ресурсами сервиса](operation-logs.md)

## EventRouter {#event-router}

### Получение информации о шине {#bus-get-info}

* [Получить список шин](eventrouter/bus/get-list.md)
* [Получить информацию о шине](eventrouter/bus/get-info.md)

### Управление шиной {#bus-control}

* [Создать шину](eventrouter/bus/create.md)
* [Изменить шину](eventrouter/bus/update.md)
* [Записать логи в журнал выполнения шины](eventrouter/bus/logs-write.md)
* [Добавить метку](eventrouter/bus/label-add.md)
* [Изменить метку](eventrouter/bus/label-update.md)
* [Удалить метку](eventrouter/bus/label-delete.md)
* [Удалить шину](eventrouter/bus/delete.md)

### Отправка событий в шину {#bus-deliver-data}

* [Отправить события в шину напрямую](eventrouter/bus/data-put.md)
* [Отправить события в шину с помощью коннектора](eventrouter/bus/data-send.md)

### Получение информации о коннекторе {#connector-get-info}

* [Получить список коннекторов](eventrouter/connector/get-list.md)
* [Получить информацию о коннекторе](eventrouter/connector/get-info.md)

### Управление коннектором {#connector-control}

* [Создать таймер](eventrouter/connector/create-timer.md)
* [Создать коннектор для API EventRouter](eventrouter/connector/create-api-eventrouter.md)
* [Создать коннектор для Data Streams](eventrouter/connector/create-yds.md)
* [Создать коннектор для Message Queue](eventrouter/connector/create-message-queue.md)
* [Изменить коннектор](eventrouter/connector/update.md)
* [Добавить метку](eventrouter/connector/label-add.md)
* [Изменить метку](eventrouter/connector/label-update.md)
* [Удалить метку](eventrouter/connector/label-delete.md)
* [Запустить коннектор](eventrouter/connector/start.md)
* [Остановить коннектор](eventrouter/connector/stop.md)
* [Удалить коннектор](eventrouter/connector/delete.md)

### Получение информации о правиле {#rule-get-info}

* [Получить список правил](eventrouter/rule/get-list.md)
* [Получить информацию о правиле](eventrouter/rule/get-info.md)

### Управление правилом {#rule-control}

* [Создать правило с приемником Yandex API Gateway](eventrouter/rule/create-api-gw.md)
* [Создать правило с приемником Yandex Cloud Functions](eventrouter/rule/create-functions.md)
* [Создать правило с приемником Yandex Cloud Logging](eventrouter/rule/create-logging.md)
* [Создать правило с приемником Yandex Data Streams](eventrouter/rule/create-data-streams.md)
* [Создать правило с приемником Yandex Message Queue](eventrouter/rule/create-message-queue.md)
* [Создать правило с приемником Yandex Serverless Containers](eventrouter/rule/create-serverless-containers.md)
* [Создать правило с приемником Yandex Workflows](eventrouter/rule/create-workflows.md)
* [Изменить правило](eventrouter/rule/update.md)
* [Добавить приемник](eventrouter/rule/add-target.md)
* [Изменить приемник](eventrouter/rule/update-target.md)
* [Удалить приемник](eventrouter/rule/delete-target.md)
* [Добавить метку](eventrouter/rule/label-add.md)
* [Изменить метку](eventrouter/rule/label-update.md)
* [Удалить метку](eventrouter/rule/label-delete.md)
* [Включить правило](eventrouter/rule/enable.md)
* [Выключить правило](eventrouter/rule/disable.md)
* [Удалить правило](eventrouter/rule/delete.md)

### Управление правами доступа к ресурсам {#er-access-rights}

* [Посмотреть роли, назначенные на ресурс EventRouter](eventrouter/access-rights/role-list.md)
* [Назначить роли на ресурс EventRouter](eventrouter/access-rights/role-add.md)
* [Отозвать роли, назначенные на ресурс EventRouter](eventrouter/access-rights/role-revoke.md)

### Получение дополнительной информации {#get-additional-info}

* [Просмотр операций с ресурсами сервиса](operation-logs.md)