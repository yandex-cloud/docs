#### datalens.instances.admin {#datalens-instances-admin}

This `{{ roles-datalens-instances-admin }}` role allows you to access {{ datalens-short-name }} as a {{ datalens-short-name }} instance administrator. Administrators have full access to all objects and folders in {{ datalens-short-name }}, as well as to [{{ datalens-short-name }}]({{ link-datalens-settings }}) settings.

{% note tip %}

Even if you have not switched to [workbooks and collections](../datalens/workbooks-collections/index.md#enable-workbooks) yet, we recommend using the `{{ roles-datalens-admin }}` role instead of `{{ roles-datalens-instances-admin }}`. For navigation across folders, the new role functions as the old one. The only difference is that `{{ roles-datalens-instances-admin }}` allows viewing all organization folders, so it is safer to use `{{ roles-datalens-admin }}`.

{% endnote %}