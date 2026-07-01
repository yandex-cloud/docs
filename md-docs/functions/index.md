# Yandex Cloud Functions

Сервис Cloud Functions позволяет запускать приложения в безопасном, отказоустойчивом и масштабируемом окружении без создания и обслуживания виртуальных машин.

# Yandex Cloud Functions

 - [Сопоставление с другими сервисами Yandex Cloud](service-comparison.md)

## Начало работы

 - [Обзор](quickstart/index.md)

### Создание функции

 - [Обзор](quickstart/create-function/index.md)

 - [Node.js](quickstart/create-function/node-function-quickstart.md)

 - [Python](quickstart/create-function/python-function-quickstart.md)

 - [Go](quickstart/create-function/go-function-quickstart.md)

 - [PHP](quickstart/create-function/php-function-quickstart.md)

 - [Bash](quickstart/create-function/bash-function-quickstart.md)

 - [Java](quickstart/create-function/java-function-quickstart.md)

 - [Kotlin](quickstart/create-function/kotlin-function-quickstart.md)

 - [.NET Core](quickstart/create-function/dotnet-function-quickstart.md)

### Создание триггера

 - [Обзор](quickstart/create-trigger/index.md)

 - [Таймер](quickstart/create-trigger/timer-quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Получение IAM-токена сервисного аккаунта с помощью функции](operations/function-sa.md)

 - [Подключение к управляемым БД из функции](operations/database-connection.md)

### Получение информации о функции

 - [Получить список функций](operations/function/function-list.md)

 - [Получить список версий функции](operations/function/version-list.md)

 - [Получить информацию о функции](operations/function/function-info.md)

 - [Получить информацию о версии функции](operations/function/version-info.md)

 - [Настроить параметры сервиса метаданных](operations/function/metadata-options.md)

### Управление правами доступа к функции

 - [Сделать функцию публичной](operations/function/function-public.md)

 - [Сделать функцию приватной](operations/function/function-private.md)

 - [Посмотреть роли, назначенные на функцию](operations/function/role-list.md)

 - [Назначить роли на функцию](operations/function/role-add.md)

 - [Отозвать роли, назначенные на функцию](operations/function/role-revoke.md)

### Создание функции

 - [Создать функцию](operations/function/function-create.md)

 - [Создать версию функции](operations/function/version-manage.md)

### Вызов функции

 - [Вызвать функцию](operations/function/function-invoke.md)

 - [Вызвать функцию асинхронно](operations/function/function-invoke-async.md)

 - [Аутентифицироваться при вызове приватной функции через HTTPS](operations/function/auth.md)

### Управление функцией

#### Изменить функцию

 - [Изменить имя](operations/function/name-update.md)

 - [Изменить описание](operations/function/description-update.md)

#### Масштабировать функцию

 - [Посмотреть настройки масштабирования](operations/function/scaling-settings-list.md)

 - [Добавить настройки масштабирования](operations/function/scaling-settings-add.md)

 - [Удалить настройки масштабирования](operations/function/scaling-settings-delete.md)

 - [Добавить переменные окружения](operations/function/environment-variables-add.md)

 - [Указать облачную сеть](operations/function/network-add.md)

 - [Передать секреты Yandex Lockbox](operations/function/lockbox-secret-transmit.md)

 - [Выделить память для директории /tmp](operations/function/allocate-memory-tmp.md)

#### Смонтировать внешние ресурсы на файловую систему функции

 - [Смонтировать бакеты](operations/function/mount-bucket.md)

 - [Смонтировать эфемерный диск](operations/function/mount-ephemeral-disk.md)

 - [Задать количество одновременных вызовов экземпляра функции](operations/function/concurrency.md)

#### Управлять тегами

 - [Добавить тег](operations/function/tag-add.md)

 - [Удалить тег](operations/function/tag-delete.md)

#### Управлять метками

 - [Добавить метку](operations/function/label-add.md)

 - [Изменить метку](operations/function/label-update.md)

 - [Удалить метку](operations/function/label-delete.md)

 - [Посмотреть графики мониторинга](operations/function/function-monitoring.md)

