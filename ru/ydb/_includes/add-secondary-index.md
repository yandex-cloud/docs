Чтобы добавить [вторичный индекс](../oss/public/develop/concepts/secondary_indexes.md) при создании таблицы, используйте конструкцию `INDEX IndexName GLOBAL ON (SomeKey1, ... SomeKeyN)`:

{% include [create-table-with-si-template](queries/create-table-with-si-template.md) %}

**Пример**

Таблица `series` со вторичными ключами `views_index` по полю `views`, и `users_index` по полю `uploaded_user_id`:

{% include [create-table-with-si-example](queries/create-table-with-si-example.md) %}