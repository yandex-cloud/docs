---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.TABLE_NOT_SORTED
description: На странице приведено описание ошибки {{ datalens-full-name }} Tables should be sorted.
---

# [{{ datalens-full-name }}] Tables should be sorted

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.TABLE_NOT_SORTED`

Ошибка возникает, когда одна из таблиц в sorted JOIN не отсортирована. В подробном сообщении об ошибке указывается проблемная таблица.

Чтобы исправить ошибку, отсортируйте и сохраните таблицу с подходящим ключом либо используйте подготовленную отсортированную таблицу. Если это невозможно, используйте другую стратегию JOIN в SQL-запросе или подготовьте промежуточный источник.
