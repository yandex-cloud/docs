---
title: "Управление доступом в {{ ml-platform-full-name }}"
description: "Управление доступом в сервисе, предоставляющем среду для ML-разработки — {{ ml-platform-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ ml-platform-name }}, назначьте пользователю нужные роли из приведенного списка."
---

# Управление доступом в {{ ml-platform-name }}

Доступ к сервису {{ ml-platform-full-name }} регулируется путем назначения прав в организации. Управление организациями осуществляется с помощью сервиса [{{ org-full-name }}](../../organization/).

Список операций, доступных пользователю {{ ml-platform-short-name }}, определяется его ролью. Роли можно назначить аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным пользователям](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md) или [системной группе](../../iam/concepts/access-control/system-group.md). Подробнее об управлении доступом в {{ yandex-cloud }} см. раздел [{#T}](../../iam/concepts/access-control/index.md).

Назначать роли на ресурс могут те, у кого есть роль `admin`, `resource-manager.clouds.owner` или `organization-manager.organizations.owner` на этот ресурс.

## На какие ресурсы можно назначить роль {#resources}

Разграничение прав доступа происходит на уровне [сообществ](../concepts/community.md) и [проектов](../concepts/project.md). Также вы можете открыть доступ к ресурсам для всех пользователей сообщества. Выданные права доступа распространяются на всю иерархию ресурсов. Например, если вы назначите пользователю роль на проект {{ ml-platform-name }}, то все разрешения будут действовать и на ресурсы внутри этого проекта. Подробнее о [взаимосвязи ресурсов в {{ ml-platform-name }}](../concepts/resource-model.md). 

## Как назначить роль {#grant-role}

Вы можете назначить роль пользователю в интерфейсе {{ ml-platform-name }}:
* [{#T}](../operations/community/add-user.md).
* [{#T}](../operations/projects/add-user.md).
* [Поделиться ресурсами с участниками сообщества](../operations/index.md#share).

Также вы можете [назначить права доступа](../../organization/security/index.md) через интерфейс {{ org-name }}.

## Какие роли действуют в сервисе {#roles-list}

### Сервисные роли {#service-roles}

#### datasphere.community-projects.viewer {#datasphere-communityprojects-viewer}

{% include [datasphere.community-projects.viewer](../../_roles/datasphere/community-projects/viewer.md) %}

#### datasphere.community-projects.developer {#datasphere-communityprojects-developer}

{% include [datasphere.community-projects.developer](../../_roles/datasphere/community-projects/developer.md) %}

#### datasphere.community-projects.editor {#datasphere-communityprojects-editor}

{% include [datasphere.community-projects.editor](../../_roles/datasphere/community-projects/editor.md) %}

#### datasphere.community-projects.admin {#datasphere-communityprojects-admin}

{% include [datasphere.community-projects.admin](../../_roles/datasphere/community-projects/admin.md) %}

#### datasphere.communities.viewer {#datasphere-communities-viewer}

{% include [datasphere.communities.viewer](../../_roles/datasphere/communities/viewer.md) %}

#### datasphere.communities.developer {#datasphere-communities-developer}

{% include [datasphere.communities.developer](../../_roles/datasphere/communities/developer.md) %}

#### datasphere.communities.editor {#datasphere-communities-editor}

{% include [datasphere.communities.editor](../../_roles/datasphere/communities/editor.md) %}

#### datasphere.communities.admin {#datasphere-communities-admin}

{% include [datasphere.communities.admin](../../_roles/datasphere/communities/admin.md) %}

> {% include [example-for-sharing](../../_includes/datasphere/roles-for-sharing-example.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `Editor` вместо `Viewer`.

#| 
|| **Действие** | **Необходимые роли** ||
|| **Просмотр информации** ||
|| Просмотр проекта, его настроек и пользователей | `Viewer` на проект ||
|| Просмотр сообщества, его настроек и пользователей | `Viewer` на сообщество ||
|| **Управление проектом** ||
|| [Создание проекта](../operations/projects/create.md) | `Developer` на сообщество ||
|| Запуск IDE | `Developer` на проект ||
|| Использование ресурсов | `Developer` на проект ||
|| Создание ресурсов | `Developer` на проект ||
|| Удаление ресурсов | `Developer` на проект ||
|| Публикация ресурсов в сообществе | `Editor` на проект и `Developer` на сообщество ||
|| [Изменение настроек проекта](../operations/projects/update.md) | `Editor` на проект ||
|| [Удаление проекта](../operations/projects/delete.md) | `Editor` на проект ||
|| [Выдача роли](#grant-role) в проекте | `Admin` на проект ||
|| **Управление сообществом** ||
|| Изменение настроек сообщества | `Editor` на сообщество ||
|| [Привязка платежного аккаунта](../operations/community/link-ba.md) | `Editor` на сообщество ||
|| [Удаление сообщества](../operations/community/delete.md) | `Editor` на сообщество ||
|| [Выдача роли](#grant-role) в сообществе | `Admin` на сообщество ||
|#

#### См. также {#see-also}

* [{{ org-full-name }}](../../organization/).
* [{#T}](../../iam/concepts/access-control/index.md).
* [{#T}](../../iam/concepts/users/service-accounts.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).