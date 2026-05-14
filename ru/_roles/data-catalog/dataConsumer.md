Роль `data-catalog.dataConsumer` позволяет просматривать информацию о ресурсах {{ data-catalog-name }}, а также использовать и изменять их.

Роль не позволяет изменять источники и управлять загрузками {{ data-catalog-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о каталогах в {{ data-catalog-name }} и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о [доменах](../../metadata-hub/concepts/data-catalog.md#domains-and-subdomains) в {{ data-catalog-name }} и назначенных правах доступа к ним, а также использовать и изменять такие домены;
* просматривать информацию об [источниках и загрузках](../../metadata-hub/concepts/data-catalog.md#metadata-upload) в {{ data-catalog-name }};
* просматривать информацию о данных и связях данных в {{ data-catalog-name }}, а также изменять такие данные и связи данных;
* просматривать информацию о [глоссариях](../../metadata-hub/concepts/data-catalog.md#glossaries-and-terms) в {{ data-catalog-name }} и изменять их;
* просматривать информацию о [терминах](../../metadata-hub/concepts/data-catalog.md#glossaries-and-terms) в {{ data-catalog-name }}, а также использовать и изменять их;
* просматривать информацию о [классификациях](../../metadata-hub/concepts/data-catalog.md#classifications-and-tags) в {{ data-catalog-name }} и изменять их;
* просматривать информацию о [тегах](../../metadata-hub/concepts/data-catalog.md#classifications-and-tags) в {{ data-catalog-name }}, а также использовать и изменять их;
* просматривать информацию о [квотах](../../metadata-hub/concepts/limits.md#data-catalog-quota) {{ data-catalog-name }}.

Включает разрешения, предоставляемые ролями `data-catalog.viewer` и `data-catalog.user`.
