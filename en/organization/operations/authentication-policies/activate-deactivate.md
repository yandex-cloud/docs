---
title: How to activate/deactivate an authentication policy in {{ org-full-name }}
description: Follow this guide to activate or deactivate an authentication policy in {{ org-full-name }}.
---

# Activating/deactivating an authentication policy

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

- API {#api}

    Use the [activate](../../policy/api-ref/AuthenticationPolicyRule/activate.md) REST API method for the [AuthenticationPolicyRule](../../policy/api-ref/AuthenticationPolicyRule/index.md) resource or the [AuthenticationPolicyRuleService/Activate](../../policy/api-ref/grpc/AuthenticationPolicyRule/activate.md) gRPC API call.

{% endlist %}

## Deactivate an authentication policy {#deactivate}

To deactivate an authentication policy, follow these steps:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}** and go to the **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_auth_policies }}** tab.
  1. In the row with an active authentication policy, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![pause](../../../_assets/console-icons/pause.svg) **{{ ui-key.yacloud_org.organization.security-settings.auth-policies-table.action-deactivate }}**.
  1. In the window that opens, confirm the policy deactivation.

- API {#api}

    Use the [deactivate](../../policy/api-ref/AuthenticationPolicyRule/deactivate.md) REST API method for the [AuthenticationPolicyRule](../../policy/api-ref/AuthenticationPolicyRule/index.md) resource or the [AuthenticationPolicyRuleService/Deactivate](../../policy/api-ref/grpc/AuthenticationPolicyRule/deactivate.md) gRPC API call.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../../concepts/applications/index.md)
* [{#T}](../../concepts/authentication-policy.md)
* [{#T}](./create.md)
* [{#T}](./update.md)
