# Yandex Serverless Containers

Сервис Yandex Serverless Containers позволяет запускать контейнеризированные приложения в безопасном, отказоустойчивом и масштабируемом окружении без создания и обслуживания виртуальных машин.

# Yandex Serverless Containers

 - [Сопоставление с другими сервисами Yandex Cloud](service-comparison.md)

## Начало работы

 - [Обзор](quickstart/index.md)

 - [Создание контейнера](quickstart/container.md)

### Создание триггера

 - [Обзор](quickstart/create-trigger/index.md)

 - [Таймер](quickstart/timer.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Получение IAM-токена сервисного аккаунта с помощью контейнера](operations/sa.md)

### Получение информации о контейнере

 - [Получить список контейнеров](operations/list.md)

 - [Получить список ревизий контейнера](operations/revision-list.md)

 - [Получить информацию о контейнере](operations/container-info.md)

 - [Получить информацию о ревизии контейнера](operations/revision-info.md)

 - [Настроить параметры сервиса метаданных](operations/metadata-options.md)

### Управление правами доступа к контейнеру

 - [Сделать контейнер публичным](operations/container-public.md)

 - [Сделать контейнер приватным](operations/container-private.md)

 - [Посмотреть роли, назначенные на контейнер](operations/role-list.md)

 - [Назначить роли на контейнер](operations/role-add.md)

 - [Отозвать роли, назначенные на контейнер](operations/role-revoke.md)

### Создание контейнера

 - [Создать контейнер](operations/create.md)

 - [Создать ревизию контейнера](operations/manage-revision.md)

### Вызов контейнера

 - [Вызвать контейнер](operations/invoke.md)

 - [Вызвать контейнер асинхронно](operations/invoke-async.md)

 - [Получить ссылку для вызова](operations/invocation-link.md)

 - [Аутентифицироваться при вызове приватного контейнера через HTTPS](operations/auth.md)

### Управление контейнером

#### Изменить контейнер

 - [Изменить имя](operations/name-update.md)

 - [Изменить описание](operations/description-update.md)

 - [Сделать ревизию активной](operations/activate-revision.md)

 - [Изменить режим работы контейнера](operations/update-runtime.md)

 - [Добавить переменные окружения](operations/environment-variables-add.md)

 - [Передать секреты Yandex Lockbox](operations/lockbox-secret-transmit.md)

 - [Указать облачную сеть](operations/network-add.md)

 - [Задать количество одновременных вызовов экземпляра контейнера](operations/concurrency.md)

#### Масштабировать контейнер

 - [Посмотреть настройки масштабирования](operations/scaling-settings-list.md)

 - [Добавить настройки масштабирования](operations/scaling-settings-add.md)

 - [Удалить настройки масштабирования](operations/scaling-settings-delete.md)

#### Смонтировать внешние ресурсы на файловую систему контейнера

 - [Смонтировать бакеты](operations/mount-bucket.md)

 - [Смонтировать эфемерный диск](operations/mount-ephemeral-disk.md)

#### Управлять метками

 - [Добавить метку](operations/label-add.md)

 - [Изменить метку](operations/label-update.md)

 - [Удалить метку](operations/label-delete.md)

 - [Посмотреть графики мониторинга](operations/monitoring.md)

#### Управлять логами

 - [Посмотреть логи](operations/logs.md)

 - [Записать логи](operations/logs-write.md)

 - [Миграция в зону ru-central1-d](operations/migration.md)

 - [Удалить контейнер](operations/delete.md)

### Получение информации о триггере

 - [Получить список триггеров](operations/trigger-list.md)

 - [Получить информацию о триггере](operations/trigger-info.md)

### Создание триггера

 - [Создать таймер](operations/timer-create.md)

 - [Создать триггер для Message Queue](operations/ymq-trigger-create.md)

 - [Создать триггер для Object Storage](operations/os-trigger-create.md)

 - [Создать триггер для Container Registry](operations/cr-trigger-create.md)

 - [Создать триггер для Cloud Logging](operations/cloud-logging-trigger-create.md)

#### Создать триггер для Yandex IoT Core

 - [Устройство](operations/iot-core-trigger-create.md)

 - [Брокер](operations/iot-core-trigger-broker-create.md)

 - [Создать триггер для бюджетов](operations/budget-trigger-create.md)

 - [Создать триггер для Data Streams](operations/data-streams-trigger-create.md)

 - [Создать триггер для почты](operations/mail-trigger-create.md)

### Управление триггером

 - [Изменить триггер](operations/trigger-update.md)

 - [Посмотреть графики мониторинга](operations/trigger-monitoring.md)

 - [Удалить триггер](operations/trigger-delete.md)

 - [Просмотр операций с ресурсами сервиса](operations/operation-logs.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Контейнер](concepts/container.md)

 - [Вызов контейнера](concepts/invoke.md)

 - [Асинхронный вызов контейнера](concepts/invoke-async.md)

 - [Среда выполнения](concepts/runtime.md)

 - [Сетевое взаимодействие](concepts/networking.md)

 - [Монтирование внешних ресурсов на файловую систему контейнера](concepts/mounting.md)

 - [Долгоживущие контейнеры](concepts/long-lived-containers.md)

 - [Уведомления о завершении выполнения контейнера](concepts/termination-notifications.md)

