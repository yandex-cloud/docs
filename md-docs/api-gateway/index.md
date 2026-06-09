# Yandex API Gateway

Yandex API Gateway — сервис для управления API-шлюзами, поддерживающий <a href="https://github.com/OAI/OpenAPI-Specification">спецификацию OpenAPI 3.0</a> и набор расширений для взаимодействия с другими облачными сервисами.

# Yandex API Gateway

 - [Начало работы](quickstart/index.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Создание API-шлюза](operations/api-gw-create.md)

### Управление API-шлюзом

 - [Изменить API-шлюз и его спецификацию](operations/api-gw-update.md)

 - [Подключить домен](operations/api-gw-domains.md)

 - [Указать облачную сеть](operations/api-gw-network-add.md)

 - [Настроить переменные](operations/api-gw-vars.md)

 - [Настроить канареечный релиз](operations/api-gw-canary.md)

#### Управлять метками

 - [Добавить метку](operations/label-add.md)

 - [Изменить метку](operations/label-update.md)

 - [Удалить метку](operations/label-delete.md)

 - [Посмотреть графики мониторинга](operations/api-gw-monitoring.md)

#### Управлять логами

 - [Посмотреть логи](operations/api-gw-logs.md)

 - [Записать логи](operations/api-gw-logs-write.md)

 - [Отключить домен](operations/api-gw-domain-detach.md)

 - [Миграция в зону {{ region-id }}-d](operations/api-gw-migration.md)

 - [Удалить API-шлюз](operations/api-gw-delete.md)

### Получение информации о триггере

 - [Получить список триггеров](operations/trigger/trigger-list.md)

 - [Получить информацию о триггере](operations/trigger/trigger-info.md)

### Создание триггера

 - [Создать таймер](operations/trigger/timer-create.md)

 - [Создать триггер для {{ message-queue-name }}](operations/trigger/ymq-trigger-create.md)

 - [Создать триггер для {{ objstorage-name }}](operations/trigger/os-trigger-create.md)

 - [Создать триггер для {{ container-registry-name }}](operations/trigger/cr-trigger-create.md)

 - [Создать триггер для {{ cloud-logging-name }}](operations/trigger/cloud-logging-trigger-create.md)

#### Создать триггер для {{ iot-name }}

 - [Устройство](operations/trigger/iot-core-trigger-create.md)

 - [Брокер](operations/trigger/iot-core-trigger-broker-create.md)

 - [Создать триггер для бюджетов](operations/trigger/budget-trigger-create.md)

 - [Создать триггер для {{ yds-name }}](operations/trigger/data-streams-trigger-create.md)

 - [Создать триггер для почты](operations/trigger/mail-trigger-create.md)

### Управление триггером

 - [Изменить триггер](operations/trigger/trigger-update.md)

 - [Посмотреть графики мониторинга](operations/trigger/trigger-monitoring.md)

 - [Удалить триггер](operations/trigger/trigger-delete.md)

### Конструктор спецификаций

 - [Обзор](operations/spec-constructor/index.md)

 - [{{ sf-name }}](operations/spec-constructor/cloud-functions.md)

 - [Статический ответ](operations/spec-constructor/dummy.md)

 - [{{ objstorage-name }}](operations/spec-constructor/object-storage.md)

 - [{{ serverless-containers-name }}](operations/spec-constructor/containers.md)

 - [Обращение по HTTP](operations/spec-constructor/http.md)

 - [{{ message-queue-name }}](operations/spec-constructor/ymq.md)

 - [{{ yds-name }}](operations/spec-constructor/datastreams.md)

 - [{{ ydb-name }}](operations/spec-constructor/ydb.md)

 - [{{ ml-platform-short-name }}](operations/spec-constructor/datasphere.md)

 - [{{ ai-studio-full-name }}](operations/spec-constructor/yagpt.md)

 - [{{ sw-full-name }}](operations/spec-constructor/workflows.md)

 - [Swagger UI](operations/spec-constructor/swagger.md)

 - [Просмотр операций с ресурсами сервиса](operations/operation-logs.md)

## Практические руководства

 - [Все практические руководства](tutorials/index.md)

### Бэкенд на Serverless

 - [Развертывание веб-приложения с использованием Java Servlet API](tutorials/java-servlet-todo-list.md)

 - [Разработка пользовательской интеграции](tutorials/api-gw-integration.md)

#### Сокращатель ссылок

 - [Обзор](tutorials/serverless-url-shortener/index.md)

 - [Консоль управления](tutorials/serverless-url-shortener/console.md)

 - [{{ TF }}](tutorials/serverless-url-shortener/terraform.md)

 - [Разработка CRUD API для сервиса фильмов](tutorials/movies-database.md)

 - [Создание интерактивного serverless-приложения с использованием WebSocket](tutorials/websocket-app.md)

 - [Работа с API-шлюзом по протоколу WebSocket](tutorials/api-gw-websocket.md)

 - [Запуск контейнерного приложения в {{ serverless-containers-full-name }}](tutorials/deploy-app-container.md)

 - [Развертывание веб-приложения с JWT-авторизацией в {{ api-gw-name }} и аутентификацией в Firebase](tutorials/jwt-authorizer-firebase.md)

 - [Канареечный релиз функции {{ sf-name }}](tutorials/canary-release.md)

 - [Интерактивная отладка функций {{ sf-name }}](tutorials/serverless-live-debug.md)

