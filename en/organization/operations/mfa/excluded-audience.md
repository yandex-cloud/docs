---
title: Managing exceptions to MFA policies in {{ org-full-name }}
description: Follow this guide to manage exceptions to MFA policies in {{ org-full-name }}.
---

# Managing exceptions to MFA policies

Exceptions prevent an [MFA policy](../../concepts/mfa.md#mfa-policies) from applying to individual users or [user groups](../../concepts/groups.md) added to the policy's target group. For example, you can exclude robots or an admin group if the policy is assigned to the entire organization. If you later remove these users or groups from the list of exceptions, they will not need to reconfigure authentication.

## Updating a list of exceptions {#update}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyPageLayout.policies_title }}** tab and select the policy you need from the list. In the window that opens:

      1. Navigate to the **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyPageLayout.tab_exclusions }}** tab.
      1. To add a user or user group to the list of exceptions:

          1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.mfa-policy-exclusions.action_add-exclusion }}**.
          1. In the window that opens, select the required user or user group.
          1. Click **{{ ui-key.yacloud.common.add }}**.
      1. To delete a user or group from the list of exceptions:
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

  1. View the description of the CLI command for updating a list of exceptions to an MFA policy:

     ```bash
     yc organization-manager mfa-enforcement update-excluded-audience --help
     ```

  1. To add a user or user group to a list of MFA policy exceptions, run this command:

     ```bash
     yc organization-manager mfa-enforcement update-excluded-audience \
       --id <policy_ID> \
       --audience-delta subject-id=<subject_ID>,action=<action>
     ```

     Where:

     * `--audience-delta`: Parameter to edit the list of users/groups in the policy:
       * `subject-id`: User or group ID.
       * `action`: Action, `action-add` to add, `action-remove` to delete.

     You can specify multiple `--audience-delta` parameters to add or remove more than one object at a time.

     Result:

      ```text
      mfa_enforcement_id: bpfjv8qeq4ii********
      effective_deltas:
        - action: ACTION_ADD
          subject_id: aje0j5mts02t********
      ```

- API {#api}

  Use the [UpdateExcludedAudience](../../../organization/api-ref/MfaEnforcement/updateExcludedAudience.md) REST API method for the [MfaEnforcement](../../../organization/api-ref/MfaEnforcement/index.md) resource or the [MfaEnforcementService/UpdateExcludedAudience](../../../organization/api-ref/grpc/MfaEnforcement/updateExcludedAudience.md) gRPC API call.

{% endlist %}

## Viewing a list of exceptions {#list}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyPageLayout.policies_title }}** tab and select the policy you need from the list.
  1. In the window that opens, navigate to the **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyPageLayout.tab_exclusions }}** tab and view the list of users and groups excluded from the policy.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a list of users or groups subject to the MFA policy:

     ```bash
     yc organization-manager mfa-enforcement list-excluded-audience \
       --id <policy_ID>
     ```

     Result:

      ```text
      +----------------------+---------------+
      |          ID          |     TYPE      |
      +----------------------+---------------+
      | aje0j5mts02t******** | federatedUser |
      +----------------------+---------------+
      ```

- API {#api}

  Use the [ListExcludedAudience](../../../organization/api-ref/MfaEnforcement/listExcludedAudience.md) REST API method for the [MfaEnforcement](../../../organization/api-ref/MfaEnforcement/index.md) resource or the [MfaEnforcementService/ListExcludedAudience](../../../organization/api-ref/grpc/MfaEnforcement/listExcludedAudience.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](./add-users.md)
* [{#T}](./create-policy.md)
* [{#T}](./update-policy.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./delete-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)
