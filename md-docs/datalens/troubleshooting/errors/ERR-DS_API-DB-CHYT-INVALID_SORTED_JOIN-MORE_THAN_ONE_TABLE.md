[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > Решение проблем > Cannot join a concatenation of tables with another table

# [Yandex DataLens] Cannot join a concatenation of tables with another table

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.MORE_THAN_ONE_TABLE`

При подключении к CHYT в JOIN нельзя использовать два диапазона таблиц (и слева, и справа).

Чтобы исправить ошибку, один из диапазонов перепишите как подзапрос.