# Finding my issues

To find the issues you're working on, use the _system filters_ preset. The filters return the lists of issues where you were specified as an assignee, reporter, or in other roles. To search for issues in the list, use [standard filters](#sys_filters) or [add search criteria](#add-condition).

## Using standard filters {#sys_filters}

Find your issues using preset system filters.

{% list tabs %}

- Web interface

   1. Go to the page with the issue list. To do this, in the left panel, open ![](../../_assets/tracker/svg/tasks.svg) **Issues** or click the [link]({{ link-tracker }}issues).

   1. In the drop-down list, select one of the options:

   * **All my issues**: Issues that list you as the reporter, assignee, or follower.

   * **Favorite issues**: Issues that you [added to Favorites](favourites.md#task-fav).

   * **Reported by me**: Issues that you created.

   * **Assigned to me**: Issues that list you as the assignee.

   * **Followed by me**: Issues that you [subscribed to](subscribe.md#section_xt5_xrv_jz) for updates.

   * **Needs response**: Issues you were [invited to comment on](comments.md#call-comment).

   * **Deadline approaching**: Issues that list you as the reporter, assignee, or follower and where:

      * Deadlines have passed in the last two weeks ![](../../_assets/tracker/deadline-red.png).

      * The deadline will be due within a month ![](../../_assets/tracker/deadline-grey.png).

      On the filter page, you'll see the selected issue list. You can add filtering conditions, set up the list's layout, or safe the list to a file.

   * To search for issues in the list, use the **Search by issue name** bar or [add the search criteria](#add-condition).

      {% if audience == "old" %}  * If you want to hide or display certain issue fields, click **Configure columns**, select the fields, and click **Save**.{% endif %}

   * To group issues by a certain field, click ![](../../_assets/tracker/svg/group.svg) **No grouping** to the right of the search bar and select the desired field.

      {% if audience == "old" %}  * To create a [Gantt chart](../manager/gantt.md) for your issue list, in the upper-right corner, click ![](../../_assets/tracker/gantt-ico.png).{% endif %}

   * To save an issue list, in the upper-right corner, click ![](../../_assets/tracker/svg/icon-export-tasks.svg) **Export** and select the format of the file to download or simply copy the list to the clipboard.

   * To collapse the panel with the filter list, in the upper-right corner of the page, click ![](../../_assets/tracker/svg/icon-parameters.svg) **Parameters**.

- Mobile app

   In the upper-left corner, tap the name of the filter and choose one of the options:

   * **All my issues**: Issues that list you as the reporter, assignee, or follower.

   * **Reported by me**: Issues that you created.

   * **Assigned to me**: Issues that list you as the assignee.

   * **Followed by me**: Issues that you [subscribed to](subscribe.md#section_xt5_xrv_jz) for updates.

   * **Favorite issues**: Issues that you [added to Favorites](favourites.md#task-fav).

   * **Waiting for my response**: Issues you were [invited to comment on](comments.md#call-comment).

   * **Deadline approaching**: Issues that list you as the reporter, assignee, or follower and where:

      * Deadlines have passed in the last two weeks ![](../../_assets/tracker/deadline-red.png).

      * The deadline will be due within three months ![](../../_assets/tracker/deadline-grey.png).

   To display both open and completed issues in the list, enable **Show completed issues** in the filter panel.

   After selecting the filter, you'll see the selected issue list.

{% endlist %}

## Quick filters {#quick-filters}

{% note info %}

Quick filters are only available in the {{ tracker-name }} web interface.

{% endnote %}

Use quick filters to filter your issue list and leave there only those issues that match the selected parameters. The quick filter buttons are above the issue list:

* To filter issues by their [resolution](../manager/create-resolution.md), click **Resolution** and select relevant values from the list.

* To use the [advanced search parameters](#add-condition), click ![](../../_assets/tracker/svg/add-filter.svg) **Add a field for filtering** and select a field.

As a result, only the issues that meet the selected filter criteria are shown in the list.

## Adding search parameters {#add-condition}

{% note info %}

You can only set the search criteria in the {{ tracker-name }} web interface.

{% endnote %}

#### Searching by parameters

To find issues by the parameters that can't be set using the system filters, add search conditions.

1. In the upper-right corner of the page, click ![](../../_assets/tracker/svg/icon-parameters.svg) **Parameters**. A panel with the specified filtering parameters will be shown under the search bar.

1. Click the icon ![](../../_assets/tracker/svg/add-filter.svg) **Add a field for filtering**.

1. Select an issue parameter, set its value, and click **Save**.

   Any issues that don't meet your criteria are filtered out of the list.


   {% if audience == "internal" %}

   {% note info %}

   A [local issue field](../local-fields.md) can only be selected if the queue that the field is linked to is specified in the search criteria.

   {% endnote %}

   {% endif %}

1. If you need to refine the search conditions, add more parameters.

1. You can reset the search parameters by clicking **Reset** above the issue list.

For example, you can search issues by their name or description:

* To find issues that contain a particular phrase in their name, add the **Issue** parameter to your search and enter the text to search for.

* To find issues that contain a particular phrase in their description, add the **Description** parameter to your search and enter the text to search for.

{% if audience == "old" %}

![](../../_assets/tracker/filters-condition.png)

{% endif %}

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

The saved filter will be added to the filter list.
