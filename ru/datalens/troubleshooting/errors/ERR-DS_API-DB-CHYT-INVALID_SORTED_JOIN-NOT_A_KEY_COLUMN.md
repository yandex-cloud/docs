---
title: Ошибка ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.NOT_A_KEY_COLUMN
description: На странице приведено описание ошибки ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.NOT_A_KEY_COLUMN.
---

# Column used in join expression is not a key column

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.NOT_A_KEY_COLUMN`

При использовании подключения CHYT значимыми являются ключевые колонки таблиц в {{ ytsaurus-name }}.
В мультитабличных датасетах разрешается создавать связь таблиц (выполнять `JOIN`) только по ключевым колонкам (`key columns`) этих таблиц.
Для этого выполните следующие требования:

* все колонки, используемые в связи таблиц, должны быть частью ключа для этих таблиц;
* ключ обеих таблиц должен начинаться именно на эти колонки;
* колонки в ключах обеих таблиц должны присутствовать в одном и том же порядке.


Чтобы обойти проблему, воспользуйтесь одним из вариантов:

* пересоздайте исходные таблицы и задайте ключи, которые будут удовлетворять требованиям выше;
* используйте в качестве источника датасета SQL-запрос с `GLOBAL JOIN`, которые разрешают объединять таблицы по неключевым столбцам:

  ```sql
  SELECT * FROM left_table GLOBAL JOIN right_table ON (...) ....
  ```

