# Creating an issue filter

If you need something more advanced than the preset {{ tracker-name }} [system filters](default-filters.md), you can create your own filter to search for issues in and sort issues by title, description, comments, field values, update dates, and other parameters. For example, you can use custom filters to find all issues in queues where you have the author or assignee status.

You can use your saved filters to pick issues for [dashboards](dashboard.md) and [agile boards](../manager/create-agile-board.md).

## Creating a filter {#create}

### Step 1. Open the issue list {#open-tasks}

The open all the issues that are available to you in {{ tracker-name }}:

* On the left panel, open ![](../../_assets/tracker/svg/tasks.svg) **Issues**, then at the bottom of the window, click **All issues**.
* Or follow the [direct link]({{ link-tracker }}issues).

### Step 2. Set filter criteria {#set-conditions}

There are several ways to set the filter conditions:

- **Filtering by parameters**

   Use the filter by parameters buttons above the issue list. To filter issues by their [resolution](../manager/create-resolution.md), click **Resolution** and select relevant values from the list.


- **Searching by parameter**

   Add the issue parameters and specify their possible values:

   1. Above the issue list, click ![](../../_assets/tracker/svg/add-filter.svg) **Add a field for filtering**.

   1. Select an issue parameter and then set its value.

      Any issues that don't meet your criteria are filtered out of the list.
   1. If you need to refine the search conditions, add more parameters.

   For example, you can search issues by their name or description.

   - To find issues that contain a particular phrase in their name, add the **Issue** parameter to your search and enter the text to search for.

   - To find issues that contain a particular phrase in their description, add the **Description** parameter to your search and enter the text to search for.


   {% note info %}

   If you set multiple search conditions, only those issues that meet all the conditions at the same time will be found.

   {% endnote %}

- **Query language**

   You can use the query language to set special conditions that are not accessible via regular parameters. For instance, you can find issues that have been opened within the last week. For more information about the query language, see [{#T}](query-filter.md).

   1. Click ![](../../_assets/tracker/svg/query-language.svg) **Query language** in the upper-right corner. All the search parameters that you set by quick filters and conditions, will be shown in the search bar.

   1. Use the [query language](query-filter.md) to add parameters.

      Any issues that don't meet your criteria are filtered out of the list.

### Step 3. Set up the layout for the issue list

- If you want to hide or display certain issue fields, click ![](../../_assets/tracker/svg/list-settings.svg) **Settings**, select the fields, and click **Apply**.

- To group issues by a certain field, click ![](../../_assets/tracker/svg/group.svg) **No grouping** above the list and select the desired field.

- To collapse the panel with the filter list, in the upper-right corner, click ![](../../_assets/tracker/svg/icon-parameters.svg) **Parameters**.

### Step 4. Save filters

If you often use a filter, save it. Your saved filters will be available in the **All issues** checkbox in the **My** section.

1. Click **Save** above the issue list.

1. Set the filter name and select a category to save it with.

1. Click **Save**.

If you want to save a filtered issue list, in the upper-right corner, click ![](../../_assets/tracker/svg/icon-export-tasks.svg) **Export** and select the format of the file to download or simply copy the list to the clipboard.

## Editing a filter {#edit}

#### Changing filter parameters

1. In the upper part of the window, in the **All issues** field, select your filter.

1. [Change the issue search criteria](#set-conditions) using quick filters, parameters, or the query language.

1. Click **Save** above the issue list:

   * To save the filter with the current name, click **Save**.

   * To save the filter with a different name, click **Save as new**. Then enter the filter name, select the category, and click **Save**.


#### Removing filters

1. In the upper part of the window, in the **All issues** field, select your filter.

1. Delete your filter using one of the methods:

   * To the right of the filter name, click ![](../../_assets/tracker/svg/icon-filter-delete.svg) **Delete**.

   * In the upper-right corner of the page, click ![](../../_assets/tracker/svg/actions.svg) **Filter actions**, then select ![](../../_assets/tracker/svg/icon-filter-delete.svg) **Delete**.