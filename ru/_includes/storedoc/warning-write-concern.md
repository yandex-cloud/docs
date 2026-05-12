{% note warning %}

Запросы с настройкой `writeConcern: 1` могут приводить к отставанию данных на вторичных репликах. Это повышает риск таймаутов при операциях записи и потери данных при выходе из строя хоста-мастера, поэтому для таких кластеров не гарантируются [SLA](https://yandex.ru/legal/cloud_sla_mdb/) и [высокая доступность](../../storedoc/concepts/high-availability.md). Подробнее о [влиянии настройки](../../storedoc/concepts/high-availability.md#connect) `writeConcern` на высокую доступность.

{% endnote %}