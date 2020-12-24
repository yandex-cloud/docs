# Все методы

{{ ydb-name }} HTTP API предоставляет следующие методы:

## Работа с таблицами
Метод | Описание
----- | -----
[CreateTable](actions/createTable) | Создает таблицу
[DeleteTable](actions/deleteTable) | Удаляет таблицу
[DescribeTable](actions/describeTable) | Возвращает информацию о таблице
[ListTables](actions/listTables) | Возвращает список таблиц

## Работа с элементами
Метод | Описание
----- | -----
[BatchGetItem](actions/batchGetItem) | Возвращает атрибуты элементов из нескольких таблиц
[BatchWriteItem](actions/batchWriteItem) | Записывает или удаляет элементы из таблиц
[DeleteItem](actions/deleteItem) | Удаляет элемент в таблице
[GetItem](actions/getItem) | Возвращает атрибуты элемента из одной таблицы
[PutItem](actions/putItem) | Перезаписывает элементы в таблице
[Query](actions/query) | Возвращает элементы из таблиц
[Scan](actions/scan) | Возвращает элементы и атрибуты из таблицы 
[TransactGetItems](actions/transactGetItems) | Извлекает несколько элементов из таблиц
[TransactWriteItems](actions/transactWriteItems) | Синхронная операция записи
[UpdateItem](actions/updateItem) | Обновляет элементы в таблице


## Полезные рецепты
[Уникальность атрибута](../../uniqueConstraint) Как с помощью транзакций обеспечить уникальность атрибута таблицы.
