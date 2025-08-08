# Service roles to manage metadata in {{ data-catalog-full-name }}

{% note info %}

{% include [preview-tp](../../_includes/preview-tp.md) %}

{% endnote %}

With {{ data-catalog-full-name }} service roles, you can view catalog data and manage catalogs.

## {{ roles.data-catalog.auditor }} {#data-catalog-auditor}

{% include [data-catalog.auditor](../../_roles/data-catalog/auditor.md) %}

## {{ roles.data-catalog.viewer }} {#data-catalog-viewer}

{% include [data-catalog.viewer](../../_roles/data-catalog/viewer.md) %}

## {{ roles.data-catalog.editor }} {#data-catalog-editor}

{% include [data-catalog.editor](../../_roles/data-catalog/editor.md) %}

## {{ roles.data-catalog.admin }} {#data-catalog-admin}

{% include [data-catalog.admin](../../_roles/data-catalog/admin.md) %}

## {{ roles.data-catalog.dataSteward }} {#data-catalog-dataSteward}

{% include [data-catalog.dataSteward](../../_roles/data-catalog/dataSteward.md) %}

## {{ roles.data-catalog.dataConsumer }} {#data-catalog-dataConsumer}

{% include [data-catalog.dataConsumer](../../_roles/data-catalog/dataConsumer.md) %}

## {{ roles.data-catalog.user }} {#data-catalog-user}

{% include [data-catalog.user](../../_roles/data-catalog/user.md) %}

## {{ roles.data-catalog.catalog.auditor }} {#data-catalog-catalogs-auditor}

{% include [data-catalog.catalog.auditor](../../_roles/data-catalog/catalogs/auditor.md) %}

## {{ roles.data-catalog.catalog.viewer }} {#data-catalog-catalogs-viewer}

{% include [data-catalog.catalog.viewer](../../_roles/data-catalog/catalogs/viewer.md) %}

## {{ roles.data-catalog.catalog.editor }} {#data-catalog-catalogs-editor}

{% include [data-catalog.catalog.editor](../../_roles/data-catalog/catalogs/editor.md) %}

## {{ roles.data-catalog.catalog.admin }} {#data-catalog-catalogs-admin}

{% include [data-catalog.catalog.admin](../../_roles/data-catalog/catalogs/admin.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles required for specific actions. You can always assign a role with more permissions. For example, you can assign the `editor` role instead of `viewer`.

| Action                                                       | Required roles                |
|----------------------------------------------------------------|---------------------------------|
| View catalog metadata                             | `data-catalog.catalogs.auditor` |
| View info on catalog access permissions and quotas | `data-catalog.catalogs.viewer`  |
| Create catalogs                                             | `data-catalog.catalogs.editor`  |
| Edit catalogs                                         | `data-catalog.catalogs.editor`  |
| Delete catalogs                                               | `data-catalog.catalogs.editor`  |
| Update catalog access permissions                             | `data-catalog.catalogs.admin`   |
| View and modify domains, tags, and terms                | `data-catalog.user`             |