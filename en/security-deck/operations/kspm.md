---
title: Getting started with {{ k8s }}® Security Posture Management (KSPM) in {{ sd-full-name }}
description: In this guide, you will learn how to get started with the {{ k8s }}® Security Posture Management (KSPM) module in {{ sd-name }}.
---

# Getting started with {{ k8s }}® Security Posture Management (KSPM) in {{ sd-full-name }}

{% include [note-preview-kspm](../../_includes/security-deck/note-preview-kspm.md) %}

{% include [kspm-basic-intro](../../_includes/security-deck/kspm-basic-intro.md) %}

{% note warning %}

To use the KSPM module, the minimum [role](../security/index.md#security-deck-admin) you need for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) specified in the [workspace](../concepts/workspace.md) is `security-deck.admin`.

Users who will later monitor failures in {{ managed-k8s-name }} clusters need the minimum [role](../security/kspm-roles.md#kspm-admin) of `kspm.admin` for the folder specified in the workspace.

{% endnote %}

## Activating the KSPM module {#enable-kspm}

To get started with KSPM:
1. [Create](../../iam/operations/sa/create.md) a service account KSPM will use to view {{ managed-k8s-name }} [cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) info, install the necessary components, and perform checks.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) to the service account the `security-deck.worker` [role](../security/index.md#security-deck-worker) for the organization, cloud, or folder.

    {% note info %}

    KSPM will only have access to the {{ managed-k8s-name }} clusters residing in the corresponding organization, cloud, or folder.

    {% endnote %}

    If you have assigned the role for a particular folder, the service account will also need the `auditor` role for the cloud.

1. [Create](../operations/workspaces/create.md) a {{ sd-name }} workspace configured as follows:

    * In the connector settings under **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.resourcesTitle_fE6qp }}**:
      * Select the service account you created earlier.
      * Specify the clouds and folders you want to control the security of {{ managed-k8s-name }} clusters in.

        {% note tip %}

        Later on you will be able to further narrow the scope of control in the KSPM settings.

        {% endnote %}

    * Under **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.standartsTitle_cxvJ8 }}**, select the industry standards and regulations the resources you chose at the previous step will be benchmarked against.
      
      {% include [kspm-sec-standard-list](../../_includes/security-deck/kspm-sec-standard-list.md) %}

      You can select several standards at the same time. The **{{ ui-key.yacloud_org.security.workspaces.WorkspaceStandardsForm.modules_title_s8LDi }}** section will display the {{ sd-name }} modules, which will be activated in the new workspace to check your resources for compliance with the selected standards and regulations.
1. Complete the KSPM setup:
    1. Click ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspacePageLayout.edit_action }}** on the new workspace page.
    1. Navigate to the **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabKubernetes_rC2uU }}** tab.
    1. Under **{{ ui-key.yacloud_org.security.workspaces.WorkspaceKspmResourcesForm.section-title_iYCNY }}**, select the clouds, folders, or clusters within the workspace resources where compliance with the {{ k8s }} security rules will be enforced.

        {% note warning %}

        A cluster can only belong to one {{ sd-name }} workspace. Otherwise, there will be conflicts.

        {% endnote %}

    1. Click **{{ ui-key.yacloud.common.save }}** and confirm the action.

        Once you do that, the necessary components will be automatically installed in the `yc-security` namespace in the {{ managed-k8s-name }} clusters that are within the scope of control.

        Depending on cluster size, component installation may take from 1 to 10 minutes.

{% note tip %}

To remove clusters from the control scope and to stop monitoring them for security, [delete](./workspaces/delete.md) the {{ sd-name }} workspace or disable the {{ k8s }} security standards.

{% endnote %}

## Using KSPM {#use-kspm}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![image](../../_assets/security-deck/kspm.svg) **{{ ui-key.yacloud_org.security-center.label_kspm }}**.
  1. At the top of the window, click **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) and select the [workspace](../concepts/workspace.md).
  1. On the **{{ ui-key.yacloud_org.security-center.kspm.title_clusters }}** tab, make sure all the clusters are connected to KSPM and are in the active control status.
  1. Review the **{{ ui-key.yacloud_org.security-center.kspm.title_dashboard }}** tab. It has the following sections:
      * **{{ ui-key.yacloud_org.security.kspm.TopControlsByErrorsWidget.table_controls_rJ32E }}**: Contains the most frequently violated rules within the control scope and gives the number of violations.
      * Section with overall statistics for the scope of control: Gives the number of clusters with KSPM connection errors, numbers of clusters with security warnings, number of **{{ ui-key.yacloud_org.kspm.TopClustersByErrorsWidget.table_clusters }}**, and number of violations.
      * A list of alerts stating threat type, status, and last update time.

        {% include [kspm-alerts](../../_includes/security-deck/kspm-alerts.md) %}

{% endlist %}

## {{ k8s }} control rules {#rules-info}

