# Управление доступом в {{ serverless-containers-name }}

Для управления правами доступа в {{ serverless-containers-name }} используются [роли](../../iam/concepts/access-control/roles.md).

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `serverless-containers.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

На [контейнер](../concepts/container.md) роль можно назначить через {{ yandex-cloud }} [CLI](../../cli/cli-ref/managed-services/serverless/container/add-access-binding.md), [API](../api-ref/containers/authentication.md) или [{{ TF }}]({{ tf-provider-resources-link }}/serverless_container_iam_binding).

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ serverless-containers-name }}.

### Сервисные роли {#service-roles}

#### serverless-containers.auditor {#serverless-containers-auditor}

{% include [containers-auditor](../../_roles/serverless-containers/auditor.md) %}

#### serverless-containers.viewer {#serverless-containers-viewer}

{% include [containers-viewer](../../_roles/serverless-containers/viewer.md) %}

#### serverless-containers.editor {#serverless-containers-editor}

{% include [containers-editor](../../_roles/serverless-containers/editor.md) %}

#### serverless-containers.admin {#serverless-containers-admin}

{% include [containers-admin](../../_roles/serverless-containers/admin.md) %}

#### serverless-containers.containerInvoker {#serverless-containers-containerinvoker}

{% include [containers-containerinvoker](../../_roles/serverless-containers/containerInvoker.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}