#### datalens.instances.user {#datalens-instances-user}

The `{{ roles-datalens-instances-user }}` role grants access to {{ datalens-short-name }} as a user with permissions to create, read, and edit objects according to the [permissions to objects](../datalens/security/manage-access.md).

After you assign a service role, you can grant the user permissions to objects and directories in {{ datalens-short-name }}.

{% note tip %}

Even if you have not switched to [workbooks and collections](../datalens/workbooks-collections/index.md#enable-workbooks) yet, we recommend using the `{{ roles-datalens-creator }}` role instead of `{{ roles-datalens-instances-user }}`. For navigation across folders, the new role functions as the old one. The only difference is that `{{ roles-datalens-instances-user }}` allows viewing all organization folders, so it is safer to use `{{ roles-datalens-creator }}`.

{% endnote %}