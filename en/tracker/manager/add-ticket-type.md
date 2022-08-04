# Configuring issue types

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

A queue may include different types of issues, such as <q>New feature</q>, <q>Improvement</q>, or <q>Bug</q>. Each type of issue has its own workflow and set of resolutions. You can change the parameters of the available types of issues in the queue settings.

{% if audience == "external" %}

## Creating an issue type {#create-ticket-type}

{% note warning %}

Only the [administrator](../role-model.md) can create new issue types. Once created, an issue type can't be deleted or edited.

{% endnote %}

The most popular issue types are available in {{ tracker-name }} by default. If you need something different, create a new one:

1. Make sure you are logged in to {{ tracker-full-name }} as an [administrator](../role-model.md).

1. On the {{ tracker-name }} top panel, select ![](../../_assets/tracker/icon-settings.png) → **Configure {{ tracker-name }}**.

1. Go to the **Issue types** tab.

1. Click **Add issue type**.

1. Fill in the fields and click **Create**.

{% endif %}

## Adding an issue type to a queue {#section_mvh_5yb_gz}

To create a new issue type:

1. Go to the queue page.

1. Select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **Issue types** tab.

1. Click **Add issue type**.

1. Configure the settings:
    - **Issue type**: Select one of the available types.
    {% if audience == "external" %}The most popular issue types are available in {{ tracker-name }} by default. If you don't see the type you need, your admin can [create one](#create-ticket-type).{% endif %}
    - **Workflow**: Set the workflow to apply to this type of issue. Select one of the available workflows or [create a new one](add-workflow.md) based on any of them.
    - **Resolutions**: Select possible resolutions.
    {% if audience == "external" %}The most popular resolutions are available in {{ tracker-name }} by default. If you don't see the resolution you need, your admin can [create one](create-resolution.md).{% endif %}
    {% if audience == "internal" %}If the desired issue type or resolution isn't available in {{ tracker-name }}, send a request to create them via the [form](../user/create-param.md#section_bjz_3p4_xgb).{% endif %}

1. The **Statuses and transitions** section shows the main settings of the selected workflow. If necessary, you can edit it or create a copy.

1. Click **Save** at the bottom of the tab.

## Removing an issue type from the queue {#section_czj_jqm_2bb}

If one of the issue types is no longer needed in the queue, you can remove it.

{% note warning %}

You can only remove types that are not used for any of the issues in the queue.

{% endnote %}

To remove an issue type from a queue:

1. Go to the queue page.

1. Select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **Issue types** tab.

1. To remove the type, click ![](../../_assets/tracker/remove-task-type.png).

1. Click **Save** at the bottom of the tab.

