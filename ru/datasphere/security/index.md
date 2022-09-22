---
title: Управление доступом в {{ ml-platform-full-name }}
description: "Управление доступом в сервисе, предоставляющем среду для ML-разработки — {{ ml-platform-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ ml-platform-name }}, назначьте пользователю нужные роли из приведенного списка."
---

# Управление доступом в {{ ml-platform-name }}

Доступ к сервису {{ ml-platform-full-name }} регулируется путем назначения прав в организации. Управление организациями осуществляется с помощью сервиса [{{ org-full-name }}](../../organization/).

Список операций, доступных пользователю {{ ml-platform-short-name }}, определяется его ролью. Подробнее об управлении доступом в {{ yandex-cloud }} см. раздел [{#T}](../../iam/concepts/access-control/index.md).

## На какие ресурсы можно назначить роль {#resources}

Разграничение прав доступа происходит на уровне [сообществ](../concepts/community.md) и [проектов](../concepts/project.md). Также вы можете открыть доступ к ресурсам для всех пользователей сообщества. Выданные права доступа распространяются на всю иерархию ресурсов. Например, если вы назначите пользователю роль на проект {{ ml-platform-name }}, то все разрешения будут действовать и на ресурсы внутри этого проекта. Подробнее о [взаимосвязи ресурсов в {{ ml-platform-name }}](../concepts/resource-model.md). 

## Как назначить роль {#grant-role}

Вы можете назначить роль пользователю в интерфейсе {{ ml-platform-name }}:
* [{#T}](../operations/community/add-user.md).
* [{#T}](../operations/projects/add-user.md).
* [Поделиться ресурсами с участниками сообщества](../operations/index.md#share).

Также вы можете [назначить права доступа](../../organization/roles.md) через интерфейс {{ org-name }}.

## Какие роли действуют в сервисе {#roles-list}

### Сервисные роли {#services}

{% include [projects-viewer](../../_includes/roles-datasphere-project-viewer.md) %}

Пользователи с ролью `{{ roles-datasphere-project-viewer }}` не отображаются в списках участников проекта и сообщества, и ее нельзя назначить в интерфейсе {{ ml-platform-name }}.

{% include [projects-developer](../../_includes/roles-datasphere-projects-developer.md) %}

В интерфейсе {{ ml-platform-name }} пользователи с ролью `{{ roles-datasphere-project-developer }}` имеют роль `Разработчик` на вкладке **Участники** на странице проекта.

{% include [projects-admin](../../_includes/roles-datasphere-projects-admin.md) %}

В интерфейсе {{ ml-platform-name }} пользователи с ролью `{{ roles-datasphere-project-admin }}` имеют роль `Админ` на вкладке **Участники** на странице проекта.

{% include [communities-viewer](../../_includes/roles-datasphere-communities-viewer.md) %}

Пользователи с ролью `{{ roles-datasphere-communities-viewer }}` не отображаются в списке участников сообщества.

{% include [communities-editor](../../_includes/roles-datasphere-communities-editor.md) %}

В интерфейсе {{ ml-platform-name }} пользователи с ролью `{{ roles-datasphere-communities-developer }}` имеют роль `Разработчик` на вкладке **Участники** на странице сообщества.

{% include [communities-admin](../../_includes/roles-datasphere-communities-admin.md) %}

В интерфейсе {{ ml-platform-name }} пользователи с ролью `{{ roles-datasphere-communities-admin }}` имеют роль `Админ` на вкладке **Участники** на странице сообщества.

> {% include [example-for-sharing](../../_includes/datasphere/roles-for-sharing-example.md) %}

### Примитивные роли {#primitive}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

#### См. также {#see-also}

* [{{ org-full-name }}](../../organization/).
* [{#T}](../../iam/concepts/access-control/index.md).
* [{#T}](../../iam/concepts/users/service-accounts.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).