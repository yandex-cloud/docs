# Управление памятью в {{ mch-name }}

За объем оперативной памяти, доступной для использования {{ CH }}, отвечает настройка [Max server memory usage]({{ ch.docs }}/operations/server-configuration-parameters/settings/#max_server_memory_usage).

Также от нее зависит максимальное значение настройки [Max memory usage](./settings-list.md#setting-max-memory-usage).

В отличие от других [настроек СУБД](./settings-list.md) значение настройки **Max server memory usage** нельзя изменять напрямую. {{ mch-name }} выставляет для нее значение автоматически в зависимости от объема оперативной памяти хостов {{ CH }} (RAM):

* RAM < 10 ГБ — значение настройки на 1 ГБ меньше объема RAM хоста.
* 10 ГБ ≤ RAM < 40 ГБ — значение настройки составляет 90% от объема RAM хоста.
* RAM ≥ 40 ГБ — значение настройки на 4 ГБ меньше объема RAM хоста.

Оставшаяся память резервируется для операционной системы и вспомогательных служб: мониторинг, резервное копирование и т. д.

Изменить значение настройки **Max server memory usage** можно только вместе с [классом хоста](./instance-types.md).

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
