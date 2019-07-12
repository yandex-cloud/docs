# Добавление данных в ClickHouse

Для рутинного добавления данных в базу данных используйте запрос INSERT, описанный в [документации ClickHouse](https://clickhouse.yandex/docs/ru/query_language/queries/#insert).

Чтобы загружать большое количество информации, используйте [клиент командной строки ClickHouse](https://clickhouse.yandex/docs/ru/interfaces/cli/), который эффективно сжимает данные при передаче. INSERT-запросы рекомендуется отправлять не чаще 1 раза в секунду.