#### Управлять логами

 - [Посмотреть логи](operations/function/function-logs.md)

 - [Записать логи](operations/function/logs-write.md)

 - [Миграция в зону ru-central1-d](operations/function/migration.md)

 - [Удалить версию функции](operations/function/version-delete.md)

 - [Удалить функцию](operations/function/function-delete.md)

### Получение информации о триггере

 - [Получить список триггеров](operations/trigger/trigger-list.md)

 - [Получить информацию о триггере](operations/trigger/trigger-info.md)

### Создание триггера

 - [Создать таймер](operations/trigger/timer-create.md)

 - [Создать триггер для Message Queue](operations/trigger/ymq-trigger-create.md)

 - [Создать триггер для Object Storage](operations/trigger/os-trigger-create.md)

 - [Создать триггер для Container Registry](operations/trigger/cr-trigger-create.md)

 - [Создать триггер для Cloud Logging](operations/trigger/cloud-logging-trigger-create.md)

#### Создать триггер для Yandex IoT Core

 - [Устройство](operations/trigger/iot-core-trigger-create.md)

 - [Брокер](operations/trigger/iot-core-trigger-broker-create.md)

 - [Создать триггер для бюджетов](operations/trigger/budget-trigger-create.md)

 - [Создать триггер для Data Streams](operations/trigger/data-streams-trigger-create.md)

 - [Создать триггер для почты](operations/trigger/mail-trigger-create.md)

### Управление триггером

 - [Изменить триггер](operations/trigger/trigger-update.md)

#### Управлять метками

 - [Добавить метку](operations/trigger/label-add.md)

 - [Изменить метку](operations/trigger/label-update.md)

 - [Удалить метку](operations/trigger/label-delete.md)

 - [Посмотреть графики мониторинга](operations/trigger/trigger-monitoring.md)

 - [Удалить триггер](operations/trigger/trigger-delete.md)

 - [Просмотр операций с ресурсами сервиса](operations/operation-logs.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Функция](concepts/function.md)

 - [Вызов функции](concepts/function-invoke.md)

 - [Асинхронный вызов функции](concepts/function-invoke-async.md)

 - [Долгоживущие функции](concepts/long-lived-functions.md)

 - [Уведомления о завершении выполнения функции](concepts/termination-notifications.md)

 - [Сетевое взаимодействие](concepts/networking.md)

### Среда выполнения

 - [Обзор](concepts/runtime/index.md)

 - [Окружение](concepts/runtime/environment-variables.md)

 - [Контекст выполнения](concepts/runtime/execution-context.md)

 - [Предзагружаемая среда выполнения](concepts/runtime/preload-runtime.md)

 - [Монтирование внешних ресурсов на файловую систему функции](concepts/mounting.md)

 - [Сборщик](concepts/builder.md)

### Триггер

 - [Обзор](concepts/trigger/index.md)

 - [Таймер](concepts/trigger/timer.md)

 - [Триггер для Message Queue](concepts/trigger/ymq-trigger.md)

 - [Триггер для Object Storage](concepts/trigger/os-trigger.md)

 - [Триггер для Container Registry](concepts/trigger/cr-trigger.md)

 - [Триггер для Cloud Logging](concepts/trigger/cloud-logging-trigger.md)

 - [Триггер для Yandex IoT Core](concepts/trigger/iot-core-trigger.md)

 - [Триггер для бюджетов](concepts/trigger/budget-trigger.md)

 - [Триггер для Data Streams](concepts/trigger/data-streams-trigger.md)

 - [Триггер для почты](concepts/trigger/mail-trigger.md)

 - [Dead Letter Queue](concepts/dlq.md)

 - [Логи функции](concepts/logs.md)

 - [Резервное копирование](concepts/backup.md)

 - [Квоты и лимиты](concepts/limits.md)

## Разработка на Node.js

 - [Обзор](lang/nodejs/index.md)

 - [Управление зависимостями](lang/nodejs/dependencies.md)

 - [Обработчик запросов](lang/nodejs/handler.md)

 - [Контекст вызова](lang/nodejs/context.md)

 - [Журналирование](lang/nodejs/logging.md)

 - [Обработка ошибок](lang/nodejs/errors.md)

 - [Использование SDK](lang/nodejs/sdk.md)

