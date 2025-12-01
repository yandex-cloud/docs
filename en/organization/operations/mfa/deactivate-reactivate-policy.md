---
title: Activating and deactivating an MFA policy in {{ org-full-name }}
description: Follow this guide to activate or deactivate an MFA policy in {{ org-full-name }}.
---

# Activating or deactivating an MFA policy

{% include [note-preview](../../../_includes/note-preview.md) %}

## Activating an MFA policy {#reactivate-policy}

To activate an inactive [MFA policy](../../concepts/mfa.md#mfa-policies):

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}** tab.
  1. In the MFA policy list, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) in the policy row and select ![arrows-rotate-right](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud_org.organization.security-settings.mfa-overview-action-activate }}**.
  1. In the window that opens, confirm the operation.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for activating an MFA policy:

     ```bash
     yc organization-manager mfa-enforcement activate --help
     ```

  1. To activate an MFA policy, run this command:

     ```bash
     yc organization-manager mfa-enforcement activate \
       --id <policy_ID>
     ```

     Where `--id` is the ID of the MFA policy you need to activate.

{% endlist %}

As a result, the MFA policy will be activated and switch to the `Active` status, and users with accounts added to the policy's target groups will be required to use an additional authentication factor.

## Deactivating an MFA policy {#deactivate-policy}

To temporarily deactivate an [MFA policy](../../concepts/mfa.md#mfa-policies):

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}** tab.
  1. In the MFA policy list, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) in the policy row and select ![pause](../../../_assets/console-icons/pause.svg) **{{ ui-key.yacloud_org.organization.security-settings.mfa-overview-action-suspend }}**.
  1. In the window that opens, confirm the operation.

- CLI {#cli}

  1. See the description of the CLI command for deactivating an MFA policy:

     ```bash
     yc organization-manager mfa-enforcement deactivate --help
     ```

  1. To deactivate an MFA policy, run this command:

     ```bash
     yc organization-manager mfa-enforcement deactivate \
       --id <policy_ID>
     ```

     Where `--id` is the ID of the MFA policy you need to deactivate.

{% endlist %}

As a result, the MFA policy will be deactivated and switch to the `Inactive` status, while users whose accounts belong to the policy's target groups will no longer be required to use an additional authentication factor.

#### See also {#see-also}

* [{#T}](./create-policy.md)
* [{#T}](./update-policy.md)
* [{#T}](./add-users.md)
* [{#T}](./delete-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)