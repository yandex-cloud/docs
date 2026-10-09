[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md)

# [Yandex DataLens] Недостаточно прав для создания подключения

`ERR.DS_API.CONNECTION.MIGRATION.CONNMAN.CREATOR_ROLE_REQUIRED`

Недостаточно прав для создания подключения. Чтобы мигрировать подключение, DataLens создает подключение Connection Manager в каталоге кластера от вашего имени — для этого нужна роль `connection_manager.editor` в этом каталоге.

Чтобы исправить ошибку, запросите [роль](../../../metadata-hub/security/connection-manager-roles.md#connection-manager-user) `connection_manager.editor` в каталоге кластера у администратора и повторите миграцию.