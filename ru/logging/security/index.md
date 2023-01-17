# Управление доступом {{ cloud-logging-name }}

Для управления правами доступа в {{ cloud-logging-name }} используются [роли](../../iam/concepts/access-control/roles.md).

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) и [пользовательскую лог-группу](../concepts/log-group.md). Роли, назначенные на облако или каталог, действуют и на лог-группы, которые находятся в них.

## Какие роли действуют в сервисе {#roles}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ cloud-logging-name }}.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

{% include [logging-roles-viewer](../../_includes/roles-logging-viewer.md) %}

{% include [logging-roles-editor](../../_includes/roles-logging-editor.md) %}

{% include [logging-roles-reader](../../_includes/roles-logging-reader.md) %}

{% include [logging-roles-writer](../../_includes/roles-logging-writer.md) %}

{% include [logging-roles-admin](../../_includes/roles-logging-admin.md) %}

### {{ roles-viewer }} {#viewer}

Пользователь с ролью `{{ roles-viewer }}` может просматривать информацию о ресурсах, например, посмотреть список лог-групп или записей в них.

### {{ roles-editor }} {#editor}

Пользователь с ролью `{{ roles-editor }}` может управлять лог-группами, например, создать лог-группу, добавить в нее записи или обновить ее настройки.

Помимо этого роль `{{ roles-editor }}` включает в себя все разрешения роли `{{ roles-viewer }}`.

### {{ roles-admin }} {#admin}

Пользователь с ролью `{{ roles-admin }}` может управлять правами доступа к ресурсам, например, разрешить другим пользователям добавлять записи в лог-группы.

Помимо этого роль `{{ roles-admin }}` включает в себя все разрешения роли `{{ roles-editor }}`.
