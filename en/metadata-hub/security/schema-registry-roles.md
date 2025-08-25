---
title: Access management in {{ schema-registry-name }}
description: Access management in {{ schema-registry-name }}. This section covers the resources supporting role assignment, the roles this service has, and the required roles for specific actions.
---

# Service roles for managing data schemas using {{ schema-registry-name }}


With {{ schema-registry-name }} service roles, you can view namespaces, subjects, and schemas in a schema registry, as well as create, edit, and delete namespaces and schemas.

### schema-registry.auditor {#schema-registry-auditor}

{% include [schema-registry.auditor](../../_roles/schema-registry/auditor.md) %}

### schema-registry.viewer {#schema-registry-viewer}

{% include [schema-registry.viewer](../../_roles/schema-registry/viewer.md) %}

### schema-registry.editor {#schema-registry-editor}

{% include [schema-registry.editor](../../_roles/schema-registry/editor.md) %}

### schema-registry.admin {#schema-registry-admin}

{% include [schema-registry.admin](../../_roles/schema-registry/admin.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles required for specific actions. You can always assign a role with more permissions. For example, you can assign the `editor` role instead of `viewer`.

| Action                        | Required roles          |
|---------------------------------|---------------------------|
| Viewing namespaces | `schema-registry.auditor` |
| Viewing subjects          | `schema-registry.viewer`  |
| Viewing schemas             | `schema-registry.viewer`  |
| Comparing schema versions          | `schema-registry.viewer`  |
| Creating namespaces     | `schema-registry.editor`  |
| Creating schemas                 | `schema-registry.editor`  |
| Editing namespaces | `schema-registry.editor`  |
| Editing schemas             | `schema-registry.editor`  |
| Deleting namespaces       | `schema-registry.editor`  |
| Deleting schemas                   | `schema-registry.editor`  |