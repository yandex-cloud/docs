#### [!KEYREF roles-cloud-member]

[!INCLUDE [roles-cloud-member](roles-cloud-member.md)]

Сама по себе эта роль не дает выполнять какие-либо операции с облаком или ресурсами в нем. Эта роль делает пользователя [участником облака](../resource-manager/concepts/resources-hierarchy.md#member) и используется только в сочетании с другими ролями, например с `admin`, `editor` или `viewer`.

#### [!KEYREF roles-cloud-owner]

Роль `[!KEYREF roles-cloud-owner]` назначается на облако. Роль `[!KEYREF roles-cloud-owner]` делает пользователя [владельцем облака](../resource-manager/concepts/resources-hierarchy.md#owner). Владелец может выполнять любые операции с облаком и ресурсами в нем.

Только владелец облака может назначать и удалять у пользователей роль `[!KEYREF roles-cloud-owner]`.

У облака должен быть хотя бы один владелец. Единственный владелец облака не сможет отнять эту роль у себя.