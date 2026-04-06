---
title: Roles for {{ ciem-full-name }} in {{ sd-full-name }}
description: This page covers the roles required to manage access to the {{ ciem-full-name }} ({{ ciem-name }}) module in {{ sd-name }}.
---

# Roles for {{ ciem-full-name }} ({{ ciem-name }})

Only [organization members](../../organization/concepts/membership.md) who have the `organization-manager.viewer` [role](../../organization/security/index.md#organization-manager-viewer) or higher for the organization can [view](../operations/ciem/view-permissions.md) access permissions in the [{{ sd-name }} interface]({{ link-sd-main }}iam-diagnostics/).

To [revoke](../operations/ciem/revoke-permissions.md) access permissions, users must have one of these roles: `admin`, `resource-manager.admin`, `organization-manager.admin`, `resource-manager.clouds.owner`, `organization-manager.organizations.owner`, or the administrator role in the [service](../../overview/concepts/services.md) where they want to revoke the subject’s access to a resource.