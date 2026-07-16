---
title: Authentication policies in {{ org-full-name }}
description: With authentication policies, you can flexibly configure access to applications for {{ org-full-name }} users.
---

# Authentication policies in {{ org-full-name }}

{% include [note-preview](../../_includes/note-preview.md) %}

In {{ org-full-name }}, _authentication policies_ are used for granular management of [user](*user_accounts) and [user group](*user_groups) access to {{ org-full-name }} [applications](*applications) by [denying or allowing](#action) authentication based on the [policy criteria](#conditions).

Currently, authentication policies can only be managed in the [{{ cloud-center }} UI]({{ link-org-cloud-center }}). To [create](../operations/authentication-policies/create.md), [update](../operations/authentication-policies/update.md), [activate](../operations/authentication-policies/activate-deactivate.md#activate), [deactivate](../operations/authentication-policies/activate-deactivate.md#deactivate), or [delete](../operations/authentication-policies/delete.md) authentication policies, a user must have the `organization-manager.admin` [role](*org_manager_admin) or higher.

## Policy scope {#conditions}

An authentication policy can apply to user authentication events based on the following condition types:

* [Users and user groups](#users-and-groups).
* [Applications](#applications).
* [Networks and IP addresses](#ip-addresses).

{% include [auth-policy-and-logic-notice](../../_includes/organization/auth-policy-and-logic-notice.md) %}

### Users and user groups {#users-and-groups}

You can configure an authentication policy to apply to all users in an {{ org-full-name }} [organization](*organization), or to specific users or user groups.

You can also exclude specific users or user groups from the policy. Note that you cannot specify the same users or user groups simultaneously in both the inclusion and exclusion lists.

### Applications {#applications}

You can configure an authentication policy to apply to all applications created in an {{ org-full-name }} organization or to specific ones.

You can also exclude specific applications from the policy.

### Networks and IP addresses {#ip-addresses}

You can configure an authentication policy to apply to authentication from all possible IP addresses or to specific ranges of IPv4 or IPv6 addresses in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation.

You can also exclude specific IP address ranges from the policy. Note that you cannot specify the same IP address ranges in both the inclusion and exclusion lists at the same time.

## Policy-driven actions {#action}

Currently, authentication policies can deny user authentication if the authentication event matches the policy's defined [conditions](#conditions).

## Policy statuses {#status}

The status of an authentication policy can be either `Active` or `Inactive`. Inactive policies are not applied to user authentication events.

#### Useful links {#see-also}

* [{#T}](../operations/authentication-policies/create.md)
* [{#T}](../operations/authentication-policies/activate-deactivate.md)
* [{#T}](../operations/authentication-policies/update.md)
* [{#T}](../operations/authentication-policies/delete.md)
* [{#T}](./applications/index.md)

[*organization]: An organization is the highest resource in the {{ yandex-cloud }} resource model hierarchy that consolidates the resources of all other services. It is also used for user management as well as authentication and authorization management. For more information, see [{#T}](./organization.md).

[*user_groups]: You can group {{ org-full-name }} users to simplify access management in {{ yandex-cloud }}. For more information, see [{#T}](./groups.md).

[*applications]: {{ org-full-name }} SAML and OIDC applications allow {{ yandex-cloud }} users to authenticate in services of third-party service providers. For more information, see [{#T}](./applications/index.md).

[*user_accounts]: {{ yandex-cloud }} uses Yandex accounts as well as federated and local user accounts. For more information, see [{#T}](../../iam/concepts/users/accounts.md).

[*org_manager_admin]: The `organization-manager.admin` role enables managing organization settings, identity federations, user pools, SAML applications, OIDC applications, users and user groups, and users' access permissions to the organization and its resources. To learn more, see [Access management in {{ org-full-name }}](../security/index.md#organization-manager-admin).