# Асинхронные операции

При асинхронном взаимодействии через очереди сообщений (Kafka, RabbitMQ и др.) вместо отношения «родитель — потомок» между спанами используются [связи спанов (Span Links)](../concepts.md#span-links). Это позволяет связать спаны из разных трейсов: например, когда несколько продюсеров отправляют сообщения, а консьюмер обрабатывает их одним батчем.

## Конвенция именования {#naming}

Имя спана формируется как `{messaging.operation.name} {destination}`, например `send orders` или `process orders`. Если имя топика имеет высокую кардинальность, используйте шаблон (`messaging.destination.template`). Если топик неизвестен, вместо него указывается `unknown`. Подробнее см. в [спецификации именования messaging-спанов](https://opentelemetry.io/docs/specs/semconv/messaging/messaging-spans/#span-name).

## Атрибуты {#attributes}

#|
|| Атрибут | Описание ||
|| `messaging.system` | Система обмена сообщениями: `kafka`, `rabbitmq` и др. ||
|| `messaging.destination.name` | Имя топика или очереди: `orders` ||
|| `messaging.operation.name` | Системное имя операции: `send`, `poll`, `process` ||
|| `messaging.operation.type` | Стандартизированный тип: `send`, `receive`, `process`, `create`, `settle` ||
|| `messaging.message.id` | Идентификатор сообщения ||
|| `messaging.batch.message_count` | Количество сообщений в батче ||
|#

Полный перечень атрибутов см. в [спецификации OpenTelemetry для messaging-спанов](https://opentelemetry.io/docs/specs/semconv/messaging/messaging-spans/).

## Примеры {#examples}

### Несколько продюсеров, один консьюмер {#many-to-one}

Продюсер A и продюсер B отправляют по сообщению в топик `orders` в Kafka. Консьюмер получает оба сообщения в одном батче (спан `poll orders`), а затем создает отдельный спан `process orders` для обработки каждого сообщения. Span Links вешаются на спаны `process`, связывая каждое сообщение с его продюсером:

#|
|| Атрибут | Продюсер A | Продюсер B | Консьюмер: получение | Консьюмер: обработка A | Консьюмер: обработка B ||
|| Name | `send orders` | `send orders` | `poll orders` | `process orders` | `process orders` ||
|| Kind | `PRODUCER` | `PRODUCER` | `CLIENT` | `CONSUMER` | `CONSUMER` ||
|| Status | `OK` | `OK` | `OK` | `OK` | `OK` ||
|| Links | — | — | — | → `send orders` (Продюсер A) | → `send orders` (Продюсер B) ||
|| `messaging.system` | `kafka` | `kafka` | `kafka` | `kafka` | `kafka` ||
|| `messaging.destination.name` | `orders` | `orders` | `orders` | `orders` | `orders` ||
|| `messaging.operation.name` | `send` | `send` | `poll` | `process` | `process` ||
|| `messaging.operation.type` | `send` | `send` | `receive` | `process` | `process` ||
|| `messaging.message.id` | `a1` | `a2` | — | `a1` | `a2` ||
|| `messaging.batch.message_count` | — | — | `2` | — | — ||
|#

### Один продюсер, несколько консьюмеров {#one-to-many}

Продюсер отправляет сообщение в топик `orders`. Консьюмер X и консьюмер Y из разных consumer group обрабатывают его независимо. Каждый спан `process` связан со спаном продюсера через Span Link:

#|
|| Атрибут | Продюсер | Консьюмер X | Консьюмер Y ||
|| Name | `send orders` | `process orders` | `process orders` ||
|| Kind | `PRODUCER` | `CONSUMER` | `CONSUMER` ||
|| Status | `OK` | `OK` | `OK` ||
|| Links | — | → `send orders` (Продюсер) | → `send orders` (Продюсер) ||
|| `messaging.system` | `kafka` | `kafka` | `kafka` ||
|| `messaging.destination.name` | `orders` | `orders` | `orders` ||
|| `messaging.operation.name` | `send` | `process` | `process` ||
|| `messaging.operation.type` | `send` | `process` | `process` ||
|| `messaging.message.id` | `a1` | `a1` | `a1` ||
|#
