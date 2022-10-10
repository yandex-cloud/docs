# Управление доступом в {{ mgl-name }}

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

{% if audience != "internal" %}

Для использования сервиса необходимо авторизоваться в консоли управления с [аккаунтом на Яндексе](../../iam/concepts/index.md#passport) или с [федеративным аккаунтом](../../iam/concepts/index.md#saml-federation).

{% endif %}

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на {% if audience != "internal" %}[облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder){% else %}облако или каталог{% endif %}. Роли на облако действуют и на вложенные каталоги.

## Какие роли действуют в сервисе {#roles-list}

{% include [gitlab-viewer](../../_includes/roles-gitlab-viewer.md) %}

{% include [gitlab-editor](../../_includes/roles-gitlab-editor.md) %}

{% include [gitlab-admin](../../_includes/roles-gitlab-admin.md) %}

### {{ roles-cloud-member }} {#resmgr-clouds-member}

{% include [roles-cloud-member](../../_includes/roles-cloud-member.md) %}

### {{ roles-cloud-owner }} {#resmgr-clouds-owner}

{% include [roles-cloud-owner](../../_includes/roles-cloud-owner.md) %}

### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_includes/roles-viewer.md) %}

### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_includes/roles-editor.md) %}

### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_includes/roles-admin.md) %}

## Какие роли необходимы {#required-roles}

Чтобы пользоваться сервисом, необходима {% if audience != "internal" %}[роль](../../iam/concepts/access-control/roles.md){% else %}роль{% endif %} `editor` или выше на каталог, в котором создаются проекты. Роль `viewer` позволит только просматривать список проектов и содержимое файлов, которые были загружены.

Вы всегда можете назначить роль, которая дает более широкие разрешения. Например, назначить `admin` вместо `editor`.

{% if audience != "internal" %}

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

{% endif %}
