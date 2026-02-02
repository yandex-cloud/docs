---
title: Activating {{ k8s }}® Security Posture Management (KSPM) in {{ sd-full-name }}
description: How to activate and configure {{ k8s }}® Security Posture Management (KSPM) in {{ sd-name }}.
---

# Activating KSPM

{% include [note-preview](../../../_includes/note-preview.md) %}

The KSPM module allows you to flexibly select and customize security rules to meet your organization's specific requirements, as well as create rule exceptions.

To get started with KSPM:
1. [Create](../../../iam/operations/sa/create.md) a service account KSPM will use to view {{ managed-k8s-name }} [cluster](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) info, install the necessary components, and perform checks.
1. [Assign](../../../iam/operations/sa/assign-role-for-sa.md) to the service account the `security-deck.worker` [role](../../security/index.md#security-deck-worker) for the organization, cloud, or folder.

    {% note info %}

    KSPM will only have access to the {{ managed-k8s-name }} clusters residing in the corresponding organization, cloud, or folder.

    {% endnote %}

    If you have assigned the role for a particular folder, the service account will also need the `auditor` role for the cloud.

1. [Create](../workspaces/create.md) a {{ sd-name }} workspace configured as follows:

    * In the connector settings under **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.resourcesTitle_fE6qp }}**:
      * Select the service account you created earlier.
      * Specify the clouds and folders you want to control the security of {{ managed-k8s-name }} clusters in.

        {% note tip %}

        Later on you will be able to further narrow the scope of control in the KSPM settings.

        {% endnote %}

    * Under **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.standartsTitle_cxvJ8 }}**, select the industry standards and regulations the resources you chose at the previous step will be benchmarked against.
      
      {% include [kspm-sec-standard-list](../../../_includes/security-deck/kspm-sec-standard-list.md) %}

      You can select several standards at the same time. The **{{ ui-key.yacloud_org.security.workspaces.WorkspaceStandardsForm.modules_title_s8LDi }}** section will display the {{ sd-name }} modules, which will be activated in the new workspace to check your resources for compliance with the selected standards and regulations.
1. Complete the KSPM setup:
    1. Click ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspacePageLayout.edit_action }}** on the new workspace page.
    1. Navigate to the **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabKubernetes_rC2uU }}** tab.
    1. Under **{{ ui-key.yacloud_org.security.workspaces.WorkspaceKspmResourcesForm.section-title_iYCNY }}**, select the clouds, folders, or clusters within the workspace resources where compliance with the {{ k8s }} security rules will be enforced.

        {% note warning %}

        A cluster can only belong to one {{ sd-name }} workspace. Otherwise, there will be conflicts.

        {% endnote %}

    1. Click **{{ ui-key.yacloud.common.save }}** and confirm the action.

        Once you do that, the necessary components will be automatically installed in the `yc-security` namespace in the {{ managed-k8s-name }} clusters that are within the scope of control.

        Depending on cluster size, component installation may take from 1 to 10 minutes.

{% note tip %}

To remove clusters from the control scope and to stop monitoring them for security, [delete](../workspaces/delete.md) the {{ sd-name }} workspace or disable the {{ k8s }} security standards.

{% endnote %}