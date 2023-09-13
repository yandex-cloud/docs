# Creating an issue filter

If you need something more advanced than the preset {{ tracker-name }} [system filters](default-filters.md), you can create your own filter to search for issues in and sort issues by title, description, comments, field values, update dates, and other parameters. For example, you can use custom filters to find all issues in queues where you have the author or assignee status.

You can use your saved filters to pick issues for [dashboards](dashboard.md) and [agile boards](../manager/create-agile-board.md).

## Creating a filter {#create}

### Step 1. Open the issue list {#open-tasks}

The open all the issues that are available to you in {{ tracker-name }}:

* In the left-hand panel, open ![](../../_assets/tracker/svg/tasks.svg) **{{ ui-key.startrek.ui_components_NavigationBar_IssuesPanel.caption }}**, then at the bottom of the window, click **{{ ui-key.startrek.ui_components_NavigationBar_IssuesPanel.all-items-link }}**.
* Or follow the [direct link]({{ link-tracker }}issues).

### Step 2. Set filter criteria {#set-conditions}

There are several ways to set the filter conditions:

- **Filtering by parameters**

   Use the filter by parameters buttons above the issue list. To filter issues by their [resolution](../manager/create-resolution.md), click **{{ ui-key.startrek-backend.fields.issue.resolution-key-value }}** and select relevant values from the list.


- **Searching by parameter**

   Add the issue parameters and specify their possible values:

   1. Click ![](../../_assets/tracker/svg/add-filter.svg) **{{ ui-key.startrek.ui_components_filter-pane_FieldsSelectButton.add-filter-field-button-title }}** above the issue list.

   1. Select an issue parameter and then set its value.

      Any issues that don't meet your criteria are filtered out of the list.
   1. If you need to refine the search conditions, add more parameters.

   For example, you can search issues by their name or description.

   - To find issues that contain a particular phrase in their name, add the **{{ ui-key.startrek-backend.fields.issue.summary-key-value }}** parameter to your search and enter the text to search for.

   - To find issues that contain a particular phrase in their description, add the **{{ ui-key.startrek-backend.fields.issue.description-key-value }}** parameter to your search and enter the text to search for.


   {% note info %}

   If you set multiple search conditions, only those issues that meet all the conditions at the same time will be found.

   {% endnote %}

- **{{ ui-key.startrek.ui_components_dashboard_FilterEditor.editor-source-radio-query }}**

   You can use the query language to set special conditions that are not accessible via regular parameters. For instance, you can find issues that have been opened within the last week. For more information about the query language, see [{#T}](query-filter.md).

   1. In the top-right corner of the page, click ![](../../_assets/tracker/svg/query-language.svg) **{{ ui-key.startrek.ui_components_dashboard_FilterEditor.editor-source-radio-query }}**. All the search parameters that you set by quick filters and conditions, will be shown in the search bar.

   1. Use the [query language](query-filter.md) to add parameters.

      Any issues that don't meet your criteria are filtered out of the list.

### Step 3. Set up the layout for the issue list

- If you want to hide or display certain issue parameters, to the right above the list, click ![](../../_assets/tracker/svg/list-settings.svg) **{{ ui-key.startrek.ui_components_PageAgileBoard_PageAgileBoardHeader.settings }}**, select the parameters, and click **{{ ui-key.startrek.ui_components_FilterFieldsSelect.applyChanges }}**.

- To group issues by a certain parameter, click ![](../../_assets/tracker/svg/group.svg) **{{ ui-key.startrek.blocks-desktop_issues-table.group-by--null }}** above the list and select the parameter.

- To collapse the panel with the filter list, in the top-right corner, click ![](../../_assets/tracker/svg/icon-parameters.svg) **{{ ui-key.startrek.ui_components_PageIssues_FilterInputTypeSwitch.parameters }}**.

### Step 4. Save filters

If you often use a filter, save it. Your saved filters will be available in the **{{ ui-key.startrek.ui_components_filter-pane.all-issues-filter-title }}** checkbox under **{{ ui-key.startrek-backend.messages.user.named.request.folder.my }}**.

1. Click **{{ ui-key.startrek.blocks-desktop_issues-filter-save-modal.action_submit }}** above the issue list.

1. Set the filter name and select a category to save it with.

1. Click **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_fields.change-category-form--change }}**.

To save a filtered issue list, in the top-right corner, click ![](../../_assets/tracker/svg/icon-export-tasks.svg) **{{ ui-key.startrek.ui_components_FilterExportMenu.menu-item-export }}** and select the download file format or simply copy the list to the clipboard.

## Editing a filter {#edit}

#### Changing filter parameters

1. In the **{{ ui-key.startrek.ui_components_page-issues_touch.all-issues-filter-title }}** field at the top of the window, select your filter.

1. [Change the issue search criteria](#set-conditions) using quick filters, parameters, or the query language.

1. Click **{{ ui-key.startrek.blocks-desktop_issues-filter-save-modal.action_submit }}** above the issue list:

   * To save the filter with the current name, click **{{ ui-key.startrek.ui_components_filter-pane.action-title-save }}**.

   * To save the filter under a different name, click **{{ ui-key.startrek.ui_components_filter-pane.action-title-save-as }}**. Then enter the filter name, select the category, and click **{{ ui-key.startrek.blocks-desktop_issues-filter-update-modal.action_submit }}**.


#### Removing filters

1. In the **{{ ui-key.startrek.ui_components_page-issues_touch.all-issues-filter-title }}** field at the top of the window, select your filter.

1. Delete your filter using one of the methods:

   * To the right of the filter name, click ![](../../_assets/tracker/svg/icon-filter-delete.svg) **{{ ui-key.startrek.blocks-desktop_issues-filter-update-modal.filter-remove-confirm-submit }}**.

   * In the top-right corner of the page, click ![](../../_assets/tracker/svg/actions.svg) **{{ ui-key.startrek.ui_components_FilterExportMenu.title }}**, then select ![](../../_assets/tracker/svg/icon-filter-delete.svg) **{{ ui-key.startrek.blocks-desktop_issues-filter-update-modal.filter-remove-confirm-submit }}**.