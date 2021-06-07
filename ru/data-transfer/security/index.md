# Управление доступом

Для использования сервиса необходимо авторизоваться в консоли управления с [аккаунтом на Яндексе](../../iam/concepts/index.md#passport) или с [федеративным аккаунтом](../../iam/concepts/index.md#saml-federation).

В этом разделе вы узнаете:

* [Какие роли необходимы](#choosing-roles) для того или иного действия.
* [На какие ресурсы можно назначить роль](#resources).
* [Какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Какие роли необходимы {#required-roles}

Чтобы пользоваться сервисом, необходима [роль](../../iam/concepts/access-control/roles.md) `editor` или выше на каталог, в котором создаются проекты. Роль `viewer` позволит только просматривать список проектов и содержимое файлов, которые были загружены.

Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `admin` вместо `editor`.

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли на облако действуют и на вложенные каталоги.

## Какие роли действуют в сервисе {#roles-list}

* Сервисные роли:
    * `data-transfer.viewer` — позволяет просматривать информацию только о ресурсах сервиса {{ data-transfer-name }}.
    * {% include [resource-manager.clouds.owner](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.owner.md) %}
    * {% include [resource-manager.clouds.member](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.member.md) %}
* Примитивные роли:
    * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
    * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
    * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