## Разработка на Python

 - [Обзор](lang/python/index.md)

 - [Управление зависимостями](lang/python/dependencies.md)

 - [Обработчик запросов](lang/python/handler.md)

 - [Контекст вызова](lang/python/context.md)

 - [Журналирование](lang/python/logging.md)

 - [Обработка ошибок](lang/python/errors.md)

 - [Использование SDK](lang/python/sdk.md)

## Разработка на Go

 - [Обзор](lang/golang/index.md)

 - [Управление зависимостями](lang/golang/dependencies.md)

 - [Обработчик запросов](lang/golang/handler.md)

 - [Контекст вызова](lang/golang/context.md)

 - [Журналирование](lang/golang/logging.md)

 - [Обработка ошибок](lang/golang/errors.md)

 - [Использование SDK](lang/golang/sdk.md)

## Разработка на PHP

 - [Обзор](lang/php/index.md)

 - [Управление зависимостями](lang/php/dependencies.md)

 - [Обработчик запросов](lang/php/handler.md)

 - [Контекст вызова](lang/php/context.md)

 - [Журналирование](lang/php/logging.md)

 - [Обработка ошибок](lang/php/errors.md)

## Разработка на Bash

 - [Обзор](lang/bash/index.md)

 - [Управление зависимостями](lang/bash/dependencies.md)

 - [Обработчик запросов](lang/bash/handler.md)

 - [Журналирование](lang/bash/logging.md)

 - [Обработка ошибок](lang/bash/errors.md)

 - [Использование SDK](lang/bash/sdk.md)

## Разработка на Java

 - [Обзор](lang/java/index.md)

### Модель программирования

 - [Обзор](lang/java/model/index.md)

 - [Интерфейс Function](lang/java/model/jdk-function.md)

 - [Интерфейс YcFunction](lang/java/model/yc-function.md)

 - [Класс HttpServlet](lang/java/model/servlet-api.md)

 - [Spring Boot](lang/java/model/spring-boot.md)

 - [Управление зависимостями](lang/java/dependencies.md)

 - [Обработчик запросов](lang/java/handler.md)

 - [Контекст вызова](lang/java/context.md)

 - [Журналирование](lang/java/logging.md)

 - [Обработка ошибок](lang/java/errors.md)

 - [Использование SDK](lang/java/sdk.md)

## Разработка на Kotlin

 - [Обзор](lang/kotlin/index.md)

### Модель программирования

 - [Обзор](lang/kotlin/model/index.md)

 - [Функция верхнего уровня](lang/kotlin/model/top-level-function.md)

 - [Интерфейс YcFunction](lang/kotlin/model/yc-function.md)

 - [Управление зависимостями](lang/kotlin/dependencies.md)

 - [Обработчик запросов](lang/kotlin/handler.md)

 - [Контекст вызова](lang/kotlin/context.md)

 - [Журналирование](lang/kotlin/logging.md)

 - [Обработка ошибок](lang/kotlin/errors.md)

 - [Использование SDK](lang/kotlin/sdk.md)

## Разработка на R

 - [Обзор](lang/r/index.md)

 - [Модель программирования](lang/r/model/index.md)

 - [Управление зависимостями](lang/r/dependencies.md)

 - [Обработчик запросов](lang/r/handler.md)

 - [Контекст вызова](lang/r/context.md)

 - [Журналирование](lang/r/logging.md)

 - [Обработка ошибок](lang/r/errors.md)

## Разработка на .NET Core

 - [Обзор](lang/csharp/index.md)

### Модель программирования

 - [Обзор](lang/csharp/model/index.md)

 - [Интерфейс Function](lang/csharp/model/independent-function.md)

 - [Интерфейс YcFunction](lang/csharp/model/yc-function.md)

 - [Управление зависимостями](lang/csharp/dependencies.md)

 - [Обработчик запросов](lang/csharp/handler.md)

 - [Контекст вызова](lang/csharp/context.md)

 - [Журналирование](lang/csharp/logging.md)

 - [Обработка ошибок](lang/csharp/errors.md)

 - [Использование SDK](lang/csharp/sdk.md)

