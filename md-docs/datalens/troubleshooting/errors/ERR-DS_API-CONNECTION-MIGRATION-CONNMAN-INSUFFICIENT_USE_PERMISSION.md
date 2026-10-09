[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md)

# [Yandex DataLens] Нет доступа к подключению Connection Manager

`ERR.DS_API.CONNECTION.MIGRATION.CONNMAN.INSUFFICIENT_USE_PERMISSION`

Нет доступа к подключению Connection Manager. Подключение для пользователя базы данных нашлось, но у вас нет прав на его использование — для этого нужна роль `connection-manager.user` в этом каталоге или напрямую на подключение.

Запросите [роль](../../../metadata-hub/security/connection-manager-roles.md#connection-manager-user) `connection-manager.user` в этом каталоге или напрямую на подключение у администратора и повторите миграцию.