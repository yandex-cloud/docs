[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > Решение проблем > Joining concatenation of multiple tables is not supported

# [Yandex DataLens] Joining concatenation of multiple tables is not supported

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.CONCAT_NOT_SUPPORTED`

Ошибка возникает при попытке выполнить sorted JOIN с источником, представляющим конкатенацию нескольких таблиц, например, список или диапазон таблиц.

Используйте в соединении одну таблицу, предварительно объедините данные в промежуточную таблицу либо вынесите конкатенацию в SQL-подзапрос и выберите поддерживаемую стратегию JOIN.