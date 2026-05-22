---
title: Adding a response page template to a profile or rule
description: Follow this guide to add a response page template to a security or ARL profile, or to a rule in any of those profiles.
---

# Adding a response page template to a profile or rule

You can add a response page template to a security or ARL profile, or to individual rules in any of those profiles.

## Adding a template to a profile {#template-to-profile}

The profile template is displayed when this profile is blocked by any rule. If you select another template for a particular profile, the selected template will be used. If no template is selected for a profile or rule, the default template will be used.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the security or ARL profile.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select **{{ ui-key.yacloud.smart-web-security.title_profiles }}** or **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. In the row with the profile you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. From the **Response page template** list, select an existing template or [create a new one](template-create.md).
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Adding a template to a rule {#template-to-rule}

{% include [rules-for-template](../../_includes/smartwebsecurity/rules-for-template.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the security or ARL profile.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select **{{ ui-key.yacloud.smart-web-security.title_profiles }}** or **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Select the profile containing the rule of interest.
  1. Next to the rule, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. From the **Response page template** list, select an existing template or [create a new one](template-create.md).
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### See also {#see-also}

* [{#T}](rule-add.md)
* [{#T}](rule-update.md)
* [{#T}](host-connect.md)
* [{#T}](profile-delete.md)
