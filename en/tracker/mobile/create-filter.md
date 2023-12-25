# Creating an issue filter

If you need something more advanced than the preset {{ tracker-name }} [system filters](default-filters.md), you can create your own filter to search for issues in and sort issues by title, description, comments, field values, update dates, and other parameters. For example, you can use custom filters to find all issues in queues where you have the author or assignee status.

To create a filter:

1. Open the issue list.

1. In the top-right corner, click ![](../../_assets/tracker/svg/gantt-settings-button.svg) → ![](../../_assets/tracker/svg/filter-mobile.svg) **Filters**.

1. Select an issue parameter and then set its value.

1. Click **Apply**. Any issues that don't meet your criteria are filtered out of the list.

1. If you need to refine the search conditions, add more parameters.

{% note info %}

To save the filter, use the {{ tracker-name }} web version: Your saved filters will be available in the **{{ ui-key.startrek.ui_components_agile_common_AgileFilters.all-issues-filter-title }}** checkbox under **{{ ui-key.startrek-backend.messages.user.named.request.folder.my }}**.

{% endnote %}