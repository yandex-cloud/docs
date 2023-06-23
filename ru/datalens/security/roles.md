# Роли в {{ datalens-short-name }}

Доступ к сервису {{ datalens-full-name }} регулируется путем назначения прав:

* для экземпляра {{ datalens-short-name }} на уровне организации — через сервис [организации](../concepts/organizations.md);
* для экземпляра {{ datalens-short-name }} на уровне каталога облака — через [консоль]({{ link-console-main }}) {{ yandex-cloud }}.

Чтобы предоставить доступ, назначьте пользователю одну из ролей {{ datalens-short-name }}.

## Пользовательские роли {#users-roles}

Позволяют определить права пользователя в экземпляре {{ datalens-short-name }}.

{% include [roles-datalens-creator](../../_includes/roles-datalens-creator.md) %}

{% include [roles-datalens-admin-org](../../_includes/roles-datalens-admin-org.md) %}

{% include [datalens-instances-user](../../_includes/roles-datalens-user.md) %}

{% include [datalens-instances-admin](../../_includes/roles-datalens-admin.md) %}

{% note info %}

Роли `{{ roles-datalens-instances-user }}` и `{{ roles-datalens-instances-admin }}` также предоставляют право на просмотр каталогов в облаке. Рекомендуем вместо них использовать роли `{{ roles-datalens-creator }}` и `{{ roles-datalens-admin }}` соответственно.

{% endnote %}
