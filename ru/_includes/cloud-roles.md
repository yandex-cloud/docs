### {{ roles-cloud-member }} {#member}

{% include [roles-cloud-member](roles-cloud-member.md) %}

### {{ roles-cloud-owner }} {#owner}

Роль `{{ roles-cloud-owner }}` назначается на облако и делает пользователя [владельцем облака](../resource-manager/concepts/resources-hierarchy.md#owner). Владелец может выполнять любые операции с облаком и ресурсами в нем.

Только владелец облака может назначать и удалять у пользователей роль `{{ roles-cloud-owner }}`.

У облака должен быть хотя бы один владелец. Единственный владелец облака не сможет отнять эту роль у себя.
