# Yandex Message Queue

Yandex Message Queue — универсальное масштабируемое решение для обмена сообщениями между приложениями. Для работы с сервисом можно использовать популярные инструменты: API сервиса совместим с Amazon SQS API.

Message Queue помогает:

<ul><li>выстроить коммуникацию между отдельными приложениями вашей системы;</li> <li>масштабировать систему, которая полагается на обмен информацией между отдельными приложениями;</li> <li>повысить отказоустойчивость обмена информацией при сбоях отдельных приложений;</li> <li>освободить ресурсы для обработки срочных запросов, перекладывая обработку входящих сообщений на предназначенные для этого приложения.</li></ul>

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_ymq">Уровень обслуживания Yandex Message Queue</a>.

# Yandex Message Queue

## Начало работы

 - [Быстрый старт](quickstart.md)

 - [Поддерживаемые инструменты](instruments/index.md)

### Примеры кода

 - [Python](instruments/python.md)

 - [Node.js](instruments/node.md)

 - [PHP](instruments/php.md)

 - [Celery](instruments/celery.md)

 - [JMS](instruments/jms.md)

 - [Laravel](instruments/laravel.md)

 - [Symfony](instruments/symfony.md)

 - [{{ TF }}](instruments/terraform.md)

 - [Golang](instruments/golang.md)

## Пошаговые инструкции

 - [Обзор](operations/index.md)

 - [Настройка AWS CLI](operations/configuring-aws-cli.md)

 - [Создание новой очереди сообщений](operations/message-queue-new-queue.md)

 - [Отправка сообщений](operations/message-queue-send-message.md)

 - [Прием и удаление сообщений](operations/message-queue-receive-and-delete-message.md)

 - [Удаление очереди сообщений](operations/message-queue-delete-queue.md)

 - [Управление метками очереди](operations/message-queue-tags.md)

 - [Мониторинг процессов в очереди](operations/monitoring.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Очереди сообщений](concepts/queue.md)

 - [Сообщения](concepts/message.md)

 - [Дедупликация](concepts/deduplication.md)

 - [Таймаут видимости](concepts/visibility-timeout.md)

 - [Long Polling](concepts/long-polling.md)

 - [Что такое Dead Letter Queue (DLQ)](concepts/dlq.md)

 - [Отложенная доставка сообщений в очереди](concepts/delay-queues.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Метки очередей](concepts/tags.md)

 - [Сравнение с {{ yds-full-name }}](concepts/yds-ymq-comparison.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

### Конвертация видео в GIF на Python

 - [Обзор](tutorials/video-converting-queue/index.md)

 - [Консоль управления](tutorials/video-converting-queue/console.md)

 - [{{ TF }}](tutorials/video-converting-queue/terraform.md)

 - [Автомасштабирование группы ВМ для обработки сообщений из очереди](tutorials/autoscale-monitoring.md)

 - [Создание триггеров, которые вызывают функции для остановки ВМ и отправки уведомлений в Telegram](tutorials/serverless-trigger-budget-queue-vm-tg.md)

### Хранение статического ключа доступа в секрете {{ lockbox-name }}

 - [Обзор](tutorials/static-key-in-lockbox/index.md)

 - [CLI](tutorials/static-key-in-lockbox/console.md)

 - [{{ TF }}](tutorials/static-key-in-lockbox/terraform.md)

 - [Создание интерактивного serverless-приложения с использованием WebSocket](tutorials/websocket-app.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

 - [Справочник {{ TF }}](tf-ref.md)

## Справочник API

 - [Обзор](api-ref/index.md)

### Queue

 - [CreateQueue](api-ref/queue/CreateQueue.md)

 - [DeleteQueue](api-ref/queue/DeleteQueue.md)

 - [GetQueueAttributes](api-ref/queue/GetQueueAttributes.md)

 - [GetQueueUrl](api-ref/queue/GetQueueUrl.md)

 - [ListQueues](api-ref/queue/ListQueues.md)

 - [PurgeQueue](api-ref/queue/PurgeQueue.md)

 - [SetQueueAttributes](api-ref/queue/SetQueueAttributes.md)

 - [TagQueue](api-ref/queue/TagQueue.md)

 - [UntagQueue](api-ref/queue/UntagQueue.md)

 - [ListQueueTags](api-ref/queue/ListQueueTags.md)

### Message

 - [ChangeMessageVisibility](api-ref/message/ChangeMessageVisibility.md)

 - [ChangeMessageVisibilityBatch](api-ref/message/ChangeMessageVisibilityBatch.md)

 - [DeleteMessage](api-ref/message/DeleteMessage.md)

 - [DeleteMessageBatch](api-ref/message/DeleteMessageBatch.md)

 - [ReceiveMessage](api-ref/message/ReceiveMessage.md)

 - [SendMessage](api-ref/message/SendMessage.md)

 - [SendMessageBatch](api-ref/message/SendMessageBatch.md)

### Типы данных

 - [BatchResultErrorEntry](api-ref/data-types/BatchResultErrorEntry.md)

 - [ChangeMessageVisibilityBatchRequestEntry](api-ref/data-types/ChangeMessageVisibilityBatchRequestEntry.md)

 - [ChangeMessageVisibilityBatchResultEntry](api-ref/data-types/ChangeMessageVisibilityBatchResultEntry.md)

 - [DeleteMessageBatchRequestEntry](api-ref/data-types/DeleteMessageBatchRequestEntry.md)

 - [DeleteMessageBatchResultEntry](api-ref/data-types/DeleteMessageBatchResultEntry.md)

 - [Message](api-ref/data-types/Message.md)

 - [MessageAttributeValue](api-ref/data-types/MessageAttributeValue.md)

 - [SendMessageBatchRequestEntry](api-ref/data-types/SendMessageBatchRequestEntry.md)

 - [SendMessageBatchResultEntry](api-ref/data-types/SendMessageBatchResultEntry.md)

 - [Стандартные ошибки](api-ref/common-errors.md)

 - [Аудитные логи {{ at-name }}](at-ref.md)

 - [Метрики {{ monitoring-name }}](metrics.md)

 - [Публичные материалы](public-talks.md)

 - [Вопросы и ответы](qa/index.md)

 - [Обучающие курсы](training.md)