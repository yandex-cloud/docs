# SMS в {{ cns-full-name }}


{% include [sms-short-description](../../_includes/notifications/sms-short-description.md) %}

{% include [limits-warning](../../_includes/notifications/limits-warning.md) %}

Вы можете создать несколько каналов SMS-уведомлений с разными [отправителями](#senders). Один из каналов настраивается в качестве канала по умолчанию. Этот канал будет использоваться для отправки SMS, если в запросе API или команде AWS CLI не будет указан конкретный канал.

## Отправители {#senders}

Для каналов SMS-уведомлений предусмотрены следующие типы отправителей:
* [общий отправитель](#common-sender);
* [индивидуальный отправитель](#individual-sender).

### Общий отправитель {#common-sender}

{% include [common-sender-description](../../_includes/notifications/common-sender-description.md) %}

### Индивидуальный отправитель {#individual-sender}

{% include [individual-sender-description](../../_includes/notifications/individual-sender-description.md) %}

Регистрация текстового имени отправителя осуществляется через техническую поддержку.

{% include [registration-duration-warning](../../_includes/notifications/registration-duration-warning.md) %}

{% include [individual-in-sandbox](../../_includes/notifications/individual-in-sandbox.md) %}

## Песочница {#sandbox}

{% include [sandbox-test-numbers](../../_includes/notifications/sandbox-test-numbers.md) %}

Тестовый номер можно будет удалить спустя 24 часа после его добавления. Чтобы в дальнейшем снова добавить этот номер, потребуется его повторное подтверждение.

Для каналов с индивидуальным отправителем доступен выход из режима песочницы через обращение в техническую поддержку.

{% include [sms-quota-increase](../../_includes/notifications/sms-quota-increase.md) %}

## См. также {#see-also}

* [Обзор сервиса](index.md)
* [Как начать работать с SMS](../quickstart-sms.md)
* [Как начать работать с сервисом с помощью AWS CLI](../tools/aws-cli.md)
* [Push-уведомления](push.md)