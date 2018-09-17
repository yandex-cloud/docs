#### resource-manager.cloud.member

Роль `resource-manager.cloud.member` назначается на облако.
Роль `resource-manager.cloud.member` необходима для всех субъектов кроме [системной группы](../iam/concepts/users/users.md#system) `allAuthenticatedUsers` и пользователей с ролью `resource-manager.cloud.owner`.

Сама по себе роль не дает выполнять какие либо операции с облаком или ресурсами в нем. Эта роль делает пользователя участником облака и используется только в сочетании с другими ролями. Например с `admin`, `editor` или `viewer`.

#### resource-manager.cloud.owner

Роль `resource-manager.cloud.owner` назначается на облако. Роль `resource-manager.cloud.owner` делает пользователя владельцем облака. Владелец одновременно является и участником облака и может выполнять любые операции с облаком и ресурсами в нем.

Только владелец облака может назначать и удалять у пользователей роль `resource-manager.cloud.owner`.
