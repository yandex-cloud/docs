Роль `data-catalog.admin` позволяет управлять ресурсами {{ data-catalog-name }} и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к каталогам в {{ data-catalog-name }} и изменять такие права доступа;
* просматривать информацию о каталогах в {{ data-catalog-name }}, а также создавать, изменять и удалять такие каталоги;
* просматривать информацию о назначенных правах доступа к доменам в {{ data-catalog-name }} и изменять такие права доступа;
* просматривать информацию о [доменах](../../metadata-hub/concepts/data-catalog.md#domains-and-subdomains) в {{ data-catalog-name }}, а также создавать, использовать, изменять и удалять такие домены;
* просматривать информацию об [источниках](../../metadata-hub/concepts/data-catalog.md#metadata-upload) в {{ data-catalog-name }}, а также создавать, изменять и удалять их;
* просматривать информацию о [загрузках](../../metadata-hub/concepts/data-catalog.md#metadata-upload) в {{ data-catalog-name }}, а также создавать, запускать, останавливать, изменять и удалять их;
* просматривать информацию о данных в {{ data-catalog-name }}, а также создавать, изменять и удалять такие данные;
* просматривать информацию о связях данных в {{ data-catalog-name }}, а также создавать, изменять и удалять такие связи;
* просматривать информацию о [глоссариях](../../metadata-hub/concepts/data-catalog.md#glossaries-and-terms) в {{ data-catalog-name }}, а также создавать, изменять и удалять их;
* просматривать информацию о [терминах](../../metadata-hub/concepts/data-catalog.md#glossaries-and-terms) в {{ data-catalog-name }}, а также создавать, использовать, изменять и удалять их;
* просматривать информацию о [классификациях](../../metadata-hub/concepts/data-catalog.md#classifications-and-tags) в {{ data-catalog-name }}, а также создавать, изменять и удалять их;
* просматривать информацию о [тегах](../../metadata-hub/concepts/data-catalog.md#classifications-and-tags) в {{ data-catalog-name }}, а также создавать, использовать, изменять и удалять их;
* просматривать информацию о [квотах](../../metadata-hub/concepts/limits.md#data-catalog-quota) {{ data-catalog-name }}.

Включает разрешения, предоставляемые ролями `data-catalog.catalogs.admin`, `data-catalog.domains.admin`, `data-catalog.ingestionSources.admin`, `data-catalog.ingestions.admin`, `data-catalog.assets.admin`, `data-catalog.lineages.admin`, `data-catalog.glossaries.admin`, `data-catalog.glossaryTerms.admin`, `data-catalog.classifications.admin` и `data-catalog.classificationTags.admin`.
