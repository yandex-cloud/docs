[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > Решение проблем > Reading multiple dynamic tables or dynamic table together with static table is not supported in CHYT

# [Yandex DataLens] Reading multiple dynamic tables or dynamic table together with static table is not supported in CHYT

`ERR.DS_API.DB.CHYT.MULTI_DYN_NOT_SUPPORTED`

Ошибка возникает, когда один запрос CHYT читает несколько динамических таблиц либо одновременно динамическую и статическую таблицы.

Чтобы исправить ошибку, оставьте в запросе одну динамическую таблицу, разделите запросы или предварительно материализуйте необходимые данные в одну статическую таблицу.