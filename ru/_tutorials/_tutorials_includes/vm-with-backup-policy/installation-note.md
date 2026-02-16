{% note info %}

{% include [agent-installation-timespan](../../../_includes/backup/agent-installation-timespan.md) %}

Привязка политики выполняется асинхронно после создания и инициализации ВМ, а также установки и настройки агента {{ backup-name }}. Это может занимать до 10–15 минут. В итоге виртуальная машина появится в списке ВМ сервиса {{ backup-name }} и в списке ВМ, привязанных к политике `weekly-backup`.

{% endnote %}

За процессом установки можно следить с помощью [последовательного порта](../../../compute/operations/vm-info/get-serial-port-output.md) ВМ в консоли управления.