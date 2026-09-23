---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.NOT_SAME_KEY_POSITION
description: На странице приведено описание ошибки {{ datalens-full-name }} Joined columns do not occupy same positions in key columns of joined tables.
---

# [{{ datalens-full-name }}] Joined columns do not occupy same positions in key columns of joined tables

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.NOT_SAME_KEY_POSITION`

Ошибка возникает, когда соединяемые колонки находятся на разных позициях в ключах сортировки таблиц.

Чтобы исправить ошибку, согласуйте порядок ключевых колонок в схемах таблиц и сопоставляйте колонки, занимающие одинаковые позиции. Если изменить сортировку нельзя, подготовьте промежуточную таблицу или используйте другую стратегию JOIN в SQL-запросе.
