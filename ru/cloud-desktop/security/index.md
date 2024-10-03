---
title: Управление доступом в {{ cloud-desktop-full-name }}
description: Управление доступом в сервисе {{ cloud-desktop-full-name }}. Разрешения выдаются при назначении роли. Роль можно назначить на организацию, каталог или облако — все разрешения от организации или облака наследуются.
---

# Управление доступом в {{ cloud-desktop-full-name }}

В {{ cloud-desktop-name }} управление доступом реализовано с помощью разграничения ролей {{ iam-full-name }} и [списков управления доступом (ACL)](../concepts/acl.md). См. [пример использования механизмов доступа](../concepts/acl.md#example).

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Какие роли действуют в сервисе {#roles-list}

### Сервисные роли {#service-roles}

#### vdi.viewer {#vdi-viewer}

{% include [vdi.viewer](../../_roles/vdi/viewer.md) %}

#### vdi.editor {#vdi-editor}

{% include [vdi.editor](../../_roles/vdi/editor.md) %}

#### vdi.admin {#vdi-admin}

{% include [vdi.admin](../../_roles/vdi/admin.md) %}

Более подробную информацию о сервисных ролях читайте на странице [{#T}](../../iam/concepts/access-control/roles.md) в документации сервиса {{ iam-full-name }}.

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

#### Что дальше {#what-is-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
