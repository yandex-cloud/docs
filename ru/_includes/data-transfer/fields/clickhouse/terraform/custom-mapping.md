`sharding.custom_mapping` — шардирование по значению колонки:

* `column_name` — имя колонки в таблицах, по которой следует шардировать данные.

* `mapping` — сопоставление значений колонки и шардов:

    * `column_value.string_value` — значение колонки.
    * `shard_name` — имя шарда.
