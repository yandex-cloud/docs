# Управление доступом пользователя в {{ marketplace-short-name }}

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

#### marketplace.productInstances.auditor {#marketplace-productInstances-auditor}

Роль `marketplace.productInstances.auditor` позволяет просматривать информацию об установленных [продуктах](../concepts/product.md) Marketplace и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, а также просматривать метаданные [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder).

#### marketplace.productInstances.viewer {#marketplace-productInstances-viewer}

Роль `marketplace.productInstances.viewer` позволяет просматривать информацию об установленных [продуктах](../concepts/product.md) Marketplace и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, а также информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `marketplace.productInstances.auditor`.

#### marketplace.productInstances.user {#marketplace-productInstances-user}

Роль `marketplace.productInstances.user` позволяет просматривать информацию об установленных [продуктах](../concepts/product.md) Marketplace, активировать и деактивировать их, просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, а также информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `marketplace.productInstances.viewer`.

#### marketplace.productInstances.editor {#marketplace-productInstances-editor}

Роль `marketplace.productInstances.editor` позволяет управлять установленными продуктами Marketplace.

Пользователи с этой ролью могут:
* просматривать информацию об установленных [продуктах](../concepts/product.md) Marketplace и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* создавать продукты Marketplace, изменять их метаданные, а также активировать и деактивировать продукты Marketplace;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `marketplace.productInstances.user`.

#### marketplace.productInstances.admin {#marketplace-productInstances-admin}

Роль `marketplace.productInstances.admin` позволяет управлять установленными продуктами Marketplace и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию об установленных [продуктах](../concepts/product.md) Marketplace;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к установленным продуктам Marketplace и изменять такие права доступа;
* создавать продукты Marketplace, изменять их метаданные, а также активировать и деактивировать продукты Marketplace;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `marketplace.productInstances.editor`.