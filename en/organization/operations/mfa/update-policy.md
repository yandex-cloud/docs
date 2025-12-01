---
title: Updating an MFA policy in {{ org-full-name }}
description: Follow this guide to update an MFA policy in {{ org-full-name }}.
---

# Updating an MFA policy

{% include [note-preview](../../../_includes/note-preview.md) %}

To update an [MFA policy](../../concepts/mfa.md#mfa-policies):

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}** tab.
  1. In the MFA policy list, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) in the policy row and select ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. In the window that opens, do the following:

      1. In the **{{ ui-key.yacloud_org.forms.field.display-name }}** field, enter a new name for the policy. Follow these naming requirements:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}
      1. {% include [mfa-create-policy-step2](../../../_includes/organization/mfa-create-policy-step2.md) %}
      1. If required, use **{{ ui-key.yacloud_org.form.mfa-enforcement.caption.active }}** to activate or deactivate the policy.
      1. {% include [mfa-create-policy-step4](../../../_includes/organization/mfa-create-policy-step4.md) %}
      1. {% include [mfa-create-policy-step5](../../../_includes/organization/mfa-create-policy-step5.md) %}
      1. {% include [mfa-create-policy-step6](../../../_includes/organization/mfa-create-policy-step6.md) %}
      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the MFA policy list using this command:

     ```bash
     yc organization-manager mfa-enforcement list \
       --organization-id <organization_ID>
     ```

     Where `organization_id` is the organization ID.

  1. View the description of an MFA policy:

     ```bash
     yc organization-manager mfa-enforcement get \
       --id <policy_ID>
     ```

  1. View the description of the update MFA policy CLI command:

     ```bash
     yc organization-manager mfa-enforcement update --help
     ```

  1. To update an MFA policy, run this command:

     ```bash
     yc organization-manager mfa-enforcement update \
       --id <policy_ID> \
       --acr-id <authentication_factor_type> \
       --ttl <lifetime> \
       --status <policy_status> \
       --apply-at <time_of_applying_changes> \
       --enroll-window <registration_period> \
       --new-name <new_name> \
       --description <new_description> \
       --organization-id <organization_ID>
     ```

     Where:

     * `--id`: MFA policy ID.
     * `--acr-id`: Authentication [factor](../../concepts/mfa.md#mfa-factors) type.
     * `--ttl`: Credential validity period in days.
     * `--status`: Policy status, active (`status-active`) or inactive (`status-inactive`).
     * `--apply-at`: Time after which the policy will become active.
     * `--enroll-window`: Period in days after registration during which the user must add a second authentication factor.
     * `--new-name`: New policy name.
     * `--description`: New description.
     * `--organization-id`: Organization ID.

{% endlist %}

{% include [mfa-policy-add-users-notice](../../../_includes/organization/mfa-policy-add-users-notice.md) %}

#### See also {#see-also}

* [{#T}](./create-policy.md)
* [{#T}](./add-users.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./delete-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)