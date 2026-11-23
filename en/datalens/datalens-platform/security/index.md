---
title: Managing access to {{ datalens-platform-full-name }}
description: In this article, you will learn about access management in {{ datalens-platform-full-name }}.
---

# Managing access to {{ datalens-platform-full-name }}

## Permissions {#access-rights}

The following permissions are used to access {{ datalens-platform-short-name }}:

* **Permissions for service access**: Determine who has access to the {{ datalens-platform-short-name }} interface and which metadata operations will be available to users.

   For service access, a user needs one of the following permissions: `Visitor` or `Admin`. Assigning permissions for working with metadata (`Metadata usage`, `Manage metadata markup`, etc.) is optional.

   You can [assign]({{ link-docs }}/organization/operations/add-role) service access permissions in the {{ org-full-name }} UI (e.g., for an admin who configures an instance); however, we recommend using the [{{ datalens-platform-short-name }}](manage-access.md#service-access) UI (for any other users).

* **Permissions for access to individual objects**: Determine the access level for a specific object, such as a collection, workbook, or REST catalog (`Limited viewer`, `Viewer`, `Editor`, `Admin`, etc.). Such permissions are [assigned for a specific object](manage-access.md#set-access) and inherited by all nested objects.
   
   If you revoke the service access permission (`Visitor` or `Admin`), the configured access permissions to objects will remain but will not apply anymore as the user will not be able to access the {{ datalens-platform-short-name }} UI.

Read more about all access permissions in [{#T}](roles.md).

Learn how to grant access to the service and objects as well as handle access requests in [{#T}](manage-access.md).

## Organization and instance {#org-tennant}

To use {{ datalens-platform-short-name }}, you need an [organization]({{ link-docs }}/organization/concepts/organization) in {{ org-full-name }}. However, this limit applies: you can only create a single {{ datalens-platform-short-name }} instance per organization.

If you create {{ datalens-platform-short-name }} from scratch, an organization will be created automatically when [activating the platform](../quickstart.md#activate-service). When configuring access permissions, user roles are assigned at the instance level.

If you are migrating from {{ datalens-name }} to {{ datalens-platform-short-name }}, it will use the same organization as the {{ datalens-name }} instance. The {{ datalens-name }} instance will be completely superseded by the {{ datalens-platform-short-name }} instance. This operation cannot be reversed. Since in {{ datalens-name }} roles are assigned at the organizational level, this will not change after migration. However, we recommend assigning all new roles in {{ datalens-platform-short-name }} at the instance level, and replace the migrated roles with instance-level roles.
