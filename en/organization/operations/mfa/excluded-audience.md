---
title: Managing exceptions to MFA policies in {{ org-full-name }}
description: Follow this guide to manage exceptions to MFA policies in {{ org-full-name }}.
---

# Managing exceptions to MFA policies

Exceptions prevent an [MFA policy](../../concepts/mfa.md#mfa-policies) from applying to individual users or [user groups](../../concepts/groups.md) added to the policy's target group. If you later remove these users or groups from the exceptions list, they will not need to reconfigure authentication.

## Updating a list of exceptions {#update}

{% list tabs group=instructions %}

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

{% endlist %}

## Viewing a list of exceptions {#list}

{% list tabs group=instructions %}

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

{% endlist %}

#### See also {#see-also}

* [{#T}](./add-users.md)
* [{#T}](./create-policy.md)
* [{#T}](./update-policy.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./delete-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)