# Управление доступом пользователя в Marketplace

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [организацию](../../organization/concepts/organization.md), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на вложенные ресурсы.

## Какие роли действуют в сервисе {#roles-list}

### Сервисные роли {#service-roles}

#### license-manager.auditor {#license-manager-auditor}

Роль `license-manager.auditor` позволяет просматривать информацию о [подписках](../concepts/users/subscription.md).

#### license-manager.viewer {#license-manager-viewer}

Роль `license-manager.viewer` позволяет просматривать информацию о [подписках](../concepts/users/subscription.md) и их [привязках](../operations/users/lock-subscription.md) к ресурсу, приложению или сервису.

Включает разрешения, предоставляемые ролью `license-manager.auditor`.

#### license-manager.user {#license-manager-user}

Роль `license-manager.user` позволяет управлять подписками, а также просматривать информацию о них и их привязках к ресурсам, приложениям или сервисам.

Пользователи с этой ролью могут:
* просматривать информацию о [подписках](../concepts/users/subscription.md) и их привязках к ресурсам, приложениям или сервисам; 
* [покупать](../operations/users/buy-subscription.md) подписки;
* [отключать](../operations/users/cancel-subscription.md) автопродление подписок;
* [привязывать](../operations/users/lock-subscription.md) подписки к ресурсам, приложениям или сервисам и [отвязывать](../operations/users/unlock-subscription.md) подписки от них;
* [перемещать](../operations/users/move-subscription.md) подписки между каталогами.

Включает разрешения, предоставляемые ролью `license-manager.viewer`.

#### license-manager.subscriptionAgent {#license-manager-subscriptionAgent}

Роль `license-manager.subscriptionAgent` позволяет [привязывать](../operations/users/lock-subscription.md) подписки к ресурсам, приложениям или сервисам, а также просматривать информацию о [подписках](../concepts/users/subscription.md) и их привязках к ресурсам, приложениям или сервисам.