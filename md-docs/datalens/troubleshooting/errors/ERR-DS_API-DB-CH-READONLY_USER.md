[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > Решение проблем > ClickHouse® user must be correctly configured to use readonly 1 option (see docs). For other readonly options user should have parameter readonly set to 0 or 2

# [Yandex DataLens] ClickHouse® user must be correctly configured to use readonly 1 option (see docs). For other readonly options user should have parameter readonly set to 0 or 2

`ERR.DS_API.DB.CH.READONLY_USER`

Ошибка возникает из-за ограничений профиля пользователя в ClickHouse® или несовпадения серверной настройки `readonly` с настройкой подключения DataLens.

Чтобы исправить ошибку:

* Для чтения данных в [дополнительных настройках подключения](../../operations/connection/create-clickhouse.md#clickhouse-additional-settings) для параметра `Readonly` выберите значение `2`.
* Если для параметра `Readonly` выбрано значение `1`, администратор ClickHouse® должен указать настройки пользователя, как описано в [инструкции](../../operations/connection/create-clickhouse.md).
* Для записи данных используйте пользователя с нужными правами и в дополнительных настройках подключения для параметра `Readonly` выберите значение `0`.
* В остальных случаях удалите операции записи.