## Практические руководства

 - [Все практические руководства](tutorials/index.md)

### Бэкенд на Serverless

 - [Развертывание веб-приложения](tutorials/java-servlet-todo-list.md)

#### Конвертация видео в GIF на Python

 - [Обзор](tutorials/video-converting-queue/index.md)

 - [Консоль управления](tutorials/video-converting-queue/console.md)

 - [Terraform](tutorials/video-converting-queue/terraform.md)

 - [Разработка пользовательской интеграции](tutorials/api-gw-integration.md)

#### Сокращатель ссылок

 - [Обзор](tutorials/serverless-url-shortener/index.md)

 - [Консоль управления](tutorials/serverless-url-shortener/console.md)

 - [Terraform](tutorials/serverless-url-shortener/terraform.md)

 - [Создание интерактивного serverless-приложения с использованием WebSocket](tutorials/websocket-app.md)

 - [Создание функции Node.js с помощью TypeScript](tutorials/nodejs-typescript.md)

 - [Подключение к базе данных YDB из функции на Python](tutorials/connect-to-ydb.md)

 - [Подключение к базе данных YDB из функции на Node.js](tutorials/connect-to-ydb-nodejs.md)

 - [Канареечный релиз функции Cloud Functions](tutorials/canary-release.md)

 - [Интерактивная отладка функций](tutorials/serverless-live-debug.md)

### Боты на Serverless

 - [Разработка Slack-бота](tutorials/slack-bot-serverless.md)

#### Разработка Telegram-бота

 - [Обзор](tutorials/telegram-bot-serverless/index.md)

 - [Консоль управления](tutorials/telegram-bot-serverless/console.md)

 - [Terraform](tutorials/telegram-bot-serverless/terraform.md)

 - [Разработка Telegram-бота для распознавания текста и аудио](tutorials/recognizer-bot.md)

### ETL на Serverless

 - [Запись данных с устройства в базу данных](tutorials/data-recording.md)

 - [Запись логов балансировщика в PostgreSQL](tutorials/logging.md)

 - [Загрузка данных из Яндекс Директ в витрину Yandex Managed Service for ClickHouse® с использованием Yandex Cloud Functions, Yandex Object Storage и Yandex Data Transfer](tutorials/data-transfer-direct-to-mch.md)

 - [Передача событий Yandex Cloud Postbox в Yandex Data Streams и их анализ с помощью Yandex DataLens](tutorials/events-from-postbox-to-yds.md)

 - [Яндекс Трекер: экспорт и визуализация данных](tutorials/data-from-tracker.md)

#### Поставка данных из Яндекс Формы в Yandex DataLens с использованием Yandex Cloud Functions и Yandex Query

 - [Обзор](tutorials/forms-and-datalens-integration/index.md)

 - [Консоль управления](tutorials/forms-and-datalens-integration/console.md)

 - [Terraform](tutorials/forms-and-datalens-integration/terraform.md)

 - [Интеграция Yandex Cloud Postbox с внешними системами через вебхуки](tutorials/postbox-webhook.md)

### Рабочие процессы и автоматизация на Serverless

 - [Создание триггера для бюджетов, который вызывает функцию для остановки ВМ](tutorials/serverless-trigger-budget-vm.md)

 - [Автоматическое копирование объектов из одного бакета Object Storage в другой](tutorials/bucket-to-bucket.md)

 - [Запуск вычислений по расписанию в DataSphere](tutorials/regular-launch-datasphere.md)

 - [Регулярное асинхронное распознавание аудиофайлов из Object Storage](tutorials/batch-recognition-stt.md)

 - [Развертывание отказоустойчивой архитектуры с прерываемыми ВМ](tutorials/nodejs-cron-restart-vm.md)

 - [Создание триггеров, которые вызывают функции для остановки ВМ и отправки уведомлений в Telegram](tutorials/serverless-trigger-budget-queue-vm-tg.md)

