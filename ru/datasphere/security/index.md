---
title: "Управление доступом в {{ ml-platform-full-name }}"
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

В интерфейсе {{ ml-platform-name }} пользователи с ролью `{{ roles-datasphere-project-viewer }}` имеют роль `Viewer` на вкладке **Участники** на странице проекта.

{% include [projects-developer](../../_includes/roles-datasphere-projects-developer.md) %}

В интерфейсе {{ ml-platform-name }} пользователи с ролью `{{ roles-datasphere-project-developer }}` имеют роль `Developer` на вкладке **Участники** на странице проекта.

{% include [projects-editor](../../_includes/roles-datasphere-projects-editor.md) %}

В интерфейсе {{ ml-platform-name }} пользователи с ролью `{{ roles-datasphere-project-editor }}` имеют роль `Editor` на вкладке **Участники** на странице проекта.

{% include [projects-admin](../../_includes/roles-datasphere-projects-admin.md) %}

В интерфейсе {{ ml-platform-name }} пользователи с ролью `{{ roles-datasphere-project-admin }}` имеют роль `Admin` на вкладке **Участники** на странице проекта.

{% include [communities-viewer](../../_includes/roles-datasphere-communities-viewer.md) %}

В интерфейсе {{ ml-platform-name }} пользователи с ролью `{{ roles-datasphere-communities-viewer }}` имеют роль `Viewer` на вкладке **Участники** на странице сообщества.

{% include [communities-developer](../../_includes/roles-datasphere-communities-developer.md) %}

В интерфейсе {{ ml-platform-name }} пользователи с ролью `{{ roles-datasphere-communities-developer }}` имеют роль `Developer` на вкладке **Участники** на странице сообщества.

{% include [communities-editor](../../_includes/roles-datasphere-communities-editor.md) %}

В интерфейсе {{ ml-platform-name }} пользователи с ролью `{{ roles-datasphere-communities-editor }}` имеют роль `Editor` на вкладке **Участники** на странице сообщества.

{% include [communities-admin](../../_includes/roles-datasphere-communities-admin.md) %}

В интерфейсе {{ ml-platform-name }} пользователи с ролью `{{ roles-datasphere-communities-admin }}` имеют роль `Admin` на вкладке **Участники** на странице сообщества.

> {% include [example-for-sharing](../../_includes/datasphere/roles-for-sharing-example.md) %}

### Примитивные роли {#primitive}

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