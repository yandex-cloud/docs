[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > Решение проблем > CHYT does not support compound expressions in ON/USING clause

# [Yandex DataLens] CHYT does not support compound expressions in ON/USING clause

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.COMPOUND_EXPR_NOT_SUPPORTED`

Ошибка возникает, когда условие сортировки при пересечении таблиц (JOIN) в CHYT содержит составное выражение вместо непосредственного равенства ключевых колонок.

Чтобы исправить ошибку, попробуйте выполнить действия:

* Вынесите вычисления в подзапрос или заранее вычисленные колонки и оставьте в `ON`/`USING` простые равенства соответствующих ключей.
* Для SQL-запроса выберите другую стратегию соединения, например `GLOBAL JOIN`.