[Документация Yandex Cloud](../index.md) > Yandex Serverless Integrations > Serverless Integrations

# Yandex Serverless Integrations

Yandex Serverless Integrations — это сервис для настройки интеграций и управления ими с помощью serverless-технологий в Yandex Cloud.

Serverless Integrations позволяет:<ul><li>разрабатывать микросервисные архитектуры без необходимости конфигурировать виртуальные машины;</li> <li>создавать и автоматизировать рабочие процессы для реагирования на инциденты безопасности;</li> <li>автоматизировать бизнес-операции;</li> <li>настраивать пайпланы CI/CD;</li> <li>разрабатывать событийно-ориентированные приложения на базе serverless, используя оркестрацию и хореографию, чтобы организовывать взаимодействие между событиями и управлять ими.</li></ul>

Workflows и EventRouter находятся на стадии <a href="../overview/concepts/launch-stages.md">Preview</a>.

О том, как управлять API-шлюзами, которые поддерживают <a href="https://github.com/OAI/OpenAPI-Specification">спецификацию OpenAPI 3.0</a> и  набор расширений для взаимодействия с сервисами Yandex Cloud,  читайте в <a href="../api-gateway/index.md">документации Yandex API Gateway</a>.

# Yandex Serverless Integrations

 - [Сопоставление с другими сервисами Yandex Cloud](service-comparison.md)

