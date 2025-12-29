---
title: '{{ org-full-name }} release notes'
description: This section contains {{ org-name }} release notes.
---


# {{ org-full-name }} release notes

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}

## November 2025 {#november-2025}

* Added the ability to manage SAML applications via the [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/application/saml/) and [API](idp/application/saml/api-ref/Application/). {{ tag-cli }} {{ tag-api }}
* Added support for domain management via the [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/userpool/domain/) and [API](idp/api-ref/Userpool/addDomain.md). {{ tag-cli }} {{ tag-api }}
* Added the ability to [activate](operations/user-pools/activate-user.md) and [deactivate](operations/user-pools/deactivate-user.md) federated users via the [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/user/suspend.md) and [API](idp/api-ref/User/suspend.md). {{ tag-cli }} {{ tag-api }}
* Implemented the ability to [reset](operations/user-pools/reset-user-password.md) a user's password via the [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/user/reset-password.md). {{ tag-cli }}
* Added the ability to automatically generate a password when creating a user via the [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/user/create.md) and [API](idp/api-ref/User/create.md). {{ tag-cli }} {{ tag-api }}
* Added service plans for {{ org-name }}. {{ tag-center }}
* Added functionality for [synchronization of users and groups with {{ microsoft-idp.ad-short }}](operations/sync-ad.md).
* Implemented the [My account](concepts/my-account.md) portal for user account management. {{ tag-con }}
* Updated password quality policy fields in user pool management commands in the [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/userpool/). {{ tag-cli }}
* Added support for resources and data sources for SAML applications: `yandex_organizationmanager_idp_saml_application`. {{ tag-tf }}
* Added support for resources and data sources for OAuth applications: `yandex_organizationmanager_idp_oauth_application`. {{ tag-tf }}
* Added support for resources and data sources for user pools: `yandex_organizationmanager_idp_userpool`. {{ tag-tf }}
* Added support for resources and data sources for users: `yandex_organizationmanager_idp_user`. {{ tag-tf }}

## October 2025 {#october-2025}

