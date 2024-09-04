* Если фоновый режим выключен (`false`), то процесс перераспределения будет запущен однократно сразу после завершения подготовки к расширению кластера.

    {% include [updating-long](./updating-long.md) %}

    {% note warning %}

    {% include [manual-redistribution](./manual-redistribution.md) %}

    {% endnote %}

* Если фоновый режим включен (`true`), то процесс перераспределения будет отложен. Процесс будет выполняться по заданному расписанию как [регламентная операция](../../../../managed-greenplum/concepts/maintenance.md#regular-ops).

    {% include [updating-short](./updating-short.md) %}
