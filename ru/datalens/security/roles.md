# Роли в {{ datalens-short-name }}

Чтобы предоставить пользователю доступ к {{ datalens-short-name }}, назначьте ему одну из ролей. Роли позволяют определить права пользователя в экземпляре {{ datalens-short-name }}.

{% include [roles-datalens-creator](../../_includes/roles-datalens-creator.md) %}

{% include [roles-datalens-admin-org](../../_includes/roles-datalens-admin-org.md) %}

{% include [datalens-instances-user](../../_includes/roles-datalens-user.md) %}

{% include [datalens-instances-admin](../../_includes/roles-datalens-admin.md) %}

{% note info %}

Роли `{{ roles-datalens-instances-user }}` и `{{ roles-datalens-instances-admin }}` также предоставляют право на просмотр каталогов в облаке. Рекомендуем вместо них использовать роли `{{ roles-datalens-creator }}` и `{{ roles-datalens-admin }}` соответственно.

{% endnote %}