* Implemented [MFA policy](./concepts/mfa.md#mfa-policies) management in an organization using the [CLI](../cli/cli-ref/organization-manager/cli-ref/mfa-enforcement/) and [API](./api-ref/grpc/MfaEnforcement/). {{ tag-cli }} {{ tag-api }}
* Added CLI and [API](saml/api-ref/Federation/reactivateUserAccounts.md) commands for [suspending](../cli/cli-ref/organization-manager/cli-ref/federation/saml/suspend-user-accounts.md) and [reactivating](../cli/cli-ref/organization-manager/cli-ref/federation/saml/reactivate-user-accounts.md) SAML federation users. {{ tag-cli }} {{ tag-api }}
* Added the ability to automatically generate a password when creating a user in the [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/user/create.md) and [API](idp/api-ref/User/create.md) as well as the [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/user/reset-password.md) [password reset](operations/user-pools/reset-user-password.md#cli_1) command. {{ tag-cli }} {{ tag-api }}
* Now you can use the [CLI](../cli/cli-ref/organization-manager/cli-ref/group/list-effective.md) to [view](operations/get-users-groups.md#cli_1) which groups a given user belongs to within an organization. {{ tag-cli }}
* Added the ability to manage password policies when [creating](../cli/cli-ref/organization-manager/cli-ref/idp/userpool/create.md) or [updating](../cli/cli-ref/organization-manager/cli-ref/idp/userpool/update.md) a user pool via the CLI and [API](idp/api-ref/Userpool/update.md). {{ tag-cli }} {{ tag-api }}
* Added commands for managing OAuth applications in the [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/application/oauth/) and [API](idp/application/oauth/api-ref/Application/). {{ tag-cli }} {{ tag-api }}
* Added support for the `domain` parameter for working with domains when managing user pools in the [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/userpool/domain/) and [API](idp/api-ref/Userpool/addDomain.md). {{ tag-cli }} {{ tag-api }}

## Q3 2025 {#q3-2025}

* Implemented the [user pool](./concepts/user-pools.md) management concept in organizations. {{ tag-con }} {{ tag-cli }}
* Added command groups for managing [user pools](../cli/cli-ref/organization-manager/cli-ref/idp/userpool/) and [local users](../cli/cli-ref/organization-manager/cli-ref/idp/user/) to the CLI and API. {{ tag-cli }} {{ tag-api }}
* Added commands for managing SAML federation domains using the [CLI](../cli/cli-ref/organization-manager/cli-ref/federation/saml/) and [API](saml/api-ref/Federation/). {{ tag-cli }} {{ tag-api }}
* Restored the option to [set up](./operations/federation-group-mapping.md) access permissions to {{ yandex-cloud }} resources using federated user group mapping. {{ tag-con }} {{ tag-tf }}
* [Added](./operations/enable-2fa-access.md) the option to enforce two-factor authentication for all Yandex account users of an organization. {{ tag-con }}
* Implemented [reactivation](./operations/user-pools/activate-user) of previously suspended users via the [CLI](../cli/cli-ref/organization-manager/cli-ref/idp/user/reactivate.md) and [API](idp/api-ref/User/reactivate.md). {{ tag-con }} {{ tag-cli }} {{ tag-api }}

## Q2 2025 {#q2-2025}

* {{ org-name }} is now in [Public Preview](../overview/concepts/launch-stages.md).
* Enabled the use of [refresh tokens](../iam/concepts/authorization/refresh-token.md#token-enabling) in the {{ yandex-cloud }} CLI. {{ tag-cli }}

## Q1 2025 {#q1-2025}

* [Updated](../organization/operations/hide-user-info.md) user visibility management in [organizations](concepts/organization.md). {{ tag-con }}


## Q4 2024 {#q4-2024}

* [Added](../organization/operations/hide-user-info.md) user visibility management in [organization](concepts/organization.md). {{ tag-con }}
* [{{ oslogin }}](../organization/concepts/os-login.md) package building script is now available on VMs running Ubuntu 24.04.
* [Added](../iam/roles-reference.md#organization-manager-passportUserAdmin) the `organization-manager.passportUserAdmin` role to manage organization [users](../organization/concepts/membership.md) with [Yandex accounts](https://yandex.ru/id/about).
* In [{{ at-full-name }}](../audit-trails/), [added](../audit-trails/concepts/events.md#organization) events for federated user group management: `CreateGroupMapping`, `DeleteGroupMapping`, and `UpdateGroupMapping`.
* Implemented user notification about the expiration of their {{ yandex-cloud}} SAML certificates.


## Q3 2024 {#q3-2024}

* Implemented sending notifications within an organization. {{ tag-con }}
* Added a script for deletion of {{ oslogin }} packets from a virtual machine.
* You can now see the last authentication date of a service account or federated users. {{ tag-con }} {{ tag-cli }} {{ tag-api }}
* Added federated user deletion event to {{ at-name }}: `DeleteFederatedUserAccounts`.


## Q2 2024 {#q2-2024}

* Added the **ACS URL** field for {{ org-full-name }}. {{ tag-con }}
* Added the `labels` parameter to work with labels when creating federations in {{ TF }}. {{ tag-tf }}
* Added [{{ oslogin }}](../organization/concepts/os-login.md) support for [CentOS Stream 9](/marketplace/products/yc/centos-stream-9).
* Added validation of user numeric ID (UID) for [{{ oslogin }}](../organization/concepts/os-login.md).


## Q1 2024 {#q1-2024}

* Added an option to delete federated users via the [CLI](../cli/cli-ref/organization-manager/cli-ref/federation/saml/delete-user-accounts.md) and [API](saml/api-ref/Federation/deleteUserAccounts.md). {{ tag-cli }} {{ tag-api }}
* Fixed the Replay Attack vulnerability for SAML.