Before you start using the {{ dspm-name }} module, set up your [workspace](../../security-deck/concepts/workspace.md) and specify the default folder to store [Data Security Posture Management](../../security-deck/concepts/dspm.md) ({{ dspm-name }}) data:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#console}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![database-magnifier](../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}**.
  1. If the {{ sd-name }} settings window opens, this means the {{ dspm-name }} data storage folder has not been configured. Under **{{ ui-key.yacloud_org.security-center.onboarding.label_select-default-folder }}**, select a folder to store the module data by default and click **{{ ui-key.yacloud.common.save }}** at the bottom of the page.
  1. If the **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}** UI opens, this means the module's data storage folder has already been configured, so you can continue working.

      You can change the **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}** data storage folder path. To do this, navigate to the **{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.settings_wHmWK }}** tab. Under **{{ ui-key.yacloud_org.security-center.settings.general.section_default-storage_label }}**, select another folder.
  1. Activate {{ dspm-name }} in the current workspace. To do this, click ![wrench](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud_org.security.dspm.DiscoveryPageLayout.header_button_text_hefvE }}** at the top right.

      In the window that opens, navigate to the **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabStandards_wSeaW }}** tab. Under **{{ ui-key.yacloud_org.security.workspaces.title_security-modules_8MdQg }}**, select the **{{ ui-key.yacloud_org.security.workspaces.module_dspm_xxxxx }}** module and click **{{ ui-key.yacloud.common.save }}**.
  
      If you have no workspaces yet, [create](../../security-deck/operations/workspaces/create.md) one and activate the **{{ ui-key.yacloud_org.security.workspaces.module_dspm_xxxxx }}** when creating the workspace.

{% endlist %}