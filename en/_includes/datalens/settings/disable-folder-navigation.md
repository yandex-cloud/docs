You can disable folder navigation after you switch to [workbooks and collections](../../../datalens/workbooks-collections/index.md) for organizing objects. Before you disable it, [migrate](../../../datalens/workbooks-collections/migrations.md) all objects in your folders to workbooks or delete them.

Folders can be disabled by the {{ datalens-short-name }} instance [administrator](../../../datalens/security/roles.md#datalens-admin) (the `{{ roles-datalens-admin }}` role).

{% note warning %}

Once you disable folder navigation, it cannot be re-enabled.

{% endnote %}

To disable folder navigation:

1. In the left-hand panel, select ![image](../../../_assets/console-icons/sliders.svg) **Service settings**.
1. Select the **Navigation** tab.
1. In the **Disable folder navigation** section, click **Disable folder navigation**.
1. In the window that opens, you will see a list of the remaining objects in the folders, which you need to migrate to workbooks or delete before disabling the folders. If the list of objects is empty, you can disable navigation. To do this, click **Disable**.