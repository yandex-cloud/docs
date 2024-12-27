# Access management in {{ foundation-models-full-name }}

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Which roles exist in the service {#roles-list}

### Service roles {#service-roles}

#### ai.playground.user {#ai-playground-user}

{% include [ai-playground-user](../../_roles/ai/playground/user.md) %}

#### ai.languageModels.user {#languageModels-user}

{% include [yandexgpt-user](../../_roles/ai/languageModels/user.md) %}

#### {{ roles-yaart-user }} {#imageGeneration-user}

{% include [yandexgpt-user](../../_roles/ai/imageGeneration/user.md) %}

#### ai.assistants.auditor {#ai-assistants-auditor}

{% include [assistants-auditor](../../_roles/ai/assistants/auditor.md) %}

#### ai.assistants.viewer {#ai-assistants-viewer}

{% include [assistants-viewer](../../_roles/ai/assistants/viewer.md) %}

#### ai.assistants.editor {#ai-assistants-editor}

{% include [assistants-editor](../../_roles/ai/assistants/editor.md) %}

#### ai.assistants.admin {#ai-assistants-admin}

{% include [assistants-admin](../../_roles/ai/assistants/admin.md) %}

#### ai.datasets.auditor {#ai-datasets-auditor}

{% include [ai-datasets-auditor](../../_roles/ai/datasets/auditor.md) %}

#### ai.datasets.viewer {#ai-datasets-viewer}

{% include [ai-datasets-viewer](../../_roles/ai/datasets/viewer.md) %}

#### ai.datasets.user {#ai-datasets-user}

{% include [ai-datasets-user](../../_roles/ai/datasets/user.md) %}

#### ai.datasets.editor {#ai-datasets-editor}

{% include [ai-datasets-editor](../../_roles/ai/datasets/editor.md) %}

#### ai.datasets.admin {#ai-datasets-admin}

{% include [ai-datasets-admin](../../_roles/ai/datasets/admin.md) %}

#### ai.models.auditor {#ai-models-auditor}

{% include [ai-models-auditor](../../_roles/ai/models/auditor.md) %}

#### ai.models.viewer {#ai-models-viewer}

{% include [ai-models-viewer](../../_roles/ai/models/viewer.md) %}

#### ai.models.user {#ai-models-user}

{% include [ai-models-user](../../_roles/ai/models/user.md) %}

#### ai.models.editor {#ai-models-editor}

{% include [ai-models-editor](../../_roles/ai/models/editor.md) %}

#### ai.models.admin {#ai-models-admin}

{% include [ai-models-admin](../../_roles/ai/models/admin.md) %}

#### ai.auditor {#ai-auditor}

{% include [ai-auditor](../../_roles/ai/auditor.md) %}

#### ai.viewer {#ai-viewer}

{% include [ai-viewer](../../_roles/ai/viewer.md) %}

#### ai.editor {#ai-editor}

{% include [ai-editor](../../_roles/ai/editor.md) %}

#### ai.admin {#ai-admin}

{% include [ai-admin](../../_roles/ai/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

#### See also {#see-also}

* [How to assign a role](../../iam/operations/roles/grant.md)
* [How to revoke a role](../../iam/operations/roles/revoke.md)
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md)
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance)