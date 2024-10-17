---
title: '{{ org-full-name }} release notes'
description: This section contains {{ org-name }} release notes.
---

# {{ org-full-name }} release notes

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}

## Q1 2024 {#q1-2024}

* Added an option to delete federated users via the [CLI](../cli/cli-ref/managed-services/organization-manager/federation/saml/delete-user-accounts.md) and [API](saml/api-ref/Federation/deleteUserAccounts.md). {{ tag-cli }} {{ tag-api }}
* Fixed the Replay Attack vulnerability for SAML.

## Q2 2024 {#q2-2024}

* Added the **ACS URL** field for {{ org-full-name }}. {{ tag-con }}
* Added the `labels` parameter to work with labels when creating federations in {{ TF }}. {{ tag-tf }}
* Added [{{ oslogin }}](../organization/concepts/os-login) support for [CentOS Stream 9](/marketplace/products/yc/centos-stream-9).
* Added validation of user numeric ID (UID) for [{{ oslogin }}](../organization/concepts/os-login).
