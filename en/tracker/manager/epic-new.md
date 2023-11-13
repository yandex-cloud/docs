# Epics

An epic is an [issue type](add-ticket-type.md) that allows you to group issues sharing the same subject. Epics can include issues from different queues and sprints.

Epics are convenient for breaking down your activities if you follow the Agile methodologies. The largest issues can be epics. You break these down into stories, and stories into issues for assignees.

{% note info %}

An epic cannot have a parent issue.
An epic cannot be another epic's sub-epic.
You can only create an epic in a queue that has epic as an issue type.

{% endnote %}

## Creating an epic on a board {#create-epic}

1. On the board, click ![](../../_assets/tracker/svg/icon-add.svg) **{{ ui-key.startrek.blocks-desktop_m-head.new-issue }}**.
1. Go to the page with the full issue creation form. To do this, click ![](../../_assets/tracker/svg/open-full.svg) (**{{ ui-key.startrek.ui_components_create-issue-popup_CreateIssuePageLink.open-create-form }}**).
1. Fill in all the required issue fields. In the **{{ ui-key.startrek.components_FormCreateIssue.field--type }}** field, specify `{{ ui-key.startrek-backend.fields.issue.epic }}`.
1. Click **{{ ui-key.startrek.ui_components_CreateIssueForm.create-issue }}**.

## Adding an issue to an epic {#add-to-epic}

You can add an issue to an epic via a [link](../user/ticket-links.md) either from the epic page or issue page.

### Adding an issue from the epic page {#add-from-epic}

1. On the epic page under **{{ ui-key.startrek.ui_components_issue-links_InternalLinksCollapse.relations }}**, click **{{ ui-key.startrek.ui_components_CreateIssueLinkButton.add-relation }}**.

1. Select the **{{ ui-key.startrek-backend.fields.issue.links.relationship.has.epic }}** link type.

1. Specify the [issue key](../user/create-ticket.md#key).

### Adding an issue from the issue page {#add-from-task}

1. On the issue page under **{{ ui-key.startrek.ui_components_issue-links_InternalLinksCollapse.relations }}**, click **{{ ui-key.startrek.ui_components_CreateIssueLinkButton.add-relation }}**.

1. Select the **{{ ui-key.startrek-backend.fields.issue.epic }}** link type.

1. Specify the [epic key](../user/create-ticket.md#key).

{% note warning %}

An issue can belong to only one epic.

{% endnote %}


## Creating a new issue in an epic {#create-in-epic}

1. On the epic page under **{{ ui-key.startrek.blocks-desktop_b-related-issues__title.is_epic_of }}**, click ![](../../_assets/tracker/svg/icon-add.svg) **{{ ui-key.startrek.blocks-desktop_calendar-editor--overrides-modal.add-button }}**.
1. Fill in the required fields and save the issue.

## Removing an issue from an epic {#remove-from-epic}

You can remove an issue from an epic either on the issue page or on a board.

### Removing an issue on the issue page {#remove-from-task}

On the issue page under **{{ ui-key.startrek.ui_components_issue-links_InternalLinksCollapse.relations }}**, remove the link to the epic in the **{{ ui-key.startrek-backend.fields.issue.epic }}** section.

### Removing an issue on a board {#remove-on-board}

Open the board, [group issues by epic](#group-by-epic), and drag the issue card to **{{ ui-key.startrek.ui_components_IssuesGroupHeader.no-epic }}**.

## Grouping issues by epic {#group-by-epic}

1. In the upper-right corner of the board page, click ![](../../_assets/tracker/svg/group.svg).
1. In the list of options, select **{{ ui-key.startrek-backend.fields.issue.epic }}**.

## Filtering issues by epic {#filter-by-epic}

You can set up issue display by epic on your board or queue page.

### Filtering issues on a board {#filter-on-board}

To filter issues by epic on your board:

1. In the top-right corner, click ![](../../_assets/tracker/svg/filter.svg)&nbsp;**{{ ui-key.startrek.ui_components_page-issues_touch_FilterSettingsMenu.item-filters }}**. The filter setup panel will be shown above the board's columns.
1. Click ![](../../_assets/tracker/svg/add-filter.svg). Select **{{ ui-key.startrek-backend.fields.issue.epic }}**.
1. In the dialog box that opens, enter the key of the epic by which you want to filter issues.

### Filtering issues on the queue page {#filter-in-queue}

You can also filter issues in a queue or on the issue page using the [query language](../user/query-filter.md):

1. In the top-right corner of the page, click ![](../../_assets/tracker/svg/query-language.svg) **{{ ui-key.startrek.ui_components_dashboard_FilterEditor.editor-source-radio-query }}**. All the current search parameters that were set using quick filters and conditions will be shown in the query string.
1. Add the filtering conditions by epic to the string, e.g.:

   * Show all issues that have an epic:

      ```
      	epic: notEmpty()
      ```

   * Show all issues from the epic with the `EPIC-1` key:

      ```
      	epic: "EPIC-1"
      ```
