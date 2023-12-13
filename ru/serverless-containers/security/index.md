# Управление доступом в {{ serverless-containers-name }}

Для управления правами доступа в {{ serverless-containers-name }} используются [роли](../../iam/concepts/access-control/roles.md).

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) и [контейнер](../concepts/container.md).

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ serverless-containers-name }}.

### Сервисные роли {#service-roles}

{% include [serverless-containers-roles-viewer](../../_includes/roles-serverless-containers-viewer.md) %}

{% include [serverless-containers-roles-auditor](../../_includes/roles-serverless-containers-auditor.md) %}

{% include [serverless-containers-roles-invoker](../../_includes/roles-serverless-containers-invoker.md) %}

{% include [serverless-containers-roles-editor](../../_includes/roles-serverless-containers-editor.md) %}

{% include [serverless-containers-roles-admin](../../_includes/roles-serverless-containers-admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
