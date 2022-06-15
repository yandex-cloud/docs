# Управление памятью в {{ mch-name }}

За объем оперативной памяти, доступной для использования {{ CH }}, отвечает настройка [Max server memory usage]({% if lang=="ru" %}https://{{ ch-domain }}/docs/ru/operations/server-configuration-parameters/settings/#max_server_memory_usage{% else %}https://{{ ch-domain }}/docs/en/operations/server-configuration-parameters/settings/#max_server_memory_usage{% endif %}).

Также от нее зависит максимальное значение настройки [Max memory usage](./settings-list.md#setting-max-memory-usage).

В отличие от других [настроек СУБД](./settings-list.md), значение настройки **Max server memory usage** нельзя изменять напрямую. {{ mch-name }} выставляет для нее значение автоматически в зависимости от объема оперативной памяти хостов {{ CH }}:

* < 10 ГБ — на 1 ГБ меньше объема оперативной памяти на хосте;
* ≥ 10 ГБ — 90% об объема оперативной памяти на хосте.

Оставшаяся память резервируется для операционной системы и вспомогательных служб: мониторинг, резервное копирование и т. д.

Изменить значение настройки **Max server memory usage** можно только вместе с [классом хоста](./instance-types.md).
