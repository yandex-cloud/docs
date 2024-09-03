Роль `resource-manager.clouds.owner` позволяет совершать любые действия в [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud) и дочерних [ресурсах](../../../resource-manager/concepts/resources-hierarchy.md), а также просматривать список [платежных аккаунтов](../../../billing/concepts/billing-account.md) и привязывать к ним облако. Роль должна быть выдана на платежный аккаунт. По умолчанию пользователи с этой ролью получают [уведомления](../../../resource-manager/concepts/notify.md) о событиях в облаке и его каталогах.

Включает разрешения, предоставляемые ролями `admin` и `resource-manager.clouds.member`.

Можно назначить только на облако.