To view active {{ k8s }} control rules:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, click **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) and select the [workspace](../concepts/workspace.md) for which you want to view the rule info. Use search, if required.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ ui-key.yacloud_org.security.controls.ControlsPage.kubernetes_jRCmt }}** tab. The section that opens lists the control rules that form a part of the [security standards](../concepts/workspace.md#standards) specified for the current workspace.

      For each rule, the table displays the following information:
      
      {% note tip %}
      
      If you need to, you can change the info columns displayed in the table. Do it by clicking ![gear](../../_assets/console-icons/gear.svg) in the row with the table column headers, selecting the info columns you need, and clicking **{{ ui-key.yacloud_org.common.apply }}**.
      
      {% endnote %}
      
      * ![traffic-light](../../_assets/console-icons/traffic-light.svg): Rule criticality level. This icon indicates how security-critical the rule is:
      
          * ![cspm-rule-notice-icon](../../_assets/security-deck/cspm-rule-notice-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_info_biSRh }}
          * ![cspm-low-severity-icon](../../_assets/security-deck/cspm-low-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_low_tqf9A }}
          * ![cspm-moderate-severity-icon](../../_assets/security-deck/cspm-moderate-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_medium_8LZ4w }}
          * ![cspm-high-severity-icon](../../_assets/security-deck/cspm-high-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_high_cahHH }}
      * **{{ ui-key.yacloud_org.security.controls.rule-result.controlRule_kr2Bv }}**: Rule name and brief summary.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.standards_iv6a5 }}**: Icon(s) for the [security standards](../../security-deck/concepts/workspace.md#standards) that are using this rule. If the icon is colored, it means the rule is checked for the corresponding standard. If the icon is gray, it means it is not.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.verificationMethod_dS9B2 }}**: How the infrastructure controlled in the workspace is checked for compliance with this rule:      
          * `automatic`
          * `manual`
      * **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.resources_field_id }}**: Rule ID in {{ yandex-cloud }}.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.violations_q7AcU }}**: Number of rule violations detected.

  1. To view detailed information about a specific rule, click the table row with its name. The detailed info window that opens includes the following tabs:

      {% list tabs %}

      - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}

        In addition to the data shown in the general rule info table, the **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}** tab contains:
        * Date and time of the most recent security check.
        * Details on the monitored features, their configurations, or actions performed with them.

      - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}

        The **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}** tab lists security violations detected during checks. Detected violations will not appear in this list if they satisfy the [exception](../concepts/cspm.md#exceptions) criteria specified for the rule.

      - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}

        The **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}** tab provides guides and solutions to help you perform the actions required by the rule.

      {% endlist %}

{% endlist %}

### Viewing the list of exceptions from the rules {#view-exceptions-list}

To view the list of exceptions from the {{ k8s }} security control rules applicable to the [workspace](../concepts/workspace.md):

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, click **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) and select the [workspace](../concepts/workspace.md) for which you want to view the info on control rule exceptions. Use search, if required.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab.

      The list of exceptions for the {{ k8s }} rules is provided under **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.exceptions_header_qJD5D }}** and contains the following fields:
      * **Exception**: Reason for exception.
      * **Status**: Active or inactive.
      * **Rules**: List of rules for which compliance check has been excluded.
      * **Author**: User who created the exception.
      * **Date of creation**: Date and time the exception was created.

{% endlist %}

### Creating an exception {#create-exception}

To create a new exception for the {{ k8s }} control rules:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, click **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) and select the [workspace](../concepts/workspace.md) in which you want to create an exception from the control rules. Use search, if required.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab.
  1. In the top-right corner, click **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) and select `{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.exceptions_header_vqsTb }}`. In the window that opens:
      1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.scopeOfControl_aRkwB }}**, specify the resources you want to exclude when checking the {{ k8s }} control rules:

          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.allResources_2ax5E }}`: To exclude all resources controlled in the [workspace](../concepts/workspace.md).
          * `Selected resources`: To exclude only some resources. To select resources excluded from the check:

              * Click ![circle-plus](../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.selectResources_bD5MC }}**.
              * In the window that opens, select the resources to exclude from the rule and click **{{ ui-key.yacloud.common.apply }}**.
      1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}**, select the {{ k8s }} control rules the selected resources should not be checked against:

          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}`: To exclude the selected resources from the check for compliance with all the {{ k8s }} control rules.
          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}`: To exclude the selected resources from the check for compliance with a given set of rules. To select rules for which compliance check will be disabled based on the exception you are creating:

              * Click ![circle-plus](../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.action_select-rules }}**.
              * In the window that opens, select the rules you want to exclude from compliance check. If required, use the filter or search at the top of the window.
              * Click **Save selection**.
      1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}**, give in any format the reason why you are creating an exception.
      1. Select ![image](../../_assets/console-icons/toggle-on.svg) **Activate exception**.
      1. Click **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}**.

{% endlist %}

The new exception will now be displayed under **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.exceptions_header_vqsTb }}** on the **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab of the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page.

### Deleting an exception {#delete-exception}

To delete an exception for the {{ k8s}} control rules:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, click **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) and select the [workspace](../concepts/workspace.md) in which you want to delete an exception from the control rules. Use search, if required.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab.
  1. Under **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.header_caption_cspm_9dTJt }}**, in the row with the exception you want to delete, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

This will remove the exception from the [workspace](../concepts/workspace.md) and cancel the restrictions it imposed on rule checks.

### See also {#see-also}

* [{#T}](../concepts/kspm.md)
* [{#T}](../security/kspm-roles.md)
* [{#T}](./workspaces/create.md)
* [{#T}](./cspm/view-rules.md)
* [{#T}](./cspm/manage-exceptions.md)