# Service roles to manage metadata in {{ data-catalog-full-name }}

{% note info %}

{% include [preview-tp](../../_includes/preview-tp.md) %}

{% endnote %}

With {{ data-catalog-full-name }} service roles, you can view catalog data and manage catalogs.

## {{ roles.data-catalog.catalog.auditor }} {#managed-data-catalog-auditor}

{% include [data-catalog.catalog.auditor](../../_roles/data-catalog/catalogs/auditor.md) %}

## {{ roles.data-catalog.catalog.viewer }} {#managed-data-catalog-viewer}

{% include [data-catalog.catalog.viewer](../../_roles/data-catalog/catalogs/viewer.md) %}

## {{ roles.data-catalog.catalog.editor }} {#managed-data-catalog-editor}

{% include [data-catalog.catalog.editor](../../_roles/data-catalog/catalogs/editor.md) %}

## {{ roles.data-catalog.catalog.admin }} {#managed-data-catalog-admin}

{% include [data-catalog.catalog.admin](../../_roles/data-catalog/catalogs/admin.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles required for specific actions. You can always assign a role with more permissions. For example, you can assign the `editor` role instead of `viewer`.

| Action                                              | Required roles                |
|-------------------------------------------------------|---------------------------------|
| View the catalog metadata                    | `data-catalog.catalogs.auditor` |
| View info on the catalog access permissions | `data-catalog.catalogs.viewer`  |
| Create catalogs                                    | `data-catalog.catalogs.editor`  |
| Edit catalogs                                | `data-catalog.catalogs.editor`  |
| Delete catalogs                                      | `data-catalog.catalogs.editor`  |
| Update catalog access permissions                    | `data-catalog.catalogs.admin`   |