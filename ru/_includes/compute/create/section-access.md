В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:

* (Опционально) [Включите доступ к ВМ по OS Login](../../../compute/operations/vm-connect/os-login.md). Опция доступна для образов Linux из [{{ marketplace-name }}](/marketplace), которые содержат `OS Login` в названии.
* В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.

    {% note alert %}

    Не используйте логин `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

    {% endnote %}

* В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [публичного ключа](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Пару ключей для подключения по SSH необходимо создать самостоятельно, см. [раздел о подключении к ВМ по SSH](../../../compute/operations/vm-connect/ssh.md).

Если вы хотите добавить на ВМ одновременно нескольких пользователей с SSH-ключами, [задайте](../../../compute/concepts/vm-metadata.md#how-to-send-metadata) данные этих пользователей в блоке **{{ ui-key.yacloud.common.metadata }}**. С помощью метаданных вы также можете [установить дополнительное ПО](../../../compute/operations/vm-create/create-with-cloud-init-scripts.md) на ВМ при ее создании.

{% include [vm-connect-linux](../../vm-connect-linux.md) %}

