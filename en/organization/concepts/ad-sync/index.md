---
title: Syncing users and groups with {{ microsoft-idp.ad-short }}
description: The {{ ad-sync-agent }} enables you to configure {{ org-full-name }} user and group synchronization with {{ microsoft-idp.ad-full }}.
---

# Syncing users and groups with {{ microsoft-idp.ad-full }}


If your company uses [{{ microsoft-idp.ad-full }}](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview) for user management and you want your users to be able to access {{ yandex-cloud }}, you do not need to create {{ yandex-cloud }} accounts for them manually. Instead, you can [sync](../../operations/sync-ad.md) the users and groups created in your {{ microsoft-idp.ad-short }} directory with {{ org-full-name }}.

{% include [ad-sync-userpoolonly-notice](../../../_includes/organization/ad-sync-userpoolonly-notice.md) %}

User and group synchronization is performed by the {{ ad-sync-agent }}, which can be run on any [Linux](https://en.wikipedia.org/wiki/Linux) or [Windows](https://en.wikipedia.org/wiki/Microsoft_Windows) server.

How synchronization works:

{% include [sync-agent](../../../_mermaid/other/identity-hub/sync-agent.md) %}

On the server the synchronization agent is [running](../../operations/sync-ad.md) on, the following network ports must be open for incoming and outgoing traffic:

* To access the {{ yandex-cloud }} API:

    * `443 (TCP)`: For [HTTPS](https://en.wikipedia.org/wiki/HTTPS).

* To access the {{ microsoft-idp.ad-short }} domain controller:

    {% include [ad-sync-ports](../../../_includes/organization/ad-sync-ports.md) %}

## Synchronization objects {#sync-objects}

The {{ ad-sync-agent }} syncs the following objects with the {{ microsoft-idp.ad-short }} directory:

* **Users**.
* **User attributes**.

    User attribute mapping table:

    Attribute name </br>in [agent configuration](./sync-agent.md#agent-config) | Attribute name in {{ microsoft-idp.ad-short }} </br>(default) | Attribute name </br>in {{ org-full-name }}
    --- | --- | ---
    `FullName` | `displayName` | `full_name`
    `GivenName` | `givenName` | `given_name`
    `FamilyName` | `sn` | `family_name`
    `Email` | `mail` | `email`
    `PhoneNumber` | `telephoneNumber` | `phone_number`
    `Username` | `userPrincipalName` | `username`
    `EmployeeId` | `employeeID` | `employee_id`
    `Department` | `department` | `department`
    `JobTitle` | `title` | `job_title`
    `CompanyName` | `company` | `company_name`
    N/A | `ObjectGUID` | `external_id`

    In the `user_attribute_mapping` [agent configuration](./sync-agent.md#agent-config) setting, you can map user attribute names different from the {{ microsoft-idp.ad-short }} default ones or disable synchronization of individual attributes.
* **User groups**.
* **User group attributes**.

    User group attribute mapping table:

    Attribute name </br>in [agent configuration](./sync-agent.md#agent-config) | Attribute name in {{ microsoft-idp.ad-short }} </br>(default) | Attribute name </br>in {{ org-full-name }}
    --- | --- | ---
    `Name` | `name` | `name`
    `Description` | `description` | `description`
    N/A | `ObjectGUID` | `external_id`

    In the `group_attribute_mapping` [agent configuration](./sync-agent.md#agent-config) setting, you can map user group attribute names different from the {{ microsoft-idp.ad-short }} default ones or disable synchronization of individual attributes.
* **User memberships in groups**.
* **[User password hashes](https://en.wikipedia.org/wiki/Hash_function)**.

    {{ microsoft-idp.ad-short }} stores user passwords as hashes, not plain text. {{ yandex-cloud }} collects the user password hash from the {{ microsoft-idp.ad-short }} directory and generates its own one based on it using the modern hack-proof [Argon2](https://en.wikipedia.org/wiki/Argon2) algorithm.

    {% note alert %}

    {{ yandex-cloud }} does not store user passwords as plain text in its databases.

    {% endnote %}

### Password writeback in {{ microsoft-idp.ad-short }} {#password-writeback}

{% include [pw-writeback-preview-notice](../../../_includes/organization/pw-writeback-preview-notice.md) %}

The sync agent can perform user _password writeback_ in {{ microsoft-idp.ad-short }}. Password writeback ensures that a user's password gets updated in {{ microsoft-idp.ad-short }} once edited in {{ org-full-name }} in the following cases:

* User who is configured to sync with {{ microsoft-idp.ad-short }} [edited their password](../../../organization/operations/manage-account.md#edit-password) in {{ org-full-name }}.
* Organization administrator [reset the password](../../../organization/operations/user-pools/reset-user-password.md#reset) for a user configured to sync with {{ microsoft-idp.ad-short }}.
* User who is configured to sync with {{ microsoft-idp.ad-short }} set a new password in {{ org-full-name }} after that user's password was reset by an administrator.

Password writeback proceeds in the following order:

1. A user or administrator initiate a change in the user's password in {{ org-full-name }}.
1. The sync agent attempts to update this user's password in {{ microsoft-idp.ad-short }}.

    An attempt to change the password in {{ microsoft-idp.ad-short }} may fail if the new password does not meet the requirements set in {{ microsoft-idp.ad-short }} security policies.
1. If the attempt to change the password in {{ microsoft-idp.ad-short }} is successful, the user's password changes accordingly in {{ org-full-name }}.
1. If the attempt to change the password in {{ microsoft-idp.ad-short }} fails, the user's password in {{ org-full-name }} also remains unchanged.

For password writeback to work, the {{ microsoft-idp.ad-short }} account on whose behalf the agent performs synchronization must also have the `Change Password`, `Reset Password`, and `Write pwdLastSet` permissions. Grant these permissions for the entire domain or for those organization units (OUs) that match the `sync_settings.filter` filters selected in the agent configuration.

## Setting up synchronization {#sync-setup}

To implement {{ org-full-name }} user and group synchronization with {{ microsoft-idp.ad-short }}, you need to do the presetting both on the [domain controller](https://en.wikipedia.org/wiki/Domain_controller_(Windows)) side with {{ microsoft-idp.ad-short }} services deployed and on the {{ yandex-cloud }} side.

{% include [ad-sync-kerberos-components-installation-info](../../../_includes/organization/ad-sync-kerberos-components-installation-info.md) %}

### {{ microsoft-idp.ad-short }} domain controller side setup {#dc-setup}

For the synchronization [agent](./sync-agent.md) to work correctly on the {{ microsoft-idp.ad-short }} side, do the following:

{% include [ad-sync-presetup-ad](../../../_includes/organization/ad-sync-presetup-ad.md) %}

### {{ yandex-cloud }} side setup {#yc-setup}

For the synchronization [agent](./sync-agent.md) to work correctly on the {{ yandex-cloud }} side, do the following:

* [Create](../../../iam/operations/sa/create.md) a service account for synchronization on the {{ org-full-name }} side.
* [Assign](../../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) the following [roles](../../../iam/concepts/access-control/roles.md) to the service account for the [organization](../organization.md) the user pool is in:

    {% include [ad-sync-sa-roles](../../../_includes/organization/ad-sync-sa-roles.md) %}

* Optionally, [create](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) and save an [authorized key](../../../iam/concepts/authorization/key.md) for the service account.

    {% include [ad-sync-iam-via-metadata-warning](../../../_includes/organization/ad-sync-iam-via-metadata-warning.md) %}

#### Useful links {#see-also}

* [{#T}](./sync-agent.md)
* [{#T}](../../operations/sync-ad.md)

[*gmsa_account]: {% include notitle [get-folder-id](../../../_popups/identity-hub/gmsa.md) %}