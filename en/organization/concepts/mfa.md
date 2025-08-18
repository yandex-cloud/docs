---
title: Multi-factor authentication (MFA) in {{ org-name }}
description: In {{ org-full-name }}, you can configure MFA for federated and local users to enhance the protection level of their accounts.
---

# Multi-factor authentication in {{ org-name }}

{% include [note-preview](../../_includes/note-preview.md) %}

In {{ org-full-name }}, you can configure [multi-factor authentication](https://en.wikipedia.org/wiki/Multi-factor_authentication) (MFA) for [federated](../../iam/concepts/users/accounts.md#saml-federation) and [local](../../iam/concepts/users/accounts.md#local) user accounts.

MFA enhances protection of user accounts by requiring an additional authentication factor aside from the password. This may be either a one-time code ([TOTP](https://en.wikipedia.org/wiki/Time-based_one-time_password) standard) or authentication via [WebAuthn](https://en.wikipedia.org/wiki/WebAuthn) ([FIDO2](https://en.wikipedia.org/wiki/FIDO_Alliance#FIDO2)).

## MFA policies {#mfa-policies}

_MFA policies_ specify the multi-factor authentication requirements enforced on users, which include:
* Requirements for the allowed [MFA factor](#mfa-factors) types.
* Requirements for the time period in which the user must add a second authentication factor after registration.

    {% include [mfa-create-policy-step5-ss1](../../_includes/organization/mfa-create-policy-step5-ss1.md) %}

* Requirements for the frequency of repeated verification of the additional authentication factor.

    {% include [mfa-create-policy-step6-ss1](../../_includes/organization/mfa-create-policy-step6-ss1.md) %}

You can [create](../operations/mfa/create-policy.md) an MFA policy in the [{{ org-name }}]({{ link-org-cloud-center }}) interface in {{ cloud-center }}.

For an MFA policy to apply to specific user accounts, you need to [explicitly add](../operations/mfa/add-users.md) those users or the [groups](./groups.md) to which they belong to the policy's target groups.

{% include [mfa-policy-applications-acc-type-notice](../../_includes/organization/mfa-policy-applications-acc-type-notice.md) %}

An MFA policy can be either `Active` or `Inactive`. 

You can temporarily [deactivate](../operations/mfa/deactivate-reactivate-policy.md#deactivate-policy) an active policy; as a result, its status will change to `Inactive`, and users whose accounts belong to the policy's target groups will no longer be required to use an additional authentication factor. You can [reactivate](../operations/mfa/deactivate-reactivate-policy.md#reactivate-policy) an inactive policy, and its requirements will again apply to the relevant user accounts.

If a user belongs to target groups of multiple MFA policies at once, their account will be subject to the most stringent policy requirements, both in terms of authentication factors and the period and frequency of additional factor verification.

MFA policies can be managed by users with the `organization-manager.editor` [role](../security/index.md#organization-manager-editor) or higher.

## MFA factors {#mfa-factors}

When getting authenticated in {{ yandex-cloud }} for the first time, federated and local users belonging to the MFA policy target groups must set up additional account protection by _verifying_ their identity with a second authentication method (factor). Authentication factors available to the user depend on their device capabilities and the factor strength settings dictated by the MFA policy:

{% include [mfa-create-policy-step4-ss1](../../_includes/organization/mfa-create-policy-step4-ss1.md) %}

Users must repeat the verification with the selected additional authentication factor as often as is [specified](../operations/mfa/create-policy.md) in the **{{ ui-key.yacloud_org.form.mfa-enforcement.caption.ttl }}** field of the MFA policy settings.

The organization administrator may [remove](../operations/mfa/manage-verification.md#remove-mfa-factor) an existing user authentication factor. For example, this may be necessary if the user is unable to access the authenticator app or lost their hardware key used for identity verification.

#### See also {#see-also}

* [{#T}](../operations/mfa/create-policy.md)
* [{#T}](../operations/mfa/update-policy.md)
* [{#T}](../operations/mfa/add-users.md)
* [{#T}](../operations/mfa/deactivate-reactivate-policy.md)
* [{#T}](../operations/mfa/delete-policy.md)
* [{#T}](../operations/mfa/manage-verification.md)