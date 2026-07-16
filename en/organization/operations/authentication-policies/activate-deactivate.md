---
title: How to activate/deactivate an authentication policy in {{ org-full-name }}
description: Follow this guide to activate or deactivate an authentication policy in {{ org-full-name }}.
---

# Activating/deactivating an authentication policy

{% include [note-preview](../../../_includes/note-preview.md) %}

{% include [auth-policy-intro](../../../_includes/organization/auth-policy-intro.md) %}

{% include [auth-policy-role](../../../_includes/organization/auth-policy-role.md) %}

## Activate an authentication policy {#activate}

To activate an authentication policy, follow these steps:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}** and go to the **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_auth_policies }}** tab.
  1. In the row with an inactive authentication policy, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![arrows-rotate-right](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud_org.organization.security-settings.auth-policies-table.action-activate }}**.
  1. In the window that opens, confirm the policy activation.

{% endlist %}

## Deactivate an authentication policy {#deactivate}

To deactivate an authentication policy, follow these steps:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}** and go to the **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_auth_policies }}** tab.
  1. In the row with an active authentication policy, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![pause](../../../_assets/console-icons/pause.svg) **{{ ui-key.yacloud_org.organization.security-settings.auth-policies-table.action-deactivate }}**.
  1. In the window that opens, confirm the policy deactivation.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../../concepts/applications/index.md)
* [{#T}](../../concepts/authentication-policy.md)
* [{#T}](./create.md)
* [{#T}](./update.md)
