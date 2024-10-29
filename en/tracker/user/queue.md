# Queue issue list

Each issue in {{ tracker-name }} belongs to a [queue](../queue-intro.md). Queues usually include issues belonging to similar categories. These can be issues of a project, department, or team.

To view all issues in the queue, open its page:

1. In the left-hand panel, select ![](../../_assets/tracker/svg/queues.svg) **{{ ui-key.startrek.ui_Common_smart-components_TrackerSearch.queues }}**.

1. Select a filter to show the list of queues:
   * **My queues**
   * **Owned by me**
   * **Favorites**
   * **Recently viewed**

1. If you cannot see all relevant queues, expand the list:

   * On the left-hand panel at the bottom of the page, click: **Full list...** for the selected filter.

   * To open all the queues available to you in {{ tracker-name }}, at the bottom of the window, click **All queues** or follow the [direct link]({{ link-tracker }}queues).

1. Click the name of the relevant queue.

By default, the queue page only displays active issues (**{{ ui-key.startrek.ui_Portfolios_smart-components_project-list_utils.field-name-resolution }}: {{ ui-key.startrek.ui_Portfolios_smart-components_project-list_utils.filter-macro-empty_ }}** option). You can customize which issues to display by using the [filter by parameters](../manager/quick-filters.md) buttons above the issue list.

## Adding a queue to Favorites {#queue-fav}

If you need quick access to a particular queue, add it to your Favorites:

1. Open the queue page.

1. At the top of the page, under the queue name, click ![](../../_assets/tracker/svg/favourites.svg) **{{ ui-key.startrek.ui_Common_smart-components_entity-page_macros_FavoriteButton.button-tooltip-add }}**.

To open the list of your favorite queues:

1. In the left-hand panel, select ![](../../_assets/tracker/svg/queues.svg) **{{ ui-key.startrek.ui_Common_smart-components_TrackerSearch.queues }}**.

1. In the list on the right, select the **Favorites** filter.


## Saving a list to a file {#save-file}

You can save an issue list to a file in one of the formats: XML, CSV, or XLSX.

{% note alert %}

The issue list is saved with all the filters and field settings applied.

{% endnote %}

To save your issue list to a file:

1. In the top-right corner of the page, click ![](../../_assets/horizontal-ellipsis.svg) → ![](../../_assets/tracker/svg/export.svg) **{{ ui-key.startrek.ui_Queues_pages_PageQueue_header.export }}**.

1. Select the format for saving the list.

1. Wait until the file downloads to your device.

## Gantt chart for queue issues {gantt-queue}

A Gantt chart in {{ tracker-name }} is a tool for planning work on issues on the calendar. Gantt charts show all issues and links between them. You can learn more about Gantt charts for issue queues [here](../gantt/queue.md).
