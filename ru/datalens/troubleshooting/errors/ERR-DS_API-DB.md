---
title: Ошибка ERR.DS_API.DB
description: На странице приведено описание ошибки ERR.DS_API.DB.
---

# Ошибка выполнения запроса в источнике данных

`ERR.DS_API.DB`

Ошибка возникает, когда источник данных, например БД, возвращает ошибку при выполнении SQL-запроса. Это ошибка самого источника данных, а не {{ datalens-short-name }}.

Некоторые распространенные и понятные ошибки выполнения запросов обрабатываются отдельно (например, ошибка [ERR.DS_API.DB.ZERO_DIVISION](./ERR-DS_API-DB-ZERO_DIVISION.md)). Все ошибки, которые не были обработаны, относятся к категории `ERR.DS_API.DB`.