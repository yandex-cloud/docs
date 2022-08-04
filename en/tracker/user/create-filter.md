# Creating an issue filter

If you need something more advanced than the preset [system filters](default-filters.md), you can create your own filter to search for issues in {{ tracker-name }} and sort issues by title, description, comments, field values, update dates, and other parameters. For example, you can use custom filters to find all issues in queues where you have the author or assignee status.

You can use your saved filters to pick issues for [dashboards](dashboard.md) and [agile boards](../manager/create-agile-board.md).

## Creating a filter {#create}

### Step 1. Create a filter

On the {{ tracker-name }} top panel, select **Issues** → **Find issues**.

### Step 2. Set filter criteria {#set-conditions}

There are several ways to set filter parameters:

- **Quick filters**

    Use quick filter buttons at the top of the page:

    ![image](../../_assets/tracker/quick-filters-new.png)

    1. Resolution filters. Select one of the options:

        - **All**: The page displays all issues, regardless of the resolution.

        - **Without resolution**: The page only displays issues that aren't resolved.

        - **With resolution**: The page only displays resolved issues.

    1. Role-based filters. You can apply multiple filters at the same time:

        - **Reported by me**

        - **Assigned to me**

        - **Followed by me**

    As a result, only the issues that meet the selected filter criteria are shown in the list.

- **Searching by parameter**

    Add issue parameters and set their possible values:

    1. Click **Add condition** above the issue list.

    1. Select an issue parameter and set its value.

        Any issues that don't meet your criteria are filtered out of the list.


    1. You can add multiple parameters for a more thorough search.

    For example, you can search for issues by name or description:

    - To find issues that contain a particular phrase in their name, add the **Issue** parameter to your search and enter the text to search for.

    - To find issues that contain a particular phrase in their description, add the **Description** parameter to your search and enter the text to search for.

    ![](../../_assets/tracker/filters-condition.png)

    {% note info %}

    If you define multiple parameters, only issues that contain all of them are found.

    {% endnote %}

- **Query language**

    You can use the query language to set special conditions that are not accessible via regular parameters. For instance, you can find issues that have been opened within the last week. For more information about the query language, see [{#T}](query-filter.md).

    1. Click **Query language** in the upper-right corner. All search parameters specified in issue fields and quick filters are displayed in the query field.

    1. Use the [query language](query-filter.md) to add parameters.

    1. Click **Apply**.

        Any issues that don't meet your criteria are filtered out of the list.

### Step 3. Configure the appearance of the issue list

- If you want to hide or display certain issue fields, click **Configure columns**, select the fields, and click **Save**.

- To group issues by a certain field, click **Not grouped** to the right of the list and select the desired field.

- To collapse the left-side panel with the filter list, click ![](../../_assets/tracker/button-collapse.png) at the top of the panel.

### Step 4. Save your filter

You can save your filter so you don't have to set it up each time you want to use it. Your saved filters are available in **Issues** → **My filters** on the {{ tracker-name }} top panel.

1. Click **Save filter** above the issue list.

1. Choose an appropriate name for your filter and a folder to save it to.

1. Click **Save**.

If you want to save a filtered issue list, click ![](../../_assets/tracker/icon-download.png) to the right above the list and select the format of the file to download or simply copy the list to the clipboard.

## Editing a filter {#edit}

#### Changing filter parameters

1. Go to **Issues** → **My filters** on the {{ tracker-name }} top panel and choose your filter.

1. [Change the issue search criteria](#set-conditions) using quick filters, parameters, or the query language.

1. Click **Save filter** above the issue list.

    To save a filter under a different name, click ![](../../_assets/tracker/icon-save-as.png) and rename it.

#### Setting up filter access

You can share saved filters with your colleagues. By default, other employees can only view your filters after receiving a link from you. To change access rights:

1. Go to **Issues** → **My filters** on the {{ tracker-name }} top panel and choose your filter.

1. Hover over the filter on the left-hand panel and click ![](../../_assets/tracker/icon-settings.png).

1. Access is open to all employees by default. If you want to restrict access to the filter, delete the **All employees** group from the list.

1. Add users you want to grant access to.

1. In the **Access rights** column, choose the access rights you want to grant:

    - **View**: Lets users view your filter after receiving a link. They won't be able to edit the filter in any way.

    - **Edit**: Lets users view and edit your filter after receiving a link.

    - **Add to shared folder**: Places the filter in the **Shared** folder on the left-hand panel to be accessed by other users. This doesn't affect any access rights to the filter itself.

1. Click **Save**.

#### Removing filters

1. Go to **Issues** → **My filters** on the {{ tracker-name }} top panel and choose your filter.

1. Hover over the filter on the left-hand panel and click ![](../../_assets/tracker/icon-settings.png).

1. In the filter card in the bottom-left corner, click ![](../../_assets/tracker/icon-delete.png) and confirm the deletion.