### Боты на Serverless

 - [Разработка Slack-бота](tutorials/slack-bot-serverless.md)

#### Разработка Telegram-бота

 - [Обзор](tutorials/telegram-bot-serverless/index.md)

 - [Консоль управления](tutorials/telegram-bot-serverless/console.md)

 - [{{ TF }}](tutorials/telegram-bot-serverless/terraform.md)

 - [Разработка Telegram-бота для распознавания текста и аудио](tutorials/recognizer-bot.md)

### ETL на Serverless

 - [Ввод данных в системы хранения](tutorials/data-ingestion.md)

### Рабочие процессы и автоматизация на Serverless

 - [Построение пайплайна CI/CD в {{ GL }} с использованием serverless-продуктов](tutorials/ci-cd-serverless.md)

### Интеграция с сервисами Яндекса и Yandex Cloud

 - [Защита {{ api-gw-name }} при помощи {{ sws-name }}](tutorials/api-gw-sws-integration.md)

 - [Разработка навыка Алисы и сайта с авторизацией](tutorials/alice-shareable-todolist.md)

 - [Использование {{ api-gw-name }} для настройки синтеза речи в {{ speechkit-full-name }}](tutorials/speechkit-integrarion-via-agi-gw.md)

### Искусственный интеллект

 - [Создание AI-агента со стримингом ответа через веб-сокеты](tutorials/streaming-openai-agent.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

 - [Сетевое взаимодействие](concepts/networking.md)

### Расширения спецификации

 - [Обзор](concepts/extensions/index.md)

#### Интеграции

 - [Статический ответ](concepts/extensions/dummy.md)

 - [Обращение по HTTP](concepts/extensions/http.md)

 - [{{ sf-name }}](concepts/extensions/cloud-functions.md)

 - [{{ serverless-containers-name }}](concepts/extensions/containers.md)

 - [{{ sws-name }}](concepts/extensions/sws.md)

 - [{{ objstorage-name }}](concepts/extensions/object-storage.md)

 - [{{ ml-platform-short-name }}](concepts/extensions/datasphere.md)

 - [{{ yds-name }}](concepts/extensions/datastreams.md)

 - [{{ message-queue-name }}](concepts/extensions/ymq.md)

 - [{{ ydb-name }}](concepts/extensions/ydb.md)

 - [Swagger UI](concepts/extensions/swagger.md)

 - [Жадные параметры](concepts/extensions/greedy-parameters.md)

 - [Обобщенный HTTP-метод](concepts/extensions/any-method.md)

 - [Авторизация с помощью функции {{ sf-name }}](concepts/extensions/function-authorizer.md)

 - [Авторизация с помощью JWT](concepts/extensions/jwt-authorizer.md)

 - [Поддержка протокола WebSocket](concepts/extensions/websocket.md)

 - [Валидация данных](concepts/extensions/validator.md)

 - [CORS](concepts/extensions/cors.md)

 - [Параметризация спецификации](concepts/extensions/parametrization.md)

 - [Канареечный релиз](concepts/extensions/canary.md)

 - [Ограничение скорости обработки запросов](concepts/extensions/rate-limit.md)

 - [Замена кода ответа](concepts/extensions/status-mapping.md)

 - [Преобразование тела ответа и запроса](concepts/extensions/schema-mapping.md)

### Триггер

 - [Обзор](concepts/trigger/index.md)

 - [Таймер](concepts/trigger/timer.md)

 - [Триггер для {{ message-queue-name }}](concepts/trigger/ymq-trigger.md)

 - [Триггер для {{ objstorage-name }}](concepts/trigger/os-trigger.md)

 - [Триггер для {{ container-registry-name }}](concepts/trigger/cr-trigger.md)

 - [Триггер для {{ cloud-logging-full-name }}](concepts/trigger/cloud-logging-trigger.md)

 - [Триггер для {{ iot-full-name }}](concepts/trigger/iot-core-trigger.md)

 - [Триггер для бюджетов](concepts/trigger/budget-trigger.md)

 - [Триггер для {{ yds-name }}](concepts/trigger/data-streams-trigger.md)

 - [Триггер для почты](concepts/trigger/mail-trigger.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Управление доступом](security/index.md)

 - [Инструменты](tools.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [{{ api-gw-name }}](../cli/cli-ref/serverless/cli-ref/api-gateway/index.md)

 - [Triggers](../cli/cli-ref/serverless/cli-ref/trigger/index.md)

 - [Network](../cli/cli-ref/serverless/cli-ref/network/index.md)

 - [Справочник {{ TF }}](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/apigateway/authentication.md)

### gRPC (англ.)

 - [Overview](apigateway/api-ref/grpc/index.md)

#### ApiGateway

 - [Overview](apigateway/api-ref/grpc/ApiGateway/index.md)

 - [Get](apigateway/api-ref/grpc/ApiGateway/get.md)

 - [List](apigateway/api-ref/grpc/ApiGateway/list.md)

 - [Create](apigateway/api-ref/grpc/ApiGateway/create.md)

 - [Update](apigateway/api-ref/grpc/ApiGateway/update.md)

 - [Delete](apigateway/api-ref/grpc/ApiGateway/delete.md)

 - [Resume](apigateway/api-ref/grpc/ApiGateway/resume.md)

 - [Stop](apigateway/api-ref/grpc/ApiGateway/stop.md)

 - [AddDomain](apigateway/api-ref/grpc/ApiGateway/addDomain.md)

 - [RemoveDomain](apigateway/api-ref/grpc/ApiGateway/removeDomain.md)

 - [GetOpenapiSpec](apigateway/api-ref/grpc/ApiGateway/getOpenapiSpec.md)

 - [ListOperations](apigateway/api-ref/grpc/ApiGateway/listOperations.md)

 - [ListAccessBindings](apigateway/api-ref/grpc/ApiGateway/listAccessBindings.md)

 - [SetAccessBindings](apigateway/api-ref/grpc/ApiGateway/setAccessBindings.md)

 - [UpdateAccessBindings](apigateway/api-ref/grpc/ApiGateway/updateAccessBindings.md)

#### Operation

 - [Overview](apigateway/api-ref/grpc/Operation/index.md)

 - [Get](apigateway/api-ref/grpc/Operation/get.md)

 - [Cancel](apigateway/api-ref/grpc/Operation/cancel.md)

### REST (англ.)

 - [Overview](apigateway/api-ref/index.md)

#### ApiGateway

 - [Overview](apigateway/api-ref/ApiGateway/index.md)

 - [Get](apigateway/api-ref/ApiGateway/get.md)

 - [List](apigateway/api-ref/ApiGateway/list.md)

 - [Create](apigateway/api-ref/ApiGateway/create.md)

 - [Update](apigateway/api-ref/ApiGateway/update.md)

 - [Delete](apigateway/api-ref/ApiGateway/delete.md)

 - [Resume](apigateway/api-ref/ApiGateway/resume.md)

 - [Stop](apigateway/api-ref/ApiGateway/stop.md)

 - [AddDomain](apigateway/api-ref/ApiGateway/addDomain.md)

 - [RemoveDomain](apigateway/api-ref/ApiGateway/removeDomain.md)

 - [GetOpenapiSpec](apigateway/api-ref/ApiGateway/getOpenapiSpec.md)

 - [ListOperations](apigateway/api-ref/ApiGateway/listOperations.md)

 - [ListAccessBindings](apigateway/api-ref/ApiGateway/listAccessBindings.md)

 - [SetAccessBindings](apigateway/api-ref/ApiGateway/setAccessBindings.md)

 - [UpdateAccessBindings](apigateway/api-ref/ApiGateway/updateAccessBindings.md)

#### Operation

 - [Overview](apigateway/api-ref/Operation/index.md)

 - [Get](apigateway/api-ref/Operation/get.md)

 - [Cancel](apigateway/api-ref/Operation/cancel.md)

## Справочник API Websocket

 - [Аутентификация в API](api-ref/websocket/authentication.md)

### gRPC (англ.)

 - [Overview](apigateway/websocket/api-ref/grpc/index.md)

#### Connection

 - [Overview](apigateway/websocket/api-ref/grpc/Connection/index.md)

 - [Get](apigateway/websocket/api-ref/grpc/Connection/get.md)

 - [Send](apigateway/websocket/api-ref/grpc/Connection/send.md)

 - [Disconnect](apigateway/websocket/api-ref/grpc/Connection/disconnect.md)

### REST (англ.)

 - [Overview](apigateway/websocket/api-ref/index.md)

#### Connection

 - [Overview](apigateway/websocket/api-ref/Connection/index.md)

 - [Get](apigateway/websocket/api-ref/Connection/get.md)

 - [Send](apigateway/websocket/api-ref/Connection/send.md)

 - [Disconnect](apigateway/websocket/api-ref/Connection/disconnect.md)

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

 - [Метрики {{ monitoring-name }}](metrics.md)

 - [Аудитные логи {{ at-name }}](at-ref.md)

 - [Публичные материалы](public-talks.md)

 - [История изменений](release-notes.md)

 - [Вопросы и ответы](qa/index.md)

 - [Обучающие курсы](training.md)