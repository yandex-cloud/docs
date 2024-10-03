---
title: '{{ org-full-name }} release notes'
description: This section contains {{ org-name }} release notes.
---

# {{ org-full-name }} release notes

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}

## Q1 2024 {#q1-2024}

* Added an option to delete federated users via the [CLI](../cli/cli-ref/managed-services/organization-manager/federation/saml/delete-user-accounts.md) and [API](api-ref/Federation/deleteUserAccounts.md). {{ tag-cli }} {{ tag-api }}
* Fixed the Replay Attack vulnerability for SAML.