#### [!KEYREF roles-cloud-member]

[!INCLUDE [roles-cloud-member](roles-cloud-member.md)]

 Одна эта роль не дает права выполнять какие-либо операции и используется только в сочетании с другими ролями, например с `admin`, `editor` или `viewer`.

#### [!KEYREF roles-cloud-owner]

Роль `[!KEYREF roles-cloud-owner]` назначается на облако и делает пользователя [владельцем облака](../resource-manager/concepts/resources-hierarchy.md#owner). Владелец может выполнять любые операции с облаком и ресурсами в нем.

Только владелец облака может назначать и удалять у пользователей роль `[!KEYREF roles-cloud-owner]`.

У облака должен быть хотя бы один владелец. Единственный владелец облака не сможет отнять эту роль у себя.