Роль `resource-manager.clouds.owner` позволяет совершать любые действия в [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud) и дочерних [ресурсах](../../../resource-manager/concepts/resources-hierarchy.md).

Роль также позволяет управлять привязкой облака к [платежному аккаунту](../../../billing/concepts/billing-account.md), для этого у пользователя должны быть права на этот платежный аккаунт. Подробнее об управлении доступом к платежному аккаунту см. в [документации Yandex Cloud Billing](../../../billing/security/index.md#billing-account).

По умолчанию пользователи с этой ролью получают [уведомления](../../../resource-manager/concepts/notify.md) о событиях в облаке и его каталогах.

Роль можно назначить только на облако. Пользователю, создающему облако, автоматически назначается данная роль на это облако.

Включает разрешения, предоставляемые ролями `admin` и `resource-manager.clouds.member`.
