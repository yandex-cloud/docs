В открывшемся окне **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingPageLayout.pageTitle_ehdBw }}** в разделе **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.generalParamsTitle_xzLoX }}**:

1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.workspace_title_365xt }}** введите имя создаваемого окружения. Требования к имени:

    {% include [group-name-format](../organization/group-name-format.md) %}

    При необходимости задайте краткое описание для создаваемого окружения.
1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.folder_title_px1re }}** выберите каталог, в котором будут храниться ресурсы {{ sd-name }} для создаваемого окружения.

    {% include [workspace-resources-in-isolated-folder](./workspace-resources-in-isolated-folder.md) %}

    {% note info %}

    После создания окружения изменить выбранный каталог нельзя.

    {% endnote %}

1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.billing_account_title_sU1Tj }}** привяжите платежный аккаунт, который будет использоваться для оплаты ресурсов модулей безопасности, используемых окружением.
1. {% include [workspace-create-step1-substep1](./workspace-create-step1-substep1.md) %}
1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.createAndContinue_1yfFr }}**, чтобы перейти к следующему этапу — настройке ресурсов окружения.