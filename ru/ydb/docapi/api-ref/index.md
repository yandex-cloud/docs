---
title: Методы работы с Yandex Database HTTP API
description: "Yandex Database HTTP API предоставляет следующие методы работы. Работа с таблицами (CreateTable, DeleteTable, DescribeTable, ListTables). Работа с элементами (BatchGetItem, BatchWriteItem, DeleteItem, GetItem, PutItem, Query, Scan, TransactGetItems, TransactWriteItems, UpdateItem)."

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Все методы

{{ ydb-name }} HTTP API предоставляет следующие методы:

## Работа с таблицами
Метод | Описание
----- | -----
[CreateTable](actions/createTable) | Создает таблицу.
[DeleteTable](actions/deleteTable) | Удаляет таблицу.
[DescribeTable](actions/describeTable) | Возвращает информацию о таблице.
[DescribeTimeToLive](actions/describeTimeToLive) | Возвращает информацию о состоянии времени жизни (TTL) в указанной таблице.
[ListTables](actions/listTables) | Возвращает список таблиц.
[UpdateTimeToLive](actions/updateTimeToLive) | Включает или отключает время жизни (TTL) для указанной таблицы.

## Работа с элементами
Метод | Описание
----- | -----
[BatchGetItem](actions/batchGetItem) | Возвращает атрибуты элементов из нескольких таблиц.
[BatchWriteItem](actions/batchWriteItem) | Записывает или удаляет элементы из таблиц.
[DeleteItem](actions/deleteItem) | Удаляет элемент в таблице.
[GetItem](actions/getItem) | Возвращает атрибуты элемента из одной таблицы.
[PutItem](actions/putItem) | Перезаписывает элементы в таблице.
[Query](actions/query) | Возвращает элементы из таблиц.
[Scan](actions/scan) | Возвращает элементы и атрибуты из таблицы.
[TransactGetItems](actions/transactGetItems) | Извлекает несколько элементов из таблиц.
[TransactWriteItems](actions/transactWriteItems) | Синхронная операция записи.
[UpdateItem](actions/updateItem) | Обновляет элементы в таблице.
