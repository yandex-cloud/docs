---
title: Deleting an MFA policy in {{ org-full-name }}
description: Follow this guide to delete an MFA policy in {{ org-full-name }}.
---

# Deleting an MFA policy

To delete [an MFA policy](../../concepts/mfa.md#mfa-policies):

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}** tab.
  1. In the MFA policy list, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) in the policy row and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the operation.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the MFA policy list using this command:

     ```bash
     yc organization-manager mfa-enforcement list \
       --organization-id <organization_ID>
     ```

     Where `organization_id` is the organization ID.

  1. See the description of the CLI command for deleting an MFA policy:

     ```bash
     yc organization-manager mfa-enforcement delete --help
     ```

  1. To delete an MFA policy, run this command:

     ```bash
     yc organization-manager mfa-enforcement delete \
       --id <policy_ID>
     ```

     Where `--id` is the ID of the MFA policy you need to delete.

{% endlist %}

#### See also {#see-also}

* [{#T}](./create-policy.md)
* [{#T}](./update-policy.md)
* [{#T}](./add-users.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)