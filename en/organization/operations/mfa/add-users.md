---
title: Applying an MFA policy to users in {{ org-full-name }}
description: Follow this guide to add and delete users and groups to and from an MFA policy in {{ org-full-name }}.
---

# Applying an MFA policy to users

For an [MFA policy](../../concepts/mfa.md#mfa-policies) to apply to user accounts, you need to explicitly add the relevant users or the [groups](../../concepts/groups.md) they are members of to the policy's target groups.

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}** tab and select the policy you need from the list. In the window that opens, do the following:

      1. Navigate to the **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyPageLayout.tab_groups }}** tab.
      1. To add a new user or group to the policy's target groups:

          1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.mfa-policy-audiences.action_add-users }}**.
          1. In the window that opens, select the required user or user group.
          1. Click **{{ ui-key.yacloud.common.add }}**.
      1. To delete a user or group from the policy:
          1. In the list of users and groups, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}** next to the user or user group.
          1. Confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a list of users or groups subject to the MFA policy:

     ```bash
     yc organization-manager mfa-enforcement list-audience \
       --id <policy_ID>
     ```

  1. See the description of the CLI command for changing the list of users or groups subject to the MFA policy:

     ```bash
     yc organization-manager mfa-enforcement update-audience --help
     ```

  1. To add users or groups to the MFA policy, or to remove them from it, run this command:

     ```bash
     yc organization-manager mfa-enforcement update-audience \
       --id <policy_ID> \
       --audience-delta subject-id=<subject_ID>,action=<action>
     ```

     Where:

     * `--audience-delta`: Parameter to edit the list of users/groups in the policy:
       * `subject-id`: User or group ID.
       * `action`: Action, `action-add` to add, `action-remove` to delete.

     You can specify multiple `--audience-delta` parameters to edit more than one object at the same time.

{% endlist %}

{% include [mfa-policy-applications-acc-type-notice](../../../_includes/organization/mfa-policy-applications-acc-type-notice.md) %}

#### See also {#see-also}

* [{#T}](./create-policy.md)
* [{#T}](./update-policy.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./delete-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)