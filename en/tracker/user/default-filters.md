# Finding my issues

To find the issues you're working on, use the _system filters_ preset. The filters return the lists of issues where you were specified as an assignee, reporter, or in other roles. To search for issues in the list, use [standard filters](#sys_filters) or [add search criteria](#add-condition).

## Using standard filters {#sys_filters}

Find your issues using preset system filters.

1. Go to the page with the issue list. To do this, in the left-hand panel, open ![](../../_assets/tracker/svg/tasks.svg) **{{ ui-key.startrek.ui_components_NavigationBar.issue-lists-menu-item }}** or follow the [link]({{ link-tracker }}issues).

1. In the drop-down list, select one of the options:

   * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-favorite }}**: Issues you [added to Favorites](favourites.md#task-fav).

   * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-my-issues }}**: Issues in which you are reporter, assignee, or follower.

   * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-author }}**: Issues you created.

   * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-assignee }}**: Issues in which you are assignee.

   * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-follower }}**: Issues you are [subscribed](subscribe.md#section_xt5_xrv_jz) to.

   * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-waiting }}**: Issues you were [invited to comment](comments.md#call-comment) on.

   * **{{ ui-key.startrek.ui_components_IssuesPresetSelect.preset_deadline }}**: Issues in which you are reporter, assignee, or follower and where:

      * Issues that have exceeded their deadlines in the past two weeks.

      * The deadline will be due within a month.

1. On the filter page, you'll see the selected issue list. You can add filtering conditions, set up the list's layout, or safe the list to a file:

   * To search for issues in the list, use the **{{ ui-key.startrek.ui_components_NavigationBar_IssuesPanel.search-input-placeholder }}** bar or [add search criteria](#add-condition).


   * To group issues by a certain parameter, click ![](../../_assets/tracker/svg/group.svg) **{{ ui-key.startrek.blocks-desktop_issues-table.group-by--null }}** to the right of the search bar and select the desired parameter.


   * To save an issue list, in the top-right corner, click ![](../../_assets/tracker/svg/icon-export-tasks.svg) **{{ ui-key.startrek.ui_components_FilterExportMenu.menu-item-export }}** and select the download file format or simply copy the list to the clipboard.

   * To collapse the panel with the filter list, in the top-right corner of the page, click ![](../../_assets/tracker/svg/icon-parameters.svg) **{{ ui-key.startrek.ui_components_PageIssues_FilterInputTypeSwitch.parameters }}**.

## Filtering by parameters {#quick-filters}

{% note info %}

Filtering by parameters is only available in the {{ tracker-name }} web interface.

{% endnote %}

Use filtering by parameters to narrow down your issue list and display only those issues that match the selected parameters. The filter by parameters buttons are above the issue list:

* To filter issues by their [resolution](../manager/create-resolution.md), click **{{ ui-key.startrek-backend.fields.issue.resolution-key-value }}** and select relevant values from the list.

* To use [advanced search parameters](#add-condition), click ![](../../_assets/tracker/svg/add-filter.svg) **{{ ui-key.startrek.ui_components_filter-pane_FieldsSelectButton.add-filter-field-button-title }}** and select a field.

As a result, only the issues that meet the selected filter criteria are shown in the list.

## Adding search parameters {#add-condition}

#### Searching by parameters

To find issues by the parameters that can't be set using the system filters, add search conditions.

1. In the top-right corner of the page, click ![](../../_assets/tracker/svg/icon-parameters.svg) **{{ ui-key.startrek.ui_components_dashboard_IssuesStatEditor.editor-source-radio-parameters }}**. A panel with the specified filtering parameters will be shown under the search bar.

1. Click ![](../../_assets/tracker/svg/add-filter.svg) **{{ ui-key.startrek.ui_components_filter-pane_FieldsSelectButton.add-filter-field-button-title }}**.

1. Select an issue parameter, set its value, and click **{{ ui-key.startrek.ui_components_filter-field.save-button }}**.

   Any issues that don't meet your criteria are filtered out of the list.


1. If you need to refine the search conditions, add more parameters.

1. You can reset the search parameters by clicking **{{ ui-key.startrek.ui_components_filter-pane.reset-button }}** above the issue list.

For example, you can search issues by their name or description:

* To find issues that contain a particular phrase in their name, add the **{{ ui-key.startrek-backend.fields.issue.summary-key-value }}** parameter to your search and enter the text to search for.

* To find issues that contain a particular phrase in their description, add the **{{ ui-key.startrek-backend.fields.issue.description-key-value }}** parameter to your search and enter the text to search for.


{% note info %}

If you set multiple search conditions, only those issues that meet all the conditions at the same time will be found.

{% endnote %}

#### Query language

If you can't set search conditions using the issue parameters, use the request:

1. Click ![](../../_assets/tracker/svg/query-language.svg) **{{ ui-key.startrek.ui_components_dashboard_FilterEditor.editor-source-radio-query }}** in the top-right corner. All the search parameters that you set by quick filters and conditions, will be shown in the search bar.

1. Use the [query language](query-filter.md) to add parameters.

1. Click **{{ ui-key.startrek.blocks-desktop_issues-filter.action--apply-query }}**.

Any issues that don't meet your criteria are filtered out of the list.


#### Saving filters

To save the issue search conditions as a filter:

1. In the panel under the issue list, click ![](../../_assets/tracker/svg/save-filter.svg) **{{ ui-key.startrek.blocks-desktop_issues-filter-update-modal.action_submit }}**.

1. Set the name and category for the filter.

Your saved filters will be available in the **{{ ui-key.startrek.ui_components_FilterEditorPane.all-issues-filter-title }}** checkbox under **{{ ui-key.startrek-backend.messages.user.named.request.folder.my }}**.
