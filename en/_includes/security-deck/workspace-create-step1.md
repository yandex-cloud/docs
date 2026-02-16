In the window that opens, select **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingPageLayout.pageTitle_ehdBw }}** in the **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.generalParamsTitle_xzLoX }}** section:

1. Under **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.workspace_title_365xt }}**, enter a name for the new workspace. Follow these naming requirements:

    {% include [group-name-format](../organization/group-name-format.md) %}

    Provide a brief description for the new workspace, if required.
1. Under **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.folder_title_px1re }}**, select the folder to store {{ sd-name }} resources for the new workspace.

    {% include [workspace-resources-in-isolated-folder](./workspace-resources-in-isolated-folder.md) %}

    {% note info %}

    Once the workspace is created, you cannot change this folder.

    {% endnote %}

1. Under **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.billing_account_title_sU1Tj }}**, add a billing account to use to pay for security module resources the workspace consumes.
1. {% include [workspace-create-step1-substep1](./workspace-create-step1-substep1.md) %}
1. Click **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.createAndContinue_1yfFr }}** to proceed to the next step and configure the workspace resources.