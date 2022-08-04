# Configuring resolutions

A resolution is an issue attribute that specifies why the issue was closed. For example, an issue can be closed because it was completed (the <q>Resolved</q> resolution) or because it's a duplicate of another issue (the <q>Duplicate</q> resolution).



## Creating resolutions {#create-resolution}

{% note warning %}

Only the [administrator](../role-model.md) can create new resolutions. Once created, a resolution can't be deleted or edited.

{% endnote %}

The most popular resolutions are available in {{ tracker-name }} by default. If you need something different, create a new one:

1. Make sure you are logged in to {{ tracker-full-name }} as an [administrator](../role-model.md).

1. On the {{ tracker-name }} top panel, select ![](../../_assets/tracker/icon-settings.png) → **Configure {{ tracker-name }}**.

1. Go to the **Resolutions** tab.

1. Click **Create resolution**.

1. Fill in the fields and click **Create**.


## Removing resolutions from a queue {#delete-resolution}

{% note warning %}

You cannot remove a resolution if there are issues within the queue that depend on it.

{% endnote %}

1. You can use filters to [find all issues in a queue](quick-filters.md) that contain the resolution you wish to remove. Then you can change the resolution of your issues or update their status.

1. Open the queue page.

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **Issue types** tab.

1. Remove resolutions in the issue types where the resolution is set.

