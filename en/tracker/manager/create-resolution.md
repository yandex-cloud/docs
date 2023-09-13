# Setting up resolutions

Resolution: A resolution is an issue attribute that specifies why the issue was closed. For example, an issue can be closed because it was completed (the <q>{{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }}</q> resolution) or because it is a duplicate of another issue (the <q>{{ ui-key.startrek-backend.applinks.samsara.resolution.duplicate }}</q> resolution).


## Creating a resolution {#create-resolution}

{% note warning %}

Only an [administrator](../role-model.md) can create new resolutions. Once you have created a resolution, you can't delete or edit it.

{% endnote %}

The most popular resolutions are available in {{ tracker-name }} by default. If there is no matching resolution among them, create a new resolution.

1. Make sure you are authorized in {{ tracker-full-name }} as an [administrator](../role-model.md).

1. In the right-hand panel, select ![](../../_assets/tracker/svg/admin.svg) **{{ ui-key.startrek.blocks-desktop_b-page-queue.cp }}** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.tracker-settings }}**.

1. Click the **{{ ui-key.startrek.blocks-desktop_page-admin.tab-title--resolutions }}** tab.

1. Click **{{ ui-key.startrek.blocks-desktop_page-admin-tab.create--resolutions }}**.

1. Fill in the fields and click **{{ ui-key.startrek.blocks-desktop_b-form-new-component.button-create }}**.


## Remove a resolution from a queue {#delete-resolution}

{% note warning %}

You can't delete a resolution if the queue includes issues that use this resolution.

{% endnote %}

1. Use filters to [find all the issues in the queue](quick-filters.md) that include the resolution to be deleted. After that, change the resolution for such issues or update their status.

1. Open the queue page.

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Click the **{{ ui-key.startrek.blocks-desktop_page-admin.tab-title--types }}** tab.

1. Delete the resolution from the issue types where the resolution was selected.