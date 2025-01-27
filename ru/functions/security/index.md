---
title: Управление доступом в {{ sf-name }}
description: Управление доступом сервиса для запуска приложений без создания и обслуживания виртуальных машин — {{ sf-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе.
---

# Управление доступом в {{ sf-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `functions.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

На [функцию](../concepts/function.md) роль можно назначить через {{ yandex-cloud }} [CLI](../../cli/cli-ref/serverless/cli-ref/function/add-access-binding.md), [API](../api-ref/functions/authentication.md) или [{{ TF }}]({{ tf-provider-resources-link }}/function_iam_binding).

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ sf-name }}.

### Сервисные роли {#service-roles}

#### functions.auditor {#functions-auditor}

{% include [functions.auditor](../../_roles/functions/auditor.md) %}

#### functions.viewer {#functions-viewer}

{% include [functions.viewer](../../_roles/functions/viewer.md) %}

#### functions.functionInvoker {#functions-functionInvoker}

{% include [functions.functionInvoker](../../_roles/functions/functionInvoker.md) %}

#### functions.editor {#functions-editor}

{% include [functions.editor](../../_roles/functions/editor.md) %}

#### functions.mdbProxiesUser {#functions-mdbProxiesUser}

{% include [functions.mdbProxiesUser](../../_roles/functions/mdbProxiesUser.md) %}

#### functions.admin {#functions-admin}

{% include [functions.admin](../../_roles/functions/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}