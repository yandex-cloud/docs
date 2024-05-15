# {{ org-full-name }} release notes

This section contains {{ org-name }} release notes.

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}

## Q1 2024 {#q1-2024}

* Added an option to delete federated users via the [CLI](../cli/cli-ref/managed-services/organization-manager/federation/saml/delete-user-accounts.md) and [API](api-ref/Federation/deleteUserAccounts.md). {{ tag-cli }}
* Fixed the Replay Attack vulnerability for SAML.