## Начало работы

 - [Обзор](quickstart/index.md)

 - [Workflows](quickstart/workflows.md)

 - [EventRouter](quickstart/eventrouter.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Workflows

#### Получение информации о рабочем процессе

 - [Получить список рабочих процессов](operations/workflows/workflow/get-list.md)

 - [Получить информацию о рабочем процессе](operations/workflows/workflow/get-info.md)

#### Управление правами доступа к рабочему процессу

 - [Сделать рабочий процесс публичным](operations/workflows/workflow/make-public.md)

 - [Сделать рабочий процесс приватным](operations/workflows/workflow/make-private.md)

 - [Посмотреть роли, назначенные на рабочий процесс](operations/workflows/access-rights/role-list.md)

 - [Назначить роли на рабочий процесс](operations/workflows/access-rights/role-add.md)

 - [Отозвать роли, назначенные на рабочий процесс](operations/workflows/access-rights/role-revoke.md)

#### Управление рабочим процессом

##### Создать рабочий процесс

 - [Конструктор](operations/workflows/workflow/create-constructor.md)

 - [YaWL-спецификация](operations/workflows/workflow/create-yawl.md)

 - [Изменить рабочий процесс](operations/workflows/workflow/update.md)

 - [Указать облачную сеть](operations/workflows/workflow/network-add.md)

##### Управлять метками

 - [Добавить метку](operations/workflows/workflow/label-add.md)

 - [Изменить метку](operations/workflows/workflow/label-update.md)

 - [Удалить метку](operations/workflows/workflow/label-delete.md)

 - [Посмотреть графики мониторинга](operations/workflows/workflow/monitoring.md)

##### Управлять логами

 - [Посмотреть логи](operations/workflows/workflow/logs-read.md)

 - [Записать логи](operations/workflows/workflow/logs-write.md)

 - [Удалить рабочий процесс](operations/workflows/workflow/delete.md)

#### Конструктор шагов рабочего процесса

 - [Обзор](operations/workflows/constructor/index.md)

##### Интеграционные шаги

 - [Модели AI Studio](operations/workflows/constructor/foundationmodelscall.md)

 - [Агент AI Studio](operations/workflows/constructor/aistudioagent.md)

 - [Vector Store](operations/workflows/constructor/vectorstore.md)

 - [Cloud Functions](operations/workflows/constructor/functioncall.md)

 - [Serverless Containers](operations/workflows/constructor/containercall.md)

 - [Yandex Cloud Postbox](operations/workflows/constructor/postbox.md)

 - [Трекер](operations/workflows/constructor/tracker.md)

 - [HTTP](operations/workflows/constructor/httpcall.md)

 - [gRPC](operations/workflows/constructor/grpccall.md)

 - [Object Storage](operations/workflows/constructor/objectstorage.md)

 - [Managed Service for YDB](operations/workflows/constructor/ydbdocument.md)

 - [Data Streams](operations/workflows/constructor/yds.md)

 - [Message Queue](operations/workflows/constructor/ymq.md)

 - [Яндекс Диск](operations/workflows/constructor/yadisk.md)

 - [Workflows](operations/workflows/constructor/workflow.md)

 - [Telegram-бот](operations/workflows/constructor/telegrambot.md)

 - [Database Query](operations/workflows/constructor/databasequery.md)

##### Управляющие шаги

 - [Switch](operations/workflows/constructor/switch.md)

 - [Foreach](operations/workflows/constructor/foreach.md)

 - [While](operations/workflows/constructor/while.md)

 - [Parallel](operations/workflows/constructor/parallel.md)

 - [No op](operations/workflows/constructor/noop.md)

 - [Fail](operations/workflows/constructor/fail.md)

 - [Success](operations/workflows/constructor/success.md)

 - [Wait](operations/workflows/constructor/wait.md)

 - [Настроить политику повторных попыток для рабочего процесса](operations/workflows/constructor/setup-restart-policy.md)

 - [Настроить правило перехода по ошибкам](operations/workflows/constructor/setup-catch-rule.md)

#### Получение информации о запуске рабочего процесса

 - [Получить список запусков рабочего процесса](operations/workflows/execution/get-list.md)

 - [Получить информацию о запуске рабочего процесса](operations/workflows/execution/get-info.md)

 - [Получить информацию о выполнении каждого шага](operations/workflows/execution/get-history.md)

#### Управление запуском рабочего процесса

##### Запустить рабочий процесс

 - [С помощью консоли управления, CLI и API](operations/workflows/execution/start.md)

 - [По таймеру](operations/workflows/execution/start-by-timer.md)

 - [По ссылке](operations/workflows/execution/start-by-link.md)

 - [Остановить запуск рабочего процесса](operations/workflows/execution/stop.md)

 - [Прекратить запуск рабочего процесса](operations/workflows/execution/terminate.md)

### EventRouter

#### Получение информации о шине

 - [Получить список шин](operations/eventrouter/bus/get-list.md)

 - [Получить информацию о шине](operations/eventrouter/bus/get-info.md)

#### Управление шиной

 - [Создать шину](operations/eventrouter/bus/create.md)

 - [Изменить шину](operations/eventrouter/bus/update.md)

 - [Записать логи](operations/eventrouter/bus/logs-write.md)

##### Управлять метками

 - [Добавить метку](operations/eventrouter/bus/label-add.md)

 - [Изменить метку](operations/eventrouter/bus/label-update.md)

 - [Удалить метку](operations/eventrouter/bus/label-delete.md)

 - [Удалить шину](operations/eventrouter/bus/delete.md)

#### Отправка событий в шину

 - [Отправить события напрямую](operations/eventrouter/bus/data-put.md)

 - [Отправить события с помощью коннектора](operations/eventrouter/bus/data-send.md)

#### Получение информации о коннекторе

 - [Получить список коннекторов](operations/eventrouter/connector/get-list.md)

 - [Получить информацию о коннекторе](operations/eventrouter/connector/get-info.md)

#### Управление коннектором

##### Создать коннектор

 - [Таймер](operations/eventrouter/connector/create-timer.md)

 - [API EventRouter](operations/eventrouter/connector/create-api-eventrouter.md)

 - [Data Streams](operations/eventrouter/connector/create-yds.md)

 - [Message Queue](operations/eventrouter/connector/create-message-queue.md)

 - [Изменить коннектор](operations/eventrouter/connector/update.md)

##### Управлять метками

 - [Добавить метку](operations/eventrouter/connector/label-add.md)

 - [Изменить метку](operations/eventrouter/connector/label-update.md)

 - [Удалить метку](operations/eventrouter/connector/label-delete.md)

 - [Запустить коннектор](operations/eventrouter/connector/start.md)

 - [Остановить коннектор](operations/eventrouter/connector/stop.md)

 - [Удалить коннектор](operations/eventrouter/connector/delete.md)

#### Получение информации о правиле

 - [Получить список правил](operations/eventrouter/rule/get-list.md)

 - [Получить информацию о правиле](operations/eventrouter/rule/get-info.md)

#### Управление правилом

##### Создать правило

 - [API Gateway](operations/eventrouter/rule/create-api-gw.md)

 - [Cloud Functions](operations/eventrouter/rule/create-functions.md)

 - [Cloud Logging](operations/eventrouter/rule/create-logging.md)

 - [Data Streams](operations/eventrouter/rule/create-data-streams.md)

 - [Message Queue](operations/eventrouter/rule/create-message-queue.md)

 - [Serverless Containers](operations/eventrouter/rule/create-serverless-containers.md)

 - [Workflows](operations/eventrouter/rule/create-workflows.md)

 - [Изменить правило](operations/eventrouter/rule/update.md)

##### Управлять приемниками

 - [Добавить приемник](operations/eventrouter/rule/add-target.md)

 - [Изменить приемник](operations/eventrouter/rule/update-target.md)

 - [Удалить приемник](operations/eventrouter/rule/delete-target.md)

##### Управлять метками

 - [Добавить метку](operations/eventrouter/rule/label-add.md)

 - [Изменить метку](operations/eventrouter/rule/label-update.md)

 - [Удалить метку](operations/eventrouter/rule/label-delete.md)

 - [Включить правило](operations/eventrouter/rule/enable.md)

 - [Выключить правило](operations/eventrouter/rule/disable.md)

 - [Удалить правило](operations/eventrouter/rule/delete.md)

#### Управление правами доступа к ресурсам

 - [Посмотреть роли, назначенные на ресурс](operations/eventrouter/access-rights/role-list.md)

 - [Назначить роли на ресурс](operations/eventrouter/access-rights/role-add.md)

 - [Отозвать роли, назначенные на ресурс](operations/eventrouter/access-rights/role-revoke.md)

 - [Просмотр операций с ресурсами сервиса](operations/operation-logs.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Автоматическая загрузка данных в Yandex SpeechSense с помощью Workflows](tutorials/auto-upload.md)

 - [Настройка интеграций Workflows с Яндекс Трекер, Yandex AI Studio и Yandex Cloud Postbox](tutorials/tracker-yandexgpt-postbox-integrations.md)

 - [Разработка Telegram-бота с поддержкой AI-агента](tutorials/telegram-ai-bot-workflows.md)

 - [ИИ-ревью пул-реквестов на GitHub с помощью Workflows и GitHub Actions](tutorials/ai-powered-github-pr-review.md)

## Концепции

 - [Обзор](concepts/index.md)

### Workflows

 - [Рабочий процесс](concepts/workflows/workflow.md)

 - [Запуск рабочего процесса](concepts/workflows/execution.md)

#### Спецификация YaWL

 - [Обзор](concepts/workflows/yawl/index.md)

##### Интеграционные шаги

 - [HTTPCall](concepts/workflows/yawl/integration/httpcall.md)

 - [GRPCCall](concepts/workflows/yawl/integration/grpccall.md)

 - [YMQ](concepts/workflows/yawl/integration/ymq.md)

 - [YDS](concepts/workflows/yawl/integration/yds.md)

 - [YDBDocument](concepts/workflows/yawl/integration/ydbdocument.md)

 - [FunctionCall](concepts/workflows/yawl/integration/functioncall.md)

 - [ContainerCall](concepts/workflows/yawl/integration/containercall.md)

 - [FoundationModelsCall](concepts/workflows/yawl/integration/foundationmodelscall.md)

 - [ObjectStorage](concepts/workflows/yawl/integration/objectstorage.md)

 - [Tracker](concepts/workflows/yawl/integration/tracker.md)

 - [Postbox](concepts/workflows/yawl/integration/postbox.md)

 - [Workflow](concepts/workflows/yawl/integration/workflow.md)

 - [Disk](concepts/workflows/yawl/integration/disk.md)

 - [TelegramBot](concepts/workflows/yawl/integration/telegrambot.md)

 - [AIStudioAgent](concepts/workflows/yawl/integration/aistudioagent.md)

 - [VectorStore](concepts/workflows/yawl/integration/vectorstore.md)

 - [DatabaseQuery](concepts/workflows/yawl/integration/databasequery.md)

##### Управляющие шаги

 - [Switch](concepts/workflows/yawl/management/switch.md)

 - [Foreach](concepts/workflows/yawl/management/foreach.md)

 - [Parallel](concepts/workflows/yawl/management/parallel.md)

 - [Success](concepts/workflows/yawl/management/success.md)

 - [Fail](concepts/workflows/yawl/management/fail.md)

 - [NoOp](concepts/workflows/yawl/management/noop.md)

 - [Wait](concepts/workflows/yawl/management/wait.md)

 - [While](concepts/workflows/yawl/management/while.md)

 - [Шаблонизация](concepts/workflows/templating.md)

### EventRouter

 - [Шина](concepts/eventrouter/bus.md)

 - [Коннектор](concepts/eventrouter/connector.md)

 - [Правило](concepts/eventrouter/rule.md)

 - [Отправка событий в шину](concepts/eventrouter/sending-events.md)

 - [Cron-выражения](concepts/cron.md)

 - [Квоты и лимиты](concepts/limits.md)

## Управление доступом

 - [Обзор](security/index.md)

 - [Роли EventRouter](security/eventrouter.md)

 - [Роли Workflows](security/workflows.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Workflows](../cli/cli-ref/serverless/cli-ref/workflow/index.md)

 - [EventRouter](../cli/cli-ref/serverless/cli-ref/eventrouter/index.md)

 - [Network](../cli/cli-ref/serverless/cli-ref/network/index.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API Workflows

 - [Аутентификация в API](api-ref/workflows/authentication.md)

### gRPC (англ.)

 - [Overview](workflows/api-ref/grpc/index.md)

#### Execution

 - [Overview](workflows/api-ref/grpc/Execution/index.md)

 - [Start](workflows/api-ref/grpc/Execution/start.md)

 - [Stop](workflows/api-ref/grpc/Execution/stop.md)

 - [Terminate](workflows/api-ref/grpc/Execution/terminate.md)

 - [Get](workflows/api-ref/grpc/Execution/get.md)

 - [GetHistory](workflows/api-ref/grpc/Execution/getHistory.md)

 - [List](workflows/api-ref/grpc/Execution/list.md)

#### Operation

 - [Overview](workflows/api-ref/grpc/Operation/index.md)

 - [Get](workflows/api-ref/grpc/Operation/get.md)

 - [Cancel](workflows/api-ref/grpc/Operation/cancel.md)

#### Workflow

 - [Overview](workflows/api-ref/grpc/Workflow/index.md)

 - [Create](workflows/api-ref/grpc/Workflow/create.md)

 - [Update](workflows/api-ref/grpc/Workflow/update.md)

 - [Get](workflows/api-ref/grpc/Workflow/get.md)

 - [Delete](workflows/api-ref/grpc/Workflow/delete.md)

 - [List](workflows/api-ref/grpc/Workflow/list.md)

 - [ListOperations](workflows/api-ref/grpc/Workflow/listOperations.md)

 - [ListAccessBindings](workflows/api-ref/grpc/Workflow/listAccessBindings.md)

 - [SetAccessBindings](workflows/api-ref/grpc/Workflow/setAccessBindings.md)

 - [UpdateAccessBindings](workflows/api-ref/grpc/Workflow/updateAccessBindings.md)

### REST (англ.)

 - [Overview](workflows/api-ref/index.md)

#### Execution

 - [Overview](workflows/api-ref/Execution/index.md)

 - [Start](workflows/api-ref/Execution/start.md)

 - [Stop](workflows/api-ref/Execution/stop.md)

 - [Terminate](workflows/api-ref/Execution/terminate.md)

 - [Get](workflows/api-ref/Execution/get.md)

 - [GetHistory](workflows/api-ref/Execution/getHistory.md)

 - [List](workflows/api-ref/Execution/list.md)

#### Operation

 - [Overview](workflows/api-ref/Operation/index.md)

 - [Get](workflows/api-ref/Operation/get.md)

 - [Cancel](workflows/api-ref/Operation/cancel.md)

#### Workflow

 - [Overview](workflows/api-ref/Workflow/index.md)

 - [Create](workflows/api-ref/Workflow/create.md)

 - [Update](workflows/api-ref/Workflow/update.md)

 - [Get](workflows/api-ref/Workflow/get.md)

 - [Delete](workflows/api-ref/Workflow/delete.md)

 - [List](workflows/api-ref/Workflow/list.md)

 - [ListOperations](workflows/api-ref/Workflow/listOperations.md)

 - [ListAccessBindings](workflows/api-ref/Workflow/listAccessBindings.md)

 - [SetAccessBindings](workflows/api-ref/Workflow/setAccessBindings.md)

 - [UpdateAccessBindings](workflows/api-ref/Workflow/updateAccessBindings.md)

## Справочник API EventRouter

 - [Аутентификация в API](api-ref/eventrouter/authentication.md)

### gRPC (англ.)

 - [Overview](eventrouter/api-ref/grpc/index.md)

#### Bus

 - [Overview](eventrouter/api-ref/grpc/Bus/index.md)

 - [Get](eventrouter/api-ref/grpc/Bus/get.md)

 - [List](eventrouter/api-ref/grpc/Bus/list.md)

 - [Create](eventrouter/api-ref/grpc/Bus/create.md)

 - [Update](eventrouter/api-ref/grpc/Bus/update.md)

 - [Delete](eventrouter/api-ref/grpc/Bus/delete.md)

 - [ListOperations](eventrouter/api-ref/grpc/Bus/listOperations.md)

 - [ListAccessBindings](eventrouter/api-ref/grpc/Bus/listAccessBindings.md)

 - [SetAccessBindings](eventrouter/api-ref/grpc/Bus/setAccessBindings.md)

 - [UpdateAccessBindings](eventrouter/api-ref/grpc/Bus/updateAccessBindings.md)

#### Connector

 - [Overview](eventrouter/api-ref/grpc/Connector/index.md)

 - [Get](eventrouter/api-ref/grpc/Connector/get.md)

 - [List](eventrouter/api-ref/grpc/Connector/list.md)

 - [Create](eventrouter/api-ref/grpc/Connector/create.md)

 - [Update](eventrouter/api-ref/grpc/Connector/update.md)

 - [Delete](eventrouter/api-ref/grpc/Connector/delete.md)

 - [Start](eventrouter/api-ref/grpc/Connector/start.md)

 - [Stop](eventrouter/api-ref/grpc/Connector/stop.md)

 - [ListAccessBindings](eventrouter/api-ref/grpc/Connector/listAccessBindings.md)

 - [SetAccessBindings](eventrouter/api-ref/grpc/Connector/setAccessBindings.md)

 - [UpdateAccessBindings](eventrouter/api-ref/grpc/Connector/updateAccessBindings.md)

 - [ListOperations](eventrouter/api-ref/grpc/Connector/listOperations.md)

#### Event

 - [Overview](eventrouter/api-ref/grpc/Event/index.md)

 - [Put](eventrouter/api-ref/grpc/Event/put.md)

 - [Send](eventrouter/api-ref/grpc/Event/send.md)

#### Operation

 - [Overview](eventrouter/api-ref/grpc/Operation/index.md)

 - [Get](eventrouter/api-ref/grpc/Operation/get.md)

 - [Cancel](eventrouter/api-ref/grpc/Operation/cancel.md)

#### Rule

 - [Overview](eventrouter/api-ref/grpc/Rule/index.md)

 - [Get](eventrouter/api-ref/grpc/Rule/get.md)

 - [List](eventrouter/api-ref/grpc/Rule/list.md)

 - [Create](eventrouter/api-ref/grpc/Rule/create.md)

 - [Update](eventrouter/api-ref/grpc/Rule/update.md)

 - [Delete](eventrouter/api-ref/grpc/Rule/delete.md)

 - [Enable](eventrouter/api-ref/grpc/Rule/enable.md)

 - [Disable](eventrouter/api-ref/grpc/Rule/disable.md)

 - [ListAccessBindings](eventrouter/api-ref/grpc/Rule/listAccessBindings.md)

 - [SetAccessBindings](eventrouter/api-ref/grpc/Rule/setAccessBindings.md)

 - [UpdateAccessBindings](eventrouter/api-ref/grpc/Rule/updateAccessBindings.md)

 - [ListOperations](eventrouter/api-ref/grpc/Rule/listOperations.md)

### REST (англ.)

 - [Overview](eventrouter/api-ref/index.md)

#### Bus

 - [Overview](eventrouter/api-ref/Bus/index.md)

 - [Get](eventrouter/api-ref/Bus/get.md)

 - [List](eventrouter/api-ref/Bus/list.md)

 - [Create](eventrouter/api-ref/Bus/create.md)

 - [Update](eventrouter/api-ref/Bus/update.md)

 - [Delete](eventrouter/api-ref/Bus/delete.md)

 - [ListOperations](eventrouter/api-ref/Bus/listOperations.md)

 - [ListAccessBindings](eventrouter/api-ref/Bus/listAccessBindings.md)

 - [SetAccessBindings](eventrouter/api-ref/Bus/setAccessBindings.md)

 - [UpdateAccessBindings](eventrouter/api-ref/Bus/updateAccessBindings.md)

#### Connector

 - [Overview](eventrouter/api-ref/Connector/index.md)

 - [Get](eventrouter/api-ref/Connector/get.md)

 - [List](eventrouter/api-ref/Connector/list.md)

 - [Create](eventrouter/api-ref/Connector/create.md)

 - [Update](eventrouter/api-ref/Connector/update.md)

 - [Delete](eventrouter/api-ref/Connector/delete.md)

 - [Start](eventrouter/api-ref/Connector/start.md)

 - [Stop](eventrouter/api-ref/Connector/stop.md)

 - [ListAccessBindings](eventrouter/api-ref/Connector/listAccessBindings.md)

 - [SetAccessBindings](eventrouter/api-ref/Connector/setAccessBindings.md)

 - [UpdateAccessBindings](eventrouter/api-ref/Connector/updateAccessBindings.md)

 - [ListOperations](eventrouter/api-ref/Connector/listOperations.md)

#### Operation

 - [Overview](eventrouter/api-ref/Operation/index.md)

 - [Get](eventrouter/api-ref/Operation/get.md)

 - [Cancel](eventrouter/api-ref/Operation/cancel.md)

#### Rule

 - [Overview](eventrouter/api-ref/Rule/index.md)

 - [Get](eventrouter/api-ref/Rule/get.md)

 - [List](eventrouter/api-ref/Rule/list.md)

 - [Create](eventrouter/api-ref/Rule/create.md)

 - [Update](eventrouter/api-ref/Rule/update.md)

 - [Delete](eventrouter/api-ref/Rule/delete.md)

 - [Enable](eventrouter/api-ref/Rule/enable.md)

 - [Disable](eventrouter/api-ref/Rule/disable.md)

 - [ListAccessBindings](eventrouter/api-ref/Rule/listAccessBindings.md)

 - [SetAccessBindings](eventrouter/api-ref/Rule/setAccessBindings.md)

 - [UpdateAccessBindings](eventrouter/api-ref/Rule/updateAccessBindings.md)

 - [ListOperations](eventrouter/api-ref/Rule/listOperations.md)

## Справочник API Triggers

 - [Аутентификация в API](api-ref/triggers/authentication.md)

### gRPC (англ.)

 - [Overview](triggers/api-ref/grpc/index.md)

#### Operation

 - [Overview](triggers/api-ref/grpc/Operation/index.md)

 - [Get](triggers/api-ref/grpc/Operation/get.md)

 - [Cancel](triggers/api-ref/grpc/Operation/cancel.md)

#### Trigger

 - [Overview](triggers/api-ref/grpc/Trigger/index.md)

 - [Get](triggers/api-ref/grpc/Trigger/get.md)

 - [List](triggers/api-ref/grpc/Trigger/list.md)

 - [Create](triggers/api-ref/grpc/Trigger/create.md)

 - [Update](triggers/api-ref/grpc/Trigger/update.md)

 - [Delete](triggers/api-ref/grpc/Trigger/delete.md)

 - [Pause](triggers/api-ref/grpc/Trigger/pause.md)

 - [Resume](triggers/api-ref/grpc/Trigger/resume.md)

 - [ListOperations](triggers/api-ref/grpc/Trigger/listOperations.md)

### REST (англ.)

 - [Overview](triggers/api-ref/index.md)

#### Operation

 - [Overview](triggers/api-ref/Operation/index.md)

 - [Get](triggers/api-ref/Operation/get.md)

 - [Cancel](triggers/api-ref/Operation/cancel.md)

#### Trigger

 - [Overview](triggers/api-ref/Trigger/index.md)

 - [Get](triggers/api-ref/Trigger/get.md)

 - [List](triggers/api-ref/Trigger/list.md)

 - [Create](triggers/api-ref/Trigger/create.md)

 - [Update](triggers/api-ref/Trigger/update.md)

 - [Delete](triggers/api-ref/Trigger/delete.md)

 - [Pause](triggers/api-ref/Trigger/pause.md)

 - [Resume](triggers/api-ref/Trigger/resume.md)

 - [ListOperations](triggers/api-ref/Trigger/listOperations.md)

 - [Метрики Monitoring](metrics.md)

 - [Публичные материалы](public-talks.md)

 - [История изменений](release-notes.md)