# Service roles to manage metadata in {{ data-catalog-full-name }}



{% note info %}

{% include [preview-tp](../../_includes/preview-tp.md) %}

{% endnote %}



To view information about metadata catalogs and manage their resources, you can use {{ data-catalog-full-name }} service roles at the following levels:

* [Service](#service-level-roles)
* [Catalog](#catalogs-roles)
* [Metadata set](#assets-roles)
* [Classification](#classifications-roles)
* [Classification tag](#tags-roles)
* [Domain](#domains-roles)
* [Glossary](#glossaries-roles)
* [Glossary term](#terms-roles)
* [Ingestion](#ingestions-roles)
* [Ingestion source](#ingestions-roles)
* [Metadata link](#lineages-roles)

## Top-level service roles {#service-level-roles}

```mermaid
flowchart BT
    data-catalog.user --> data-catalog.dataConsumer
    data-catalog.viewer --> data-catalog.dataConsumer
    data-catalog.dataConsumer --> data-catalog.dataSteward
    data-catalog.auditor --> data-catalog.viewer
    data-catalog.viewer --> data-catalog.editor
    data-catalog.editor --> data-catalog.admin    
```

### {{ roles.data-catalog.auditor }} {#data-catalog-auditor}

{% include [data-catalog.auditor](../../_roles/data-catalog/auditor.md) %}

### {{ roles.data-catalog.viewer }} {#data-catalog-viewer}

{% include [data-catalog.viewer](../../_roles/data-catalog/viewer.md) %}

### {{ roles.data-catalog.editor }} {#data-catalog-editor}

{% include [data-catalog.editor](../../_roles/data-catalog/editor.md) %}

### {{ roles.data-catalog.admin }} {#data-catalog-admin}

{% include [data-catalog.admin](../../_roles/data-catalog/admin.md) %}

### {{ roles.data-catalog.dataSteward }} {#data-catalog-dataSteward}

{% include [data-catalog.dataSteward](../../_roles/data-catalog/dataSteward.md) %}

### {{ roles.data-catalog.dataConsumer }} {#data-catalog-dataConsumer}

{% include [data-catalog.dataConsumer](../../_roles/data-catalog/dataConsumer.md) %}

### {{ roles.data-catalog.user }} {#data-catalog-user}

{% include [data-catalog.user](../../_roles/data-catalog/user.md) %}

## Roles for catalog access management {#catalogs-roles}

### {{ roles.data-catalog.catalogs.auditor }} {#data-catalog-catalogs-auditor}

{% include [data-catalog.catalogs.auditor](../../_roles/data-catalog/catalogs/auditor.md) %}

### {{ roles.data-catalog.catalogs.viewer }} {#data-catalog-catalogs-viewer}

{% include [data-catalog.catalogs.viewer](../../_roles/data-catalog/catalogs/viewer.md) %}

### {{ roles.data-catalog.catalogs.editor }} {#data-catalog-catalogs-editor}

{% include [data-catalog.catalogs.editor](../../_roles/data-catalog/catalogs/editor.md) %}

### {{ roles.data-catalog.catalogs.admin }} {#data-catalog-catalogs-admin}

{% include [data-catalog.catalogs.admin](../../_roles/data-catalog/catalogs/admin.md) %}

## Roles for metadata set access management {#assets-roles}

### {{ roles.data-catalog.assets.auditor }} {#data-catalog-assets-auditor}

{% include [data-catalog.assets.auditor](../../_roles/data-catalog/assets/auditor.md) %}

### {{ roles.data-catalog.assets.viewer }} {#data-catalog-assets-viewer}

{% include [data-catalog.assets.viewer](../../_roles/data-catalog/catalogs/viewer.md) %}

### {{ roles.data-catalog.assets.editor }} {#data-catalog-assets-editor}

{% include [data-catalog.assets.editor](../../_roles/data-catalog/assets/editor.md) %}

### {{ roles.data-catalog.assets.admin }} {#data-catalog-assets-admin}

{% include [data-catalog.assets.admin](../../_roles/data-catalog/catalogs/admin.md) %}

## Roles for classification access management {#classifications-roles}

### {{ roles.data-catalog.classifications.auditor }} {#data-catalog-classifications-auditor}

{% include [data-catalog.classifications.auditor](../../_roles/data-catalog/classifications/auditor.md) %}

### {{ roles.data-catalog.classifications.viewer }} {#data-catalog-classifications-viewer}

{% include [data-catalog.classifications.viewer](../../_roles/data-catalog/classifications/viewer.md) %}

### {{ roles.data-catalog.classifications.editor }} {#data-catalog-classifications-editor}

{% include [data-catalog.classifications.editor](../../_roles/data-catalog/classifications/editor.md) %}

### {{ roles.data-catalog.classifications.admin }} {#data-catalog-classifications-admin}

{% include [data-catalog.classifications.admin](../../_roles/data-catalog/classifications/admin.md) %}

## Roles for classification tag access management {#tags-roles}

### {{ roles.data-catalog.classificationTags.auditor }} {#data-catalog-classificationTags-auditor}

{% include [data-catalog.classificationTags.auditor](../../_roles/data-catalog/classificationTags/auditor.md) %}

### {{ roles.data-catalog.classificationTags.viewer }} {#data-catalog-classificationTags-viewer}

{% include [data-catalog.classificationTags.viewer](../../_roles/data-catalog/classificationTags/viewer.md) %}

### {{ roles.data-catalog.classificationTags.user }} {#data-catalog-classificationTags-user}

{% include [data-catalog.classificationTags.user](../../_roles/data-catalog/classificationTags/user.md) %}

### {{ roles.data-catalog.classificationTags.editor }} {#data-catalog-classificationTags-editor}

{% include [data-catalog.classificationTags.editor](../../_roles/data-catalog/classificationTags/editor.md) %}

### {{ roles.data-catalog.classificationTags.admin }} {#data-catalog-classificationTags-admin}

{% include [data-catalog.classificationTags.admin](../../_roles/data-catalog/classificationTags/admin.md) %}

## Roles for domain access management {#domains-roles}

### {{ roles.data-catalog.domains.auditor }} {#data-catalog-domains-auditor}

{% include [data-catalog.domains.auditor](../../_roles/data-catalog/domains/auditor.md) %}

### {{ roles.data-catalog.domains.viewer }} {#data-catalog-domains-viewer}

{% include [data-catalog.domains.viewer](../../_roles/data-catalog/domains/viewer.md) %}

### {{ roles.data-catalog.domains.user }} {#data-catalog-domains-user}

{% include [data-catalog.domains.user](../../_roles/data-catalog/domains/user.md) %}

### {{ roles.data-catalog.domains.editor }} {#data-catalog-domains-editor}

{% include [data-catalog.domains.editor](../../_roles/data-catalog/domains/editor.md) %}

### {{ roles.data-catalog.domains.admin }} {#data-catalog-domains-admin}

{% include [data-catalog.domains.admin](../../_roles/data-catalog/domains/admin.md) %}

## Roles for dictionary access management {#glossaries-roles}

### {{ roles.data-catalog.glossaries.auditor }} {#data-catalog-glossaries-auditor}

{% include [data-catalog.glossaries.auditor](../../_roles/data-catalog/glossaries/auditor.md) %}

### {{ roles.data-catalog.glossaries.viewer }} {#data-catalog-glossaries-viewer}

{% include [data-catalog.glossaries.viewer](../../_roles/data-catalog/glossaries/viewer.md) %}

### {{ roles.data-catalog.glossaries.editor }} {#data-catalog-glossaries-editor}

{% include [data-catalog.glossaries.editor](../../_roles/data-catalog/glossaries/editor.md) %}

### {{ roles.data-catalog.glossaries.admin }} {#data-catalog-glossaries-admin}

{% include [data-catalog.glossaries.admin](../../_roles/data-catalog/glossaries/admin.md) %}

## Roles for glossary term access management {#terms-roles}

### {{ roles.data-catalog.glossaryTerms.auditor }} {#data-catalog-glossaryTerms-auditor}

{% include [data-catalog.glossaryTerms.auditor](../../_roles/data-catalog/glossaryTerms/auditor.md) %}

### {{ roles.data-catalog.glossaryTerms.viewer }} {#data-catalog-glossaryTerms-viewer}

{% include [data-catalog.glossaryTerms.viewer](../../_roles/data-catalog/glossaryTerms/viewer.md) %}

### {{ roles.data-catalog.glossaryTerms.user }} {#data-catalog-glossaryTerms-user}

{% include [data-catalog.glossaryTerms.user](../../_roles/data-catalog/glossaryTerms/user.md) %}

### {{ roles.data-catalog.glossaryTerms.editor }} {#data-catalog-glossaryTerms-editor}

{% include [data-catalog.glossaryTerms.editor](../../_roles/data-catalog/glossaryTerms/editor.md) %}

### {{ roles.data-catalog.glossaryTerms.admin }} {#data-catalog-glossaryTerms-admin}

{% include [data-catalog.glossaryTerms.admin](../../_roles/data-catalog/glossaryTerms/admin.md) %}

## Roles for ingestion access management {#ingestions-roles}

### {{ roles.data-catalog.ingestions.auditor }} {#data-catalog-ingestions-auditor}

{% include [data-catalog.ingestions.auditor](../../_roles/data-catalog/ingestions/auditor.md) %}

### {{ roles.data-catalog.ingestions.viewer }} {#data-catalog-ingestions-viewer}

{% include [data-catalog.ingestions.viewer](../../_roles/data-catalog/ingestions/viewer.md) %}

### {{ roles.data-catalog.ingestions.editor }} {#data-catalog-ingestions-editor}

{% include [data-catalog.ingestions.editor](../../_roles/data-catalog/ingestions/editor.md) %}

### {{ roles.data-catalog.ingestions.admin }} {#data-catalog-ingestions-admin}

{% include [data-catalog.ingestions.admin](../../_roles/data-catalog/ingestions/admin.md) %}

## Roles for ingestion source access management {#ingestion-sources-roles}

### {{ roles.data-catalog.ingestionSources.auditor }} {#data-catalog-ingestionSources-auditor}

{% include [data-catalog.ingestionSources.auditor](../../_roles/data-catalog/ingestionSources/auditor.md) %}

### {{ roles.data-catalog.ingestionSources.viewer }} {#data-catalog-ingestionSources-viewer}

{% include [data-catalog.ingestionSources.viewer](../../_roles/data-catalog/ingestionSources/viewer.md) %}

### {{ roles.data-catalog.ingestionSources.editor }} {#data-catalog-ingestionSources-editor}

{% include [data-catalog.ingestionSources.editor](../../_roles/data-catalog/ingestionSources/editor.md) %}

### {{ roles.data-catalog.ingestionSources.admin }} {#data-catalog-ingestionSources-admin}

{% include [data-catalog.ingestionSources.admin](../../_roles/data-catalog/ingestionSources/admin.md) %}

## Roles for metadata link access management {#lineages-roles}

### {{ roles.data-catalog.lineages.auditor }} {#data-catalog-lineages-auditor}

{% include [data-catalog.lineages.auditor](../../_roles/data-catalog/lineages/auditor.md) %}

### {{ roles.data-catalog.lineages.viewer }} {#data-catalog-lineages-viewer}

{% include [data-catalog.lineages.viewer](../../_roles/data-catalog/lineages/viewer.md) %}

### {{ roles.data-catalog.lineages.editor }} {#data-catalog-lineages-editor}

{% include [data-catalog.lineages.editor](../../_roles/data-catalog/lineages/editor.md) %}

### {{ roles.data-catalog.lineages.admin }} {#data-catalog-lineages-admin}

{% include [data-catalog.lineages.admin](../../_roles/data-catalog/lineages/admin.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles required for specific actions. You can always assign a role with more permissions. For example, you can assign the `editor` role instead of `viewer`.

| Action                                                       | Required roles                                      |
|----------------------------------------------------------------|-------------------------------------------------------|
| View catalog metadata                             | `{{ roles.data-catalog.auditor }}`                    |
| View info on catalog access permissions and quotas | `{{ roles.data-catalog.viewer }}`                     |
| Create catalogs                                             | `{{ roles.data-catalog.editor }}`                     |
| Edit catalogs                                         | `{{ roles.data-catalog.editor }}`                     |
| Delete catalogs                                               | `{{ roles.data-catalog.editor }}`                     |
| Update catalog access permissions                             | `{{ roles.data-catalog.admin }}`                      |
| View and modify domains, tags, and terms                | `{{ roles.data-catalog.user }}`                       |
| View dataset information                      | `{{ roles.data-catalog.assets.auditor }}`             |
| Manage datasets: update, delete, or edit them | `{{ roles.data-catalog.assets.editor }}` |
| View classification information                       | `{{ roles.data-catalog.classifications.auditor }}`    |
| Edit classifications                                    | `{{ roles.data-catalog.classifications.editor }}`     |
| View tag information                               | `{{ roles.data-catalog.classificationTags.auditor }}` |
| Edit tags                                             | `{{ roles.data-catalog.classificationTags.editor }}`  |
| View glossary information                          | `{{ roles.data-catalog.glossaries.auditor }}`         |
| Edit glossaries                                        | `{{ roles.data-catalog.glossaries.editor }}`          |
| View term information                            | `{{ roles.data-catalog.glossaryTerms.auditor }}`      |
| Edit terms                                          | `{{ roles.data-catalog.glossaryTerms.editor }}`       |
| View ingestion settings                               | `{{ roles.data-catalog.ingestions.auditor }}`         |
| Edit ingestion settings                               | `{{ roles.data-catalog.ingestions.editor }}`          |
| View ingestion source settings                     | `{{ roles.data-catalog.ingestionSources.auditor }}`   |
| Edit ingestion source settings                     | `{{ roles.data-catalog.ingestionSources.editor }}`    |
| View information on data links                       | `{{ roles.data-catalog.lineages.auditor }}`           |
| Create, modify, and delete data links              | `{{ roles.data-catalog.lineages.editor }}`            |