#### resource-manager.cloud.owner

Роль `resource-manager.cloud.owner` назначается на облако.
`resource-manager.cloud.owner` может выполнять любые операции с облаком и ресурсами в нем.

#### resource-manager.cloud.member

Роль `resource-manager.cloud.member` назначается на облако.
Роль `resource-manager.cloud.member` необходима для всех субъектов кроме [системной группы](../iam/concepts/users/users.md#system) `allAuthenticatedUsers`. При выполнении операций с ресурсами внутри облака эта роль используется в сочетании с другими ролями, например с `admin`, `editor` или `viewer`.