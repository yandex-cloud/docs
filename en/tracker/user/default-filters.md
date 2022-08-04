# Searching for my issues

To find the issues you're working on, use the _system filters_ preset. Filters let you view issues that list you as the assignee, reporter, and so on. To search for issues in the list, use [quick filters](#quick-filters) or [add search criteria](#add-condition).

## Using system filters {#sys_filters}

Find your issues using preset system filters:

{% list tabs %}

- Web interface

  On the top panel in {{ tracker-name }}, click **Issues** → **My issues** and choose one of the options:

  * **My issues**: Issues that list you as the reporter, assignee, or follower.

  * **Favorite issues**: Issues that you [added to Favorites](favourites.md#section_thz_1n5_jz).

  * **Reported by me**: Issues that you created.

  * **Assigned to me**: Issues that list you as the assignee.

  * **Followed by me**: Issues that you [subscribed to](subscribe.md#section_xt5_xrv_jz) for updates.

  * **Needs response**: Issues you were [invited to comment on](comments.md#call-comment).

  You will find the issues you selected on the filter page. You can add filter parameters, configure the list's appearance, or download the list as a file:

  * To search for issues in the list, use [quick filters](#quick-filters) or [add search criteria](#add-condition).

  * If you want to hide or display certain issue fields, click **Configure columns**, select the fields, and click **Save**.

  * To group issues by a certain field, click **No grouping** to the right of the list and select the desired field.

  * To create a [Gantt chart](../manager/gantt.md) for your issue list, go to the upper-right corner and click ![](../../_assets/tracker/gantt-ico.png).

  * To save an issue list, click ![](../../_assets/tracker/icon-download.png) to the right above the list and select the format of the file to download or simply copy the list to the clipboard.

  * To collapse the left-side panel with the filter list, click ![](../../_assets/tracker/button-collapse.png) at the top of the panel.

- Mobile app

  In the upper-left corner, tap the name of the filter and choose one of the options:

    * **My issues**: Issues that list you as the reporter, assignee, or follower.

    * **Reported by me**: Issues that you created.

    * **Assigned to me**: Issues that list you as the assignee.

    * **Followed by me**: Issues that you [subscribed to](subscribe.md#section_xt5_xrv_jz) for updates.

    * **Favorite issues**: Issues that you [added to Favorites](favourites.md#section_thz_1n5_jz).

    * **Waiting for my response**: Issues you were [invited to comment on](comments.md#call-comment).

    * **Deadline approaching**: Issues that list you as the reporter, assignee, or follower and where:

      * The deadline passed in the last two weeks ![](../../_assets/tracker/deadline-red.png).

      * The deadline will pass in the next three months ![](../../_assets/tracker/deadline-grey.png).

  To display both open and completed issues in the list, enable **Show completed issues** in the filter panel.

  After selecting the filter, you'll see the selected issue list.

{% endlist %}

## Quick filters {#quick-filters}

{% note info %}

Quick filters are only available in the {{ tracker-name }} web interface.

{% endnote %}

You can use quick filters to filter out your issue list, leaving only the issues that include the selected parameters. Quick filter buttons are located above the issue list:

![image](../../_assets/tracker/quick-filters-new.png)

* Resolution filters. Select one of the options:

    * **All**: The page displays all issues, regardless of the resolution.

    * **Without resolution**: The page only displays issues that aren't resolved.

    * **With resolution**: The page only displays resolved issues.

* Role-based filters. You can apply multiple filters at the same time:

    * **Reported by me**

    * **Assigned to me**

    * **Followed by me**

As a result, only the issues that meet the selected filter criteria are shown in the list.

## Adding search parameters {#add-condition}

{% note info %}

You can only set the search criteria in the {{ tracker-name }} web interface.

{% endnote %}

#### Searching by parameter

Some parameters can't be added to quick filters, but you can specify them in your search:

1. Click **Add condition** above the issue list.

1. Select an issue parameter and set its value.

    All issues that don't meet your criteria are filtered out of the list.



1. You can add multiple parameters for a more thorough search.

1. You can reset the search parameters by clicking **Reset** above the issue list.

For example, you can search for issues by name or description:

* To find issues that contain a particular phrase in their name, add the **Issue** parameter to your search and enter the text to search for.

* To find issues that contain a particular phrase in their description, add the **Description** parameter to your search and enter the text to search for.

![](../../_assets/tracker/filters-condition.png)

{% note info %}

If you define multiple parameters, only issues that contain all of them are found.

{% endnote %}

#### Query language

If you can't add certain issue parameters to your search, use a query:

1. Click **Query language** in the upper-right corner. All search parameters specified in issue fields and quick filters are displayed in the query field.

1. Use the [query language](query-filter.md) to add parameters.

1. Click **Apply**.

    All issues that don't meet your criteria are filtered out of the list.

#### Saving filters

You can use search parameters as a template for creating filters. To do this, click **Save filter as** and name the filter. The saved filter then appears in the list in the left panel.

