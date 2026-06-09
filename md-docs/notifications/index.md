# Yandex Cloud Notification Service

<i>Yandex Cloud Notification Service находится на <a href="../overview/concepts/launch-stages.md">стадии Preview</a>.</i>

Yandex Cloud Notification Service — сервис для мультиканальной отправки уведомлений пользователям. HTTP API сервиса совместим с <a href="https://docs.aws.amazon.com/sns/latest/api/welcome.html">Amazon SNS API</a>.

На стадии Preview доступна отправка push-уведомлений на устройства с iOS и Android, в браузеры и SMS.

Позднее будет реализована отправка уведомлений в мессенджеры.

# Yandex Cloud Notification Service

## Начало работы

 - [Обзор](quickstart.md)

 - [Начало работы с мобильными Push-уведомлениями](quickstart-push.md)

 - [Начало работы с Push-уведомлениями в браузере](quickstart-browser.md)

 - [Начало работы с SMS](quickstart-sms.md)

 - [Начало работы с топиками](quickstart-topics.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Мобильные Push-уведомления

 - [Создать канал push-уведомлений](operations/push/channel-create.md)

 - [Изменить канал push-уведомлений](operations/push/channel-update.md)

 - [Удалить канал push-уведомлений](operations/push/channel-delete.md)

 - [Создать эндпоинт](operations/push/endpoint-create.md)

 - [Изменить эндпоинт](operations/push/endpoint-update.md)

 - [Удалить эндпоинт](operations/push/endpoint-delete.md)

 - [Отправить push-уведомление](operations/push/send.md)

### Push-уведомления в браузере

 - [Создать канал](operations/browser/channel-create.md)

 - [Управлять каналом](operations/browser/channel-manage.md)

 - [Создать эндпоинт](operations/browser/endpoint-create.md)

 - [Управлять эндпоинтом](operations/browser/endpoint-manage.md)

 - [Отправить push-уведомление в браузер](operations/browser/send.md)

### SMS-уведомления

 - [Создать канал SMS-уведомлений](operations/sms/channel-create.md)

 - [Удалить канал SMS-уведомлений](operations/sms/channel-delete.md)

 - [Добавить тестовый номер](operations/sms/test-number-create.md)

 - [Удалить тестовый номер](operations/sms/test-number-delete.md)

 - [Отправить тестовое SMS-уведомление](operations/sms/send.md)

 - [Управлять шаблонами SMS](operations/sms/manage-templates.md)

 - [Выйти из песочницы](operations/sms/exit-sandbox.md)

### Топики

 - [Создать топик](operations/topics/topic-create.md)

 - [Создать подписку на топик](operations/topics/subscription-create.md)

 - [Отправить уведомление в топик](operations/topics/send.md)

 - [Управлять топиком](operations/topics/topic-manage.md)

 - [Управлять подпиской](operations/topics/subscription-manage.md)

 - [Настроить логирование](operations/configure-logging.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Мобильные Push-уведомления](concepts/push.md)

 - [Push-уведомления в браузере](concepts/browser.md)

 - [SMS](concepts/sms.md)

 - [Топики](concepts/topics.md)

 - [Квоты и лимиты](concepts/limits.md)

## Инструменты

 - [Все инструменты](tools/index.md)

 - [AWS CLI](tools/aws-cli.md)

 - [AWS SDK для С++](tools/sdk-cpp.md)

 - [AWS SDK для Go](tools/sdk-go.md)

 - [AWS SDK для Java](tools/sdk-java.md)

 - [AWS SDK для JavaScript](tools/sdk-javascript.md)

 - [AWS SDK для Kotlin](tools/sdk-kotlin.md)

 - [AWS SDK для .NET](tools/sdk-dot-net.md)

 - [AWS SDK для PHP](tools/sdk-php.md)

 - [AWS SDK для Python (boto3)](tools/sdk-python.md)

 - [Правила тарификации](pricing.md)

 - [Управление доступом](security/index.md)

## Справочник API

 - [Обзор](api-ref/index.md)

 - [Отправка запроса](api-ref/send-request.md)

 - [Ошибки](api-ref/common-errors.md)

### PlatformApplication

 - [Create](api-ref/create-platform-application.md)

 - [GetAttributes](api-ref/get-platform-application-attributes.md)

 - [SetAttributes](api-ref/set-platform-application-attributes.md)

 - [List](api-ref/list-platform-applications.md)

 - [Delete](api-ref/delete-platform-application.md)

### Endpoint

 - [Create](api-ref/create-platform-endpoint.md)

 - [GetAttributes](api-ref/get-endpoint-attributes.md)

 - [SetAttributes](api-ref/set-endpoint-attributes.md)

 - [List](api-ref/list-endpoints.md)

 - [Delete](api-ref/delete-endpoint.md)

### SMS

 - [Create](api-ref/create-sms-channel.md)

 - [GetAttributes](api-ref/get-sms-channel-attributes.md)

 - [GetSmsAttributes](api-ref/get-sms-attributes.md)

 - [SetAttributes](api-ref/set-sms-channel-attributes.md)

 - [List](api-ref/list-sms-channels.md)

 - [Delete](api-ref/delete-sms-channel.md)

### Sandbox

 - [Create](api-ref/create-sms-sandbox-phone-number.md)

 - [Verify](api-ref/verify-sms-sandbox-phone-number.md)

 - [List](api-ref/list-sms-sandbox-phone-numbers.md)

 - [Delete](api-ref/delete-sms-sandbox-phone-number.md)

 - [Publish](api-ref/publish.md)

 - [Метрики Monitoring](metrics.md)

 - [Логи Cloud Logging](concepts/logging.md)

 - [История изменений](release-notes.md)