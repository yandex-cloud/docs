# Имперсонация

_Имперсонация_ — это выполнение пользователем действий с ресурсами [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) от имени [сервисного аккаунта](../users/service-accounts.md), которому назначены необходимые [права доступа](roles.md). Имперсонация чаще всего [применяется](../../operations/sa/impersonate-sa.md), чтобы временно расширить права пользователя, не прибегая к генерации [статических учетных данных](../authorization/index.md).

Например, имперсонация может быть полезна, когда у пользователя нет прав на просмотр [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), но на какое-то время они ему понадобились. Для этого администратор может [назначить](../../operations/sa/impersonate-sa.md) сервисному аккаунту роль на просмотр каталога, а пользователю назначить специальную [роль](../../security/index.md#iam-serviceAccounts-tokenCreator) `iam.serviceAccounts.tokenCreator`. В результате пользователь сможет от имени сервисного аккаунта просматривать ресурсы в каталоге или получить [IAM-токен](../authorization/iam-token.md) сервисного аккаунта. При этом пользователь не сможет изменить права доступа или удалить сервисный аккаунт.

В нужный момент администратор может отозвать у пользователя роль `iam.serviceAccounts.tokenCreator`. В результате пользователь потеряет возможность просматривать каталог от имени сервисного аккаунта.

{% note info %}

Использование имперсонации может быть запрещено [политиками авторизации](access-policies.md) на уровне [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) или [организации](../../../organization/concepts/organization.md).

{% endnote %}

#### См. также {#see-also}

* [{#T}](../../operations/sa/impersonate-sa.md)