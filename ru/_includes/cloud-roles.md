#### resource-manager.cloud.owner

Роль `resource-manager.cloud.owner` назначается на уровне облака.
`resource-manager.cloud.owner` может выполнять любые действия с облаком и ресурсами в нем.

#### resource-manager.cloud.member

Роль `resource-manager.cloud.member` назначается на уровне облака.
Роль `resource-manager.cloud.member` необходима для всех субъектов кроме [системных групп](../iam/concepts/users/users.md#system) `allUsers` и `allAuthenticatedUsers`. При выполнении операций с ресурсами внутри облака эта роль используется в сочетании с другими ролями, например с `admin`, `editor` или `viewer`.