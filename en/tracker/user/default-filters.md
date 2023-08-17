# Finding my issues

To find the issues you're working on, use the _system filters_ preset. The filters return the lists of issues where you were specified as an assignee, reporter, or in other roles. To search for issues in the list, use [standard filters](#sys_filters) or [add search criteria](#add-condition).

## Using standard filters {#sys_filters}

Find your issues using preset system filters.

1. Go to the page with the issue list. To do this, in the left panel, open ![](../../_assets/tracker/svg/tasks.svg) **Issues** or click the [link]({{ link-tracker }}issues).

1. In the drop-down list, select one of the options:

   * **Favorite issues**: Issues that you [added to Favorites](favourites.md#task-fav).

   * **All my issues**: Issues that list you as the reporter, assignee, or follower.

   * **Reported by me**: Issues that you created.

   * **Assigned to me**: Issues that list you as the assignee.

   * **Followed by me**: Issues that you [subscribed to](subscribe.md#section_xt5_xrv_jz) for updates.

   * **Needs response**: Issues you were [invited to comment on](comments.md#call-comment).

   * **Deadline approaching**: Issues that list you as the reporter, assignee, or follower and where:

      * Issues that have exceeded their deadlines in the past two weeks.

      * The deadline will be due within a month.

1. On the filter page, you'll see the selected issue list. You can add filtering conditions, set up the list's layout, or safe the list to a file:

   * To search for issues in the list, use the **Search by issue name** bar or [add the search criteria](#add-condition).


   * To group issues by a certain field, click ![](../../_assets/tracker/svg/group.svg) **No grouping** to the right of the search bar and select the desired field.


   * To save an issue list, in the upper-right corner, click ![](../../_assets/tracker/svg/icon-export-tasks.svg) **Export** and select the format of the file to download or simply copy the list to the clipboard.

   * To collapse the panel with the filter list, in the upper-right corner of the page, click ![](../../_assets/tracker/svg/icon-parameters.svg) **Parameters**.

## Filtering by parameters {#quick-filters}

{% note info %}

Filtering by parameters is only available in the {{ tracker-name }} web interface.

{% endnote %}

Use filtering by parameters to narrow down your issue list and display only those issues that match the selected parameters. The filter by parameters buttons are above the issue list:

* To filter issues by their [resolution](../manager/create-resolution.md), click **Resolution** and select relevant values from the list.

* To use the [advanced search parameters](#add-condition), click ![](../../_assets/tracker/svg/add-filter.svg) **Add a field for filtering** and select a field.

As a result, only the issues that meet the selected filter criteria are shown in the list.

## Adding search parameters {#add-condition}

#### Searching by parameters

To find issues by the parameters that can't be set using the system filters, add search conditions.

1. In the upper-right corner of the page, click ![](../../_assets/tracker/svg/icon-parameters.svg) **Parameters**. A panel with the specified filtering parameters will be shown under the search bar.

1. Click the icon ![](../../_assets/tracker/svg/add-filter.svg) **Add a field for filtering**.

1. Select an issue parameter, then set its value and click **Save**.

   Any issues that don't meet your criteria are filtered out of the list.


1. If you need to refine the search conditions, add more parameters.

1. You can reset the search parameters by clicking **Reset** above the issue list.

For example, you can search issues by their name or description:

* To find issues that contain a particular phrase in their name, add the **Issue** parameter to your search and enter the text to search for.

* To find issues that contain a particular phrase in their description, add the **Description** parameter to your search and enter the text to search for.


{% note info %}

If you set multiple search conditions, only those issues that meet all the conditions at the same time will be found.

{% endnote %}

#### Query language

If you can't set search conditions using the issue parameters, use the request:

1. Click ![](../../_assets/tracker/svg/query-language.svg) **Query language** in the upper-right corner. All the search parameters that you set by quick filters and conditions, will be shown in the search bar.

1. Use the [query language](query-filter.md) to add parameters.

1. Click **Apply**.

Any issues that don't meet your criteria are filtered out of the list.


#### Saving filters

To save the issue search conditions as a filter:

1. On the panel under the issue list, click ![](../../_assets/tracker/svg/save-filter.svg) **Save**.

1. Set the name and category for the filter.

Your saved filters will be available in the **All issues** checkbox in the **My** section.
