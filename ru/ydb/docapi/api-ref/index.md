---
title: "Методы работы {{ ydb-full-name }} с HTTP API"
description: "{{ ydb-full-name }} HTTP API предоставляет следующие методы работы. Работа с таблицами (CreateTable, DeleteTable, DescribeTable, ListTables). Работа с элементами (BatchGetItem, BatchWriteItem, DeleteItem, GetItem, PutItem, Query, Scan, TransactGetItems, TransactWriteItems, UpdateItem)."
sourcePath: overlay/docapi/api-ref/index.md
---

# Все методы

{{ ydb-name }} HTTP API предоставляет следующие методы:

## Работа с таблицами {#scheme}

Метод | Описание
----- | -----
[CreateTable](actions/createTable.md) | Создает таблицу.
[DeleteTable](actions/deleteTable.md) | Удаляет таблицу.
[DescribeTable](actions/describeTable.md) | Возвращает информацию о таблице.
[DescribeTimeToLive](actions/describeTimeToLive.md) | Возвращает информацию о состоянии времени жизни (TTL) в указанной таблице.
[ListTables](actions/listTables.md) | Возвращает список таблиц.
[UpdateTimeToLive](actions/updateTimeToLive.md) | Включает или отключает время жизни (TTL) для указанной таблицы.

## Работа с элементами {#data}

Метод | Описание
----- | -----
[BatchGetItem](actions/batchGetItem.md) | Возвращает атрибуты элементов из нескольких таблиц.
[BatchWriteItem](actions/batchWriteItem.md) | Записывает или удаляет элементы из таблиц.
[DeleteItem](actions/deleteItem.md) | Удаляет элемент в таблице.
[GetItem](actions/getItem.md) | Возвращает атрибуты элемента из одной таблицы.
[PutItem](actions/putItem.md) | Перезаписывает элементы в таблице.
[Query](actions/query.md) | Возвращает элементы из таблиц.
[Scan](actions/scan.md) | Возвращает элементы и атрибуты из таблицы.
[TransactGetItems](actions/transactGetItems.md) | Извлекает несколько элементов из таблиц.
[TransactWriteItems](actions/transactWriteItems.md) | Синхронная операция записи.
[UpdateItem](actions/updateItem.md) | Обновляет элементы в таблице.