#### Масштабирование группы виртуальных машин по расписанию

 - [Обзор](tutorials/vm-scale-scheduled/index.md)

 - [Консоль управления, CLI и API](tutorials/vm-scale-scheduled/console.md)

 - [Terraform](tutorials/vm-scale-scheduled/terraform.md)

 - [Запуск вычислений в DataSphere с помощью API](tutorials/batch-code-execution.md)

 - [Настройка CI/CD с SourceCraft](tutorials/ci-cd-sourcecraft-functions.md)

 - [Настройка CI/CD с GitHub](tutorials/ci-cd-github-functions.md)

 - [Настройка реагирования в Yandex Cloud Logging и Cloud Functions](tutorials/logging-functions.md)

 - [Разработка функций в Functions Framework и их развертывание в Yandex Serverless Containers](tutorials/functions-framework-to-container.md)

### Интернет вещей

 - [Мониторинг состояния географически распределенных устройств](tutorials/datalens.md)

 - [Мониторинг показаний датчиков и уведомления о событиях](tutorials/monitoring.md)

 - [Эмуляция множества IoT-устройств](tutorials/iot-emulation.md)

### Интеграция с сервисами Яндекса и Yandex Cloud

 - [Разработка навыка Алисы и сайта с авторизацией](tutorials/alice-shareable-todolist.md)

#### Создание навыка Алисы

 - [Обзор](tutorials/alice-skill/index.md)

 - [Консоль управления, CLI и API](tutorials/alice-skill/console.md)

 - [Terraform](tutorials/alice-skill/terraform.md)

### Искусственный интеллект

 - [Создание AI-агента с помощью Cloud Functions](tutorials/create-ai-agent-function.md)

 - [Создание AI-агента со стримингом ответа через веб-сокеты](tutorials/streaming-openai-agent.md)

 - [Инструменты](tools.md)

 - [Правила тарификации](pricing.md)

 - [Управление доступом](security/index.md)

