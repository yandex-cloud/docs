# Finding my issues

To find issues you're working on, use the preset _system filters_. Filters let you view issues that list you as the assignee, reporter, and so on. To search for issues in the list, use [quick filters](#quick-filters) or [add a search parameter](#add-condition).

## Use system filters {#sys_filters}

To find issues you're responsible for, on the top panel in {{ tracker-name }}, click **Issues** → **My issues** and choose one of the filters:

- **My issues**: Issues that list you as the reporter, assignee, or follower.

- **Favorite issues**: Issues that you [added to Favorites](favourites.md#section_thz_1n5_jz).

- **Reported by me**: Issues that you created.

- **Assigned to me**: Issues that list you as the assignee.

- **Followed by me**: Issues that you [subscribed](subscribe.md#section_xt5_xrv_jz) to for updates.

- **Pending reply**: Issues you were [invited to comment on](comments.md#section_nl2_1qv_tz).

You will find the issues you selected on the filter page. You can add filter parameters, configure the list's appearance, or download the list as a file:

- To search for issues in the list, use [quick filters](#quick-filters) or [add a search parameter](#add-condition).

- If you want to hide or display certain issue fields, click **Configure columns**, select the fields, and click **Save**.

- To group issues by a certain field, click **Not grouped** to the right of the list and select the field.

- If you want to create a [Gantt chart](../manager/gantt.md) for your issue list, in the upper-right corner, click ![](../../_assets/tracker/gantt-ico.png) .

- To save the issue list, click ![](../../_assets/tracker/icon-download.png) to the right above the list and select the format of the file to download or simply copy the list to the clipboard.

- To collapse the left-side panel with the filter list, click ![](../../_assets/tracker/button-collapse.png) at the top of the panel.

## Quick filters {#quick-filters}

You can use quick filters to filter out your issue list, leaving only the issues that include the selected parameters. Quick filter buttons are located above the issue list:

![image](../../_assets/tracker/quick-filters-new.png)

* Resolution filters. Select one of the options:

    - **All**: The page displays all issues, regardless of the resolution.

    - **Without resolution**: The page only displays issues that aren't resolved.

    - **With resolution**: The page only displays resolved issues.

* Role-based filters. You can apply multiple filters at the same time:

    - **Reported by me**.

    - **Assigned to me**.

    - **Followed by me**.

As a result, only the issues that meet the selected filter parameters are shown in the list.

## Adding search parameters {#add-condition}

#### Searching by parameter

Some parameters can't be added to quick filters, but you can specify them in your search:

1. Click **Add condition** above the issue list.

1. Select an issue parameter and set its value.

    All issues that don't meet your criteria are filtered out of the list.


1. You can add multiple parameters for a more thorough search.

1. You can reset the search parameters by clicking **Reset**.

For example, you can search for issues by name or description:

- To find issues that contain a particular phrase in their name, add the **Issue** parameter to your search and enter the text to search for.

- To find issues that contain a particular phrase in their description, add the **Description** parameter to your search and enter the text to search for.

![image](../../_assets/tracker/filters-condition.png)

{% note info %}

If you define multiple parameters, only issues that contain all of them are found.

{% endnote %}

#### Query language

If you can't add certain issue parameters to your search, use a query:

1. Click **Query language** in the upper-right corner. All search parameters specified in issue fields and quick filters are displayed in the query field.

1. Use the [query language](query-filter.md) to add parameters.

1. Click **Apply**.

    All issues that don't meet your criteria are filtered out of the list.

#### Save filters

You can use search parameters as a template for creating filters. To do this, click **Save filter as** and enter a name for the filter. The saved filter then appears in the list in the left panel.



