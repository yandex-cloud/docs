# Управление доступом в {{ foundation-models-full-name }}

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Какие роли действуют в сервисе {#roles-list}

### Сервисные роли {#service-roles}

#### ai.languageModels.user {#languageModels-user}

{% include [yandexgpt-user](../../_roles/ai/languageModels/user.md) %}

#### {{ roles-yaart-user }} {#imageGeneration-user}

{% include [yandexgpt-user](../../_roles/ai/imageGeneration/user.md) %}

#### ai.assistants.auditor {#assistants-auditor}

{% include [assistants-auditor](../../_roles/ai/assistants/auditor.md) %}

#### ai.assistants.viewer {#assistants-viewer}

{% include [assistants-viewer](../../_roles/ai/assistants/viewer.md) %}

#### ai.assistants.editor {#assistants-editor}

{% include [assistants-editor](../../_roles/ai/assistants/editor.md) %}

#### ai.assistants.admin {#assistants-admin}

{% include [assistants-admin](../../_roles/ai/assistants/admin.md) %}

#### ai.auditor {#ai-auditor}

{% include [ai-auditor](../../_roles/ai/auditor.md) %}

#### ai.viewer {#ai-viewer}

{% include [ai-viewer](../../_roles/ai/viewer.md) %}

#### ai.editor {#ai-editor}

{% include [ai-editor](../../_roles/ai/editor.md) %}

#### ai.admin {#ai-admin}

{% include [ai-admin](../../_roles/ai/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

#### См. также {#see-also}

* [Как назначить роль](../../iam/operations/roles/grant.md)
* [Как отозвать роль](../../iam/operations/roles/revoke.md)
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md)
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance)