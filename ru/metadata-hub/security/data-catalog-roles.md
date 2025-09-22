# Сервисные роли для работы с метаданными в {{ data-catalog-full-name }}



{% note info %}

{% include [preview-pp](../../_includes/preview-pp.md) %}

{% endnote %}



Вы можете просматривать информацию о каталогах метаданных и управлять их ресурсами с помощью сервисных ролей {{ data-catalog-full-name }} уровня:

* [сервиса](#service-level-roles)
* [каталогов](#catalogs-roles)
* [наборов метаданных](#assets-roles)
* [классификаций](#classifications-roles)
* [тегов классификаций](#tags-roles)
* [доменов](#domains-roles)
* [глоссариев](#glossaries-roles)
* [терминов глоссариев](#terms-roles)
* [загрузок](#ingestions-roles)
* [источников загрузок](#ingestions-roles)
* [связей метаданных](#lineages-roles)

## Сервисные роли верхнего уровня {#service-level-roles}

{% include [data catalog roles](../../_mermaid/roles/data-catalog.md) %}

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

## Роли для управления доступом к каталогу {#catalogs-roles}

### {{ roles.data-catalog.catalogs.auditor }} {#data-catalog-catalogs-auditor}

{% include [data-catalog.catalogs.auditor](../../_roles/data-catalog/catalogs/auditor.md) %}

### {{ roles.data-catalog.catalogs.viewer }} {#data-catalog-catalogs-viewer}

{% include [data-catalog.catalogs.viewer](../../_roles/data-catalog/catalogs/viewer.md) %}

### {{ roles.data-catalog.catalogs.editor }} {#data-catalog-catalogs-editor}

{% include [data-catalog.catalogs.editor](../../_roles/data-catalog/catalogs/editor.md) %}

### {{ roles.data-catalog.catalogs.admin }} {#data-catalog-catalogs-admin}

{% include [data-catalog.catalogs.admin](../../_roles/data-catalog/catalogs/admin.md) %}

## Роли для управления доступом к наборам метаданных {#assets-roles}

### {{ roles.data-catalog.assets.auditor }} {#data-catalog-assets-auditor}

{% include [data-catalog.assets.auditor](../../_roles/data-catalog/assets/auditor.md) %}

### {{ roles.data-catalog.assets.viewer }} {#data-catalog-assets-viewer}

{% include [data-catalog.assets.viewer](../../_roles/data-catalog/catalogs/viewer.md) %}

### {{ roles.data-catalog.assets.editor }} {#data-catalog-assets-editor}

{% include [data-catalog.assets.editor](../../_roles/data-catalog/assets/editor.md) %}

### {{ roles.data-catalog.assets.admin }} {#data-catalog-assets-admin}

{% include [data-catalog.assets.admin](../../_roles/data-catalog/catalogs/admin.md) %}

## Роли для управления доступом к классификациям {#classifications-roles}

### {{ roles.data-catalog.classifications.auditor }} {#data-catalog-classifications-auditor}

{% include [data-catalog.classifications.auditor](../../_roles/data-catalog/classifications/auditor.md) %}

### {{ roles.data-catalog.classifications.viewer }} {#data-catalog-classifications-viewer}

{% include [data-catalog.classifications.viewer](../../_roles/data-catalog/classifications/viewer.md) %}

### {{ roles.data-catalog.classifications.editor }} {#data-catalog-classifications-editor}

{% include [data-catalog.classifications.editor](../../_roles/data-catalog/classifications/editor.md) %}

### {{ roles.data-catalog.classifications.admin }} {#data-catalog-classifications-admin}

{% include [data-catalog.classifications.admin](../../_roles/data-catalog/classifications/admin.md) %}

## Роли для управления доступом к тегам классификаций {#tags-roles}

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

## Роли для управления доступом к доменам {#domains-roles}

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

## Роли для управления доступом к словарям {#glossaries-roles}

### {{ roles.data-catalog.glossaries.auditor }} {#data-catalog-glossaries-auditor}

{% include [data-catalog.glossaries.auditor](../../_roles/data-catalog/glossaries/auditor.md) %}

### {{ roles.data-catalog.glossaries.viewer }} {#data-catalog-glossaries-viewer}

{% include [data-catalog.glossaries.viewer](../../_roles/data-catalog/glossaries/viewer.md) %}

### {{ roles.data-catalog.glossaries.editor }} {#data-catalog-glossaries-editor}

{% include [data-catalog.glossaries.editor](../../_roles/data-catalog/glossaries/editor.md) %}

### {{ roles.data-catalog.glossaries.admin }} {#data-catalog-glossaries-admin}

{% include [data-catalog.glossaries.admin](../../_roles/data-catalog/glossaries/admin.md) %}

## Роли для управления доступом к терминам глоссариев {#terms-roles}

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

## Роли для управления доступом к загрузкам {#ingestions-roles}

### {{ roles.data-catalog.ingestions.auditor }} {#data-catalog-ingestions-auditor}

{% include [data-catalog.ingestions.auditor](../../_roles/data-catalog/ingestions/auditor.md) %}

### {{ roles.data-catalog.ingestions.viewer }} {#data-catalog-ingestions-viewer}

{% include [data-catalog.ingestions.viewer](../../_roles/data-catalog/ingestions/viewer.md) %}

### {{ roles.data-catalog.ingestions.editor }} {#data-catalog-ingestions-editor}

{% include [data-catalog.ingestions.editor](../../_roles/data-catalog/ingestions/editor.md) %}

### {{ roles.data-catalog.ingestions.admin }} {#data-catalog-ingestions-admin}

{% include [data-catalog.ingestions.admin](../../_roles/data-catalog/ingestions/admin.md) %}

## Роли для управления доступом к источникам загрузок {#ingestion-sources-roles}

### {{ roles.data-catalog.ingestionSources.auditor }} {#data-catalog-ingestionSources-auditor}

{% include [data-catalog.ingestionSources.auditor](../../_roles/data-catalog/ingestionSources/auditor.md) %}

### {{ roles.data-catalog.ingestionSources.viewer }} {#data-catalog-ingestionSources-viewer}

{% include [data-catalog.ingestionSources.viewer](../../_roles/data-catalog/ingestionSources/viewer.md) %}

### {{ roles.data-catalog.ingestionSources.editor }} {#data-catalog-ingestionSources-editor}

{% include [data-catalog.ingestionSources.editor](../../_roles/data-catalog/ingestionSources/editor.md) %}

### {{ roles.data-catalog.ingestionSources.admin }} {#data-catalog-ingestionSources-admin}

{% include [data-catalog.ingestionSources.admin](../../_roles/data-catalog/ingestionSources/admin.md) %}

## Роли для управления доступом к связям метаданных {#lineages-roles}

### {{ roles.data-catalog.lineages.auditor }} {#data-catalog-lineages-auditor}

{% include [data-catalog.lineages.auditor](../../_roles/data-catalog/lineages/auditor.md) %}

### {{ roles.data-catalog.lineages.viewer }} {#data-catalog-lineages-viewer}

{% include [data-catalog.lineages.viewer](../../_roles/data-catalog/lineages/viewer.md) %}

### {{ roles.data-catalog.lineages.editor }} {#data-catalog-lineages-editor}

{% include [data-catalog.lineages.editor](../../_roles/data-catalog/lineages/editor.md) %}

### {{ roles.data-catalog.lineages.admin }} {#data-catalog-lineages-admin}

{% include [data-catalog.lineages.admin](../../_roles/data-catalog/lineages/admin.md) %}

## Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.

| Действие                                                       | Необходимые роли                                      |
|----------------------------------------------------------------|-------------------------------------------------------|
| Просматривать метаданные каталогов                             | `{{ roles.data-catalog.auditor }}`                    |
| Просматривать информацию о правах доступа к каталогам и квотах | `{{ roles.data-catalog.viewer }}`                     |
| Создавать каталоги                                             | `{{ roles.data-catalog.editor }}`                     |
| Редактировать каталоги                                         | `{{ roles.data-catalog.editor }}`                     |
| Удалять каталоги                                               | `{{ roles.data-catalog.editor }}`                     |
| Изменять права доступа к каталогам                             | `{{ roles.data-catalog.admin }}`                      |
| Просматривать и изменять домены, теги и термины                | `{{ roles.data-catalog.user }}`                       |
| Просматривать информацию о наборах данных                      | `{{ roles.data-catalog.assets.auditor }}`             |
| Работать с наборами данных: изменять, удалять, редактировать | `{{ roles.data-catalog.assets.editor }}` |
| Просматривать информацию о классификации                       | `{{ roles.data-catalog.classifications.auditor }}`    |
| Редактировать классификации                                    | `{{ roles.data-catalog.classifications.editor }}`     |
| Просматривать информацию о тегах                               | `{{ roles.data-catalog.classificationTags.auditor }}` |
| Редактировать теги                                             | `{{ roles.data-catalog.classificationTags.editor }}`  |
| Просматривать информацию о глоссариях                          | `{{ roles.data-catalog.glossaries.auditor }}`         |
| Редактировать глоссарии                                        | `{{ roles.data-catalog.glossaries.editor }}`          |
| Просматривать информацию о терминах                            | `{{ roles.data-catalog.glossaryTerms.auditor }}`      |
| Редактировать термины                                          | `{{ roles.data-catalog.glossaryTerms.editor }}`       |
| Просматривать настройки загрузок                               | `{{ roles.data-catalog.ingestions.auditor }}`         |
| Редактировать настройки загрузок                               | `{{ roles.data-catalog.ingestions.editor }}`          |
| Просматривать настройки источников загрузок                     | `{{ roles.data-catalog.ingestionSources.auditor }}`   |
| Редактировать настройки источников загрузок                     | `{{ roles.data-catalog.ingestionSources.editor }}`    |
| Просматривать информацию о связях данных                       | `{{ roles.data-catalog.lineages.auditor }}`           |
| Создавать, изменять и удалять связи между данными              | `{{ roles.data-catalog.lineages.editor }}`            |
