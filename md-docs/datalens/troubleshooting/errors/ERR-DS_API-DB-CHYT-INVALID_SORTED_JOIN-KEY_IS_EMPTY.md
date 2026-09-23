[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > Решение проблем > Cannot join: key is empty

# [Yandex DataLens] Cannot join: key is empty

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.KEY_IS_EMPTY`

Ошибка возникает, когда CHYT не может выделить ключ соединения из `ON`/`USING`.

Чтобы исправить ошибку, добавьте хотя бы одно прямое равенство ключевых колонок и убедитесь, что соединяемые колонки входят в префиксы ключей сортировки обеих таблиц.