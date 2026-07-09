---
title: Authentication policies in {{ org-full-name }}
description: Authentication policies allow for granular management of {{ org-full-name }} user access to applications.
---

# Authentication policies in {{ org-full-name }}

{% include [note-preview](../../_includes/note-preview.md) %}

In {{ org-full-name }}, _authentication policies_ are used for granular management of [user](*user_accounts) and [user group](*user_groups) access to {{ org-full-name }} [applications](*applications) by [denying or allowing](#action) authentication based on conditions specified in the [policy scope](#conditions).

Currently, you can manage authentication policies via the [{{ cloud-center }} UI]({{ link-org-cloud-center }}). To [create](../operations/authentication-policies/create.md), [update](../operations/authentication-policies/update.md), [activate](../operations/authentication-policies/activate-deactivate.md#activate), [deactivate](../operations/authentication-policies/activate-deactivate.md#deactivate), or [delete](../operations/authentication-policies/delete.md) authentication policies, users need the `organization-manager.admin` [role](*org_manager_admin) or higher.

## Policy scope {#conditions}

Authentication policies apply to user authentication events based on the following conditions:

* [Users and user groups](#users-and-groups).
* [Applications](#applications).
* [Networks and IP addresses](#ip-addresses).

{% include [auth-policy-and-logic-notice](../../_includes/organization/auth-policy-and-logic-notice.md) %}

### Users and user groups {#users-and-groups}

You can apply an authentication policy to all users within your [{{ org-full-name }}](*organization) or restrict it to specific users or user groups.

You can also explicitly exclude certain users or user groups from a policy. Note that you cannot add the same users or user groups to both inclusion and exclusion lists at the same time.

### Applications {#applications}

You can apply an authentication policy to all applications created in your {{ org-full-name }} or restrict it to specific applications.

You can also exclude certain applications from a policy.

### Networks and IP addresses {#ip-addresses}

You can apply an authentication policy to either all possible IP addresses or specific IPv4 and IPv6 ranges in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation.

You can also exclude certain address ranges from a policy. Note that you cannot add the same IP address ranges to both inclusion and exclusion lists at the same time.

## Policy outcomes {#action}

Currently, you can use authentication policies to deny user authentication if the authentication event meets the policy [conditions](#conditions).

## Policy statuses {#status}

An authentication policy may be either `Active` or `Inactive`. An inactive policy does not apply to user authentication events.

#### Useful links {#see-also}

* [{#T}](../operations/authentication-policies/create.md)
* [{#T}](../operations/authentication-policies/activate-deactivate.md)
* [{#T}](../operations/authentication-policies/update.md)
* [{#T}](../operations/authentication-policies/delete.md)
* [{#T}](./applications.md)

[*organization]: An organization is the highest resource in the {{ yandex-cloud }} resource model hierarchy that consolidates the resources of all other services. It is also used for user management as well as authentication and authorization management. For more information, see [{#T}](./organization.md).

[*user_groups]: You can group {{ org-full-name }} users to simplify access management in {{ yandex-cloud }}. For more information, see [{#T}](./groups.md).

[*applications]: {{ org-full-name }} SAML and OIDC applications allow {{ yandex-cloud }} users to authenticate in services of third-party service providers. For more information, see [{#T}](./applications.md).

[*user_accounts]: {{ yandex-cloud }} uses Yandex accounts as well as federated and local user accounts. For more information, see [{#T}](../../iam/concepts/users/accounts.md).

[*org_manager_admin]: The `organization-manager.admin` role enables managing organization settings, identity federations, user pools, SAML applications, OIDC applications, users and user groups, and users' access permissions to the organization and its resources. To learn more, see [Access management in {{ org-full-name }}](../security/index.md#organization-manager-admin).