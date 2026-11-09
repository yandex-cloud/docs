---
title: Roles for working with {{ access-analyzer-name }} in {{ sd-full-name }}
description: This page lists the roles required to manage access to {{ access-analyzer-name }} in {{ sd-full-name }}.
---

# Roles for working with {{ access-analyzer-name }}

Only organization members who have the `organization-manager.viewer` [role](../../organization/security/index.md#organization-manager-viewer) or higher for the organization can view [access permissions](../operations/access-analyzer/analyze-permissions.md#view) and [recommendations](../operations/access-analyzer/use-recommendations.md#view) in the [{{ sd-name }} interface]({{ link-sd-main }}access-analyzer/).

To [revoke access permissions](../operations/access-analyzer/analyze-permissions.md#revoke) and [accept recommendations](../operations/access-analyzer/use-recommendations.md#replace), users must have one of these roles: `admin`, `resource-manager.admin`, `organization-manager.admin`, `resource-manager.clouds.owner`, `organization-manager.organizations.owner`, or the administrator role in the [service](../../overview/concepts/services.md) to whose resource the subject’s access is being revoked.