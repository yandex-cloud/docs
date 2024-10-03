---
title: "Управление доступом в {{ schema-registry-name }}"
description: "Управление доступом в {{ schema-registry-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия."
---

# Сервисные роли для управления схемами данных с помощью {{ schema-registry-name }}

С помощью сервисных ролей {{ schema-registry-name }} вы сможете просматривать пространства имен, субъекты и схемы в реестре схем, а также создавать, редактировать и удалять пространства имен и схемы.

### schema-registry.auditor {#schema-registry-auditor}

{% include [schema-registry.auditor](../../_roles/schema-registry/auditor.md) %}

### schema-registry.viewer {#schema-registry-viewer}

{% include [schema-registry.viewer](../../_roles/schema-registry/viewer.md) %}

### schema-registry.editor {#schema-registry-editor}

{% include [schema-registry.editor](../../_roles/schema-registry/editor.md) %}

### schema-registry.admin {#schema-registry-admin}

{% include [schema-registry.admin](../../_roles/schema-registry/admin.md) %}

## Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.

| Действие                        | Необходимые роли          |
|---------------------------------|---------------------------|
| Просматривать пространства имен | `schema-registry.auditor` |
| Просматривать субъекты          | `schema-registry.viewer`  |
| Просматривать схемы             | `schema-registry.viewer`  |
| Сравнивать версии схем          | `schema-registry.viewer`  |
| Создавать пространства имен     | `schema-registry.editor`  |
| Создавать схемы                 | `schema-registry.editor`  |
| Редактировать пространства имен | `schema-registry.editor`  |
| Редактировать схемы             | `schema-registry.editor`  |
| Удалять пространства имен       | `schema-registry.editor`  |
| Удалять схемы                   | `schema-registry.editor`  |
