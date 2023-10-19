# Working with issues on a board

Issues are displayed on the board as cards with basic issue parameters. You can [customize](#cards) the appearance of cards on the board.

To open the board page, select ![](../../_assets/tracker/svg/boards.svg)&nbsp;**{{ ui-key.startrek.ui_components_NavigationBar.boards }}** in the left-hand panel and click the relevant board in the list.

## Configuring issue cards {#cards}

Customize the layout of issue cards to see only relevant parameters on the board or quickly find issues with specific tags and components.

By default, the issue card displays the values of such fields as the key, name, assignee, and some others. To set up the fields to be displayed on the issue card:

1. On the board page, click ![](../../_assets/tracker/svg/actions.svg) → **{{ ui-key.startrek.ui_components_agile_common_FieldsSelect.fields-settings }}** in the right-hand corner of the search, sort, and group panel.

1. Select the issue fields to be shown on the card. You can add or remove any field, except for the issue name (the **Issue** field) that can't be removed.

1. Click **Apply**.

1. To highlight certain tags or issue components with colors:

   1. Set up the card to show the **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.field-tags }}** or the **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.field-components }}** field.

   2. On the issue card, click the name of the tag or component and select its color.

   This tag or component will be highlighted by color on all cards.

## Managing issues {#manage}

Managing issues on {{ tracker-name }} boards is like working with stickers on a real board:

* Issue cards are distributed across columns according to their statuses. To change the issue status, drag it to the relevant column.

   {% note info %}

   You won't be able to move a card to a column unless the [workflow](./workflow.md) of the queue that the issue belongs to supports switching from the current status to the new status.

   {% endnote %}

* To move a card within the column, hover over it, click ![](../../_assets/tracker/svg/actions.svg) in the top-right corner, and select **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardIssue.issue-actions--move-up }}** or **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardIssue.issue-actions--move-down }}**.

* To delete an issue from the board, in the top-right corner of the card, click ![](../../_assets/tracker/svg/actions.svg), then select **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardIssue.issue-actions--delete-from-board }}**.

   {% note info %}

   If you delete an issue from the project, the issue will also be deleted from the [project issue list](project-list.md).

   {% endnote %}

* To edit the parameters or comment on the issue, click the issue's card and make changes on the right panel.

## Filtering issues {#filter}

If there are too many issues on the board, you can always hide some of them using filters. You can select a saved filter or create a new one: You can also combine several filters.

To create a filter on the board:

1. In the top-right corner, click ![](../../_assets/tracker/svg/filter.svg)&nbsp;**{{ ui-key.startrek.ui_components_page-issues_touch_FilterSettingsMenu.item-filters }}**. The filter setup panel will be shown above the board's columns.

1. Click ![](../../_assets/tracker/svg/add-filter.svg). Select the parameter to filter your issues and set the value for it.

   Add multiple parameters to the filter if needed.

1. To reset the filter, click ![](../../_assets/tracker/svg/clear-filter.svg)&nbsp;**{{ ui-key.startrek.ui_components_agile_common_AgileFilters.reset-button }}**.

1. To save the filter, click ![](../../_assets/tracker/svg/save-filter.svg)&nbsp;**{{ ui-key.startrek.ui_components_agile_common_AgileFilters.action-title-save }}**:

   1. Name the filter.

   1. Select for whom the filter will be fixed at the top of the board: only for yourself or for every user. Fixed filters are shown as buttons at the top of the board.

   1. Click **{{ ui-key.startrek.ui_components_agile_common_AgileFilters.action-title-save }}**.

   Saved filters are available for all users.

1. You can pin the saved filters at the top of the board for quick access.

   {% note info %}

   Once a filter is created, you can only pin it on the board for yourself. If you want the filter to be displayed to all the board users, you will have to create it again.

   {% endnote %}

   1. Click ![](../../_assets/tracker/svg/settings.svg) in the filters panel or click ![](../../_assets/horizontal-ellipsis.svg) in the top-right corner of the page and select **{{ ui-key.startrek.ui_components_agile_common_QuickFilterPopup.filters-manage }}**.

   1. Select the filters to be shown on the board and click **{{ ui-key.startrek.blocks-desktop_issues-filter.action--apply-query }}**.

1. To edit or delete a saved filter, in the top-right corner, click ![](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.startrek.ui_components_agile_common_QuickFilterPopup.filters-manage }}**. After that, next to the filter name, click ![](../../_assets/tracker/svg/settings.svg).

## Grouping issues {#group}

To group issues on a [board](agile-new.md) or in a [backlog](backlog.md) based on a parameter, click ![](../../_assets/tracker/svg/group.svg)&nbsp;**{{ ui-key.startrek.blocks-desktop_issues-table.group-by--null }}** at the top of the board and select the grouping parameter from the list. All issues that have the same value of the selected parameter will be combined into groups.

To reorder issues in the group, click ![](../../_assets/tracker/svg/set-order.svg) **Change order** and reorder the parameters as needed.

You can set the maximum number of issues per group:

1. To the right of the group parameter value, click ![](../../_assets/tracker/svg/actions.svg) → **Maximum number of issues**.

1. Set a limit for the number of issues.

1. Click **Save**.

You can also add issues with preset parameters to a group. To do this, click **{{ ui-key.startrek.blocks-desktop_b-agile-board.create-issue--title }}** under the list of issues in the group. This sets a value in a new or existing issue's field to group issues by. For example, <q>Assignee</q> or <q>Deadline</q>.

Restrictions:
* When grouping issues by queue, you can only create a new issue.
* When grouping issues by reporter, status, or type, you can't add a new issue.

You can move issues across groups on a [board](agile-new.md) or in a [backlog](backlog.md). When moving an issue, a new field value is set depending on the grouping criterion.

## Sorting issues on a board {#sorting}

You can sort issues on a board manually or based on preset parameters, such as priority, deadline, or assignee. To sort issues, click ![](../../_assets/tracker/svg/sorting.svg)&nbsp;**{{ ui-key.startrek.ui_components_dashboard_IssuesStatEditor.editor-sort-by-field-label }}** at the top of the board and select the appropriate parameter from the list. Next to the sorting button, there is a button that allows you to manage the sorting direction.

## Mass editing of issues {#bulk}

You can make bulk changes to issues on a board. Open an issue card on the board, click ![](../../_assets/tracker/svg/actions.svg) → **{{ ui-key.startrek.ui_components_agile_common_IssueActionsMenu.select-issue }}** and then click other issues to perform the same action on. Once you select all issues, choose the appropriate action in the board's bottom panel:

* Move the issue up or down the column.
* Change the issue status.
* Move the issue to a sprint or backlog.
* Change the assignee or other issue parameters.
* Remove the issue from the board.