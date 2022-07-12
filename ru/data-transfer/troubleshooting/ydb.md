# {{ ydb-full-name }} и {{ yds-full-name }}

В некоторых случаях работа трансферов типа _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_ останавливается с ошибкой `/Ydb.PersQueue.V1.PersQueueService/AddReadRule failed: OVERLOADED`.

Она обусловлена ограничением облачной [квоты]({{ link-console-quotas }}) на количество операций с {{ ydb-name }}.

Чтобы устранить проблему:
1. Увеличьте в {% if audience != "internal" %}[квотах {{ ydb-name }}][](../../ydb/concepts/limits.md){% else %}квотах {{ ydb-name }}{% endif %} на облако с нужной базой данных значение характеристики **Количество схемных операций в минуту**.
1. [Перезагрузите](../operations/transfer.md#reupload) трансфер.
