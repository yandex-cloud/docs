---
title: Working with recommendations in {{ sd-full-name }} {{ access-analyzer-name }}
description: In this section, you will learn how to get and apply recommendations in {{ sd-full-name }} {{ access-analyzer-name }} regarding unused and excessive access permissions to organizational resources.
---

# Working with recommendations in the {{ access-analyzer-name }} module

{% include [access-analyzer-recommendations-preview-notice](../../../_includes/security-deck/access-analyzer-recommendations-preview-notice.md) %}

The [{{ access-analyzer-name }} module]({{ link-sd-main }}access-analyzer/) identifies unused and excessively granted privileges and provides [recommendations](../../concepts/access-analyzer.md#recommendations) for replacing or revoking excessive roles. If any recommendations do not suit you, you can hide them.

Recommendations can be accepted by users holding one of the following roles: `admin`, `resource-manager.admin`, `organization-manager.admin`, `resource-manager.clouds.owner`, `organization-manager.organizations.owner`.

To use the recommendation functionality, [enable](../workspaces/update.md) the {{ access-analyzer-name }} module in the [workspace](../../concepts/workspace.md) settings.

{% include [access-analyzer-recommendations-responsibility-alert](../../../_includes/security-deck/access-analyzer-recommendations-responsibility-alert.md) %}

## View recommendations {#view}

{% include [access-analyzer-recommendations-view-role-notice](../../../_includes/security-deck/access-analyzer-recommendations-view-role-notice.md) %}

To view {{ access-analyzer-name }} recommendations:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Log in to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. Ensure that the {{ access-analyzer-name }} module is enabled in your [workspace](../../concepts/workspace.md).
  1. On the left panel, select ![person-gear](../../../_assets/console-icons/person-gear.svg) **{{ ui-key.yacloud_org.ui.label_access-analyzer_4bfVo }}**, and at the top of the screen, select the workspace.
  1. Navigate to the **{{ ui-key.yacloud_org.security.access-analyzer.AccessAnalyzerPageLayout.recommendations_24yZa }}** tab.

{% endlist %}

This will open a page with a list of {{ access-analyzer-name }} recommendations. At the top of the screen, there is a filter bar that allows you to select recommendations based on [type](../../concepts/access-analyzer.md#recommendation-types), [subjects](../../../iam/concepts/access-control/index.md#subject) being checked, monitored resources and roles, as well as the specified [visibility](#manage-visibility).

The date and time of the last analysis are displayed below the filter bar.

The list of recommendations contains the following fields:

* **{{ ui-key.yacloud_org.security.access-analyzer.recommendations.subject }}**: Name and type of the subject to which the recommendation was issued.

    A subject can be a user, [service account](../../../iam/concepts/users/service-accounts.md), [user group](../../../organization/concepts/groups.md), as well as [system](../../../iam/concepts/access-control/system-group.md) or [public](../../../iam/concepts/access-control/public-group.md) group.
* **{{ ui-key.yacloud_org.security.access-analyzer.recommendations.resource }}**: Name and type of the resource for which the access recommendation has been issued.

    A resource can be a [folder](*folder_definition), [cloud](*cloud_definition), or [organization](*organization_definition). {{ access-analyzer-name }} does not provide recommendations regarding roles assigned to subjects for specific {{ yandex-cloud }} service resources, such as virtual machines, service accounts, managed database clusters, etc.
* **{{ ui-key.yacloud_org.security.access-analyzer.recommendations.role }}**: Role assigned to a subject for a resource, and regarding which {{ access-analyzer-name }} has issued a recommendation.
* **{{ ui-key.yacloud_org.security.access-analyzer.recommendations.recommendation }}**: Recommended action: [replace](#replace) or [revoke](#revoke) the current role.

    If it is recommended to replace the role, this field also displays a list (of up to five) of new roles that will be assigned to the subject as a result of the replacement.

### Managing recommendation visibility {#manage-visibility}

You can manage the visibility of recommendations to hide those that do not suit you from the list.

#### Hiding a recommendation {#hide}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. [Open](#view) the list of {{ access-analyzer-name }} recommendations.
  1. Make sure **{{ ui-key.yacloud_org.form.oslogin-settings.title_ssh-certificate-settings }}** is selected in the filter bar.
  1. In the row containing the recommendation you want to hide, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![eye-slash](../../../_assets/console-icons/eye-slash.svg) **{{ ui-key.yacloud_org.security.access-analyzer.recommendations.hide }}**.

      As a result, the recommendation will be hidden from the list of active recommendations and will appear in the list of hidden recommendations.

{% endlist %}

#### Restoring a recommendation {#restore}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. [Open](#view) the list of {{ access-analyzer-name }} recommendations.
  1. In the filter bar at the top of the screen, select `{{ ui-key.yacloud_org.security.access-analyzer.recommendations.hidden }}`.
  1. In the row containing the recommendation you want to return to the active list, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![arrow-uturn-cw-right](../../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud_org.security.access-analyzer.recommendations.restore }}**.

      As a result, the recommendation will be removed from the list of hidden recommendations and will reappear in the list of active recommendations.

{% endlist %}

## Replacing a role {#replace}

To accept the recommendation to replace a role:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. [Open](#view) the list of {{ access-analyzer-name }} recommendations.
  1. In the row containing the recommendation to replace the role you want to accept, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![arrows-rotate-right](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud_org.security.access-analyzer.recommendations.replace-role }}**.

      In the window that opens, review the details of the proposed replacement and, if you agree, click **{{ ui-key.yacloud_org.security.access-analyzer.ApplyRecommendationDialog.replace_tQxKb }}**.

{% endlist %}

As a result, the initial role assigned to the subject for the resource will be replaced by a new role or set of roles for that same resource.

## Revoking a role {#revoke}

To accept the recommendation to revoke a role:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. [Open](#view) the list of {{ access-analyzer-name }} recommendations.
  1. In the row containing the recommendation to revoke the role you want to accept, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![circle-xmark](../../../_assets/console-icons/circle-xmark.svg) **{{ ui-key.yacloud_org.security.access-analyzer.recommendations.revoke }}**.

      In the window that opens, review the details of the proposed action and, if you agree, click **{{ ui-key.yacloud_org.security.access-analyzer.ApplyRecommendationDialog.revoke_dTPYb }}**.

{% endlist %}

As a result, the role assigned to the subject for the resource will be revoked.

#### Useful links {#see-also}

* [{#T}](../../concepts/access-analyzer.md)
* [{#T}](./analyze-permissions.md)

[*folder_definition]: {% include [folder-definition](../../../_popups/resource-manager/folder-definition.md) %}

[*cloud_definition]: {% include [cloud-definition](../../../_popups/resource-manager/cloud-definition.md) %}

[*organization_definition]: {% include [organization-definition](../../../_popups/identity-hub/organization-definition.md) %}
