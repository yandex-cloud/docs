---
title: "Управление доступом в {{ sf-name }}"
description: "Управление доступом сервиса для запуска приложений без создания и обслуживания виртуальных машин — {{ sf-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе."
---

# Управление доступом в {{ sf-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) и [функцию](../concepts/function.md). Роли, назначенные на облако или каталог, действуют и на функции, которые находятся в них.

## Какие роли действуют в сервисе {#roles}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ sf-name }}.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

{% include [functions-roles-invoker](../../_includes/roles-functions-invoker.md) %}

{% include [functions-roles-admin](../../_includes/roles-functions-admin.md) %}

{% include [functions-roles-mdbproxy](../../_includes/roles-functions-mdbproxy.md) %}

### {{ roles-viewer }} {#viewer}

Пользователь с ролью `{{ roles-viewer }}` может просматривать информацию о ресурсах, например, посмотреть список функций или версий и журнал выполнения функции.

### {{ roles-editor }} {#editor}

Пользователь с ролью `{{ roles-editor }}` может управлять функциями и версиями, например, создать или удалить версию или отредактировать информацию о функции.

Помимо этого роль `{{ roles-editor }}` включает в себя все разрешения роли `{{ roles-viewer }}`.

### {{ roles-admin }} {#admin}

Пользователь с ролью `{{ roles-admin }}` может управлять правами доступа к ресурсам, например разрешить другим пользователям запускать функции или работать с версиями.

Помимо этого роль `{{ roles-admin }}` включает в себя все разрешения роли `{{ roles-editor }}`.