## Справочник CLI (англ.)

 - [Functions](../cli/cli-ref/serverless/cli-ref/function/index.md)

 - [Triggers](../cli/cli-ref/serverless/cli-ref/trigger/index.md)

 - [MDB Proxy](../cli/cli-ref/serverless/cli-ref/mdbproxy/index.md)

 - [Network](../cli/cli-ref/serverless/cli-ref/network/index.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API Functions

 - [Аутентификация в API](api-ref/functions/authentication.md)

### gRPC (англ.)

 - [Overview](functions/api-ref/grpc/index.md)

#### Function

 - [Overview](functions/api-ref/grpc/Function/index.md)

 - [Get](functions/api-ref/grpc/Function/get.md)

 - [List](functions/api-ref/grpc/Function/list.md)

 - [Create](functions/api-ref/grpc/Function/create.md)

 - [Update](functions/api-ref/grpc/Function/update.md)

 - [Delete](functions/api-ref/grpc/Function/delete.md)

 - [DeleteVersion](functions/api-ref/grpc/Function/deleteVersion.md)

 - [GetVersion](functions/api-ref/grpc/Function/getVersion.md)

 - [GetFunctionVersion](functions/api-ref/grpc/Function/getFunctionVersion.md)

 - [GetVersionByTag](functions/api-ref/grpc/Function/getVersionByTag.md)

 - [GetFunctionVersionByTag](functions/api-ref/grpc/Function/getFunctionVersionByTag.md)

 - [ListVersions](functions/api-ref/grpc/Function/listVersions.md)

 - [ListFunctionVersions](functions/api-ref/grpc/Function/listFunctionVersions.md)

 - [SetTag](functions/api-ref/grpc/Function/setTag.md)

 - [RemoveTag](functions/api-ref/grpc/Function/removeTag.md)

 - [ListTagHistory](functions/api-ref/grpc/Function/listTagHistory.md)

 - [ListFunctionTagHistory](functions/api-ref/grpc/Function/listFunctionTagHistory.md)

 - [CreateVersion](functions/api-ref/grpc/Function/createVersion.md)

 - [CreateFunctionVersion](functions/api-ref/grpc/Function/createFunctionVersion.md)

 - [ListRuntimes](functions/api-ref/grpc/Function/listRuntimes.md)

 - [ListOperations](functions/api-ref/grpc/Function/listOperations.md)

 - [ListAccessBindings](functions/api-ref/grpc/Function/listAccessBindings.md)

 - [SetAccessBindings](functions/api-ref/grpc/Function/setAccessBindings.md)

 - [UpdateAccessBindings](functions/api-ref/grpc/Function/updateAccessBindings.md)

 - [ListScalingPolicies](functions/api-ref/grpc/Function/listScalingPolicies.md)

 - [SetScalingPolicy](functions/api-ref/grpc/Function/setScalingPolicy.md)

 - [RemoveScalingPolicy](functions/api-ref/grpc/Function/removeScalingPolicy.md)

#### Network

 - [Overview](functions/api-ref/grpc/Network/index.md)

 - [GetUsed](functions/api-ref/grpc/Network/getUsed.md)

 - [ListUsed](functions/api-ref/grpc/Network/listUsed.md)

 - [ListConnectedResources](functions/api-ref/grpc/Network/listConnectedResources.md)

 - [TriggerUsedCleanup](functions/api-ref/grpc/Network/triggerUsedCleanup.md)

#### Operation

 - [Overview](functions/api-ref/grpc/Operation/index.md)

 - [Get](functions/api-ref/grpc/Operation/get.md)

 - [Cancel](functions/api-ref/grpc/Operation/cancel.md)

### REST (англ.)

 - [Overview](functions/api-ref/index.md)

#### Function

 - [Overview](functions/api-ref/Function/index.md)

 - [Get](functions/api-ref/Function/get.md)

 - [List](functions/api-ref/Function/list.md)

 - [Create](functions/api-ref/Function/create.md)

 - [Update](functions/api-ref/Function/update.md)

 - [Delete](functions/api-ref/Function/delete.md)

 - [DeleteVersion](functions/api-ref/Function/deleteVersion.md)

 - [GetVersion](functions/api-ref/Function/getVersion.md)

 - [GetVersionByTag](functions/api-ref/Function/getVersionByTag.md)

 - [ListVersions](functions/api-ref/Function/listVersions.md)

 - [SetTag](functions/api-ref/Function/setTag.md)

 - [RemoveTag](functions/api-ref/Function/removeTag.md)

 - [ListTagHistory](functions/api-ref/Function/listTagHistory.md)

 - [CreateVersion](functions/api-ref/Function/createVersion.md)

 - [ListRuntimes](functions/api-ref/Function/listRuntimes.md)

 - [ListOperations](functions/api-ref/Function/listOperations.md)

 - [ListAccessBindings](functions/api-ref/Function/listAccessBindings.md)

 - [SetAccessBindings](functions/api-ref/Function/setAccessBindings.md)

 - [UpdateAccessBindings](functions/api-ref/Function/updateAccessBindings.md)

 - [ListScalingPolicies](functions/api-ref/Function/listScalingPolicies.md)

 - [SetScalingPolicy](functions/api-ref/Function/setScalingPolicy.md)

 - [RemoveScalingPolicy](functions/api-ref/Function/removeScalingPolicy.md)

#### Network

 - [Overview](functions/api-ref/Network/index.md)

 - [GetUsed](functions/api-ref/Network/getUsed.md)

 - [ListUsed](functions/api-ref/Network/listUsed.md)

 - [ListConnectedResources](functions/api-ref/Network/listConnectedResources.md)

 - [TriggerUsedCleanup](functions/api-ref/Network/triggerUsedCleanup.md)

#### Operation

 - [Overview](functions/api-ref/Operation/index.md)

 - [Get](functions/api-ref/Operation/get.md)

 - [Cancel](functions/api-ref/Operation/cancel.md)

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

 - [Аудитные логи Audit Trails](at-ref.md)

 - [Публичные материалы](public-talks.md)

 - [История изменений](release-notes.md)

 - [Вопросы и ответы](qa/index.md)

 - [Обучающие курсы](training.md)