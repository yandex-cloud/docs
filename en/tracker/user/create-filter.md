# Creating an issue filter

If you need something more advanced than the preset {{ tracker-name }} [system filters](default-filters.md), you can create your own filter to search for issues in  and sort issues by title, description, comments, field values, update dates, and other parameters. For example, you can use custom filters to find all issues in queues where you have the author or assignee status.

You can use your saved filters to pick issues for [dashboards](dashboard.md) and [agile boards](../manager/create-agile-board.md).

## Creating a filter {#create}

### Step 1. Open the issue list {#open-tasks}

The open all the issues that are available to you in {{ tracker-name }}:

* On the left panel, open ![](../../_assets/tracker/svg/tasks.svg) **Issues**, then at the bottom of the window, click **All issues**.

* or follow the [direct link]({{ link-tracker }}issues).

### Step 2. Set filter criteria {#set-conditions}

There are several ways to set the filter conditions:

- **Quick filters**

   Use the quick filter buttons above the issue list. To filter issues by their [resolution](../manager/create-resolution.md), click **Resolution** and select relevant values from the list.

   {% if audience == "old" %}

   ![image](../../_assets/tracker/quick-filters-new.png)

   1. Filter by resolution. Select one of the options:

      - **All**: The page displays all issues, regardless of the resolution.

      - **Without resolution**: The page only displays issues that aren't resolved.

      - **With resolution**: The page only displays resolved issues.

   1. A group of filters to search the issues for your role. You can enable multiple filters at the same time:

      - **Reported by me**.

      - **Assigned to me**.

      - **Followed by me**.

   As a result, only the issues that meet the selected filter criteria are shown in the list.

   {% endif %}

- **Searching by parameter**

   Add the issue parameters and specify their possible values:

   1. Above the issue list, click ![](../../_assets/tracker/svg/add-filter.svg) **Add a field for filtering**.

   1. Select an issue parameter and then set its value.

      Any issues that don't meet your criteria are filtered out of the list.
      {% if audience == "internal" %}

      {% note info %}

      A [local issue field](../local-fields.md) can only be selected if the queue that the field is linked to is specified in the search criteria.

      {% endnote %}

      {% endif %}
   1. If you need to refine the search conditions, add more parameters.

   For example, you can search issues by their name or description.

   - To find issues that contain a particular phrase in their name, add the **Issue** parameter to your search and enter the text to search for.

   - To find issues that contain a particular phrase in their description, add the **Description** parameter to your search and enter the text to search for.

   {% if audience == "old" %}

   ![](../../_assets/tracker/filters-condition.png)

   {% endif %}

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

{% if audience == "old" %}

#### Setting up filter access

You can share saved filters with your colleagues. By default, other employees can view your filters only if you share your filter links with them. To update the settings:

1. Go to **Issues** → **My filters** on the top {{ tracker-name }} panel and choose your filter.

1. Hover over the filter on the left-hand panel and click ![](../../_assets/tracker/icon-settings.png).

1. By default, access to the filter is granted to all employees. If you want to restrict access to the filter, delete the **All employees** group from the list.

1. Add users{% if audience == "internal" %}, departments, or teams{% endif %} that you want to grant access to.

1. In the **Access rights** column, choose the access rights you want to grant:

   - **View**: Lets users view your filter after receiving a link. They won't be able to change your filter.

   - **Edit**: Lets users view and edit your filter after receiving a link.

   - **Add to shared folder**: Places the filter in the **Shared** folder on the left-hand panel to be accessed by other users. This won't affect the rights to access the filter in any way.

1. Click **Save**.

{% endif %}

#### Removing filters

1. In the upper part of the window, in the **All issues** field, select your filter.

1. Delete your filter using one of these methods:

   * To the right of the filter name, click ![](../../_assets/tracker/svg/icon-filter-delete.svg) **Delete**.

   * In the upper-right corner of the page, click ![](../../_assets/tracker/svg/actions.svg) **Filter actions**, then select ![](../../_assets/tracker/svg/icon-filter-delete.svg) **Delete**.
