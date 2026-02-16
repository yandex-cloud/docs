---
title: '{{ org-full-name }} release notes'
description: This section contains the {{ org-name }} release notes.
---


# {{ org-full-name }} release notes

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}

## December 2025 {#december-2025}

* Added a list of supported values for the `--acr-id` parameter in the `yc organization-manager mfa-enforcement create` and `yc organization-manager mfa-enforcement update` commands. {{ tag-cli }}


## November 2025 {#november-2025}

* Implemented the [My account](concepts/my-account.md) portal for user account management. {{ tag-con }}


## October 2025 {#october-2025}

* Implemented [MFA policy](./concepts/mfa.md#mfa-policies) management in an organization using the [CLI](../cli/cli-ref/organization-manager/cli-ref/mfa-enforcement/) and [API](./api-ref/grpc/MfaEnforcement/). {{ tag-cli }} {{ tag-api }}
* Added CLI and [API](saml/api-ref/Federation/reactivateUserAccounts.md) commands for [suspending](../cli/cli-ref/organization-manager/cli-ref/federation/saml/suspend-user-accounts.md) and [reactivating](../cli/cli-ref/organization-manager/cli-ref/federation/saml/reactivate-user-accounts.md) SAML federation users. {{ tag-cli }} {{ tag-api }}
* Now you can use the [CLI](../cli/cli-ref/organization-manager/cli-ref/group/list-effective.md) to [view](operations/get-users-groups.md#cli_1) which groups a given user belongs to within an organization. {{ tag-cli }}


## Q3 2025 {#q3-2025}

* Added commands for managing SAML federation domains using the [CLI](../cli/cli-ref/organization-manager/cli-ref/federation/saml/) and [API](saml/api-ref/Federation/). {{ tag-cli }} {{ tag-api }}
* Restored the option to [set up](./operations/federation-group-mapping.md) access permissions to {{ yandex-cloud }} resources using federated user group mapping. {{ tag-con }} {{ tag-tf }}
* [Added](./operations/enable-2fa-access.md) the option to enforce two-factor authentication for all Yandex account users of an organization. {{ tag-con }}


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