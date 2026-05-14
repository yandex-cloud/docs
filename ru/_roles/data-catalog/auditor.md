Роль `data-catalog.auditor` позволяет просматривать информацию о ресурсах и квотах {{ data-catalog-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о каталогах в {{ data-catalog-name }} и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о [доменах](../../metadata-hub/concepts/data-catalog.md#domains-and-subdomains) в {{ data-catalog-name }} и назначенных правах доступа к ним;
* просматривать информацию об [источниках и загрузках](../../metadata-hub/concepts/data-catalog.md#metadata-upload) в {{ data-catalog-name }};
* просматривать информацию о данных и связях данных в {{ data-catalog-name }};
* просматривать информацию о [глоссариях и терминах](../../metadata-hub/concepts/data-catalog.md#glossaries-and-terms) в {{ data-catalog-name }};
* просматривать информацию о [классификациях и тегах](../../metadata-hub/concepts/data-catalog.md#classifications-and-tags) в {{ data-catalog-name }};
* просматривать информацию о [квотах](../../metadata-hub/concepts/limits.md#data-catalog-quota) {{ data-catalog-name }}.

Включает разрешения, предоставляемые ролями `data-catalog.catalogs.auditor`, `data-catalog.domains.auditor`, `data-catalog.ingestionSources.auditor`, `data-catalog.ingestions.auditor`, `data-catalog.assets.auditor`, `data-catalog.lineages.auditor`, `data-catalog.glossaries.auditor`, `data-catalog.glossaryTerms.auditor`, `data-catalog.classifications.auditor` и `data-catalog.classificationTags.auditor`.
