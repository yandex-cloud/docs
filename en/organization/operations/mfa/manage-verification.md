---
title: Removing MFA factors and resetting user verification dates in {{ org-full-name }}
description: Follow this guide to remove MFA factors as well as track and reset user MFA verification in {{ org-full-name }}.
---

# Removing an MFA factor and resetting the verification date

{% include [note-preview](../../../_includes/note-preview.md) %}

An organization administrator can view the last verification date of [federated](../../../iam/concepts/users/accounts.md#saml-federation) and [local](../../../iam/concepts/users/accounts.md#local) user accounts. In some cases, an administrator may also need to [reset](#reset-verification-date) the verification date of a user account or [remove](#remove-mfa-factor) its [authentication factor](../../concepts/mfa.md#mfa-factors).

{% include [mfa-check-last-verification-notice](../../../_includes/organization/mfa-check-last-verification-notice.md) %}

## Resetting the user account verification date {#reset-verification-date}

{% include [mfa-reset-last-verification-roles](../../../_includes/organization/mfa-reset-last-verification-roles.md) %}

To reset a user's verification date:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![icon-users](../../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** and select the federated or local user.
  1. In the top-right corner, click **{{ ui-key.yacloud_org.common.more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select ![arrow-rotate-left](../../../_assets/console-icons/arrow-rotate-left.svg) **{{ ui-key.yacloud_org.entity.user.action.reset-date }}**.
  1. In the window that opens, confirm the operation.

{% endlist %}

The user's verification date will be updated to the current date.

## Removing a user account authentication factor {#remove-mfa-factor}

You can remove an existing [authentication factor](../../concepts/mfa.md#mfa-factors)from a user account if you either have the `organization-manager.federations.userAdmin` [role](../../../organization/security/index.md) or higher (for federated accounts) or the `organization-manager.userpools.userAdmin` role or higher (for local accounts).

To remove an existing authentication factor from a user account:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![icon-users](../../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** and select the federated or local user.
  1. Go to the **{{ ui-key.yacloud_org.organization.users.components.title_mfa_5CFwd }}** tab.
  1. In the row with the user's authentication factor, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

{% endlist %}

The user's authentication factor will be deleted, and the user will need to complete the [verification](../../concepts/mfa.md#mfa-factors) again during the next authentication in {{ yandex-cloud }}.

#### See also {#see-also}

* [{#T}](./create-policy.md)
* [{#T}](./update-policy.md)
* [{#T}](./add-users.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./delete-policy.md)
* [{#T}](../../concepts/mfa.md)