### Триггер

 - [Обзор](concepts/trigger/index.md)

 - [Таймер](concepts/trigger/timer.md)

 - [Триггер для Message Queue](concepts/trigger/ymq-trigger.md)

 - [Триггер для Object Storage](concepts/trigger/os-trigger.md)

 - [Триггер для Container Registry](concepts/trigger/cr-trigger.md)

 - [Триггер для Yandex Cloud Logging](concepts/trigger/cloud-logging-trigger.md)

 - [Триггер для Yandex IoT Core](concepts/trigger/iot-core-trigger.md)

 - [Триггер для бюджетов](concepts/trigger/budget-trigger.md)

 - [Триггер для Data Streams](concepts/trigger/data-streams-trigger.md)

 - [Триггер для почты](concepts/trigger/mail-trigger.md)

 - [Dead Letter Queue](concepts/dlq.md)

 - [Логи контейнера](concepts/logs.md)

 - [Резервное копирование](concepts/backup.md)

 - [Квоты и лимиты](concepts/limits.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

### Бэкенд на Serverless

 - [Разработка CRUD API для сервиса фильмов](tutorials/movies-database.md)

 - [Запуск контейнерного приложения в Yandex Serverless Containers](tutorials/deploy-app-container.md)

 - [Настройка подключения к Yandex Managed Service for PostgreSQL из контейнера Serverless Containers](tutorials/pg-connect.md)

 - [Разработка пользовательской интеграции в API Gateway](tutorials/api-gw-integration.md)

 - [Разработка функций в Functions Framework и их развертывание в Yandex Serverless Containers](tutorials/functions-framework-to-container.md)

### Рабочие процессы и автоматизация на Serverless

 - [Построение пайплайна CI/CD в GitLab с использованием serverless-продуктов](tutorials/ci-cd-serverless.md)

 - [Запуск GitLab Runner в Serverless Containers](tutorials/serverless-gitlab-runner.md)

 - [Настройка CI/CD в SourceCraft для развертывания Serverless Containers с помощью GitHub Actions](tutorials/ci-cd-sourcecraft-github-actions.md)

 - [Регулярное распознавание изображений и PDF-документов из бакета Object Storage](tutorials/vision-ocrrecognizer-storage.md)

 - [Управление доступом](security/index.md)

 - [Инструменты](tools.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Containers](../cli/cli-ref/serverless/cli-ref/container/index.md)

 - [Triggers](../cli/cli-ref/serverless/cli-ref/trigger/index.md)

 - [Network](../cli/cli-ref/serverless/cli-ref/network/index.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API Containers

 - [Аутентификация в API](api-ref/containers/authentication.md)

### gRPC (англ.)

 - [Overview](containers/api-ref/grpc/index.md)

#### Container

 - [Overview](containers/api-ref/grpc/Container/index.md)

 - [Get](containers/api-ref/grpc/Container/get.md)

 - [List](containers/api-ref/grpc/Container/list.md)

 - [Create](containers/api-ref/grpc/Container/create.md)

 - [Update](containers/api-ref/grpc/Container/update.md)

 - [Delete](containers/api-ref/grpc/Container/delete.md)

 - [DeployRevision](containers/api-ref/grpc/Container/deployRevision.md)

 - [Rollback](containers/api-ref/grpc/Container/rollback.md)

 - [GetRevision](containers/api-ref/grpc/Container/getRevision.md)

 - [ListRevisions](containers/api-ref/grpc/Container/listRevisions.md)

 - [ListOperations](containers/api-ref/grpc/Container/listOperations.md)

 - [ListAccessBindings](containers/api-ref/grpc/Container/listAccessBindings.md)

 - [SetAccessBindings](containers/api-ref/grpc/Container/setAccessBindings.md)

 - [UpdateAccessBindings](containers/api-ref/grpc/Container/updateAccessBindings.md)

#### Operation

 - [Overview](containers/api-ref/grpc/Operation/index.md)

 - [Get](containers/api-ref/grpc/Operation/get.md)

 - [Cancel](containers/api-ref/grpc/Operation/cancel.md)

### REST (англ.)

 - [Overview](containers/api-ref/index.md)

#### Container

 - [Overview](containers/api-ref/Container/index.md)

 - [Get](containers/api-ref/Container/get.md)

 - [List](containers/api-ref/Container/list.md)

 - [Create](containers/api-ref/Container/create.md)

 - [Update](containers/api-ref/Container/update.md)

 - [Delete](containers/api-ref/Container/delete.md)

 - [DeployRevision](containers/api-ref/Container/deployRevision.md)

 - [Rollback](containers/api-ref/Container/rollback.md)

 - [GetRevision](containers/api-ref/Container/getRevision.md)

 - [ListRevisions](containers/api-ref/Container/listRevisions.md)

 - [ListOperations](containers/api-ref/Container/listOperations.md)

 - [ListAccessBindings](containers/api-ref/Container/listAccessBindings.md)

 - [SetAccessBindings](containers/api-ref/Container/setAccessBindings.md)

 - [UpdateAccessBindings](containers/api-ref/Container/updateAccessBindings.md)

#### Operation

 - [Overview](containers/api-ref/Operation/index.md)

 - [Get](containers/api-ref/Operation/get.md)

 - [Cancel](containers/api-ref/Operation/cancel.md)

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