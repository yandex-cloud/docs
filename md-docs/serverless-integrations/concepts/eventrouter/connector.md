[Документация Yandex Cloud](../../../index.md) > [Yandex Serverless Integrations](../../index.md) > [Концепции](../index.md) > EventRouter > Коннектор

# Коннектор

_Коннектор_ — настраиваемый компонент, позволяющий получать события из внешних источников и отправлять их в [шину](bus.md).

Поддерживаемые источники:

* [Таймер](#timer)
* [API EventRouter](#from-api)
* [Yandex Data Streams](../../../data-streams/index.md)
* [Yandex Message Queue](../../../message-queue/index.md)


## Таймер {#timer}

Таймер — тип источника, который запускает генерацию событий по расписанию. Расписание задается в формате cron-выражения. По умолчанию время в cron-выражении указывается по [UTC+0](https://ru.wikipedia.org/wiki/Всемирное_координированное_время), но в настройках таймера можно указать другой часовой пояс.

Если в настройках таймера не указаны данные, которые нужно передать в шину, на вход [приемника](rule.md#target), указанного в [правиле](rule.md), ничего не передается.

Подробнее о формате cron-выражений в [Cron-выражения в Serverless Integrations](../cron.md)


## API EventRouter {#from-api}

API EventRouter — тип источника, который позволяет использовать [API EventRouter](../../api-ref/eventrouter/authentication.md) для [отправки](sending-events.md) пользовательских событий в шину.

Чтобы отправлять события [через коннектор](../../operations/eventrouter/bus/data-send.md) для API EventRouter, используйте [вызов](../../eventrouter/api-ref/grpc/Event/send.md) gRPC API `EventService/Send` или [команду](../../../cli/cli-ref/serverless/cli-ref/eventrouter/send-event.md) Yandex Cloud CLI `yc serverless eventrouter send-event`.

В отличие от отправки сообщений [напрямую в шину](../../operations/eventrouter/bus/data-put.md), использование коннектора для API EventRouter позволяет:
* назначать пользователям и [сервисным аккаунтам](../../../iam/concepts/users/service-accounts.md) роли на отправку событий гранулярно через заданный коннектор;
* прекращать отправку событий, [останавливая](../../operations/eventrouter/connector/stop.md) коннектор;
* группировать события перед отправкой в шину.