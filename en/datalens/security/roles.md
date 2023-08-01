# {{ datalens-short-name }} roles

To grant a user access to {{ datalens-short-name }}, assign them a role. With roles, you can define user permissions in a {{ datalens-short-name }} instance.

{% include [roles-datalens-creator](../../_includes/roles-datalens-creator.md) %}

{% include [roles-datalens-admin-org](../../_includes/roles-datalens-admin-org.md) %}

{% include [datalens-instances-user](../../_includes/roles-datalens-user.md) %}

{% include [datalens-instances-admin](../../_includes/roles-datalens-admin.md) %}

{% note info %}

The `{{ roles-datalens-instances-user }}` and `{{ roles-datalens-instances-admin }}` roles also provide the permission to view folders in the cloud. Instead of them, we recommend using the `{{ roles-datalens-creator }}` and `{{ roles-datalens-admin }}` roles, respectively.

{% endnote %}
