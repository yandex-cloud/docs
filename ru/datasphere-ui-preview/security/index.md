---
title: Управление доступом в {{ ml-platform-full-name }}
description: "Управление доступом в сервисе, предоставляющем среду для ML-разработки — {{ ml-platform-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ ml-platform-name }}, назначьте пользователю нужные роли из приведенного списка."
---

# Управление доступом в {{ ml-platform-name }}

Список операций, доступных пользователю {{ yandex-cloud }}, определяется его ролью. Роль пользователя назначается на уровне каталога или облака, а вложенные ресурсы наследуют эту роль.

Чтобы разрешить доступ к ресурсам сервиса {{ ml-platform-short-name }}, назначьте пользователю нужные роли из приведенного ниже списка.

{% note info %}

Подробнее о наследовании ролей читайте в разделе [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-full-name }}.

{% endnote %}

## Назначение ролей {#grant-role}

Чтобы назначить пользователю роль:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Роли для управления облаком и каталогом {#rm-roles}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

## Сервисные роли {#services}

{% include [projects-user](../../_includes/roles-datasphere-projects-user.md) %}

{% include [projects-admin](../../_includes/roles-datasphere-projects-admin.md) %}

{% include [communities-viewer](../../_includes/roles-datasphere-communities-viewer.md) %}

{% include [communities-editor](../../_includes/roles-datasphere-communities-editor.md) %}

{% include [communities-admin](../../_includes/roles-datasphere-communities-admin.md) %}

## Примитивные роли {#primitive}

### {{ roles-viewer }} {#viewer}

Роль `{{ roles-viewer }}` включает в себя все разрешения роли `{{ roles-datasphere-project-user }}`. Пользователь может просматривать список проектов, а также работать с уже существующими проектами. Пользователь не может создавать или удалять проекты.

### {{ roles-editor }} {#editor}

Роль `{{ roles-editor }}` включает в себя все разрешения роли `{{ roles-viewer }}`. С точки зрения доступа к ресурсам сервиса {{ ml-platform-short-name }} эти роли совпадают.

### {{ roles-admin }} {#admin}

Пользователь с ролью `{{ roles-admin }}` может управлять правами доступа к ресурсам, например, разрешить другим пользователям работать с каталогами или просматривать информацию о проектах и правах пользователей.

Помимо этого роль `{{ roles-admin }}` включает в себя все разрешения роли `{{ roles-editor }}`.