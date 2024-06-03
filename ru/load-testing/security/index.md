# Управление доступом в {{ load-testing-name }}

Для управления правами доступа в {{ load-testing-name }} используются [роли](../../iam/concepts/access-control/roles.md).

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

{% include [roles-assign](../../_includes/iam/roles-assign.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/load-testing/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

#### loadtesting.viewer {#loadtesting-viewer}

{% include [loadtesting.viewer](../../_roles/loadtesting/viewer.md) %}

#### loadtesting.editor {#loadtesting-editor}

{% include [loadtesting.editor](../../_roles/loadtesting/editor.md) %}

#### loadtesting.admin {#loadtesting-admin}

{% include [loadtesting.admin](../../_roles/loadtesting/admin.md) %}

#### loadtesting.loadTester {#loadtesting-loadtester}

{% include [loadtesting.loadtester](../../_roles/loadtesting/loadTester.md) %}

#### loadtesting.generatorClient {#loadtesting-generatorclient}

{% include [loadtesting.generatorclient](../../_roles/loadtesting/generatorClient.md) %}

#### loadtesting.externalAgent {#loadtesting-externalagent}

{% include [loadtesting.externalagent](../../_roles/loadtesting/externalAgent.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

#### Что дальше {#next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
