---
title: '{{ org-full-name }} release notes'
description: This section contains {{ org-name }} release notes.
---


# {{ org-full-name }} release notes

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}


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
* Added [{{ oslogin }}](../organization/concepts/os-login) support for [CentOS Stream 9](/marketplace/products/yc/centos-stream-9).
* Added validation of user numeric ID (UID) for [{{ oslogin }}](../organization/concepts/os-login).


## Q1 2024 {#q1-2024}

* Added an option to delete federated users via the [CLI](../cli/cli-ref/organization-manager/cli-ref/federation/saml/delete-user-accounts.md) and [API](saml/api-ref/Federation/deleteUserAccounts.md). {{ tag-cli }} {{ tag-api }}
* Fixed the Replay Attack vulnerability for SAML.